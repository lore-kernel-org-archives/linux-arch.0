From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [RFC 1/4] asm-generic/uaccess: don't define inline functions if noinline lib/* in use
Date: Tue, 14 Jan 2020 12:08:43 -0800
Message-ID: <20200114200846.29434-2-vgupta@synopsys.com>
References: <20200114200846.29434-1-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200114200846.29434-1-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Christian Brauner <christian.brauner@ubuntu.com>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-arch.vger.kernel.org

There are 2 generic varaints of strncpy_from_user() / strnlen_user()
 (1). inline version in asm-generic/uaccess.h
 (2). optimized word-at-a-time version in lib/*

This patch disables #1 if #2 selected. This allows arches to continue
reusing asm-generic/uaccess.h for rest of code

This came up when switching ARC to generic word-at-a-time interface

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 include/asm-generic/uaccess.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index e935318804f8..74c14211377b 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -227,6 +227,7 @@ __strncpy_from_user(char *dst, const char __user *src, long count)
 }
 #endif
 
+#ifndef CONFIG_GENERIC_STRNCPY_FROM_USER
 static inline long
 strncpy_from_user(char *dst, const char __user *src, long count)
 {
@@ -234,6 +235,7 @@ strncpy_from_user(char *dst, const char __user *src, long count)
 		return -EFAULT;
 	return __strncpy_from_user(dst, src, count);
 }
+#endif
 
 /*
  * Return the size of a string (including the ending 0)
@@ -244,6 +246,7 @@ strncpy_from_user(char *dst, const char __user *src, long count)
 #define __strnlen_user(s, n) (strnlen((s), (n)) + 1)
 #endif
 
+#ifndef CONFIG_GENERIC_STRNLEN_USER
 /*
  * Unlike strnlen, strnlen_user includes the nul terminator in
  * its returned count. Callers should check for a returned value
@@ -255,6 +258,7 @@ static inline long strnlen_user(const char __user *src, long n)
 		return 0;
 	return __strnlen_user(src, n);
 }
+#endif
 
 /*
  * Zero Userspace
-- 
2.20.1
