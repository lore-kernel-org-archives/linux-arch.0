From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH v2 11/13] [sparc] unify 32bit and 64bit string.h
Date: Wed,  3 Feb 2016 21:20:43 +0000
Message-ID: <1454534445-16759-11-git-send-email-viro@ZenIV.linux.org.uk>
References: <20160203211953.GT17997@ZenIV.linux.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160203211953.GT17997@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sparc/include/asm/string.h    | 34 +++++++++++++++++++++++
 arch/sparc/include/asm/string_32.h | 56 --------------------------------------
 arch/sparc/include/asm/string_64.h | 44 ------------------------------
 arch/sparc/lib/memcpy.S            |  5 ----
 4 files changed, 34 insertions(+), 105 deletions(-)

diff --git a/arch/sparc/include/asm/string.h b/arch/sparc/include/asm/string.h
index 98b72a0..86f34be 100644
--- a/arch/sparc/include/asm/string.h
+++ b/arch/sparc/include/asm/string.h
@@ -5,4 +5,38 @@
 #else
 #include <asm/string_32.h>
 #endif
+
+/* First the mem*() things. */
+#define __HAVE_ARCH_MEMMOVE
+void *memmove(void *, const void *, __kernel_size_t);
+
+#define __HAVE_ARCH_MEMCPY
+#define memcpy(t, f, n) __builtin_memcpy(t, f, n)
+
+#define __HAVE_ARCH_MEMSET
+#define memset(s, c, count) __builtin_memset(s, c, count)
+
+#define __HAVE_ARCH_MEMSCAN
+
+#define memscan(__arg0, __char, __arg2)						\
+({										\
+	void *__memscan_zero(void *, size_t);					\
+	void *__memscan_generic(void *, int, size_t);				\
+	void *__retval, *__addr = (__arg0);					\
+	size_t __size = (__arg2);						\
+										\
+	if(__builtin_constant_p(__char) && !(__char))				\
+		__retval = __memscan_zero(__addr, __size);			\
+	else									\
+		__retval = __memscan_generic(__addr, (__char), __size);		\
+										\
+	__retval;								\
+})
+
+#define __HAVE_ARCH_MEMCMP
+int memcmp(const void *,const void *,__kernel_size_t);
+
+#define __HAVE_ARCH_STRNCMP
+int strncmp(const char *, const char *, __kernel_size_t);
+
 #endif
diff --git a/arch/sparc/include/asm/string_32.h b/arch/sparc/include/asm/string_32.h
index 69974e92..6494124 100644
--- a/arch/sparc/include/asm/string_32.h
+++ b/arch/sparc/include/asm/string_32.h
@@ -11,60 +11,4 @@
 
 #include <asm/page.h>
 
-/* Really, userland/ksyms should not see any of this stuff. */
-
-#ifdef __KERNEL__
-
-void __memmove(void *,const void *,__kernel_size_t);
-
-#ifndef EXPORT_SYMTAB_STROPS
-
-/* First the mem*() things. */
-#define __HAVE_ARCH_MEMMOVE
-#undef memmove
-#define memmove(_to, _from, _n) \
-({ \
-	void *_t = (_to); \
-	__memmove(_t, (_from), (_n)); \
-	_t; \
-})
-
-#define __HAVE_ARCH_MEMCPY
-#define memcpy(t, f, n) __builtin_memcpy(t, f, n)
-
-#define __HAVE_ARCH_MEMSET
-#define memset(s, c, count) __builtin_memset(s, c, count)
-
-#define __HAVE_ARCH_MEMSCAN
-
-#undef memscan
-#define memscan(__arg0, __char, __arg2)						\
-({										\
-	void *__memscan_zero(void *, size_t);					\
-	void *__memscan_generic(void *, int, size_t);				\
-	void *__retval, *__addr = (__arg0);					\
-	size_t __size = (__arg2);						\
-										\
-	if(__builtin_constant_p(__char) && !(__char))				\
-		__retval = __memscan_zero(__addr, __size);			\
-	else									\
-		__retval = __memscan_generic(__addr, (__char), __size);		\
-										\
-	__retval;								\
-})
-
-#define __HAVE_ARCH_MEMCMP
-int memcmp(const void *,const void *,__kernel_size_t);
-
-/* Now the str*() stuff... */
-#define __HAVE_ARCH_STRLEN
-__kernel_size_t strlen(const char *);
-
-#define __HAVE_ARCH_STRNCMP
-int strncmp(const char *, const char *, __kernel_size_t);
-
-#endif /* !EXPORT_SYMTAB_STROPS */
-
-#endif /* __KERNEL__ */
-
 #endif /* !(__SPARC_STRING_H__) */
diff --git a/arch/sparc/include/asm/string_64.h b/arch/sparc/include/asm/string_64.h
index 5936b8f..6b9ccb3 100644
--- a/arch/sparc/include/asm/string_64.h
+++ b/arch/sparc/include/asm/string_64.h
@@ -9,54 +9,10 @@
 #ifndef __SPARC64_STRING_H__
 #define __SPARC64_STRING_H__
 
-/* Really, userland/ksyms should not see any of this stuff. */
-
-#ifdef __KERNEL__
-
 #include <asm/asi.h>
 
-#ifndef EXPORT_SYMTAB_STROPS
-
-/* First the mem*() things. */
-#define __HAVE_ARCH_MEMMOVE
-void *memmove(void *, const void *, __kernel_size_t);
-
-#define __HAVE_ARCH_MEMCPY
-#define memcpy(t, f, n) __builtin_memcpy(t, f, n)
-
-#define __HAVE_ARCH_MEMSET
-#define memset(s, c, count) __builtin_memset(s, c, count)
-
-#define __HAVE_ARCH_MEMSCAN
-
-#undef memscan
-#define memscan(__arg0, __char, __arg2)					\
-({									\
-	void *__memscan_zero(void *, size_t);				\
-	void *__memscan_generic(void *, int, size_t);			\
-	void *__retval, *__addr = (__arg0);				\
-	size_t __size = (__arg2);					\
-									\
-	if(__builtin_constant_p(__char) && !(__char))			\
-		__retval = __memscan_zero(__addr, __size);		\
-	else								\
-		__retval = __memscan_generic(__addr, (__char), __size);	\
-									\
-	__retval;							\
-})
-
-#define __HAVE_ARCH_MEMCMP
-int memcmp(const void *,const void *,__kernel_size_t);
-
 /* Now the str*() stuff... */
 #define __HAVE_ARCH_STRLEN
 __kernel_size_t strlen(const char *);
 
-#define __HAVE_ARCH_STRNCMP
-int strncmp(const char *, const char *, __kernel_size_t);
-
-#endif /* !EXPORT_SYMTAB_STROPS */
-
-#endif /* __KERNEL__ */
-
 #endif /* !(__SPARC64_STRING_H__) */
diff --git a/arch/sparc/lib/memcpy.S b/arch/sparc/lib/memcpy.S
index 1dc8ec5..d3626cd 100644
--- a/arch/sparc/lib/memcpy.S
+++ b/arch/sparc/lib/memcpy.S
@@ -141,11 +141,6 @@ x:
 	retl
 	 nop		! Only bcopy returns here and it retuns void...
 
-#ifdef __KERNEL__
-FUNC(amemmove)
-FUNC(__memmove)
-EXPORT_SYMBOL(__memmove)
-#endif
 FUNC(memmove)
 EXPORT_SYMBOL(memmove)
 	cmp		%o0, %o1
-- 
2.1.4
