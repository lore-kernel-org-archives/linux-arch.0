Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:6635 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264271AbUDTXMH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 20 Apr 2004 19:12:07 -0400
Date: Tue, 20 Apr 2004 16:14:21 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: "[PATCH] idr.c: extra features enhancements" breaks some archs
Message-Id: <20040420161421.375b46ed.akpm@osdl.org>
In-Reply-To: <200404210052.39771.bzolnier@elka.pw.edu.pl>
References: <200404202259.43931.bzolnier@elka.pw.edu.pl>
	<20040420142947.6501c5c4.akpm@osdl.org>
	<20040420234245.G16428@flint.arm.linux.org.uk>
	<200404210052.39771.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: rmk@arm.linux.org.uk, jim.houston@comcast.net, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
>
> On Wednesday 21 of April 2004 00:42, Russell King wrote:
> > On Tue, Apr 20, 2004 at 02:29:47PM -0700, Andrew Morton wrote:
> > > Could I please ask the relevant arch maintainers to prepare an
> > > implementation?
> >
> > Its in the usual place.
> 
> I'm talking about find_next_bit() not find_next_zero_bit().

Russell's bk tree now contains an impementation of find_next_bit().


diff -Nru a/arch/arm/lib/findbit.S b/arch/arm/lib/findbit.S
--- a/arch/arm/lib/findbit.S	Tue Apr 20 12:58:39 2004
+++ b/arch/arm/lib/findbit.S	Tue Apr 20 12:58:39 2004
@@ -51,6 +51,39 @@
 		add	r2, r2, #1		@ align bit pointer
 		b	2b			@ loop for next bit
 
+/*
+ * Purpose  : Find a 'one' bit
+ * Prototype: int find_first_bit(const unsigned long *addr, unsigned int maxbit);
+ */
+ENTRY(_find_first_bit_le)
+		teq	r1, #0	
+		beq	3f
+		mov	r2, #0
+1:		ldrb	r3, [r0, r2, lsr #3]
+		movs	r3, r3
+		bne	.found			@ any now set - found zero bit
+		add	r2, r2, #8		@ next bit pointer
+2:		cmp	r2, r1			@ any more?
+		blo	1b
+3:		mov	r0, r1			@ no free bits
+		RETINSTR(mov,pc,lr)
+
+/*
+ * Purpose  : Find next 'one' bit
+ * Prototype: int find_next_zero_bit(void *addr, unsigned int maxbit, int offset)
+ */
+ENTRY(_find_next_bit_le)
+		teq	r1, #0
+		beq	2b
+		ands	ip, r2, #7
+		beq	1b			@ If new byte, goto old routine
+		ldrb	r3, [r0, r2, lsr #3]
+		movs	r3, r3, lsr ip		@ shift off unused bits
+		bne	.found
+		orr	r2, r2, #7		@ if zero, then no bits here
+		add	r2, r2, #1		@ align bit pointer
+		b	2b			@ loop for next bit
+
 #ifdef __ARMEB__
 
 ENTRY(_find_first_zero_bit_be)
@@ -73,6 +106,30 @@
 		eor	r3, r2, #0x18		@ big endian byte ordering
 		ldrb	r3, [r0, r3, lsr #3]
 		eor	r3, r3, #0xff		@ now looking for a 1 bit
+		movs	r3, r3, lsr ip		@ shift off unused bits
+		orreq	r2, r2, #7		@ if zero, then no bits here
+		addeq	r2, r2, #1		@ align bit pointer
+		beq	2b			@ loop for next bit
+
+ENTRY(_find_first_bit_be)
+		teq	r1, #0
+		beq	3f
+		mov	r2, #0
+1:		eor	r3, r2, #0x18		@ big endian byte ordering
+		ldrb	r3, [r0, r3, lsr #3]
+		movs	r3, r3
+		bne	.found			@ any now set - found zero bit
+		add	r2, r2, #8		@ next bit pointer
+2:		cmp	r2, r1			@ any more?
+		blo	1b
+3:		mov	r0, r1			@ no free bits
+		RETINSTR(mov,pc,lr)
+
+ENTRY(_find_next_bit_be)
+		ands	ip, r2, #7
+		beq	1b			@ If new byte, goto old routine
+		eor	r3, r2, #0x18		@ big endian byte ordering
+		ldrb	r3, [r0, r3, lsr #3]
 		movs	r3, r3, lsr ip		@ shift off unused bits
 		orreq	r2, r2, #7		@ if zero, then no bits here
 		addeq	r2, r2, #1		@ align bit pointer
diff -Nru a/include/asm-arm/bitops.h b/include/asm-arm/bitops.h
--- a/include/asm-arm/bitops.h	Tue Apr 20 12:58:39 2004
+++ b/include/asm-arm/bitops.h	Tue Apr 20 12:58:39 2004
@@ -212,6 +212,8 @@
 extern int _test_and_change_bit_le(int nr, volatile unsigned long * p);
 extern int _find_first_zero_bit_le(void * p, unsigned size);
 extern int _find_next_zero_bit_le(void * p, int size, int offset);
+extern int _find_first_bit_le(const unsigned long *p, unsigned size);
+extern int _find_next_bit_le(const unsigned long *p, int size, int offset);
 
 /*
  * Big endian assembly bitops.  nr = 0 -> byte 3 bit 0.
@@ -224,7 +226,8 @@
 extern int _test_and_change_bit_be(int nr, volatile unsigned long * p);
 extern int _find_first_zero_bit_be(void * p, unsigned size);
 extern int _find_next_zero_bit_be(void * p, int size, int offset);
-
+extern int _find_first_bit_be(const unsigned long *p, unsigned size);
+extern int _find_next_bit_be(unsigned long *p, int size, int offset);
 
 /*
  * The __* form of bitops are non-atomic and may be reordered.
@@ -255,6 +258,8 @@
 #define test_bit(nr,p)			__test_bit(nr,p)
 #define find_first_zero_bit(p,sz)	_find_first_zero_bit_le(p,sz)
 #define find_next_zero_bit(p,sz,off)	_find_next_zero_bit_le(p,sz,off)
+#define find_first_bit(p,sz)		_find_first_bit_le(p,sz)
+#define find_next_bit(p,sz,off)		_find_next_bit_le(p,sz,off)
 
 #define WORD_BITOFF_TO_LE(x)		((x))
 
@@ -272,6 +277,8 @@
 #define test_bit(nr,p)			__test_bit(nr,p)
 #define find_first_zero_bit(p,sz)	_find_first_zero_bit_be(p,sz)
 #define find_next_zero_bit(p,sz,off)	_find_next_zero_bit_be(p,sz,off)
+#define find_first_bit(p,sz)		_find_first_bit_be(p,sz)
+#define find_next_bit(p,sz,off)		_find_next_bit_be(p,sz,off)
 
 #define WORD_BITOFF_TO_LE(x)		((x) ^ 0x18)
 
