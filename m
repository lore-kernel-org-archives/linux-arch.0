Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:58622 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727999AbeIEQjG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Sep 2018 12:39:06 -0400
From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V3 13/26] csky: Library functions
Date: Wed,  5 Sep 2018 20:07:52 +0800
Message-ID: <37f9bd824ede529fdab291a40eef3415f99ec8aa.1536138304.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1536138304.git.ren_guo@c-sky.com>
References: <cover.1536138304.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1536138304.git.ren_guo@c-sky.com>
References: <cover.1536138304.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, ren_guo@c-sky.com, green.hu@gmail.com
Message-ID: <20180905120752.P9dPHMZiTGygIGWAtKUpHH0QBxCRqmZqgAd4UaIJsfM@z>

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/abiv1/bswapdi.c        |  18 ++
 arch/csky/abiv1/bswapsi.c        |  14 ++
 arch/csky/abiv1/inc/abi/string.h |  13 ++
 arch/csky/abiv1/memcpy.S         | 344 +++++++++++++++++++++++++++++++++++++++
 arch/csky/abiv1/memset.c         |  38 +++++
 arch/csky/abiv1/strksyms.c       |   7 +
 arch/csky/abiv2/inc/abi/string.h |  28 ++++
 arch/csky/abiv2/memcmp.S         | 151 +++++++++++++++++
 arch/csky/abiv2/memcpy.S         | 110 +++++++++++++
 arch/csky/abiv2/memcpy.c         |  40 +++++
 arch/csky/abiv2/memmove.S        | 108 ++++++++++++
 arch/csky/abiv2/memset.S         |  83 ++++++++++
 arch/csky/abiv2/strcmp.S         | 168 +++++++++++++++++++
 arch/csky/abiv2/strcpy.S         | 123 ++++++++++++++
 arch/csky/abiv2/strksyms.c       |  12 ++
 arch/csky/abiv2/strlen.S         |  97 +++++++++++
 arch/csky/abiv2/sysdep.h         |  29 ++++
 arch/csky/include/asm/string.h   |  13 ++
 arch/csky/kernel/platform.c      |  17 ++
 arch/csky/kernel/power.c         |  30 ++++
 arch/csky/lib/delay.c            |  40 +++++
 21 files changed, 1483 insertions(+)
 create mode 100644 arch/csky/abiv1/bswapdi.c
 create mode 100644 arch/csky/abiv1/bswapsi.c
 create mode 100644 arch/csky/abiv1/inc/abi/string.h
 create mode 100644 arch/csky/abiv1/memcpy.S
 create mode 100644 arch/csky/abiv1/memset.c
 create mode 100644 arch/csky/abiv1/strksyms.c
 create mode 100644 arch/csky/abiv2/inc/abi/string.h
 create mode 100644 arch/csky/abiv2/memcmp.S
 create mode 100644 arch/csky/abiv2/memcpy.S
 create mode 100644 arch/csky/abiv2/memcpy.c
 create mode 100644 arch/csky/abiv2/memmove.S
 create mode 100644 arch/csky/abiv2/memset.S
 create mode 100644 arch/csky/abiv2/strcmp.S
 create mode 100644 arch/csky/abiv2/strcpy.S
 create mode 100644 arch/csky/abiv2/strksyms.c
 create mode 100644 arch/csky/abiv2/strlen.S
 create mode 100644 arch/csky/abiv2/sysdep.h
 create mode 100644 arch/csky/include/asm/string.h
 create mode 100644 arch/csky/kernel/platform.c
 create mode 100644 arch/csky/kernel/power.c
 create mode 100644 arch/csky/lib/delay.c

diff --git a/arch/csky/abiv1/bswapdi.c b/arch/csky/abiv1/bswapdi.c
new file mode 100644
index 0000000..7346252
--- /dev/null
+++ b/arch/csky/abiv1/bswapdi.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/export.h>
+#include <linux/compiler.h>
+
+unsigned long long notrace __bswapdi2(unsigned long long u)
+{
+	return (((u) & 0xff00000000000000ull) >> 56) |
+	       (((u) & 0x00ff000000000000ull) >> 40) |
+	       (((u) & 0x0000ff0000000000ull) >> 24) |
+	       (((u) & 0x000000ff00000000ull) >>  8) |
+	       (((u) & 0x00000000ff000000ull) <<  8) |
+	       (((u) & 0x0000000000ff0000ull) << 24) |
+	       (((u) & 0x000000000000ff00ull) << 40) |
+	       (((u) & 0x00000000000000ffull) << 56);
+}
+
+EXPORT_SYMBOL(__bswapdi2);
diff --git a/arch/csky/abiv1/bswapsi.c b/arch/csky/abiv1/bswapsi.c
new file mode 100644
index 0000000..6e26b7e
--- /dev/null
+++ b/arch/csky/abiv1/bswapsi.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/export.h>
+#include <linux/compiler.h>
+
+unsigned int notrace __bswapsi2(unsigned int u)
+{
+	return (((u) & 0xff000000) >> 24) |
+	       (((u) & 0x00ff0000) >>  8) |
+	       (((u) & 0x0000ff00) <<  8) |
+	       (((u) & 0x000000ff) << 24);
+}
+
+EXPORT_SYMBOL(__bswapsi2);
diff --git a/arch/csky/abiv1/inc/abi/string.h b/arch/csky/abiv1/inc/abi/string.h
new file mode 100644
index 0000000..60d4fc4
--- /dev/null
+++ b/arch/csky/abiv1/inc/abi/string.h
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef __ABI_CSKY_STRING_H
+#define __ABI_CSKY_STRING_H
+
+#define __HAVE_ARCH_MEMCPY
+extern void * memcpy(void *,const void *,__kernel_size_t);
+
+#define __HAVE_ARCH_MEMSET
+extern void * memset(void *,int,__kernel_size_t);
+
+#endif /* __ABI_CSKY_STRING_H */
diff --git a/arch/csky/abiv1/memcpy.S b/arch/csky/abiv1/memcpy.S
new file mode 100644
index 0000000..f86ad75
--- /dev/null
+++ b/arch/csky/abiv1/memcpy.S
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/linkage.h>
+
+.macro	GET_FRONT_BITS rx y
+#ifdef	__cskyLE__
+	lsri	\rx, \y
+#else
+	lsli	\rx, \y
+#endif
+.endm
+
+.macro	GET_AFTER_BITS rx y
+#ifdef	__cskyLE__
+	lsli	\rx, \y
+#else
+	lsri	\rx, \y
+#endif
+.endm
+
+/* void *memcpy(void *dest, const void *src, size_t n); */
+ENTRY(memcpy)
+	mov	r7, r2
+	cmplti	r4, 4                                   /* If len less than 4 bytes */
+	bt	.L_copy_by_byte
+	mov	r6, r2
+	andi	r6, 3
+	cmpnei	r6, 0
+	jbt	.L_dest_not_aligned                     /* If dest is not 4 bytes aligned */
+	mov	r6, r3
+	andi	r6, 3
+	cmpnei	r6, 0
+	jbt	.L_dest_aligned_but_src_not_aligned     /* If dest is aligned, but src is not aligned */
+.L0:
+	cmplti	r4, 16
+	jbt	.L_aligned_and_len_less_16bytes         /* If len less than 16 bytes */
+	subi	sp, 8
+	stw	r8, (sp, 0)
+.L_aligned_and_len_larger_16bytes:                      /* src and dst are all aligned, and len > 16 bytes */
+	ldw	r1, (r3, 0)
+	ldw	r5, (r3, 4)
+	ldw	r8, (r3, 8)
+	stw	r1, (r7, 0)
+	ldw	r1, (r3, 12)
+	stw	r5, (r7, 4)
+	stw	r8, (r7, 8)
+	stw	r1, (r7, 12)
+	subi	r4, 16
+	addi	r3, 16
+	addi	r7, 16
+	cmplti	r4, 16
+	jbf	.L_aligned_and_len_larger_16bytes
+	ldw	r8, (sp, 0)
+	addi	sp, 8
+	cmpnei	r4, 0                    /* If len == 0, return, else goto .L_aligned_and_len_less_16bytes  */
+	jbf	.L_return
+
+.L_aligned_and_len_less_16bytes:
+	cmplti	r4, 4
+	bt	.L_copy_by_byte
+.L1:
+	ldw	r1, (r3, 0)
+	stw	r1, (r7, 0)
+	subi	r4, 4
+	addi	r3, 4
+	addi	r7, 4
+	cmplti	r4, 4
+	jbf	.L1
+	br	.L_copy_by_byte
+
+.L_return:
+	rts
+
+.L_copy_by_byte:                      /* len less than 4 bytes */
+	cmpnei	r4, 0
+	jbf	.L_return
+.L4:
+	ldb	r1, (r3, 0)
+	stb	r1, (r7, 0)
+	addi	r3, 1
+	addi	r7, 1
+	decne	r4
+	jbt	.L4
+	rts
+
+/* If dest is not aligned, just copying some bytes makes the dest align.
+   Afther that, we judge whether the src is aligned. */
+.L_dest_not_aligned:
+	mov	r5, r3
+	rsub	r5, r5, r7
+	abs	r5, r5
+	cmplt	r5, r4
+	bt	.L_copy_by_byte
+	mov	r5, r7
+	sub	r5, r3
+	cmphs	r5, r4
+	bf	.L_copy_by_byte
+	mov	r5, r6
+.L5:
+	ldb	r1, (r3, 0)              /* makes the dest align. */
+	stb	r1, (r7, 0)
+	addi	r5, 1
+	subi	r4, 1
+	addi	r3, 1
+	addi	r7, 1
+	cmpnei	r5, 4
+	jbt	.L5
+	cmplti	r4, 4
+	jbt	.L_copy_by_byte
+	mov	r6, r3                   /* judge whether the src is aligned. */
+	andi	r6, 3
+	cmpnei	r6, 0
+	jbf	.L0
+
+/* Judge the number of misaligned, 1, 2, 3? */
+.L_dest_aligned_but_src_not_aligned:
+	mov	r5, r3
+	rsub	r5, r5, r7
+	abs	r5, r5
+	cmplt	r5, r4
+	bt	.L_copy_by_byte
+	bclri	r3, 0
+	bclri	r3, 1
+	ldw	r1, (r3, 0)
+	addi	r3, 4
+	cmpnei	r6, 2
+	bf	.L_dest_aligned_but_src_not_aligned_2bytes
+	cmpnei	r6, 3
+	bf	.L_dest_aligned_but_src_not_aligned_3bytes
+
+.L_dest_aligned_but_src_not_aligned_1byte:
+	mov	r5, r7
+	sub	r5, r3
+	cmphs	r5, r4
+	bf	.L_copy_by_byte
+	cmplti	r4, 16
+	bf	.L11
+.L10:                                     /* If the len is less than 16 bytes */
+	GET_FRONT_BITS r1 8
+	mov	r5, r1
+	ldw	r6, (r3, 0)
+	mov	r1, r6
+	GET_AFTER_BITS r6 24
+	or	r5, r6
+	stw	r5, (r7, 0)
+	subi	r4, 4
+	addi	r3, 4
+	addi	r7, 4
+	cmplti	r4, 4
+	bf	.L10
+	subi	r3, 3
+	br	.L_copy_by_byte
+.L11:
+	subi	sp, 16
+	stw	r8, (sp, 0)
+	stw	r9, (sp, 4)
+	stw	r10, (sp, 8)
+	stw	r11, (sp, 12)
+.L12:
+	ldw	r5, (r3, 0)
+	ldw	r11, (r3, 4)
+	ldw	r8, (r3, 8)
+	ldw	r9, (r3, 12)
+
+	GET_FRONT_BITS r1 8               /* little or big endian? */
+	mov	r10, r5
+	GET_AFTER_BITS r5 24
+	or	r5, r1
+
+	GET_FRONT_BITS r10 8
+	mov	r1, r11
+	GET_AFTER_BITS r11 24
+	or	r11, r10
+
+	GET_FRONT_BITS r1 8
+	mov	r10, r8
+	GET_AFTER_BITS r8 24
+	or	r8, r1
+
+	GET_FRONT_BITS r10 8
+	mov	r1, r9
+	GET_AFTER_BITS r9 24
+	or	r9, r10
+
+	stw	r5, (r7, 0)
+	stw	r11, (r7, 4)
+	stw	r8, (r7, 8)
+	stw	r9, (r7, 12)
+	subi	r4, 16
+	addi	r3, 16
+	addi	r7, 16
+	cmplti	r4, 16
+	jbf	.L12
+	ldw	r8, (sp, 0)
+	ldw	r9, (sp, 4)
+	ldw	r10, (sp, 8)
+	ldw	r11, (sp, 12)
+	addi	sp , 16
+	cmplti	r4, 4
+	bf	.L10
+	subi	r3, 3
+	br	.L_copy_by_byte
+
+.L_dest_aligned_but_src_not_aligned_2bytes:
+	cmplti	r4, 16
+	bf	.L21
+.L20:
+	GET_FRONT_BITS r1 16
+	mov	r5, r1
+	ldw	r6, (r3, 0)
+	mov	r1, r6
+	GET_AFTER_BITS r6 16
+	or	r5, r6
+	stw	r5, (r7, 0)
+	subi	r4, 4
+	addi	r3, 4
+	addi	r7, 4
+	cmplti	r4, 4
+	bf	.L20
+	subi	r3, 2
+	br	.L_copy_by_byte
+	rts
+
+.L21:	/* n > 16 */
+	subi 	sp, 16
+	stw	r8, (sp, 0)
+	stw	r9, (sp, 4)
+	stw	r10, (sp, 8)
+	stw	r11, (sp, 12)
+
+.L22:
+	ldw	r5, (r3, 0)
+	ldw	r11, (r3, 4)
+	ldw	r8, (r3, 8)
+	ldw	r9, (r3, 12)
+
+	GET_FRONT_BITS r1 16
+	mov	r10, r5
+	GET_AFTER_BITS r5 16
+	or	r5, r1
+
+	GET_FRONT_BITS r10 16
+	mov	r1, r11
+	GET_AFTER_BITS r11 16
+	or	r11, r10
+
+	GET_FRONT_BITS r1 16
+	mov	r10, r8
+	GET_AFTER_BITS r8 16
+	or	r8, r1
+
+	GET_FRONT_BITS r10 16
+	mov	r1, r9
+	GET_AFTER_BITS r9 16
+	or	r9, r10
+
+	stw	r5, (r7, 0)
+	stw	r11, (r7, 4)
+	stw	r8, (r7, 8)
+	stw	r9, (r7, 12)
+	subi	r4, 16
+	addi	r3, 16
+	addi	r7, 16
+	cmplti	r4, 16
+	jbf	.L22
+	ldw	r8, (sp, 0)
+	ldw	r9, (sp, 4)
+	ldw	r10, (sp, 8)
+	ldw	r11, (sp, 12)
+	addi	sp, 16
+	cmplti	r4, 4
+	bf	.L20
+	subi	r3, 2
+	br	.L_copy_by_byte
+
+
+.L_dest_aligned_but_src_not_aligned_3bytes:
+	cmplti	r4, 16
+	bf	.L31
+.L30:
+	GET_FRONT_BITS r1 24
+	mov	r5, r1
+	ldw	r6, (r3, 0)
+	mov	r1, r6
+	GET_AFTER_BITS r6 8
+	or	r5, r6
+	stw	r5, (r7, 0)
+	subi	r4, 4
+	addi	r3, 4
+	addi	r7, 4
+	cmplti	r4, 4
+	bf	.L30
+	subi	r3, 1
+	br	.L_copy_by_byte
+.L31:
+	subi	sp, 16
+	stw	r8, (sp, 0)
+	stw	r9, (sp, 4)
+	stw	r10, (sp, 8)
+	stw	r11, (sp, 12)
+.L32:
+	ldw	r5, (r3, 0)
+	ldw	r11, (r3, 4)
+	ldw	r8, (r3, 8)
+	ldw	r9, (r3, 12)
+
+	GET_FRONT_BITS r1 24
+	mov	r10, r5
+	GET_AFTER_BITS r5 8
+	or	r5, r1
+
+	GET_FRONT_BITS r10 24
+	mov	r1, r11
+	GET_AFTER_BITS r11 8
+	or	r11, r10
+
+	GET_FRONT_BITS r1 24
+	mov	r10, r8
+	GET_AFTER_BITS r8 8
+	or	r8, r1
+
+	GET_FRONT_BITS r10 24
+	mov	r1, r9
+	GET_AFTER_BITS r9 8
+	or	r9, r10
+
+	stw	r5, (r7, 0)
+	stw	r11, (r7, 4)
+	stw	r8, (r7, 8)
+	stw	r9, (r7, 12)
+	subi	r4, 16
+	addi	r3, 16
+	addi	r7, 16
+	cmplti	r4, 16
+	jbf	.L32
+	ldw	r8, (sp, 0)
+	ldw	r9, (sp, 4)
+	ldw	r10, (sp, 8)
+	ldw	r11, (sp, 12)
+	addi	sp, 16
+	cmplti	r4, 4
+	bf	.L30
+	subi	r3, 1
+	br	.L_copy_by_byte
diff --git a/arch/csky/abiv1/memset.c b/arch/csky/abiv1/memset.c
new file mode 100644
index 0000000..b7897af
--- /dev/null
+++ b/arch/csky/abiv1/memset.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/types.h>
+
+void *memset(void *dest, int c, size_t l)
+{
+	char *d = dest;
+	int ch = c;
+	int tmp;
+
+	if ((long)d & 0x3)
+		while (l--) *d++ = ch;
+	else {
+		ch &= 0xff;
+		tmp = (ch | ch << 8 | ch << 16 | ch << 24);
+
+		while (l >= 16) {
+			*(((long *)d)) = tmp;
+			*(((long *)d)+1) = tmp;
+			*(((long *)d)+2) = tmp;
+			*(((long *)d)+3) = tmp;
+			l -= 16;
+			d += 16;
+		}
+
+		while (l > 3) {
+			*(((long *)d)) = tmp;
+			d = d + 4;
+			l -= 4;
+		}
+
+		while (l) {
+			*d++ = ch;
+			l--;
+		}
+	}
+	return dest;
+}
diff --git a/arch/csky/abiv1/strksyms.c b/arch/csky/abiv1/strksyms.c
new file mode 100644
index 0000000..436995c
--- /dev/null
+++ b/arch/csky/abiv1/strksyms.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/module.h>
+
+EXPORT_SYMBOL(memcpy);
+EXPORT_SYMBOL(memset);
diff --git a/arch/csky/abiv2/inc/abi/string.h b/arch/csky/abiv2/inc/abi/string.h
new file mode 100644
index 0000000..2297d13
--- /dev/null
+++ b/arch/csky/abiv2/inc/abi/string.h
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef __ABI_CSKY_STRING_H
+#define __ABI_CSKY_STRING_H
+
+#define __HAVE_ARCH_MEMCMP
+extern int memcmp(const void *,const void *,__kernel_size_t);
+
+#define __HAVE_ARCH_MEMCPY
+extern void * memcpy(void *,const void *,__kernel_size_t);
+
+#define __HAVE_ARCH_MEMMOVE
+extern void * memmove(void *,const void *,__kernel_size_t);
+
+#define __HAVE_ARCH_MEMSET
+extern void * memset(void *,int,__kernel_size_t);
+
+#define __HAVE_ARCH_STRCMP
+extern int strcmp(const char *,const char *);
+
+#define __HAVE_ARCH_STRCPY
+extern char * strcpy(char *,const char *);
+
+#define __HAVE_ARCH_STRLEN
+extern __kernel_size_t strlen(const char *);
+
+#endif /* __ABI_CSKY_STRING_H */
diff --git a/arch/csky/abiv2/memcmp.S b/arch/csky/abiv2/memcmp.S
new file mode 100644
index 0000000..b2387bc
--- /dev/null
+++ b/arch/csky/abiv2/memcmp.S
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/linkage.h>
+#include "sysdep.h"
+
+ENTRY(memcmp)
+	/* Test if len less than 4 bytes.  */
+	mov	r3, r0
+	movi	r0, 0
+	mov	r12, r4
+	cmplti	r2, 4
+	jbt	.L_compare_by_byte
+
+	andi	r13, r0, 3
+	movi	r19, 4
+
+	/* Test if s1 is not 4 bytes aligned.  */
+	bnez	r13, .L_s1_not_aligned
+
+	LABLE_ALIGN
+.L_s1_aligned:
+	/* If dest is aligned, then copy.  */
+	zext	r18, r2, 31, 4
+	/* Test if len less than 16 bytes.  */
+	bez	r18, .L_compare_by_word
+
+.L_compare_by_4word:
+	/* If aligned, load word each time.  */
+	ldw	r20, (r3, 0)
+	ldw	r21, (r1, 0)
+	/* If s1[i] != s2[i], goto .L_byte_check.  */
+	cmpne	r20, r21
+	bt	.L_byte_check
+
+	ldw	r20, (r3, 4)
+	ldw	r21, (r1, 4)
+	cmpne	r20, r21
+	bt	.L_byte_check
+
+	ldw	r20, (r3, 8)
+	ldw	r21, (r1, 8)
+	cmpne	r20, r21
+	bt	.L_byte_check
+
+	ldw	r20, (r3, 12)
+	ldw	r21, (r1, 12)
+	cmpne	r20, r21
+	bt	.L_byte_check
+
+	PRE_BNEZAD (r18)
+	addi	a3, 16
+	addi	a1, 16
+
+	BNEZAD (r18, .L_compare_by_4word)
+
+.L_compare_by_word:
+	zext	r18, r2, 3, 2
+	bez	r18, .L_compare_by_byte
+.L_compare_by_word_loop:
+	ldw	r20, (r3, 0)
+	ldw	r21, (r1, 0)
+	addi	r3, 4
+	PRE_BNEZAD (r18)
+	cmpne	r20, r21
+	addi    r1, 4
+	bt	.L_byte_check
+	BNEZAD (r18, .L_compare_by_word_loop)
+
+.L_compare_by_byte:
+        zext    r18, r2, 1, 0
+        bez     r18, .L_return
+.L_compare_by_byte_loop:
+        ldb     r0, (r3, 0)
+        ldb     r4, (r1, 0)
+        addi    r3, 1
+        subu    r0, r4
+        PRE_BNEZAD (r18)
+        addi    r1, 1
+        bnez    r0, .L_return
+        BNEZAD (r18, .L_compare_by_byte_loop)
+
+.L_return:
+        mov     r4, r12
+        rts
+
+# ifdef __CSKYBE__
+/* d[i] != s[i] in word, so we check byte 0.  */
+.L_byte_check:
+        xtrb0   r0, r20
+        xtrb0   r2, r21
+        subu    r0, r2
+        bnez    r0, .L_return
+
+        /* check byte 1 */
+        xtrb1   r0, r20
+        xtrb1   r2, r21
+        subu    r0, r2
+        bnez    r0, .L_return
+
+        /* check byte 2 */
+        xtrb2   r0, r20
+        xtrb2   r2, r21
+        subu    r0, r2
+        bnez    r0, .L_return
+
+        /* check byte 3 */
+        xtrb3   r0, r20
+        xtrb3   r2, r21
+        subu    r0, r2
+# else
+/* s1[i] != s2[i] in word, so we check byte 3.  */
+.L_byte_check:
+	xtrb3	r0, r20
+	xtrb3	r2, r21
+        subu    r0, r2
+        bnez    r0, .L_return
+
+	/* check byte 2 */
+	xtrb2	r0, r20
+	xtrb2	r2, r21
+        subu    r0, r2
+        bnez    r0, .L_return
+
+	/* check byte 1 */
+	xtrb1	r0, r20
+	xtrb1	r2, r21
+	subu	r0, r2
+	bnez    r0, .L_return
+
+	/* check byte 0 */
+	xtrb0	r0, r20
+	xtrb0	r2, r21
+	subu	r0, r2
+	br	.L_return
+# endif /* !__CSKYBE__ */
+
+/* Compare when s1 is not aligned.  */
+.L_s1_not_aligned:
+	sub	r13, r19, r13
+	sub	r2, r13
+.L_s1_not_aligned_loop:
+	ldb	r0, (r3, 0)
+	ldb	r4, (r1, 0)
+	addi	r3, 1
+	subu	r0, r4
+	PRE_BNEZAD (r13)
+	addi	r1, 1
+	bnez	r0, .L_return
+	BNEZAD (r13, .L_s1_not_aligned_loop)
+	br	.L_s1_aligned
+ENDPROC(memcmp)
diff --git a/arch/csky/abiv2/memcpy.S b/arch/csky/abiv2/memcpy.S
new file mode 100644
index 0000000..0623e7c
--- /dev/null
+++ b/arch/csky/abiv2/memcpy.S
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/linkage.h>
+#include "sysdep.h"
+
+ENTRY(__memcpy)
+ENTRY(memcpy)
+	/* Test if len less than 4 bytes.  */
+	mov	r12, r0
+	cmplti	r2, 4
+	jbt	.L_copy_by_byte
+
+	andi	r13, r0, 3
+	movi	r19, 4
+	/* Test if dest is not 4 bytes aligned.  */
+	bnez	r13, .L_dest_not_aligned
+
+/* Hardware can handle unaligned access directly.  */
+.L_dest_aligned:
+	/* If dest is aligned, then copy.  */
+	zext	r18, r2, 31, 4
+
+	/* Test if len less than 16 bytes.  */
+	bez	r18, .L_len_less_16bytes
+	movi	r19, 0
+
+	LABLE_ALIGN
+.L_len_larger_16bytes:
+#if defined(__CSKY_VDSPV2__)
+	vldx.8	vr0, (r1), r19
+	PRE_BNEZAD (r18)
+	addi	r1, 16
+	vstx.8	vr0, (r0), r19
+	addi	r0, 16
+#elif defined(__CK860__)
+	ldw	r3, (r1, 0)
+	stw	r3, (r0, 0)
+	ldw	r3, (r1, 4)
+	stw	r3, (r0, 4)
+	ldw	r3, (r1, 8)
+	stw	r3, (r0, 8)
+	ldw	r3, (r1, 12)
+	addi	r1, 16
+	stw	r3, (r0, 12)
+	addi	r0, 16
+#else
+	ldw	r20, (r1, 0)
+	ldw	r21, (r1, 4)
+	ldw	r22, (r1, 8)
+	ldw	r23, (r1, 12)
+	stw	r20, (r0, 0)
+	stw	r21, (r0, 4)
+	stw	r22, (r0, 8)
+	stw	r23, (r0, 12)
+	PRE_BNEZAD (r18)
+	addi	r1, 16
+	addi	r0, 16
+#endif
+	BNEZAD (r18, .L_len_larger_16bytes)
+
+.L_len_less_16bytes:
+	zext	r18, r2, 3, 2
+	bez	r18, .L_copy_by_byte
+.L_len_less_16bytes_loop:
+	ldw	r3, (r1, 0)
+	PRE_BNEZAD (r18)
+	addi	r1, 4
+	stw	r3, (r0, 0)
+	addi	r0, 4
+	BNEZAD (r18, .L_len_less_16bytes_loop)
+
+/* Test if len less than 4 bytes.  */
+.L_copy_by_byte:
+	zext	r18, r2, 1, 0
+	bez	r18, .L_return
+.L_copy_by_byte_loop:
+	ldb	r3, (r1, 0)
+	PRE_BNEZAD (r18)
+	addi	r1, 1
+	stb	r3, (r0, 0)
+	addi	r0, 1
+	BNEZAD (r18, .L_copy_by_byte_loop)
+
+.L_return:
+	mov	r0, r12
+	rts
+
+/*
+ * If dest is not aligned, just copying some bytes makes the
+ * dest align.
+ */
+.L_dest_not_aligned:
+	sub	r13, r19, r13
+	sub	r2, r13
+
+/* Makes the dest align.  */
+.L_dest_not_aligned_loop:
+	ldb	r3, (r1, 0)
+	PRE_BNEZAD (r13)
+	addi	r1, 1
+	stb	r3, (r0, 0)
+	addi	r0, 1
+	BNEZAD (r13, .L_dest_not_aligned_loop)
+	cmplti	r2, 4
+	jbt	.L_copy_by_byte
+
+	/* Check whether the src is aligned.  */
+	jbr	.L_dest_aligned
+ENDPROC(__memcpy)
diff --git a/arch/csky/abiv2/memcpy.c b/arch/csky/abiv2/memcpy.c
new file mode 100644
index 0000000..b8b4019
--- /dev/null
+++ b/arch/csky/abiv2/memcpy.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/types.h>
+
+/*
+ * memory copy function.
+ */
+void *memcpy (void *to, const void *from, size_t l)
+{
+	char *d = to;
+	const char *s = from;
+
+	if (((long)d | (long)s) & 0x3) {
+		while (l--) *d++ = *s++;
+	} else {
+		while (l >= 16) {
+			*(((long *)d)) = *(((long *)s));
+			*(((long *)d)+1) = *(((long *)s)+1);
+			*(((long *)d)+2) = *(((long *)s)+2);
+			*(((long *)d)+3) = *(((long *)s)+3);
+			l -= 16;
+			d += 16;
+			s += 16;
+		}
+
+		while (l > 3) {
+			*(((long *)d)) = *(((long *)s));
+			d = d +4;
+			s = s +4;
+			l -= 4;
+		}
+
+		while (l) {
+			*d++ = *s++;
+			l--;
+		}
+	}
+	return to;
+}
diff --git a/arch/csky/abiv2/memmove.S b/arch/csky/abiv2/memmove.S
new file mode 100644
index 0000000..fe703c6
--- /dev/null
+++ b/arch/csky/abiv2/memmove.S
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/linkage.h>
+#include "sysdep.h"
+
+	.weak memmove
+ENTRY(__memmove)
+ENTRY(memmove)
+	subu	r3, r0, r1
+	cmphs	r3, r2
+	jbt	memcpy
+
+	mov	r12, r0
+	addu	r0, r0, r2
+	addu	r1, r1, r2
+
+	/* Test if len less than 4 bytes.  */
+	cmplti	r2, 4
+	jbt	.L_copy_by_byte
+
+	andi	r13, r0, 3
+	/* Test if dest is not 4 bytes aligned.  */
+	bnez	r13, .L_dest_not_aligned
+	/* Hardware can handle unaligned access directly.  */
+.L_dest_aligned:
+	/* If dest is aligned, then copy.  */
+	zext	r18, r2, 31, 4
+	/* Test if len less than 16 bytes.  */
+	bez	r18, .L_len_less_16bytes
+	movi	r19, 0
+
+	/* len > 16 bytes */
+	LABLE_ALIGN
+.L_len_larger_16bytes:
+	subi	r1, 16
+	subi	r0, 16
+#if defined(__CSKY_VDSPV2__)
+	vldx.8	vr0, (r1), r19
+	PRE_BNEZAD (r18)
+	vstx.8	vr0, (r0), r19
+#elif defined(__CK860__)
+	ldw	r3, (r1, 12)
+	stw	r3, (r0, 12)
+	ldw	r3, (r1, 8)
+	stw	r3, (r0, 8)
+	ldw	r3, (r1, 4)
+	stw	r3, (r0, 4)
+	ldw	r3, (r1, 0)
+	stw	r3, (r0, 0)
+#else
+	ldw	r20, (r1, 0)
+	ldw	r21, (r1, 4)
+	ldw	r22, (r1, 8)
+	ldw	r23, (r1, 12)
+	stw	r20, (r0, 0)
+	stw	r21, (r0, 4)
+	stw	r22, (r0, 8)
+	stw	r23, (r0, 12)
+	PRE_BNEZAD (r18)
+#endif
+	BNEZAD (r18, .L_len_larger_16bytes)
+
+.L_len_less_16bytes:
+	zext	r18, r2, 3, 2
+	bez	r18, .L_copy_by_byte
+.L_len_less_16bytes_loop:
+	subi	r1, 4
+	subi	r0, 4
+	ldw	r3, (r1, 0)
+	PRE_BNEZAD (r18)
+	stw	r3, (r0, 0)
+	BNEZAD (r18, .L_len_less_16bytes_loop)
+
+	/* Test if len less than 4 bytes.  */
+.L_copy_by_byte:
+	zext	r18, r2, 1, 0
+	bez	r18, .L_return
+.L_copy_by_byte_loop:
+	subi	r1, 1
+	subi	r0, 1
+	ldb	r3, (r1, 0)
+	PRE_BNEZAD (r18)
+	stb	r3, (r0, 0)
+	BNEZAD (r18, .L_copy_by_byte_loop)
+
+.L_return:
+	mov	r0, r12
+	rts
+
+	/* If dest is not aligned, just copy some bytes makes the dest
+	   align.  */
+.L_dest_not_aligned:
+	sub	r2, r13
+.L_dest_not_aligned_loop:
+	subi	r1, 1
+	subi	r0, 1
+	/* Makes the dest align.  */
+	ldb	r3, (r1, 0)
+	PRE_BNEZAD (r13)
+	stb	r3, (r0, 0)
+	BNEZAD (r13, .L_dest_not_aligned_loop)
+	cmplti	r2, 4
+	jbt	.L_copy_by_byte
+	/* Check whether the src is aligned.  */
+	jbr	.L_dest_aligned
+ENDPROC(memmove)
+ENDPROC(__memmove)
diff --git a/arch/csky/abiv2/memset.S b/arch/csky/abiv2/memset.S
new file mode 100644
index 0000000..ff438ac
--- /dev/null
+++ b/arch/csky/abiv2/memset.S
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/linkage.h>
+#include "sysdep.h"
+
+	.weak memset
+ENTRY(__memset)
+ENTRY(memset)
+	/* Test if len less than 4 bytes.  */
+	mov	r12, r0
+	cmplti	r2, 8
+	jbt	.L_set_by_byte
+
+	andi	r13, r0, 3
+	movi	r19, 4
+	/* Test if dest is not 4 bytes aligned.  */
+	bnez	r13, .L_dest_not_aligned
+	/* Hardware can handle unaligned access directly.  */
+.L_dest_aligned:
+        zextb   r3, r1
+        lsli    r1, 8
+        or      r1, r3
+        lsli    r3, r1, 16
+        or      r3, r1
+
+	/* If dest is aligned, then copy.  */
+	zext	r18, r2, 31, 4
+	/* Test if len less than 16 bytes.  */
+	bez	r18, .L_len_less_16bytes
+
+	LABLE_ALIGN
+.L_len_larger_16bytes:
+	stw	r3, (r0, 0)
+	stw	r3, (r0, 4)
+	stw	r3, (r0, 8)
+	stw	r3, (r0, 12)
+	PRE_BNEZAD (r18)
+	addi	r0, 16
+	BNEZAD (r18, .L_len_larger_16bytes)
+
+.L_len_less_16bytes:
+	zext	r18, r2, 3, 2
+	andi	r2, 3
+	bez	r18, .L_set_by_byte
+.L_len_less_16bytes_loop:
+	stw	r3, (r0, 0)
+	PRE_BNEZAD (r18)
+	addi	r0, 4
+	BNEZAD (r18, .L_len_less_16bytes_loop)
+
+	/* Test if len less than 4 bytes.  */
+.L_set_by_byte:
+	zext	r18, r2, 2, 0
+	bez	r18, .L_return
+.L_set_by_byte_loop:
+	stb	r1, (r0, 0)
+	PRE_BNEZAD (r18)
+	addi	r0, 1
+	BNEZAD (r18, .L_set_by_byte_loop)
+
+.L_return:
+	mov	r0, r12
+	rts
+
+	/* If dest is not aligned, just set some bytes makes the dest
+	   align.  */
+
+.L_dest_not_aligned:
+	sub	r13, r19, r13
+	sub	r2, r13
+.L_dest_not_aligned_loop:
+	/* Makes the dest align.  */
+	stb	r1, (r0, 0)
+	PRE_BNEZAD (r13)
+	addi	r0, 1
+	BNEZAD (r13, .L_dest_not_aligned_loop)
+	cmplti	r2, 8
+	jbt	.L_set_by_byte
+	/* Check whether the src is aligned.  */
+	jbr	.L_dest_aligned
+ENDPROC(memset)
+ENDPROC(__memset)
diff --git a/arch/csky/abiv2/strcmp.S b/arch/csky/abiv2/strcmp.S
new file mode 100644
index 0000000..7cbbaec
--- /dev/null
+++ b/arch/csky/abiv2/strcmp.S
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/linkage.h>
+#include "sysdep.h"
+
+ENTRY(strcmp)
+	mov	a3, a0
+	/* Check if the s1 addr is aligned.  */
+	xor	a2, a3, a1
+	andi	a2, 0x3
+	bnez	a2, 7f
+	andi	t1, a0, 0x3
+	bnez	t1, 5f
+
+1:
+	/* If aligned, load word each time.  */
+	ldw	t0, (a3, 0)
+	ldw	t1, (a1, 0)
+	/* If s1[i] != s2[i], goto 2f.  */
+	cmpne   t0, t1
+	bt      2f
+	/* If s1[i] == s2[i], check if s1 or s2 is at the end.  */
+	tstnbz	t0
+	/* If at the end, goto 3f (finish comparing).  */
+	bf	3f
+
+	ldw	t0, (a3, 4)
+	ldw	t1, (a1, 4)
+	cmpne	t0, t1
+	bt	2f
+	tstnbz	t0
+	bf	3f
+
+	ldw	t0, (a3, 8)
+	ldw	t1, (a1, 8)
+	cmpne	t0, t1
+	bt	2f
+	tstnbz	t0
+	bf	3f
+
+	ldw	t0, (a3, 12)
+	ldw	t1, (a1, 12)
+	cmpne	t0, t1
+	bt	2f
+	tstnbz	t0
+	bf	3f
+
+	ldw	t0, (a3, 16)
+	ldw	t1, (a1, 16)
+	cmpne	t0, t1
+	bt	2f
+	tstnbz	t0
+	bf	3f
+
+	ldw	t0, (a3, 20)
+	ldw	t1, (a1, 20)
+	cmpne	t0, t1
+	bt	2f
+	tstnbz	t0
+	bf	3f
+
+	ldw	t0, (a3, 24)
+	ldw	t1, (a1, 24)
+	cmpne	t0, t1
+	bt	2f
+	tstnbz	t0
+	bf	3f
+
+	ldw	t0, (a3, 28)
+	ldw	t1, (a1, 28)
+	cmpne	t0, t1
+	bt	2f
+	tstnbz	t0
+	bf	3f
+
+	addi	a3, 32
+	addi	a1, 32
+
+	br	1b
+
+# ifdef __CSKYBE__
+	/* d[i] != s[i] in word, so we check byte 0.  */
+2:
+	xtrb0   a0, t0
+	xtrb0   a2, t1
+	subu    a0, a2
+	bez     a2, 4f
+	bnez    a0, 4f
+
+	/* check byte 1 */
+	xtrb1   a0, t0
+	xtrb1   a2, t1
+	subu    a0, a2
+	bez     a2, 4f
+	bnez    a0, 4f
+
+	/* check byte 2 */
+	xtrb2   a0, t0
+	xtrb2   a2, t1
+	subu    a0, a2
+	bez     a2, 4f
+	bnez    a0, 4f
+
+	/* check byte 3 */
+	xtrb3   a0, t0
+	xtrb3   a2, t1
+	subu    a0, a2
+# else
+	/* s1[i] != s2[i] in word, so we check byte 3.  */
+2:
+	xtrb3	a0, t0
+	xtrb3	a2, t1
+	subu    a0, a2
+	bez     a2, 4f
+	bnez    a0, 4f
+
+	/* check byte 2 */
+	xtrb2	a0, t0
+	xtrb2	a2, t1
+	subu    a0, a2
+	bez     a2, 4f
+	bnez    a0, 4f
+
+	/* check byte 1 */
+	xtrb1	a0, t0
+	xtrb1	a2, t1
+	subu	a0, a2
+	bez	a2, 4f
+	bnez    a0, 4f
+
+	/* check byte 0 */
+	xtrb0	a0, t0
+	xtrb0	a2, t1
+	subu	a0, a2
+
+# endif /* !__CSKYBE__ */
+	jmp     lr
+3:
+	movi	a0, 0
+4:
+	jmp     lr
+
+	/* Compare when s1 or s2 is not aligned.  */
+5:
+	subi    t1, 4
+6:
+	ldb	a0, (a3, 0)
+	ldb	a2, (a1, 0)
+	subu	a0, a2
+	bez	a2, 4b
+	bnez	a0, 4b
+	addi    t1, 1
+	addi	a1, 1
+	addi	a3, 1
+	bnez	t1, 6b
+	br	1b
+
+7:
+	ldb	a0, (a3, 0)
+	addi	a3, 1
+	ldb	a2, (a1, 0)
+	addi	a1, 1
+	subu    a0, a2
+	bnez    a0, 4b
+	bnez	a2, 7b
+	jmp	r15
+ENDPROC(strcmp)
diff --git a/arch/csky/abiv2/strcpy.S b/arch/csky/abiv2/strcpy.S
new file mode 100644
index 0000000..0183c5e
--- /dev/null
+++ b/arch/csky/abiv2/strcpy.S
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/linkage.h>
+#include "sysdep.h"
+
+ENTRY(strcpy)
+	mov	a3, a0
+	/* Check if the src addr is aligned.  */
+        andi    t0, a1, 3
+        bnez	t0, 11f
+1:
+	/* Check if all the bytes in the word are not zero.  */
+	ldw	a2, (a1)
+	tstnbz	a2
+	bf	9f
+	stw	a2, (a3)
+
+	ldw	a2, (a1, 4)
+	tstnbz	a2
+	bf	2f
+	stw	a2, (a3, 4)
+
+	ldw	a2, (a1, 8)
+	tstnbz	a2
+	bf	3f
+	stw	a2, (a3, 8)
+
+	ldw	a2, (a1, 12)
+	tstnbz	a2
+	bf	4f
+	stw	a2, (a3, 12)
+
+	ldw	a2, (a1, 16)
+	tstnbz	a2
+	bf	5f
+	stw	a2, (a3, 16)
+
+	ldw	a2, (a1, 20)
+	tstnbz	a2
+	bf	6f
+	stw	a2, (a3, 20)
+
+	ldw	a2, (a1, 24)
+	tstnbz	a2
+	bf	7f
+	stw	a2, (a3, 24)
+
+	ldw	a2, (a1, 28)
+	tstnbz	a2
+	bf	8f
+	stw	a2, (a3, 28)
+
+	addi	a3, 32
+	addi	a1, 32
+	br	1b
+
+
+2:
+	addi	a3, 4
+	br	9f
+
+3:
+	addi	a3, 8
+	br	9f
+
+4:
+	addi	a3, 12
+	br	9f
+
+5:
+	addi	a3, 16
+	br	9f
+
+6:
+	addi	a3, 20
+	br	9f
+
+7:
+	addi	a3, 24
+	br	9f
+
+8:
+	addi	a3, 28
+9:
+# ifdef __CSKYBE__
+	xtrb0	t0, a2
+	st.b	t0, (a3)
+	bez	t0, 10f
+	xtrb1	t0, a2
+	st.b	t0, (a3, 1)
+	bez	t0, 10f
+	xtrb2	t0, a2
+	st.b	t0, (a3, 2)
+	bez	t0, 10f
+	stw	a2, (a3)
+# else
+	xtrb3	t0, a2
+	st.b	t0, (a3)
+	bez	t0, 10f
+	xtrb2	t0, a2
+	st.b	t0, (a3, 1)
+	bez	t0, 10f
+	xtrb1	t0, a2
+	st.b	t0, (a3, 2)
+	bez	t0, 10f
+	stw	a2, (a3)
+# endif	/* !__CSKYBE__ */
+10:
+	jmp	lr
+
+11:
+	subi    t0, 4
+12:
+        ld.b    a2, (a1)
+        st.b	a2, (a3)
+        bez	a2, 10b
+	addi    t0, 1
+        addi    a1, a1, 1
+        addi    a3, a3, 1
+	bnez	t0, 12b
+	jbr	1b
+ENDPROC(strcpy)
diff --git a/arch/csky/abiv2/strksyms.c b/arch/csky/abiv2/strksyms.c
new file mode 100644
index 0000000..06da723
--- /dev/null
+++ b/arch/csky/abiv2/strksyms.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/module.h>
+
+EXPORT_SYMBOL(memcpy);
+EXPORT_SYMBOL(memset);
+EXPORT_SYMBOL(memcmp);
+EXPORT_SYMBOL(memmove);
+EXPORT_SYMBOL(strcmp);
+EXPORT_SYMBOL(strcpy);
+EXPORT_SYMBOL(strlen);
diff --git a/arch/csky/abiv2/strlen.S b/arch/csky/abiv2/strlen.S
new file mode 100644
index 0000000..c0c5d79
--- /dev/null
+++ b/arch/csky/abiv2/strlen.S
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/linkage.h>
+#include "sysdep.h"
+
+ENTRY(strlen)
+	/* Check if the start addr is aligned.  */
+	mov	r3, r0
+	andi	r1, r0, 3
+	movi	r2, 4
+	movi	r0, 0
+	bnez	r1, .L_start_not_aligned
+
+	LABLE_ALIGN
+.L_start_addr_aligned:
+	/* Check if all the bytes in the word are not zero.  */
+	ldw	r1, (r3)
+	tstnbz	r1
+	bf	.L_string_tail
+
+	ldw	r1, (r3, 4)
+	addi	r0, 4
+	tstnbz	r1
+	bf	.L_string_tail
+
+	ldw	r1, (r3, 8)
+	addi	r0, 4
+	tstnbz	r1
+	bf	.L_string_tail
+
+	ldw	r1, (r3, 12)
+	addi	r0, 4
+	tstnbz	r1
+	bf	.L_string_tail
+
+	ldw	r1, (r3, 16)
+	addi	r0, 4
+	tstnbz	r1
+	bf	.L_string_tail
+
+	ldw	r1, (r3, 20)
+	addi	r0, 4
+	tstnbz	r1
+	bf	.L_string_tail
+
+	ldw	r1, (r3, 24)
+	addi	r0, 4
+	tstnbz	r1
+	bf	.L_string_tail
+
+	ldw	r1, (r3, 28)
+	addi	r0, 4
+	tstnbz	r1
+	bf	.L_string_tail
+
+	addi	r0, 4
+	addi	r3, 32
+	br	.L_start_addr_aligned
+
+.L_string_tail:
+# ifdef __CSKYBE__
+	xtrb0	r3, r1
+	bez	r3, .L_return
+	addi	r0, 1
+	xtrb1	r3, r1
+	bez	r3, .L_return
+	addi	r0, 1
+	xtrb2	r3, r1
+	bez	r3, .L_return
+	addi	r0, 1
+# else
+	xtrb3	r3, r1
+	bez	r3, .L_return
+	addi	r0, 1
+	xtrb2	r3, r1
+	bez	r3, .L_return
+	addi	r0, 1
+	xtrb1	r3, r1
+	bez	r3, .L_return
+	addi	r0, 1
+# endif	/* !__CSKYBE__ */
+
+.L_return:
+	rts
+
+.L_start_not_aligned:
+	sub	r2, r2, r1
+.L_start_not_aligned_loop:
+	ldb	r1, (r3)
+	PRE_BNEZAD (r2)
+	addi	r3, 1
+	bez	r1, .L_return
+	addi	r0, 1
+	BNEZAD (r2, .L_start_not_aligned_loop)
+	br	.L_start_addr_aligned
+ENDPROC(strlen)
diff --git a/arch/csky/abiv2/sysdep.h b/arch/csky/abiv2/sysdep.h
new file mode 100644
index 0000000..c421563
--- /dev/null
+++ b/arch/csky/abiv2/sysdep.h
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __SYSDEP_H
+#define __SYSDEP_H
+
+#ifdef __ASSEMBLER__
+
+#if defined (__CK860__)
+#define LABLE_ALIGN	\
+	.balignw 16, 0x6c03
+
+#define PRE_BNEZAD(R)
+
+#define BNEZAD(R, L)	\
+	bnezad	R, L
+#else
+#define LABLE_ALIGN	\
+	.balignw 8, 0x6c03
+
+#define PRE_BNEZAD(R)	\
+	subi	R, 1
+
+#define BNEZAD(R, L)	\
+	bnez	R, L
+#endif
+
+#endif
+
+#endif
diff --git a/arch/csky/include/asm/string.h b/arch/csky/include/asm/string.h
new file mode 100644
index 0000000..a8b8930
--- /dev/null
+++ b/arch/csky/include/asm/string.h
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef _CSKY_STRING_MM_H_
+#define _CSKY_STRING_MM_H_
+
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+#include <linux/compiler.h>
+#include <abi/string.h>
+#endif
+
+#endif /* _CSKY_STRING_MM_H_ */
diff --git a/arch/csky/kernel/platform.c b/arch/csky/kernel/platform.c
new file mode 100644
index 0000000..9d04c50
--- /dev/null
+++ b/arch/csky/kernel/platform.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/init.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/of_fdt.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+#include <linux/io.h>
+
+static int __init csky_platform_init(void)
+{
+	return of_platform_default_populate(NULL, NULL, NULL);
+}
+device_initcall(csky_platform_init);
diff --git a/arch/csky/kernel/power.c b/arch/csky/kernel/power.c
new file mode 100644
index 0000000..923ee4e
--- /dev/null
+++ b/arch/csky/kernel/power.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/reboot.h>
+
+void (*pm_power_off)(void);
+EXPORT_SYMBOL(pm_power_off);
+
+void machine_power_off(void)
+{
+	local_irq_disable();
+	if (pm_power_off)
+		pm_power_off();
+	asm volatile ("bkpt");
+}
+
+void machine_halt(void)
+{
+	local_irq_disable();
+	if (pm_power_off)
+		pm_power_off();
+	asm volatile ("bkpt");
+}
+
+void machine_restart(char *cmd)
+{
+	local_irq_disable();
+	do_kernel_restart(cmd);
+	asm volatile ("bkpt");
+}
diff --git a/arch/csky/lib/delay.c b/arch/csky/lib/delay.c
new file mode 100644
index 0000000..34766a4
--- /dev/null
+++ b/arch/csky/lib/delay.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+
+void __delay(unsigned long loops)
+{
+       asm volatile (
+		"mov r0, r0\n"
+		"1:declt %0\n"
+		"bf	1b"
+                :"=r"(loops)
+	        :"0"(loops));
+}
+EXPORT_SYMBOL(__delay);
+
+extern unsigned long loops_per_jiffy;
+
+void __const_udelay(unsigned long xloops)
+{
+	unsigned long long loops;
+
+	loops = (unsigned long long)xloops * loops_per_jiffy * HZ;
+
+	__delay(loops >> 32);
+}
+EXPORT_SYMBOL(__const_udelay);
+
+void __udelay(unsigned long usecs)
+{
+	__const_udelay(usecs * 0x10C7UL); /* 2**32 / 1000000 (rounded up) */
+}
+EXPORT_SYMBOL(__udelay);
+
+void __ndelay(unsigned long nsecs)
+{
+	__const_udelay(nsecs * 0x5UL); /* 2**32 / 1000000000 (rounded up) */
+}
+EXPORT_SYMBOL(__ndelay);
-- 
2.7.4
