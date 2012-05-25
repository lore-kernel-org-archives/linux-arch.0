From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Mostly portable strnlen_user()
Date: Fri, 25 May 2012 15:35:38 -0700 (PDT)
Message-ID: <alpine.LFD.2.02.1205251528570.26378@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:51710 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754368Ab2EYWfx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 May 2012 18:35:53 -0400
Received: by dady13 with SMTP id y13so1784419dad.19
        for <linux-arch@vger.kernel.org>; Fri, 25 May 2012 15:35:53 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org


Ok, so I'm going to merge the appended commit into mainline at some point 
here soon, and I thought maybe the BE people wanted to pipe up.

This does *not* use the generic "find zero" or "count bytes" logic that 
David used for strncpy_from_user(), because quite frankly, that one is 
suboptimal on x86 and causes conditionals and crap.

So it's not truly generic, but it's in lib/strnlen_user.c and under the 
CONFIG_GENERIC_STRNLEN_USER config option, because I'm convinced it should 
be possible to do something that does the right thing for everybody. 
Eventually.

But "the right thing" definitely involves arch-specific helpers for doing 
the byte counting, because it *is* going to occasionally be a popcount 
instruction or similar. And it *is* going to take advantage of the fact 
that things are sometimes simply easier on little-endian.

So this isn't truly generic, but without a BE machine I simply cannot care 
enough about the BE case. So I'm posting this as a heads-up before I 
actually merge it, to see.. Maybe the existing lib/strncpy_from_user.c 
could also be improved sufficiently that it would generate the fairly 
optimal code on x86 that our x86 code currently does.. I'll take a look at 
that at some point.

Comments? What's the appropriate *clean* interface to allow architectures 
to tweak the little details?

                      Linus
---
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 May 2012 15:02:46 -0700
Subject: [PATCH] lib: add a generic str[n]len_user() implementation, use it on x86

This is reasonably generic, but unlike the strncpy_from_user() function
it requires the bytemask counting functions from word-at-a-time.h that
only x86 does right now, and still does some things that only work on
little-endian.

With a bit of tweaking, the BE people could use it though, and unlike
the dcache hashing or the strncpy implementation, this has no issues
with architectures that require aligned accesses, since doing
pre-alignment is simple and thus worthwhile even on architectures that
do efficient aligned word accesses.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/Kconfig                  |   1 +
 arch/x86/include/asm/uaccess.h    |   4 ++
 arch/x86/include/asm/uaccess_32.h |  17 -----
 arch/x86/include/asm/uaccess_64.h |   3 -
 arch/x86/lib/usercopy.c           |   2 +-
 arch/x86/lib/usercopy_32.c        |  41 -----------
 arch/x86/lib/usercopy_64.c        |  48 -------------
 lib/Kconfig                       |   3 +
 lib/Makefile                      |   1 +
 lib/strnlen_user.c                | 143 ++++++++++++++++++++++++++++++++++++++
 10 files changed, 153 insertions(+), 110 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 81c3e8be789a..54bbfac5b91a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -93,6 +93,7 @@ config X86
 	select GENERIC_CLOCKEVENTS_BROADCAST if X86_64 || (X86_32 && X86_LOCAL_APIC)
 	select GENERIC_TIME_VSYSCALL if X86_64
 	select KTIME_SCALAR if X86_32
+	select GENERIC_STRNLEN_USER
 
 config INSTRUCTION_DECODER
 	def_bool (KPROBES || PERF_EVENTS || UPROBES)
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 851fe0dc13bc..04cd6882308e 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -32,6 +32,7 @@
 
 #define segment_eq(a, b)	((a).seg == (b).seg)
 
+#define user_addr_max() (current_thread_info()->addr_limit.seg)
 #define __addr_ok(addr)					\
 	((unsigned long __force)(addr) <		\
 	 (current_thread_info()->addr_limit.seg))
@@ -565,6 +566,9 @@ copy_from_user_nmi(void *to, const void __user *from, unsigned long n);
 extern __must_check long
 strncpy_from_user(char *dst, const char __user *src, long count);
 
+extern __must_check long strlen_user(const char __user *str);
+extern __must_check long strnlen_user(const char __user *str, long n);
+
 /*
  * movsl can be slow when source and dest are not both 8-byte aligned
  */
diff --git a/arch/x86/include/asm/uaccess_32.h b/arch/x86/include/asm/uaccess_32.h
index 8084bc73b18c..576e39bca6ad 100644
--- a/arch/x86/include/asm/uaccess_32.h
+++ b/arch/x86/include/asm/uaccess_32.h
@@ -213,23 +213,6 @@ static inline unsigned long __must_check copy_from_user(void *to,
 	return n;
 }
 
-/**
- * strlen_user: - Get the size of a string in user space.
- * @str: The string to measure.
- *
- * Context: User context only.  This function may sleep.
- *
- * Get the size of a NUL-terminated string in user space.
- *
- * Returns the size of the string INCLUDING the terminating NUL.
- * On exception, returns 0.
- *
- * If there is a limit on the length of a valid string, you may wish to
- * consider using strnlen_user() instead.
- */
-#define strlen_user(str) strnlen_user(str, LONG_MAX)
-
-long strnlen_user(const char __user *str, long n);
 unsigned long __must_check clear_user(void __user *mem, unsigned long len);
 unsigned long __must_check __clear_user(void __user *mem, unsigned long len);
 
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index fcd4b6f3ef02..8e796fbbf9c6 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -208,9 +208,6 @@ int __copy_in_user(void __user *dst, const void __user *src, unsigned size)
 	}
 }
 
-__must_check long strnlen_user(const char __user *str, long n);
-__must_check long __strnlen_user(const char __user *str, long n);
-__must_check long strlen_user(const char __user *str);
 __must_check unsigned long clear_user(void __user *mem, unsigned long len);
 __must_check unsigned long __clear_user(void __user *mem, unsigned long len);
 
diff --git a/arch/x86/lib/usercopy.c b/arch/x86/lib/usercopy.c
index 2e4e4b02c37a..4239f063f6ac 100644
--- a/arch/x86/lib/usercopy.c
+++ b/arch/x86/lib/usercopy.c
@@ -131,7 +131,7 @@ strncpy_from_user(char *dst, const char __user *src, long count)
 	if (unlikely(count <= 0))
 		return 0;
 
-	max_addr = current_thread_info()->addr_limit.seg;
+	max_addr = user_addr_max();
 	src_addr = (unsigned long)src;
 	if (likely(src_addr < max_addr)) {
 		unsigned long max = max_addr - src_addr;
diff --git a/arch/x86/lib/usercopy_32.c b/arch/x86/lib/usercopy_32.c
index 883b216c60b2..1781b2f950e2 100644
--- a/arch/x86/lib/usercopy_32.c
+++ b/arch/x86/lib/usercopy_32.c
@@ -95,47 +95,6 @@ __clear_user(void __user *to, unsigned long n)
 }
 EXPORT_SYMBOL(__clear_user);
 
-/**
- * strnlen_user: - Get the size of a string in user space.
- * @s: The string to measure.
- * @n: The maximum valid length
- *
- * Get the size of a NUL-terminated string in user space.
- *
- * Returns the size of the string INCLUDING the terminating NUL.
- * On exception, returns 0.
- * If the string is too long, returns a value greater than @n.
- */
-long strnlen_user(const char __user *s, long n)
-{
-	unsigned long mask = -__addr_ok(s);
-	unsigned long res, tmp;
-
-	might_fault();
-
-	__asm__ __volatile__(
-		"	testl %0, %0\n"
-		"	jz 3f\n"
-		"	andl %0,%%ecx\n"
-		"0:	repne; scasb\n"
-		"	setne %%al\n"
-		"	subl %%ecx,%0\n"
-		"	addl %0,%%eax\n"
-		"1:\n"
-		".section .fixup,\"ax\"\n"
-		"2:	xorl %%eax,%%eax\n"
-		"	jmp 1b\n"
-		"3:	movb $1,%%al\n"
-		"	jmp 1b\n"
-		".previous\n"
-		_ASM_EXTABLE(0b,2b)
-		:"=&r" (n), "=&D" (s), "=&a" (res), "=&c" (tmp)
-		:"0" (n), "1" (s), "2" (0), "3" (mask)
-		:"cc");
-	return res & mask;
-}
-EXPORT_SYMBOL(strnlen_user);
-
 #ifdef CONFIG_X86_INTEL_USERCOPY
 static unsigned long
 __copy_user_intel(void __user *to, const void *from, unsigned long size)
diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index 0d0326f388c0..e5b130bc2d0e 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -52,54 +52,6 @@ unsigned long clear_user(void __user *to, unsigned long n)
 }
 EXPORT_SYMBOL(clear_user);
 
-/*
- * Return the size of a string (including the ending 0)
- *
- * Return 0 on exception, a value greater than N if too long
- */
-
-long __strnlen_user(const char __user *s, long n)
-{
-	long res = 0;
-	char c;
-
-	while (1) {
-		if (res>n)
-			return n+1;
-		if (__get_user(c, s))
-			return 0;
-		if (!c)
-			return res+1;
-		res++;
-		s++;
-	}
-}
-EXPORT_SYMBOL(__strnlen_user);
-
-long strnlen_user(const char __user *s, long n)
-{
-	if (!access_ok(VERIFY_READ, s, 1))
-		return 0;
-	return __strnlen_user(s, n);
-}
-EXPORT_SYMBOL(strnlen_user);
-
-long strlen_user(const char __user *s)
-{
-	long res = 0;
-	char c;
-
-	for (;;) {
-		if (get_user(c, s))
-			return 0;
-		if (!c)
-			return res+1;
-		res++;
-		s++;
-	}
-}
-EXPORT_SYMBOL(strlen_user);
-
 unsigned long copy_in_user(void __user *to, const void __user *from, unsigned len)
 {
 	if (access_ok(VERIFY_WRITE, to, len) && access_ok(VERIFY_READ, from, len)) { 
diff --git a/lib/Kconfig b/lib/Kconfig
index 98230ac3db29..64ddc44d0b81 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -19,6 +19,9 @@ config RATIONAL
 config GENERIC_STRNCPY_FROM_USER
 	bool
 
+config GENERIC_STRNLEN_USER
+	bool
+
 config GENERIC_FIND_FIRST_BIT
 	bool
 
diff --git a/lib/Makefile b/lib/Makefile
index b98df505f335..77937a7dd5ce 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -126,6 +126,7 @@ obj-$(CONFIG_CLZ_TAB) += clz_tab.o
 obj-$(CONFIG_DDR) += jedec_ddr_data.o
 
 obj-$(CONFIG_GENERIC_STRNCPY_FROM_USER) += strncpy_from_user.o
+obj-$(CONFIG_GENERIC_STRNLEN_USER) += strnlen_user.o
 
 hostprogs-y	:= gen_crc32table
 clean-files	:= crc32table.h
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
new file mode 100644
index 000000000000..3dc78a846b1a
--- /dev/null
+++ b/lib/strnlen_user.c
@@ -0,0 +1,143 @@
+#include <linux/kernel.h>
+#include <linux/export.h>
+#include <linux/uaccess.h>
+
+/*
+ * Currently this requires the word-at-a-time
+ * macros for the "generic" part.
+ */
+#include <asm/word-at-a-time.h>
+
+/* Set bits in the first 'n' bytes when loaded from memory */
+#ifdef __LITTLE_ENDIAN
+#  define aligned_byte_mask(n) ((1ul << 8*(n))-1)
+#else
+#  define aligned_byte_mask(n) (~0xfful << 8*(7-(n)))
+#endif
+
+/*
+ * Do a strnlen, return length of string *with* final '\0'.
+ * 'count' is the user-supplied count, while 'max' is the
+ * address space maximum.
+ *
+ * Return 0 for exceptions (which includes hitting the address
+ * space maximum), or 'count+1' if hitting the user-supplied
+ * maximum count.
+ *
+ * NOTE! We can sometimes overshoot the user-supplied maximum
+ * if it fits in a aligned 'long'. The caller needs to check
+ * the return value against "> max".
+ */
+static inline long do_strnlen_user(const char __user *src, unsigned long count, unsigned long max)
+{
+	long align, res = 0;
+	unsigned long c;
+
+	/*
+	 * Truncate 'max' to the user-specified limit, so that
+	 * we only have one limit we need to check in the loop
+	 */
+	if (max > count)
+		max = count;
+
+	/*
+	 * Do everything aligned. But that means that we
+	 * need to also expand the maximum..
+	 */
+	align = (sizeof(long) - 1) & (unsigned long)src;
+	src -= align;
+	max += align;
+
+	if (unlikely(__get_user(c,(unsigned long __user *)src)))
+		return 0;
+	c |= aligned_byte_mask(align);
+
+	for (;;) {
+		unsigned long mask;
+
+		mask = has_zero(c);
+		if (mask) {
+			mask = (mask - 1) & ~mask;
+			mask >>= 7;
+			return res + count_masked_bytes(mask) + 1 - align;
+		}
+		res += sizeof(unsigned long);
+		if (unlikely(max < sizeof(unsigned long)))
+			break;
+		max -= sizeof(unsigned long);
+		if (unlikely(__get_user(c,(unsigned long __user *)(src+res))))
+			return 0;
+	}
+	res -= align;
+
+	/*
+	 * Uhhuh. We hit 'max'. But was that the user-specified maximum
+	 * too? If so, return the marker for "too long".
+	 */
+	if (res >= count)
+		return count+1;
+
+	/*
+	 * Nope: we hit the address space limit, and we still had more
+	 * characters the caller would have wanted. That's 0.
+	 */
+	return 0;
+}
+
+/**
+ * strnlen_user: - Get the size of a user string INCLUDING final NUL.
+ * @str: The string to measure.
+ * @count: Maximum count (including NUL character)
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * Get the size of a NUL-terminated string in user space.
+ *
+ * Returns the size of the string INCLUDING the terminating NUL.
+ * If the string is too long, returns 'count+1'.
+ * On exception (or invalid count), returns 0.
+ */
+long strnlen_user(const char __user *str, long count)
+{
+	unsigned long max_addr, src_addr;
+
+	if (unlikely(count <= 0))
+		return 0;
+
+	max_addr = user_addr_max();
+	src_addr = (unsigned long)str;
+	if (likely(src_addr < max_addr)) {
+		unsigned long max = max_addr - src_addr;
+		return do_strnlen_user(str, count, max);
+	}
+	return 0;
+}
+EXPORT_SYMBOL(strnlen_user);
+
+/**
+ * strlen_user: - Get the size of a user string INCLUDING final NUL.
+ * @str: The string to measure.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * Get the size of a NUL-terminated string in user space.
+ *
+ * Returns the size of the string INCLUDING the terminating NUL.
+ * On exception, returns 0.
+ *
+ * If there is a limit on the length of a valid string, you may wish to
+ * consider using strnlen_user() instead.
+ */
+long strlen_user(const char __user *str)
+{
+	unsigned long max_addr, src_addr;
+
+	max_addr = user_addr_max();
+	src_addr = (unsigned long)str;
+	if (likely(src_addr < max_addr)) {
+		unsigned long max = max_addr - src_addr;
+		return do_strnlen_user(str, ~0ul, max);
+	}
+	return 0;
+}
+EXPORT_SYMBOL(strlen_user);
