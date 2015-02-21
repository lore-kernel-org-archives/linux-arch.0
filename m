Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:19197 "EHLO
	mail2.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbbBUHyL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 21 Feb 2015 02:54:11 -0500
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v4 09/15] h8300: library functions
Date: Sat, 21 Feb 2015 16:53:53 +0900
Message-ID: <1424505239-7082-10-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1424505239-7082-1-git-send-email-ysato@users.sourceforge.jp>
References: <1424505239-7082-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20150221075353.IYvu7ouU7uPFg0RArc7NcTkem8N90VagaHwD6leLTmo@z>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/h8300/lib/Makefile    |   7 ++
 arch/h8300/lib/abs.S       |  20 ++++++
 arch/h8300/lib/ashldi3.c   |  24 +++++++
 arch/h8300/lib/ashrdi3.c   |  24 +++++++
 arch/h8300/lib/checksum.c  | 167 +++++++++++++++++++++++++++++++++++++++++++++
 arch/h8300/lib/libgcc.h    |  77 +++++++++++++++++++++
 arch/h8300/lib/lshrdi3.c   |  23 +++++++
 arch/h8300/lib/memcpy.S    |  85 +++++++++++++++++++++++
 arch/h8300/lib/memset.S    |  69 +++++++++++++++++++
 arch/h8300/lib/moddivsi3.S |  72 +++++++++++++++++++
 arch/h8300/lib/modsi3.S    |  72 +++++++++++++++++++
 arch/h8300/lib/muldi3.c    |  44 ++++++++++++
 arch/h8300/lib/mulsi3.S    |  38 +++++++++++
 arch/h8300/lib/strncpy.S   |  34 +++++++++
 arch/h8300/lib/ucmpdi2.c   |  17 +++++
 arch/h8300/lib/udivsi3.S   |  76 +++++++++++++++++++++
 16 files changed, 849 insertions(+)
 create mode 100644 arch/h8300/lib/Makefile
 create mode 100644 arch/h8300/lib/abs.S
 create mode 100644 arch/h8300/lib/ashldi3.c
 create mode 100644 arch/h8300/lib/ashrdi3.c
 create mode 100644 arch/h8300/lib/checksum.c
 create mode 100644 arch/h8300/lib/libgcc.h
 create mode 100644 arch/h8300/lib/lshrdi3.c
 create mode 100644 arch/h8300/lib/memcpy.S
 create mode 100644 arch/h8300/lib/memset.S
 create mode 100644 arch/h8300/lib/moddivsi3.S
 create mode 100644 arch/h8300/lib/modsi3.S
 create mode 100644 arch/h8300/lib/muldi3.c
 create mode 100644 arch/h8300/lib/mulsi3.S
 create mode 100644 arch/h8300/lib/strncpy.S
 create mode 100644 arch/h8300/lib/ucmpdi2.c
 create mode 100644 arch/h8300/lib/udivsi3.S

diff --git a/arch/h8300/lib/Makefile b/arch/h8300/lib/Makefile
new file mode 100644
index 0000000..8311a9f
--- /dev/null
+++ b/arch/h8300/lib/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for H8/300-specific library files..
+#
+
+lib-y  = checksum.o memcpy.o memset.o abs.o strncpy.o \
+	 mulsi3.o udivsi3.o muldi3.o moddivsi3.o \
+	 ashldi3.o lshrdi3.o ashrdi3.o ucmpdi2.o
diff --git a/arch/h8300/lib/abs.S b/arch/h8300/lib/abs.S
new file mode 100644
index 0000000..efda749
--- /dev/null
+++ b/arch/h8300/lib/abs.S
@@ -0,0 +1,20 @@
+;;; abs.S
+
+#include <asm/linkage.h>
+
+#if defined(CONFIG_CPU_H8300H)
+	.h8300h
+#endif
+#if defined(CONFIG_CPU_H8S)
+	.h8300s
+#endif
+	.text
+.global _abs
+
+;;; int abs(int n)
+_abs:
+	mov.l	er0,er0
+	bpl	1f
+	neg.l	er0
+1:
+	rts
diff --git a/arch/h8300/lib/ashldi3.c b/arch/h8300/lib/ashldi3.c
new file mode 100644
index 0000000..c6aa8ea
--- /dev/null
+++ b/arch/h8300/lib/ashldi3.c
@@ -0,0 +1,24 @@
+#include "libgcc.h"
+
+DWtype
+__ashldi3(DWtype u, word_type b)
+{
+	const DWunion uu = {.ll = u};
+	const word_type bm = (sizeof (Wtype) * BITS_PER_UNIT) - b;
+	DWunion w;
+
+	if (b == 0)
+		return u;
+
+	if (bm <= 0) {
+		w.s.low = 0;
+		w.s.high = (UWtype) uu.s.low << -bm;
+	} else {
+		const UWtype carries = (UWtype) uu.s.low >> bm;
+
+		w.s.low = (UWtype) uu.s.low << b;
+		w.s.high = ((UWtype) uu.s.high << b) | carries;
+	}
+
+	return w.ll;
+}
diff --git a/arch/h8300/lib/ashrdi3.c b/arch/h8300/lib/ashrdi3.c
new file mode 100644
index 0000000..070adf9
--- /dev/null
+++ b/arch/h8300/lib/ashrdi3.c
@@ -0,0 +1,24 @@
+#include "libgcc.h"
+
+DWtype __ashrdi3(DWtype u, word_type b)
+{
+	const DWunion uu = {.ll = u};
+	const word_type bm = (sizeof (Wtype) * BITS_PER_UNIT) - b;
+	DWunion w;
+
+	if (b == 0)
+		return u;
+
+	if (bm <= 0) {
+		/* w.s.high = 1..1 or 0..0 */
+		w.s.high = uu.s.high >> (sizeof (Wtype) * BITS_PER_UNIT - 1);
+		w.s.low = uu.s.high >> -bm;
+	} else {
+		const UWtype carries = (UWtype) uu.s.high << bm;
+
+		w.s.high = uu.s.high >> b;
+		w.s.low = ((UWtype) uu.s.low >> b) | carries;
+	}
+
+	return w.ll;
+}
diff --git a/arch/h8300/lib/checksum.c b/arch/h8300/lib/checksum.c
new file mode 100644
index 0000000..ae28469
--- /dev/null
+++ b/arch/h8300/lib/checksum.c
@@ -0,0 +1,167 @@
+/*
+ * INET		An implementation of the TCP/IP protocol suite for the LINUX
+ *		operating system.  INET is implemented using the  BSD Socket
+ *		interface as the means of communication with the user level.
+ *
+ *		IP/TCP/UDP checksumming routines
+ *
+ * Authors:	Jorge Cwik, <jorge@laser.satlink.net>
+ *		Arnt Gulbrandsen, <agulbra@nvg.unit.no>
+ *		Tom May, <ftom@netcom.com>
+ *		Andreas Schwab, <schwab@issan.informatik.uni-dortmund.de>
+ *		Lots of code moved from tcp.c and ip.c; see those files
+ *		for more names.
+ *
+ * 03/02/96	Jes Sorensen, Andreas Schwab, Roman Hodek:
+ *		Fixed some nasty bugs, causing some horrible crashes.
+ *		A: At some points, the sum (%0) was used as
+ *		length-counter instead of the length counter
+ *		(%1). Thanks to Roman Hodek for pointing this out.
+ *		B: GCC seems to mess up if one uses too many
+ *		data-registers to hold input values and one tries to
+ *		specify d0 and d1 as scratch registers. Letting gcc choose these
+ *      registers itself solves the problem.
+ *
+ *		This program is free software; you can redistribute it and/or
+ *		modify it under the terms of the GNU General Public License
+ *		as published by the Free Software Foundation; either version
+ *		2 of the License, or (at your option) any later version.
+ */
+
+/* Revised by Kenneth Albanowski for m68knommu. Basic problem: unaligned access kills, so most
+   of the assembly has to go. */
+
+#include <net/checksum.h>
+#include <linux/module.h>
+
+static inline unsigned short from32to16(unsigned long x)
+{
+	/* add up 16-bit and 16-bit for 16+c bit */
+	x = (x & 0xffff) + (x >> 16);
+	/* add up carry.. */
+	x = (x & 0xffff) + (x >> 16);
+	return x;
+}
+
+static unsigned long do_csum(const unsigned char *buff, int len)
+{
+	int odd, count;
+	unsigned long result = 0;
+
+	if (len <= 0)
+		goto out;
+	odd = 1 & (unsigned long) buff;
+	if (odd) {
+		result = *buff;
+		len--;
+		buff++;
+	}
+	count = len >> 1;		/* nr of 16-bit words.. */
+	if (count) {
+		if (2 & (unsigned long) buff) {
+			result += *(unsigned short *) buff;
+			count--;
+			len -= 2;
+			buff += 2;
+		}
+		count >>= 1;		/* nr of 32-bit words.. */
+		if (count) {
+			unsigned long carry = 0;
+
+			do {
+				unsigned long w = *(unsigned long *) buff;
+
+				count--;
+				buff += 4;
+				result += carry;
+				result += w;
+				carry = (w > result);
+			} while (count);
+			result += carry;
+			result = (result & 0xffff) + (result >> 16);
+		}
+		if (len & 2) {
+			result += *(unsigned short *) buff;
+			buff += 2;
+		}
+	}
+	if (len & 1)
+		result += (*buff << 8);
+	result = from32to16(result);
+	if (odd)
+		result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
+out:
+	return result;
+}
+
+/*
+ *	This is a version of ip_compute_csum() optimized for IP headers,
+ *	which always checksum on 4 octet boundaries.
+ */
+__sum16 ip_fast_csum(const void *iph, unsigned int ihl)
+{
+	return (__force __sum16)~do_csum(iph, ihl*4);
+}
+
+/*
+ * computes the checksum of a memory block at buff, length len,
+ * and adds in "sum" (32-bit)
+ *
+ * returns a 32-bit number suitable for feeding into itself
+ * or csum_tcpudp_magic
+ *
+ * this function must be called with even lengths, except
+ * for the last fragment, which may be odd
+ *
+ * it's best to have buff aligned on a 32-bit boundary
+ */
+/*
+ * Egads...  That thing apparently assumes that *all* checksums it ever sees will
+ * be folded.  Very likely a bug.
+ */
+__wsum csum_partial(const void *buff, int len, __wsum sum)
+{
+	unsigned int result = do_csum(buff, len);
+
+	/* add in old sum, and carry.. */
+	result += (__force u32)sum;
+	/* 16+c bits -> 16 bits */
+	result = (result & 0xffff) + (result >> 16);
+	return (__force __wsum)result;
+}
+
+EXPORT_SYMBOL(csum_partial);
+
+/*
+ * this routine is used for miscellaneous IP-like checksums, mainly
+ * in icmp.c
+ */
+__sum16 ip_compute_csum(const void *buff, int len)
+{
+	return (__force __sum16)~do_csum(buff, len);
+}
+
+/*
+ * copy from fs while checksumming, otherwise like csum_partial
+ */
+
+__wsum
+csum_partial_copy_from_user(const void __user *src, void *dst, int len,
+			    __wsum sum, int *csum_err)
+{
+	if (csum_err)
+		*csum_err = 0;
+	memcpy(dst, (__force const void *)src, len);
+	return csum_partial(dst, len, sum);
+}
+
+/*
+ * copy from ds while checksumming, otherwise like csum_partial
+ */
+
+__wsum
+csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
+{
+	memcpy(dst, src, len);
+	return csum_partial(dst, len, sum);
+}
diff --git a/arch/h8300/lib/libgcc.h b/arch/h8300/lib/libgcc.h
new file mode 100644
index 0000000..468a8f7
--- /dev/null
+++ b/arch/h8300/lib/libgcc.h
@@ -0,0 +1,77 @@
+#ifndef __H8300_LIBGCC_H__
+#define __H8300_LIBGCC_H__
+
+#ifdef __ASSEMBLY__
+#define A0 r0
+#define A0L r0l
+#define A0H r0h
+
+#define A1 r1
+#define A1L r1l
+#define A1H r1h
+
+#define A2 r2
+#define A2L r2l
+#define A2H r2h
+
+#define A3 r3
+#define A3L r3l
+#define A3H r3h
+
+#define S0 r4
+#define S0L r4l
+#define S0H r4h
+
+#define S1 r5
+#define S1L r5l
+#define S1H r5h
+
+#define S2 r6
+#define S2L r6l
+#define S2H r6h
+
+#define PUSHP	push.l
+#define POPP	pop.l
+
+#define A0P	er0
+#define A1P	er1
+#define A2P	er2
+#define A3P	er3
+#define S0P	er4
+#define S1P	er5
+#define S2P	er6
+
+#define A0E	e0
+#define A1E	e1
+#define A2E	e2
+#define A3E	e3
+#else
+#define Wtype   SItype
+#define UWtype  USItype
+#define HWtype  SItype
+#define UHWtype USItype
+#define DWtype  DItype
+#define UDWtype UDItype
+#define UWtype  USItype
+#define Wtype   SItype
+#define UWtype  USItype
+#define W_TYPE_SIZE (4 * BITS_PER_UNIT)
+#define BITS_PER_UNIT (8)
+
+typedef          int SItype     __attribute__ ((mode (SI)));
+typedef unsigned int USItype    __attribute__ ((mode (SI)));
+typedef		 int DItype	__attribute__ ((mode (DI)));
+typedef unsigned int UDItype	__attribute__ ((mode (DI)));
+struct DWstruct {
+	Wtype high, low;
+};
+typedef union {
+	struct DWstruct s;
+	DWtype ll;
+} DWunion;
+
+typedef int word_type __attribute__ ((mode (__word__)));
+
+#endif
+
+#endif
diff --git a/arch/h8300/lib/lshrdi3.c b/arch/h8300/lib/lshrdi3.c
new file mode 100644
index 0000000..a86bbe3
--- /dev/null
+++ b/arch/h8300/lib/lshrdi3.c
@@ -0,0 +1,23 @@
+#include "libgcc.h"
+
+DWtype __lshrdi3(DWtype u, word_type b)
+{
+	const DWunion uu = {.ll = u};
+	const word_type bm = (sizeof (Wtype) * BITS_PER_UNIT) - b;
+	DWunion w;
+
+	if (b == 0)
+		return u;
+
+	if (bm <= 0) {
+		w.s.high = 0;
+		w.s.low = (UWtype) uu.s.high >> -bm;
+	} else {
+		const UWtype carries = (UWtype) uu.s.high << bm;
+
+		w.s.high = (UWtype) uu.s.high >> b;
+		w.s.low = ((UWtype) uu.s.low >> b) | carries;
+	}
+
+	return w.ll;
+}
diff --git a/arch/h8300/lib/memcpy.S b/arch/h8300/lib/memcpy.S
new file mode 100644
index 0000000..0c9a51f
--- /dev/null
+++ b/arch/h8300/lib/memcpy.S
@@ -0,0 +1,85 @@
+;;; memcpy.S
+
+#include <asm/linkage.h>
+
+#if defined(CONFIG_CPU_H8300H)
+	.h8300h
+#endif
+#if defined(CONFIG_CPU_H8S)
+	.h8300s
+#endif
+	.text
+.global memcpy
+
+;;; void *memcpy(void *to, void *from, size_t n)
+memcpy:
+	mov.l	er2,er2
+	bne	1f
+	rts
+1:
+	;; address check
+	bld	#0,r0l
+	bxor	#0,r1l
+	bcs	4f
+	mov.l	er4,@-sp
+	mov.l	er0,@-sp
+	btst	#0,r0l
+	beq	1f
+	;; (aligned even) odd address
+	mov.b	@er1,r3l
+	mov.b	r3l,@er0
+	adds	#1,er1
+	adds	#1,er0
+	dec.l	#1,er2
+	beq	3f
+1:
+	;; n < sizeof(unsigned long) check
+	sub.l	er4,er4
+	adds	#4,er4		; loop count check value
+	cmp.l	er4,er2
+	blo	2f
+	;; unsigned long copy
+1:
+	mov.l	@er1,er3
+	mov.l	er3,@er0
+	adds	#4,er0
+	adds	#4,er1
+	subs	#4,er2
+	cmp.l	er4,er2
+	bcc	1b
+	;; rest
+2:
+	mov.l	er2,er2
+	beq	3f
+1:
+	mov.b	@er1,r3l
+	mov.b	r3l,@er0
+	adds	#1,er1
+	adds	#1,er0
+	dec.l	#1,er2
+	bne	1b
+3:
+	mov.l	@sp+,er0
+	mov.l	@sp+,er4
+	rts
+
+	;; odd <- even / even <- odd
+4:
+	mov.l	er4,er3
+	mov.l	er2,er4
+	mov.l	er5,er2
+	mov.l	er1,er5
+	mov.l	er6,er1
+	mov.l	er0,er6
+1:
+	eepmov.w
+	mov.w	r4,r4
+	bne	1b
+	dec.w	#1,e4
+	bpl	1b
+	mov.l	er1,er6
+	mov.l	er2,er5
+	mov.l	er3,er4
+	rts
+
+	.end
diff --git a/arch/h8300/lib/memset.S b/arch/h8300/lib/memset.S
new file mode 100644
index 0000000..18d4e70
--- /dev/null
+++ b/arch/h8300/lib/memset.S
@@ -0,0 +1,69 @@
+/* memset.S */
+
+#include <asm/linkage.h>
+
+#if defined(CONFIG_CPU_H8300H)
+	.h8300h
+#endif
+#if defined(CONFIG_CPU_H8S)
+	.h8300s
+#endif
+	.text
+
+.global	memset
+.global	clear_user
+
+;;void *memset(*ptr, int c, size_t count)
+;; ptr = er0
+;; c   = er1(r1l)
+;; count = er2
+memset:
+	btst	#0,r0l
+	beq	2f
+
+	;; odd address
+1:
+	mov.b	r1l,@er0
+	adds	#1,er0
+	dec.l	#1,er2
+	beq	6f
+
+	;; even address
+2:
+	mov.l	er2,er3
+	cmp.l	#4,er2
+	blo	4f
+	;; count>=4 -> count/4
+#if defined(CONFIG_CPU_H8300H)
+	shlr.l	er2
+	shlr.l	er2
+#endif
+#if defined(CONFIG_CPU_H8S)
+	shlr.l	#2,er2
+#endif
+	;; byte -> long
+	mov.b	r1l,r1h
+	mov.w	r1,e1
+3:
+	mov.l	er1,@er0
+	adds	#4,er0
+	dec.l	#1,er2
+	bne	3b
+4:
+	;; count % 4
+	and.b	#3,r3l
+	beq	6f
+5:
+	mov.b	r1l,@er0
+	adds	#1,er0
+	dec.b	r3l
+	bne	5b
+6:
+	rts
+
+clear_user:
+	mov.l	er1, er2
+	sub.l	er1, er1
+	bra	memset
+
+	.end
diff --git a/arch/h8300/lib/moddivsi3.S b/arch/h8300/lib/moddivsi3.S
new file mode 100644
index 0000000..c803129
--- /dev/null
+++ b/arch/h8300/lib/moddivsi3.S
@@ -0,0 +1,72 @@
+#include "libgcc.h"
+
+; numerator in A0/A1
+; denominator in A2/A3
+	.global	__modsi3
+__modsi3:
+	PUSHP	S2P
+	bsr	modnorm
+	bsr	__divsi3
+	mov.l	er3,er0
+	bra	exitdiv
+
+	.global	__umodsi3
+__umodsi3:
+	bsr	__udivsi3:16
+	mov.l	er3,er0
+	rts
+
+	.global	__divsi3
+__divsi3:
+	PUSHP	S2P
+	bsr	divnorm
+	bsr	__udivsi3:16
+
+	; examine what the sign should be
+exitdiv:
+	btst	#3,S2L
+	beq	reti
+
+	; should be -ve
+	neg.l	A0P
+
+reti:
+	POPP	S2P
+	rts
+
+divnorm:
+	mov.l	A0P,A0P		; is the numerator -ve
+	stc	ccr,S2L		; keep the sign in bit 3 of S2L
+	bge	postive
+
+	neg.l	A0P		; negate arg
+
+postive:
+	mov.l	A1P,A1P		; is the denominator -ve
+	bge	postive2
+
+	neg.l	A1P		; negate arg
+	xor.b	#0x08,S2L	; toggle the result sign
+
+postive2:
+	rts
+
+;; Basically the same, except that the sign of the divisor determines
+;; the sign.
+modnorm:
+	mov.l	A0P,A0P		; is the numerator -ve
+	stc	ccr,S2L		; keep the sign in bit 3 of S2L
+	bge	mpostive
+
+	neg.l	A0P		; negate arg
+
+mpostive:
+	mov.l	A1P,A1P		; is the denominator -ve
+	bge	mpostive2
+
+	neg.l	A1P		; negate arg
+
+mpostive2:
+	rts
+
+	.end
diff --git a/arch/h8300/lib/modsi3.S b/arch/h8300/lib/modsi3.S
new file mode 100644
index 0000000..68b1dfc
--- /dev/null
+++ b/arch/h8300/lib/modsi3.S
@@ -0,0 +1,72 @@
+#include "libgcc.h"
+
+; numerator in A0/A1
+; denominator in A2/A3
+	.global	__modsi3
+__modsi3:
+	PUSHP	S2P
+	bsr	modnorm
+	bsr	__divsi3
+	mov.l	er3,er0
+	bra	exitdiv
+
+	.global	__umodsi3
+__umodsi3:
+	bsr	__udivsi3
+	mov.l	er3,er0
+	rts
+
+	.global	__divsi3
+__divsi3:
+	PUSHP	S2P
+	jsr	divnorm
+	bsr	__udivsi3
+
+	; examine what the sign should be
+exitdiv:
+	btst	#3,S2L
+	beq	reti
+
+	; should be -ve
+	neg.l	A0P
+
+reti:
+	POPP	S2P
+	rts
+
+divnorm:
+	mov.l	A0P,A0P		; is the numerator -ve
+	stc	ccr,S2L		; keep the sign in bit 3 of S2L
+	bge	postive
+
+	neg.l	A0P		; negate arg
+
+postive:
+	mov.l	A1P,A1P		; is the denominator -ve
+	bge	postive2
+
+	neg.l	A1P		; negate arg
+	xor.b	#0x08,S2L	; toggle the result sign
+
+postive2:
+	rts
+
+;; Basically the same, except that the sign of the divisor determines
+;; the sign.
+modnorm:
+	mov.l	A0P,A0P		; is the numerator -ve
+	stc	ccr,S2L		; keep the sign in bit 3 of S2L
+	bge	mpostive
+
+	neg.l	A0P		; negate arg
+
+mpostive:
+	mov.l	A1P,A1P		; is the denominator -ve
+	bge	mpostive2
+
+	neg.l	A1P		; negate arg
+
+mpostive2:
+	rts
+
+	.end
diff --git a/arch/h8300/lib/muldi3.c b/arch/h8300/lib/muldi3.c
new file mode 100644
index 0000000..7905122
--- /dev/null
+++ b/arch/h8300/lib/muldi3.c
@@ -0,0 +1,44 @@
+#include "libgcc.h"
+
+#define __ll_B ((UWtype) 1 << (W_TYPE_SIZE / 2))
+#define __ll_lowpart(t) ((UWtype) (t) & (__ll_B - 1))
+#define __ll_highpart(t) ((UWtype) (t) >> (W_TYPE_SIZE / 2))
+
+#define umul_ppmm(w1, w0, u, v) \
+	do {			   \
+		UWtype __x0, __x1, __x2, __x3;	\
+		UHWtype __ul, __vl, __uh, __vh; \
+		__ul = __ll_lowpart(u);	\
+		__uh = __ll_highpart(u);	\
+		__vl = __ll_lowpart(v);	\
+		__vh = __ll_highpart(v);	\
+		__x0 = (UWtype) __ul * __vl;	\
+		__x1 = (UWtype) __ul * __vh;	\
+		__x2 = (UWtype) __uh * __vl;	\
+		__x3 = (UWtype) __uh * __vh;	\
+		__x1 += __ll_highpart(__x0);	\
+		__x1 += __x2;			\
+		if (__x1 < __x2)		\
+			__x3 += __ll_B;		\
+		(w1) = __x3 + __ll_highpart(__x1);	       \
+		(w0) = __ll_lowpart(__x1) * __ll_B + __ll_lowpart(__x0); \
+	} while (0)
+
+#define __umulsidi3(u, v) (			\
+		{				\
+			DWunion __w;		\
+			umul_ppmm(__w.s.high, __w.s.low, u, v);	\
+			__w.ll; }					\
+		)
+
+DWtype __muldi3(DWtype u, DWtype v)
+{
+	const DWunion uu = {.ll = u};
+	const DWunion vv = {.ll = v};
+	DWunion w = {.ll = __umulsidi3(uu.s.low, vv.s.low)};
+
+	w.s.high += ((UWtype) uu.s.low * (UWtype) vv.s.high
+		     + (UWtype) uu.s.high * (UWtype) vv.s.low);
+
+	return w.ll;
+}
diff --git a/arch/h8300/lib/mulsi3.S b/arch/h8300/lib/mulsi3.S
new file mode 100644
index 0000000..451f0e0
--- /dev/null
+++ b/arch/h8300/lib/mulsi3.S
@@ -0,0 +1,38 @@
+;
+; mulsi3 for H8/300H - based on Renesas SH implementation
+;
+; by Toshiyasu Morita
+;
+; Old code:
+;
+; 16b * 16b = 372 states (worst case)
+; 32b * 32b = 724 states (worst case)
+;
+; New code:
+;
+; 16b * 16b =  48 states
+; 16b * 32b =  72 states
+; 32b * 32b =  92 states
+;
+
+	.global __mulsi3
+__mulsi3:
+	mov.w	r1,r2   ; ( 2 states) b * d
+	mulxu	r0,er2  ; (22 states)
+
+	mov.w	e0,r3   ; ( 2 states) a * d
+	beq	L_skip1 ; ( 4 states)
+	mulxu	r1,er3  ; (22 states)
+	add.w	r3,e2   ; ( 2 states)
+
+L_skip1:
+	mov.w	e1,r3   ; ( 2 states) c * b
+	beq	L_skip2 ; ( 4 states)
+	mulxu	r0,er3  ; (22 states)
+	add.w	r3,e2   ; ( 2 states)
+
+L_skip2:
+	mov.l	er2,er0	; ( 2 states)
+	rts		; (10 states)
+
+	.end
diff --git a/arch/h8300/lib/strncpy.S b/arch/h8300/lib/strncpy.S
new file mode 100644
index 0000000..d00396a
--- /dev/null
+++ b/arch/h8300/lib/strncpy.S
@@ -0,0 +1,34 @@
+;;; strncpy.S
+
+#include <asm/linkage.h>
+
+	.text
+.global strncpy_from_user
+
+;;; long strncpy_from_user(void *to, void *from, size_t n)
+strncpy_from_user:
+	mov.l	er2,er2
+	bne	1f
+	sub.l	er0,er0
+	rts
+1:
+	mov.l	er4,@-sp
+	sub.l	er3,er3
+2:
+	mov.b	@er1+,r4l
+	mov.b	r4l,@er0
+	adds	#1,er0
+	beq	3f
+	inc.l	#1,er3
+	dec.l	#1,er2
+	bne	2b
+3:
+	dec.l	#1,er2
+4:
+	mov.b	r4l,@er0
+	adds	#1,er0
+	dec.l	#1,er2
+	bne	4b
+	mov.l	er3,er0
+	mov.l	@sp+,er4
+	rts
diff --git a/arch/h8300/lib/ucmpdi2.c b/arch/h8300/lib/ucmpdi2.c
new file mode 100644
index 0000000..772399d
--- /dev/null
+++ b/arch/h8300/lib/ucmpdi2.c
@@ -0,0 +1,17 @@
+#include "libgcc.h"
+
+word_type __ucmpdi2(DWtype a, DWtype b)
+{
+	const DWunion au = {.ll = a};
+	const DWunion bu = {.ll = b};
+
+	if ((UWtype) au.s.high < (UWtype) bu.s.high)
+		return 0;
+	else if ((UWtype) au.s.high > (UWtype) bu.s.high)
+		return 2;
+	if ((UWtype) au.s.low < (UWtype) bu.s.low)
+		return 0;
+	else if ((UWtype) au.s.low > (UWtype) bu.s.low)
+		return 2;
+	return 1;
+}
diff --git a/arch/h8300/lib/udivsi3.S b/arch/h8300/lib/udivsi3.S
new file mode 100644
index 0000000..bbe6561
--- /dev/null
+++ b/arch/h8300/lib/udivsi3.S
@@ -0,0 +1,76 @@
+#include "libgcc.h"
+
+	;; This function also computes the remainder and stores it in er3.
+	.global	__udivsi3
+__udivsi3:
+	mov.w	A1E,A1E		; denominator top word 0?
+	bne	DenHighNonZero
+
+	; do it the easy way, see page 107 in manual
+	mov.w	A0E,A2
+	extu.l	A2P
+	divxu.w	A1,A2P
+	mov.w	A2E,A0E
+	divxu.w	A1,A0P
+	mov.w	A0E,A3
+	mov.w	A2,A0E
+	extu.l	A3P
+	rts
+
+	; er0 = er0 / er1
+	; er3 = er0 % er1
+	; trashes er1 er2
+	; expects er1 >= 2^16
+DenHighNonZero:
+	mov.l	er0,er3
+	mov.l	er1,er2
+#ifdef CONFIG_CPU_H8300H
+divmod_L21:
+	shlr.l	er0
+	shlr.l	er2		; make divisor < 2^16
+	mov.w	e2,e2
+	bne	divmod_L21
+#else
+	shlr.l	#2,er2		; make divisor < 2^16
+	mov.w	e2,e2
+	beq	divmod_L22A
+divmod_L21:
+	shlr.l	#2,er0
+divmod_L22:
+	shlr.l	#2,er2		; make divisor < 2^16
+	mov.w	e2,e2
+	bne	divmod_L21
+divmod_L22A:
+	rotxl.w	r2
+	bcs	divmod_L23
+	shlr.l	er0
+	bra	divmod_L24
+divmod_L23:
+	rotxr.w	r2
+	shlr.l	#2,er0
+divmod_L24:
+#endif
+	;; At this point,
+	;;  er0 contains shifted dividend
+	;;  er1 contains divisor
+	;;  er2 contains shifted divisor
+	;;  er3 contains dividend, later remainder
+	divxu.w	r2,er0		; r0 now contains the approximate quotient (AQ)
+	extu.l	er0
+	beq	divmod_L25
+	subs	#1,er0		; er0 = AQ - 1
+	mov.w	e1,r2
+	mulxu.w	r0,er2		; er2 = upper (AQ - 1) * divisor
+	sub.w	r2,e3		; dividend - 65536 * er2
+	mov.w	r1,r2
+	mulxu.w	r0,er2		; compute er3 = remainder (tentative)
+	sub.l	er2,er3		; er3 = dividend - (AQ - 1) * divisor
+divmod_L25:
+	cmp.l	er1,er3		; is divisor < remainder?
+	blo	divmod_L26
+	adds	#1,er0
+	sub.l	er1,er3		; correct the remainder
+divmod_L26:
+	rts
+
+	.end
-- 
2.1.4

