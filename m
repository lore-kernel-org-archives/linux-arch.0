From: Chris Metcalf <cmetcalf@ezchip.com>
Subject: [PATCH 2/3] string: provide strscpy() and strscpy_truncate()
Date: Thu, 30 Apr 2015 12:01:16 -0400
Message-ID: <1430409677-13284-3-git-send-email-cmetcalf@ezchip.com>
References: <1430409677-13284-1-git-send-email-cmetcalf@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430409677-13284-1-git-send-email-cmetcalf@ezchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Chris Metcalf <cmetcalf@ezchip.com>, Al Viro <viro@zeniv.linux.org.uk>, Fabian Frederick <fabf@skynet.be>, Randy Dunlap <rdunlap@infradead.org>, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, gregkh@linuxfoundation.org, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, Frederic Weisbecker <fweisbec@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Theodore Ts'o <tytso@mit.edu>, Grant Likely <grant.likely@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The strscpy() API is intended to be used instead of strlcpy(),
and instead of most uses of strncpy().

- The API provides an easy way to check for destination buffer overflow:
  a -E2BIG error return value.

- By default, truncation causes the destination buffer to be the
  empty string, so users don't blindly assume a truncated string is
  valid.  If you know a truncated string still has valid semantics,
  you can use the provided strscpy_truncate(), which has the same
  return value semantics but does not make the destination an empty
  string on error.

- The provided implementation is robust in the face of the source
  buffer being asynchronously changed during the copy, unlike the
  current implementation of strlcpy().

- The implementation should be reasonably performant on all
  platforms since it uses the asm/word-at-a-time.h API rather than
  simple byte copy.  Kernel-to-kernel string copy is not considered
  to be performance critical in any case.

- If the remainder of the destination buffer must be zeroed for some
  reason, strscpy() + error check + memset() is probably the easiest
  pattern, but using strncpy() in a pattern where the last byte of
  the buffer is first set non-NUL, then tested for NUL afterwards,
  can also be safely used.

Signed-off-by: Chris Metcalf <cmetcalf@ezchip.com>
---
 include/linux/string.h |   6 +++
 lib/string.c           | 109 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index e40099e585c9..7942944f3abb 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -25,6 +25,12 @@ extern char * strncpy(char *,const char *, __kernel_size_t);
 #ifndef __HAVE_ARCH_STRLCPY
 size_t strlcpy(char *, const char *, size_t);
 #endif
+#ifndef __HAVE_ARCH_STRSCPY
+ssize_t strscpy(char *, const char *, size_t);
+#endif
+#ifndef __HAVE_ARCH_STRSCPY_TRUNCATE
+ssize_t strscpy_truncate(char *, const char *, size_t);
+#endif
 #ifndef __HAVE_ARCH_STRCAT
 extern char * strcat(char *, const char *);
 #endif
diff --git a/lib/string.c b/lib/string.c
index a5792019193c..84d5b6eceb74 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -27,6 +27,9 @@
 #include <linux/bug.h>
 #include <linux/errno.h>
 
+#include <asm/byteorder.h>
+#include <asm/word-at-a-time.h>
+
 #ifndef __HAVE_ARCH_STRNCASECMP
 /**
  * strncasecmp - Case insensitive, length-limited string comparison
@@ -146,6 +149,112 @@ size_t strlcpy(char *dest, const char *src, size_t size)
 EXPORT_SYMBOL(strlcpy);
 #endif
 
+#ifndef __HAVE_ARCH_STRSCPY_TRUNCATE
+/**
+ * strscpy_truncate - Copy a C-string into a sized buffer
+ * @dest: Where to copy the string to
+ * @src: Where to copy the string from
+ * @count: Size of destination buffer
+ *
+ * Copy the string, or as much of it as fits, into the dest buffer.
+ * The routine returns the number of characters copied (not including
+ * the trailing NUL) or -E2BIG if the destination buffer wasn't big enough.
+ * The behavior is undefined if the string buffers overlap.
+ *
+ * Note that the implementation is robust to the string changing out
+ * from underneath it, unlike the current strlcpy() implementation,
+ * and it is easier to check overflow than with strlcpy()'s API.
+ *
+ * strscpy() is preferred over this function unless a truncated string
+ * provides some valid semantics in the destination buffer.
+ */
+ssize_t strscpy_truncate(char *dest, const char *src, size_t count)
+{
+	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
+	size_t max = count;
+	long res = 0;
+
+	if (count == 0)
+		return -E2BIG;
+
+#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+	/*
+	 * If src is unaligned, don't cross a page boundary,
+	 * since we don't know if the next page is mapped.
+	 */
+	if ((long)src & (sizeof(long) - 1)) {
+		size_t limit = PAGE_SIZE - ((long)src & (PAGE_SIZE - 1));
+		if (limit < max)
+			max = limit;
+	}
+#else
+	/* If src or dest is unaligned, don't do word-at-a-time. */
+	if (((long) dest | (long) src) & (sizeof(long) - 1))
+		max = 0;
+#endif
+
+	while (max >= sizeof(unsigned long)) {
+		unsigned long c, data;
+
+		c = *(unsigned long *)(src+res);
+		*(unsigned long *)(dest+res) = c;
+		if (has_zero(c, &data, &constants)) {
+			data = prep_zero_mask(c, data, &constants);
+			data = create_zero_mask(data);
+			return res + find_zero(data);
+		}
+		res += sizeof(unsigned long);
+		count -= sizeof(unsigned long);
+		max -= sizeof(unsigned long);
+	}
+
+	while (count) {
+		char c;
+
+		c = src[res];
+		dest[res] = c;
+		if (!c)
+			return res;
+		res++;
+		count--;
+	}
+
+	/* Hit buffer length without finding a NUL; force NUL-termination. */
+	if (res)
+		dest[res-1] = '\0';
+
+	return -E2BIG;
+}
+EXPORT_SYMBOL(strscpy_truncate);
+#endif
+
+#ifndef __HAVE_ARCH_STRSCPY
+/**
+ * strscpy - Copy a C-string into a sized buffer, but only if it fits
+ * @dest: Where to copy the string to
+ * @src: Where to copy the string from
+ * @count: Size of destination buffer
+ *
+ * Copy the string into the dest buffer.  The routine returns the
+ * number of characters copied (not including the trailing NUL) or
+ * -E2BIG if the destination buffer wasn't big enough.  The behavior
+ * is undefined if the string buffers overlap.  The destination buffer
+ * is set to the empty string if the buffer is not big enough.
+ *
+ * Preferred over strlcpy() in all cases, and over strncpy() unless
+ * the latter's zero-fill behavior is desired and truncation of the
+ * source string is known not to be an issue.
+ */
+ssize_t strscpy(char *dest, const char *src, size_t count)
+{
+	ssize_t res = strscpy_truncate(dest, src, count);
+	if (res < 0 && count != 0)
+		dest[0] = '\0';
+	return res;
+}
+EXPORT_SYMBOL(strscpy);
+#endif
+
 #ifndef __HAVE_ARCH_STRCAT
 /**
  * strcat - Append one %NUL-terminated string to another
-- 
2.1.2
