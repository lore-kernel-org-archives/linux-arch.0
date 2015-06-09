From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 09/28] ARCv2: optimised string/mem lib routines
Date: Tue, 9 Jun 2015 17:18:09 +0530
Message-ID: <1433850508-26317-10-git-send-email-vgupta@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:51882 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933175AbbFILwy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 07:52:54 -0400
In-Reply-To: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, arc-linux-dev@synopsys.com, Claudiu Zissulescu <Claudiu.Zissulescu@synopsys.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>

From: Claudiu Zissulescu <claziss@synopsys.com>

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/lib/Makefile       |   6 +-
 arch/arc/lib/memcpy-archs.S | 236 ++++++++++++++++++++++++++++++++++++++++++++
 arch/arc/lib/memset-archs.S |  93 +++++++++++++++++
 arch/arc/lib/strcmp-archs.S |  78 +++++++++++++++
 4 files changed, 411 insertions(+), 2 deletions(-)
 create mode 100644 arch/arc/lib/memcpy-archs.S
 create mode 100644 arch/arc/lib/memset-archs.S
 create mode 100644 arch/arc/lib/strcmp-archs.S

diff --git a/arch/arc/lib/Makefile b/arch/arc/lib/Makefile
index db46e200baba..b1656d156097 100644
--- a/arch/arc/lib/Makefile
+++ b/arch/arc/lib/Makefile
@@ -5,5 +5,7 @@
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
 
-lib-y	:= strchr-700.o strcmp.o strcpy-700.o strlen.o
-lib-y	+= memcmp.o memcpy-700.o memset.o
+lib-y	:= strchr-700.o strcpy-700.o strlen.o memcmp.o
+
+lib-$(CONFIG_ISA_ARCOMPACT)	+= memcpy-700.o memset.o strcmp.o
+lib-$(CONFIG_ISA_ARCV2)		+= memcpy-archs.o memset-archs.o strcmp-archs.o
diff --git a/arch/arc/lib/memcpy-archs.S b/arch/arc/lib/memcpy-archs.S
new file mode 100644
index 000000000000..1b2b3acfed52
--- /dev/null
+++ b/arch/arc/lib/memcpy-archs.S
@@ -0,0 +1,236 @@
+/*
+ * Copyright (C) 2014-15 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+
+#ifdef __LITTLE_ENDIAN__
+# define SHIFT_1(RX,RY,IMM)	asl	RX, RY, IMM	; <<
+# define SHIFT_2(RX,RY,IMM)	lsr	RX, RY, IMM	; >>
+# define MERGE_1(RX,RY,IMM)	asl	RX, RY, IMM
+# define MERGE_2(RX,RY,IMM)
+# define EXTRACT_1(RX,RY,IMM)	and	RX, RY, 0xFFFF
+# define EXTRACT_2(RX,RY,IMM)	lsr	RX, RY, IMM
+#else
+# define SHIFT_1(RX,RY,IMM)	lsr	RX, RY, IMM	; >>
+# define SHIFT_2(RX,RY,IMM)	asl	RX, RY, IMM	; <<
+# define MERGE_1(RX,RY,IMM)	asl	RX, RY, IMM	; <<
+# define MERGE_2(RX,RY,IMM)	asl	RX, RY, IMM	; <<
+# define EXTRACT_1(RX,RY,IMM)	lsr	RX, RY, IMM
+# define EXTRACT_2(RX,RY,IMM)	lsr	RX, RY, 0x08
+#endif
+
+#ifdef CONFIG_ARC_HAS_LL64
+# define PREFETCH_READ(RX)	prefetch    [RX, 56]
+# define PREFETCH_WRITE(RX)	prefetchw   [RX, 64]
+# define LOADX(DST,RX)		ldd.ab	DST, [RX, 8]
+# define STOREX(SRC,RX)		std.ab	SRC, [RX, 8]
+# define ZOLSHFT		5
+# define ZOLAND			0x1F
+#else
+# define PREFETCH_READ(RX)	prefetch    [RX, 28]
+# define PREFETCH_WRITE(RX)	prefetchw   [RX, 32]
+# define LOADX(DST,RX)		ld.ab	DST, [RX, 4]
+# define STOREX(SRC,RX)		st.ab	SRC, [RX, 4]
+# define ZOLSHFT		4
+# define ZOLAND			0xF
+#endif
+
+ENTRY(memcpy)
+	prefetch [r1]		; Prefetch the read location
+	prefetchw [r0]		; Prefetch the write location
+	mov.f	0, r2
+;;; if size is zero
+	jz.d	[blink]
+	mov	r3, r0		; don;t clobber ret val
+
+;;; if size <= 8
+	cmp	r2, 8
+	bls.d	@smallchunk
+	mov.f	lp_count, r2
+
+	and.f	r4, r0, 0x03
+	rsub	lp_count, r4, 4
+	lpnz	@aligndestination
+	;; LOOP BEGIN
+	ldb.ab	r5, [r1,1]
+	sub	r2, r2, 1
+	stb.ab	r5, [r3,1]
+aligndestination:
+
+;;; Check the alignment of the source
+	and.f	r4, r1, 0x03
+	bnz.d	@sourceunaligned
+
+;;; CASE 0: Both source and destination are 32bit aligned
+;;; Convert len to Dwords, unfold x4
+	lsr.f	lp_count, r2, ZOLSHFT
+	lpnz	@copy32_64bytes
+	;; LOOP START
+	LOADX (r6, r1)
+	PREFETCH_READ (r1)
+	PREFETCH_WRITE (r3)
+	LOADX (r8, r1)
+	LOADX (r10, r1)
+	LOADX (r4, r1)
+	STOREX (r6, r3)
+	STOREX (r8, r3)
+	STOREX (r10, r3)
+	STOREX (r4, r3)
+copy32_64bytes:
+
+	and.f	lp_count, r2, ZOLAND ;Last remaining 31 bytes
+smallchunk:
+	lpnz	@copyremainingbytes
+	;; LOOP START
+	ldb.ab	r5, [r1,1]
+	stb.ab	r5, [r3,1]
+copyremainingbytes:
+
+	j	[blink]
+;;; END CASE 0
+
+sourceunaligned:
+	cmp	r4, 2
+	beq.d	@unalignedOffby2
+	sub	r2, r2, 1
+
+	bhi.d	@unalignedOffby3
+	ldb.ab	r5, [r1, 1]
+
+;;; CASE 1: The source is unaligned, off by 1
+	;; Hence I need to read 1 byte for a 16bit alignment
+	;; and 2bytes to reach 32bit alignment
+	ldh.ab	r6, [r1, 2]
+	sub	r2, r2, 2
+	;; Convert to words, unfold x2
+	lsr.f	lp_count, r2, 3
+	MERGE_1 (r6, r6, 8)
+	MERGE_2 (r5, r5, 24)
+	or	r5, r5, r6
+
+	;; Both src and dst are aligned
+	lpnz	@copy8bytes_1
+	;; LOOP START
+	ld.ab	r6, [r1, 4]
+	prefetch [r1, 28]	;Prefetch the next read location
+	ld.ab	r8, [r1,4]
+	prefetchw [r3, 32]	;Prefetch the next write location
+
+	SHIFT_1	(r7, r6, 24)
+	or	r7, r7, r5
+	SHIFT_2	(r5, r6, 8)
+
+	SHIFT_1	(r9, r8, 24)
+	or	r9, r9, r5
+	SHIFT_2	(r5, r8, 8)
+
+	st.ab	r7, [r3, 4]
+	st.ab	r9, [r3, 4]
+copy8bytes_1:
+
+	;; Write back the remaining 16bits
+	EXTRACT_1 (r6, r5, 16)
+	sth.ab	r6, [r3, 2]
+	;; Write back the remaining 8bits
+	EXTRACT_2 (r5, r5, 16)
+	stb.ab	r5, [r3, 1]
+
+	and.f	lp_count, r2, 0x07 ;Last 8bytes
+	lpnz	@copybytewise_1
+	;; LOOP START
+	ldb.ab	r6, [r1,1]
+	stb.ab	r6, [r3,1]
+copybytewise_1:
+	j	[blink]
+
+unalignedOffby2:
+;;; CASE 2: The source is unaligned, off by 2
+	ldh.ab	r5, [r1, 2]
+	sub	r2, r2, 1
+
+	;; Both src and dst are aligned
+	;; Convert to words, unfold x2
+	lsr.f	lp_count, r2, 3
+#ifdef __BIG_ENDIAN__
+	asl.nz	r5, r5, 16
+#endif
+	lpnz	@copy8bytes_2
+	;; LOOP START
+	ld.ab	r6, [r1, 4]
+	prefetch [r1, 28]	;Prefetch the next read location
+	ld.ab	r8, [r1,4]
+	prefetchw [r3, 32]	;Prefetch the next write location
+
+	SHIFT_1	(r7, r6, 16)
+	or	r7, r7, r5
+	SHIFT_2	(r5, r6, 16)
+
+	SHIFT_1	(r9, r8, 16)
+	or	r9, r9, r5
+	SHIFT_2	(r5, r8, 16)
+
+	st.ab	r7, [r3, 4]
+	st.ab	r9, [r3, 4]
+copy8bytes_2:
+
+#ifdef __BIG_ENDIAN__
+	lsr.nz	r5, r5, 16
+#endif
+	sth.ab	r5, [r3, 2]
+
+	and.f	lp_count, r2, 0x07 ;Last 8bytes
+	lpnz	@copybytewise_2
+	;; LOOP START
+	ldb.ab	r6, [r1,1]
+	stb.ab	r6, [r3,1]
+copybytewise_2:
+	j	[blink]
+
+unalignedOffby3:
+;;; CASE 3: The source is unaligned, off by 3
+;;; Hence, I need to read 1byte for achieve the 32bit alignment
+
+	;; Both src and dst are aligned
+	;; Convert to words, unfold x2
+	lsr.f	lp_count, r2, 3
+#ifdef __BIG_ENDIAN__
+	asl.ne	r5, r5, 24
+#endif
+	lpnz	@copy8bytes_3
+	;; LOOP START
+	ld.ab	r6, [r1, 4]
+	prefetch [r1, 28]	;Prefetch the next read location
+	ld.ab	r8, [r1,4]
+	prefetch [r3, 32]	;Prefetch the next write location
+
+	SHIFT_1	(r7, r6, 8)
+	or	r7, r7, r5
+	SHIFT_2	(r5, r6, 24)
+
+	SHIFT_1	(r9, r8, 8)
+	or	r9, r9, r5
+	SHIFT_2	(r5, r8, 24)
+
+	st.ab	r7, [r3, 4]
+	st.ab	r9, [r3, 4]
+copy8bytes_3:
+
+#ifdef __BIG_ENDIAN__
+	lsr.nz	r5, r5, 24
+#endif
+	stb.ab	r5, [r3, 1]
+
+	and.f	lp_count, r2, 0x07 ;Last 8bytes
+	lpnz	@copybytewise_3
+	;; LOOP START
+	ldb.ab	r6, [r1,1]
+	stb.ab	r6, [r3,1]
+copybytewise_3:
+	j	[blink]
+
+END(memcpy)
diff --git a/arch/arc/lib/memset-archs.S b/arch/arc/lib/memset-archs.S
new file mode 100644
index 000000000000..92d573c734b5
--- /dev/null
+++ b/arch/arc/lib/memset-archs.S
@@ -0,0 +1,93 @@
+/*
+ * Copyright (C) 2014-15 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+
+#undef PREALLOC_NOT_AVAIL
+
+#ifdef PREALLOC_NOT_AVAIL
+#define PREWRITE(A,B)	prefetchw [(A),(B)]
+#else
+#define PREWRITE(A,B)	prealloc [(A),(B)]
+#endif
+
+ENTRY(memset)
+	prefetchw [r0]		; Prefetch the write location
+	mov.f	0, r2
+;;; if size is zero
+	jz.d	[blink]
+	mov	r3, r0		; don't clobber ret val
+
+;;; if length < 8
+	brls.d.nt	r2, 8, .Lsmallchunk
+	mov.f	lp_count,r2
+
+	and.f	r4, r0, 0x03
+	rsub	lp_count, r4, 4
+	lpnz	@.Laligndestination
+	;; LOOP BEGIN
+	stb.ab	r1, [r3,1]
+	sub	r2, r2, 1
+.Laligndestination:
+
+;;; Destination is aligned
+	and	r1, r1, 0xFF
+	asl	r4, r1, 8
+	or	r4, r4, r1
+	asl	r5, r4, 16
+	or	r5, r5, r4
+	mov	r4, r5
+
+	sub3	lp_count, r2, 8
+	cmp     r2, 64
+	bmsk.hi	r2, r2, 5
+	mov.ls	lp_count, 0
+	add3.hi	r2, r2, 8
+
+;;; Convert len to Dwords, unfold x8
+	lsr.f	lp_count, lp_count, 6
+	lpnz	@.Lset64bytes
+	;; LOOP START
+	PREWRITE(r3, 64)	;Prefetch the next write location
+	std.ab	r4, [r3, 8]
+	std.ab	r4, [r3, 8]
+	std.ab	r4, [r3, 8]
+	std.ab	r4, [r3, 8]
+	std.ab	r4, [r3, 8]
+	std.ab	r4, [r3, 8]
+	std.ab	r4, [r3, 8]
+	std.ab	r4, [r3, 8]
+.Lset64bytes:
+
+	lsr.f	lp_count, r2, 5 ;Last remaining  max 124 bytes
+	lpnz	.Lset32bytes
+	;; LOOP START
+	prefetchw   [r3, 32]	;Prefetch the next write location
+	std.ab	r4, [r3, 8]
+	std.ab	r4, [r3, 8]
+	std.ab	r4, [r3, 8]
+	std.ab	r4, [r3, 8]
+.Lset32bytes:
+
+	and.f	lp_count, r2, 0x1F ;Last remaining 31 bytes
+.Lsmallchunk:
+	lpnz	.Lcopy3bytes
+	;; LOOP START
+	stb.ab	r1, [r3, 1]
+.Lcopy3bytes:
+
+	j	[blink]
+
+END(memset)
+
+ENTRY(memzero)
+    ; adjust bzero args to memset args
+    mov r2, r1
+    b.d  memset    ;tail call so need to tinker with blink
+    mov r1, 0
+END(memzero)
diff --git a/arch/arc/lib/strcmp-archs.S b/arch/arc/lib/strcmp-archs.S
new file mode 100644
index 000000000000..4f338eec3365
--- /dev/null
+++ b/arch/arc/lib/strcmp-archs.S
@@ -0,0 +1,78 @@
+/*
+ * Copyright (C) 2014-15 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+
+ENTRY(strcmp)
+	or	r2, r0, r1
+	bmsk_s	r2, r2, 1
+	brne	r2, 0, @.Lcharloop
+
+;;; s1 and s2 are word aligned
+	ld.ab	r2, [r0, 4]
+
+	mov_s	r12, 0x01010101
+	ror	r11, r12
+	.align  4
+.LwordLoop:
+	ld.ab	r3, [r1, 4]
+	;; Detect NULL char in str1
+	sub	r4, r2, r12
+	ld.ab	r5, [r0, 4]
+	bic	r4, r4, r2
+	and	r4, r4, r11
+	brne.d.nt	r4, 0, .LfoundNULL
+	;; Check if the read locations are the same
+	cmp	r2, r3
+	beq.d	.LwordLoop
+	mov.eq	r2, r5
+
+	;; A match is found, spot it out
+#ifdef __LITTLE_ENDIAN__
+	swape	r3, r3
+	mov_s	r0, 1
+	swape	r2, r2
+#else
+	mov_s	r0, 1
+#endif
+	cmp_s	r2, r3
+	j_s.d	[blink]
+	bset.lo	r0, r0, 31
+
+	.align 4
+.LfoundNULL:
+#ifdef __BIG_ENDIAN__
+	swape	r4, r4
+	swape	r2, r2
+	swape	r3, r3
+#endif
+	;; Find null byte
+	ffs	r0, r4
+	bmsk	r2, r2, r0
+	bmsk	r3, r3, r0
+	swape	r2, r2
+	swape	r3, r3
+	;; make the return value
+	sub.f	r0, r2, r3
+	mov.hi	r0, 1
+	j_s.d	[blink]
+	bset.lo	r0, r0, 31
+
+	.align 4
+.Lcharloop:
+	ldb.ab	r2, [r0, 1]
+	ldb.ab	r3, [r1, 1]
+	nop
+	breq	r2, 0, .Lcmpend
+	breq	r2, r3, .Lcharloop
+
+	.align 4
+.Lcmpend:
+	j_s.d	[blink]
+	sub	r0, r2, r3
+END(strcmp)
-- 
1.9.1
