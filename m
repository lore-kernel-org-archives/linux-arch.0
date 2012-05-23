From: David Miller <davem@davemloft.net>
Subject: Re: Arch maintainers Ahoy!
Date: Wed, 23 May 2012 01:46:27 -0400 (EDT)
Message-ID: <20120523.014627.497058725671088241.davem@davemloft.net>
References: <CA+55aFzm5v2JXNOEp=VmJ22FOdo77L_TsDKbou6S=AtAJB-+Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:54768 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268Ab2EWFq3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 May 2012 01:46:29 -0400
In-Reply-To: <CA+55aFzm5v2JXNOEp=VmJ22FOdo77L_TsDKbou6S=AtAJB-+Hg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-arch@vger.kernel.org


Thanks for the reminder although I did still have this on my TODO
list somewhere :-)

I'll do something like the following (untested) for sparc.

--------------------
[PATCH] sparc: Add full proper error handling to strncpy_from_user().

Linus removed the end-of-address-space hackery from
fs/namei.c:do_getname() so we really have to validate these edge
conditions and cannot cheat any more (as x86 used to as well).

Move to a common C implementation like x86 did.  And if both
src and dst are sufficiently aligned we'll do word at a time
copies and checks as well.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/uaccess.h      |    3 +
 arch/sparc/include/asm/uaccess_32.h   |   10 ---
 arch/sparc/include/asm/uaccess_64.h   |    4 -
 arch/sparc/lib/Makefile               |    2 +-
 arch/sparc/lib/ksyms.c                |    3 -
 arch/sparc/lib/strncpy_from_user_32.S |   47 ------------
 arch/sparc/lib/strncpy_from_user_64.S |  133 ---------------------------------
 arch/sparc/lib/usercopy.c             |  132 ++++++++++++++++++++++++++++++++
 8 files changed, 136 insertions(+), 198 deletions(-)
 delete mode 100644 arch/sparc/lib/strncpy_from_user_32.S
 delete mode 100644 arch/sparc/lib/strncpy_from_user_64.S

diff --git a/arch/sparc/include/asm/uaccess.h b/arch/sparc/include/asm/uaccess.h
index e88fbe5..42a28cf 100644
--- a/arch/sparc/include/asm/uaccess.h
+++ b/arch/sparc/include/asm/uaccess.h
@@ -5,4 +5,7 @@
 #else
 #include <asm/uaccess_32.h>
 #endif
+
+extern long strncpy_from_user(char *dest, const char __user *src, long count);
+
 #endif
diff --git a/arch/sparc/include/asm/uaccess_32.h b/arch/sparc/include/asm/uaccess_32.h
index d50c310..59586b5 100644
--- a/arch/sparc/include/asm/uaccess_32.h
+++ b/arch/sparc/include/asm/uaccess_32.h
@@ -304,16 +304,6 @@ static inline unsigned long clear_user(void __user *addr, unsigned long n)
 		return n;
 }
 
-extern long __strncpy_from_user(char *dest, const char __user *src, long count);
-
-static inline long strncpy_from_user(char *dest, const char __user *src, long count)
-{
-	if (__access_ok((unsigned long) src, count))
-		return __strncpy_from_user(dest, src, count);
-	else
-		return -EFAULT;
-}
-
 extern long __strlen_user(const char __user *);
 extern long __strnlen_user(const char __user *, long len);
 
diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm/uaccess_64.h
index a1091afb..dcdfb89 100644
--- a/arch/sparc/include/asm/uaccess_64.h
+++ b/arch/sparc/include/asm/uaccess_64.h
@@ -257,10 +257,6 @@ extern unsigned long __must_check __clear_user(void __user *, unsigned long);
 
 #define clear_user __clear_user
 
-extern long __must_check __strncpy_from_user(char *dest, const char __user *src, long count);
-
-#define strncpy_from_user __strncpy_from_user
-
 extern long __strlen_user(const char __user *);
 extern long __strnlen_user(const char __user *, long len);
 
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 389628f..943d98d 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -10,7 +10,7 @@ lib-y                 += strlen.o
 lib-y                 += checksum_$(BITS).o
 lib-$(CONFIG_SPARC32) += blockops.o
 lib-y                 += memscan_$(BITS).o memcmp.o strncmp_$(BITS).o
-lib-y                 += strncpy_from_user_$(BITS).o strlen_user_$(BITS).o
+lib-y                 += strlen_user_$(BITS).o
 lib-$(CONFIG_SPARC32) += divdi3.o udivdi3.o
 lib-$(CONFIG_SPARC32) += copy_user.o locks.o
 lib-$(CONFIG_SPARC64) += atomic_64.o
diff --git a/arch/sparc/lib/ksyms.c b/arch/sparc/lib/ksyms.c
index 2dc3087..6b278ab 100644
--- a/arch/sparc/lib/ksyms.c
+++ b/arch/sparc/lib/ksyms.c
@@ -33,9 +33,6 @@ EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(__bzero);
 
-/* Moving data to/from/in userspace. */
-EXPORT_SYMBOL(__strncpy_from_user);
-
 /* Networking helper routines. */
 EXPORT_SYMBOL(csum_partial);
 
diff --git a/arch/sparc/lib/strncpy_from_user_32.S b/arch/sparc/lib/strncpy_from_user_32.S
deleted file mode 100644
index db0ed29..0000000
--- a/arch/sparc/lib/strncpy_from_user_32.S
+++ /dev/null
@@ -1,47 +0,0 @@
-/* strncpy_from_user.S: Sparc strncpy from userspace.
- *
- *  Copyright(C) 1996 David S. Miller
- */
-
-#include <linux/linkage.h>
-#include <asm/ptrace.h>
-#include <asm/errno.h>
-
-	.text
-
-	/* Must return:
-	 *
-	 * -EFAULT		for an exception
-	 * count		if we hit the buffer limit
-	 * bytes copied		if we hit a null byte
-	 */
-
-ENTRY(__strncpy_from_user)
-	/* %o0=dest, %o1=src, %o2=count */
-	mov	%o2, %o3
-1:
-	subcc	%o2, 1, %o2
-	bneg	2f
-	 nop
-10:
-	ldub	[%o1], %o4
-	add	%o0, 1, %o0
-	cmp	%o4, 0
-	add	%o1, 1, %o1
-	bne	1b
-	 stb	%o4, [%o0 - 1]
-2:
-	add	%o2, 1, %o0
-	retl
-	 sub	%o3, %o0, %o0
-ENDPROC(__strncpy_from_user)
-
-	.section .fixup,#alloc,#execinstr
-	.align	4
-4:
-	retl
-	 mov	-EFAULT, %o0
-
-	.section __ex_table,#alloc
-	.align	4
-	.word	10b, 4b
diff --git a/arch/sparc/lib/strncpy_from_user_64.S b/arch/sparc/lib/strncpy_from_user_64.S
deleted file mode 100644
index d1246b7..0000000
--- a/arch/sparc/lib/strncpy_from_user_64.S
+++ /dev/null
@@ -1,133 +0,0 @@
-/*
- * strncpy_from_user.S: Sparc64 strncpy from userspace.
- *
- *  Copyright (C) 1997, 1999 Jakub Jelinek (jj@ultra.linux.cz)
- */
-
-#include <linux/linkage.h>
-#include <asm/asi.h>
-#include <asm/errno.h>
-
-	.data
-	.align	8
-0:	.xword	0x0101010101010101
-
-	.text
-
-	/* Must return:
-	 *
-	 * -EFAULT		for an exception
-	 * count		if we hit the buffer limit
-	 * bytes copied		if we hit a null byte
-	 * (without the null byte)
-	 *
-	 * This implementation assumes:
-	 * %o1 is 8 aligned => !(%o2 & 7)
-	 * %o0 is 8 aligned (if not, it will be slooooow, but will work)
-	 *
-	 * This is optimized for the common case:
-	 * in my stats, 90% of src are 8 aligned (even on sparc32)
-	 * and average length is 18 or so.
-	 */
-
-ENTRY(__strncpy_from_user)
-	/* %o0=dest, %o1=src, %o2=count */
-	andcc	%o1, 7, %g0		! IEU1	Group
-	bne,pn	%icc, 30f		! CTI
-	 add	%o0, %o2, %g3		! IEU0
-60:	ldxa	[%o1] %asi, %g1		! Load	Group
-	brlez,pn %o2, 10f		! CTI
-	 mov	%o0, %o3		! IEU0
-50:	sethi	%hi(0b), %o4		! IEU0	Group
-	ldx	[%o4 + %lo(0b)], %o4	! Load
-	sllx	%o4, 7, %o5		! IEU1	Group
-1:	sub	%g1, %o4, %g2		! IEU0	Group
-	stx	%g1, [%o0]		! Store
-	add	%o0, 8, %o0		! IEU1
-	andcc	%g2, %o5, %g0		! IEU1	Group
-	bne,pn	%xcc, 5f		! CTI
-	 add	%o1, 8, %o1		! IEU0
-	cmp	%o0, %g3		! IEU1	Group
-	bl,a,pt %xcc, 1b		! CTI
-61:	 ldxa	[%o1] %asi, %g1		! Load
-10:	retl				! CTI	Group
-	 mov	%o2, %o0		! IEU0
-5:	srlx	%g2, 32, %g7		! IEU0	Group
-	sethi	%hi(0xff00), %o4	! IEU1
-	andcc	%g7, %o5, %g0		! IEU1	Group
-	be,pn	%icc, 2f		! CTI
-	 or	%o4, %lo(0xff00), %o4	! IEU0
-	srlx	%g1, 48, %g7		! IEU0	Group
-	andcc	%g7, %o4, %g0		! IEU1	Group
-	be,pn	%icc, 50f		! CTI
-	 andcc	%g7, 0xff, %g0		! IEU1	Group
-	be,pn	%icc, 51f		! CTI
-	 srlx	%g1, 32, %g7		! IEU0
-	andcc	%g7, %o4, %g0		! IEU1	Group
-	be,pn	%icc, 52f		! CTI
-	 andcc	%g7, 0xff, %g0		! IEU1	Group
-	be,pn	%icc, 53f		! CTI
-2:	 andcc	%g2, %o5, %g0		! IEU1	Group
-	be,pn	%icc, 2f		! CTI
-	 srl	%g1, 16, %g7		! IEU0
-	andcc	%g7, %o4, %g0		! IEU1	Group
-	be,pn	%icc, 54f		! CTI
-	 andcc	%g7, 0xff, %g0		! IEU1	Group
-	be,pn	%icc, 55f		! CTI
-	 andcc	%g1, %o4, %g0		! IEU1	Group
-	be,pn	%icc, 56f		! CTI
-	 andcc	%g1, 0xff, %g0		! IEU1	Group
-	be,a,pn	%icc, 57f		! CTI
-	 sub	%o0, %o3, %o0		! IEU0
-2:	cmp	%o0, %g3		! IEU1	Group
-	bl,a,pt	%xcc, 50b		! CTI
-62:	 ldxa	[%o1] %asi, %g1		! Load
-	retl				! CTI	Group
-	 mov	%o2, %o0		! IEU0
-50:	sub	%o0, %o3, %o0
-	retl
-	 sub	%o0, 8, %o0
-51:	sub	%o0, %o3, %o0
-	retl
-	 sub	%o0, 7, %o0
-52:	sub	%o0, %o3, %o0
-	retl
-	 sub	%o0, 6, %o0
-53:	sub	%o0, %o3, %o0
-	retl
-	 sub	%o0, 5, %o0
-54:	sub	%o0, %o3, %o0
-	retl
-	 sub	%o0, 4, %o0
-55:	sub	%o0, %o3, %o0
-	retl
-	 sub	%o0, 3, %o0
-56:	sub	%o0, %o3, %o0
-	retl
-	 sub	%o0, 2, %o0
-57:	retl
-	 sub	%o0, 1, %o0
-30:	brlez,pn %o2, 3f
-	 sub	%g0, %o2, %o3
-	add	%o0, %o2, %o0
-63:	lduba	[%o1] %asi, %o4
-1:	add	%o1, 1, %o1
-	brz,pn	%o4, 2f
-	 stb	%o4, [%o0 + %o3]
-	addcc	%o3, 1, %o3
-	bne,pt	%xcc, 1b
-64:	 lduba	[%o1] %asi, %o4
-3:	retl
-	 mov	%o2, %o0
-2:	retl
-	 add	%o2, %o3, %o0
-ENDPROC(__strncpy_from_user)
-
-	.section __ex_table,"a"
-	.align	4
-	.word	60b, __retl_efault
-	.word	61b, __retl_efault
-	.word	62b, __retl_efault
-	.word	63b, __retl_efault
-	.word	64b, __retl_efault
-	.previous
diff --git a/arch/sparc/lib/usercopy.c b/arch/sparc/lib/usercopy.c
index 14b363f..4621dba 100644
--- a/arch/sparc/lib/usercopy.c
+++ b/arch/sparc/lib/usercopy.c
@@ -1,4 +1,6 @@
 #include <linux/module.h>
+#include <linux/uaccess.h>
+#include <linux/errno.h>
 #include <linux/bug.h>
 
 void copy_from_user_overflow(void)
@@ -6,3 +8,133 @@ void copy_from_user_overflow(void)
 	WARN(1, "Buffer overflow detected!\n");
 }
 EXPORT_SYMBOL(copy_from_user_overflow);
+
+#define REPEAT_BYTE(x)	((~0ul / 0xff) * (x))
+
+/* Return the high bit set in the first byte that is a zero */
+static inline unsigned long has_zero(unsigned long a)
+{
+	return ((a - REPEAT_BYTE(0x01)) & ~a) & REPEAT_BYTE(0x80);
+}
+
+static inline long find_zero(unsigned long c)
+{
+#ifdef CONFIG_64BIT
+	if (!(c & 0xff00000000000000UL))
+		return 0;
+	if (!(c & 0x00ff000000000000UL))
+		return 1;
+	if (!(c & 0x0000ff0000000000UL))
+		return 2;
+	if (!(c & 0x000000ff00000000UL))
+		return 3;
+#define __OFF 4
+#else
+#define __OFF 0
+#endif
+	if (!(c & 0xff000000))
+		return __OFF + 0;
+	if (!(c & 0x00ff0000))
+		return __OFF + 1;
+	if (!(c & 0x0000ff00))
+		return __OFF + 2;
+	return __OFF + 3;
+#undef __OFF
+}
+
+/*
+ * Do a strncpy, return length of string without final '\0'.
+ * 'count' is the user-supplied count (return 'count' if we
+ * hit it), 'max' is the address space maximum (and we return
+ * -EFAULT if we hit it).
+ */
+static inline long do_strncpy_from_user(char *dst, const char __user *src, long count, unsigned long max)
+{
+	long res = 0;
+
+	/*
+	 * Truncate 'max' to the user-specified limit, so that
+	 * we only have one limit we need to check in the loop
+	 */
+	if (max > count)
+		max = count;
+
+	if (((long) dst | (long) src) & (sizeof(long) - 1))
+		goto byte_at_a_time;
+
+	while (max >= sizeof(unsigned long)) {
+		unsigned long c;
+
+		/* Fall back to byte-at-a-time if we get a page fault */
+		if (unlikely(__get_user(c,(unsigned long __user *)(src+res))))
+			break;
+		if (has_zero(c))
+			return res + find_zero(c);
+		*(unsigned long *)(dst+res) = c;
+		res += sizeof(unsigned long);
+		max -= sizeof(unsigned long);
+	}
+
+byte_at_a_time:
+	while (max) {
+		char c;
+
+		if (unlikely(__get_user(c,src+res)))
+			return -EFAULT;
+		dst[res] = c;
+		if (!c)
+			return res;
+		res++;
+		max--;
+	}
+
+	/*
+	 * Uhhuh. We hit 'max'. But was that the user-specified maximum
+	 * too? If so, that's ok - we got as much as the user asked for.
+	 */
+	if (res >= count)
+		return res;
+
+	/*
+	 * Nope: we hit the address space limit, and we still had more
+	 * characters the caller would have wanted. That's an EFAULT.
+	 */
+	return -EFAULT;
+}
+
+/**
+ * strncpy_from_user: - Copy a NUL terminated string from userspace.
+ * @dst:   Destination address, in kernel space.  This buffer must be at
+ *         least @count bytes long.
+ * @src:   Source address, in user space.
+ * @count: Maximum number of bytes to copy, including the trailing NUL.
+ *
+ * Copies a NUL-terminated string from userspace to kernel space.
+ *
+ * On success, returns the length of the string (not including the trailing
+ * NUL).
+ *
+ * If access to userspace fails, returns -EFAULT (some data may have been
+ * copied).
+ *
+ * If @count is smaller than the length of the string, copies @count bytes
+ * and returns @count.
+ */
+long strncpy_from_user(char *dst, const char __user *src, long count)
+{
+	unsigned long max_addr, src_addr;
+
+	if (unlikely(count <= 0))
+		return 0;
+
+	max_addr = ~0UL;
+	if (likely(segment_eq(get_fs(), USER_DS)))
+		max_addr = STACK_TOP;
+	src_addr = (unsigned long)src;
+	if (likely(src_addr < max_addr)) {
+		unsigned long max = max_addr - src_addr;
+		return do_strncpy_from_user(dst, src, count, max);
+	}
+	return -EFAULT;
+}
+EXPORT_SYMBOL(strncpy_from_user);
-- 
1.7.10
