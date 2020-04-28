Return-Path: <SRS0=fQTO=6M=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:12112 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgD1NQt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Apr 2020 09:16:49 -0400
Message-ID: <e13d95312e0b9792556b19b4bb8955cc1ff19fc7.1588079622.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1588079622.git.christophe.leroy@c-s.fr>
References: <cover.1588079622.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v8 1/8] powerpc/vdso64: Switch from __get_datapage() to
 get_datapage inline macro
Date: Tue, 28 Apr 2020 13:16:47 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, nathanl@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, arnd@arndb.de, tglx@linutronix.de, vincenzo.frascino@arm.com, luto@kernel.org, linux-arch@vger.kernel.org
Message-ID: <20200428131647.9SCC1Xui1TtzX6mZAkE0n8YXLGbmXj9w_DfwBdDKfmM@z>

On the same way as already done on PPC32, drop __get_datapage()
function and use get_datapage inline macro instead.

See commit ec0895f08f99 ("powerpc/vdso32: inline __get_datapage()")

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/vdso64/cacheflush.S   |  9 ++++----
 arch/powerpc/kernel/vdso64/datapage.S     | 28 +++--------------------
 arch/powerpc/kernel/vdso64/gettimeofday.S |  8 +++----
 3 files changed, 11 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/kernel/vdso64/cacheflush.S b/arch/powerpc/kernel/vdso64/cacheflush.S
index 526f5ba2593e..cab14324242b 100644
--- a/arch/powerpc/kernel/vdso64/cacheflush.S
+++ b/arch/powerpc/kernel/vdso64/cacheflush.S
@@ -8,6 +8,7 @@
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
 #include <asm/vdso.h>
+#include <asm/vdso_datapage.h>
 #include <asm/asm-offsets.h>
 
 	.text
@@ -24,14 +25,12 @@ V_FUNCTION_BEGIN(__kernel_sync_dicache)
   .cfi_startproc
 	mflr	r12
   .cfi_register lr,r12
-	mr	r11,r3
-	bl	V_LOCAL_FUNC(__get_datapage)
+	get_datapage	r10, r0
 	mtlr	r12
-	mr	r10,r3
 
 	lwz	r7,CFG_DCACHE_BLOCKSZ(r10)
 	addi	r5,r7,-1
-	andc	r6,r11,r5		/* round low to line bdy */
+	andc	r6,r3,r5		/* round low to line bdy */
 	subf	r8,r6,r4		/* compute length */
 	add	r8,r8,r5		/* ensure we get enough */
 	lwz	r9,CFG_DCACHE_LOGBLOCKSZ(r10)
@@ -48,7 +47,7 @@ V_FUNCTION_BEGIN(__kernel_sync_dicache)
 
 	lwz	r7,CFG_ICACHE_BLOCKSZ(r10)
 	addi	r5,r7,-1
-	andc	r6,r11,r5		/* round low to line bdy */
+	andc	r6,r3,r5		/* round low to line bdy */
 	subf	r8,r6,r4		/* compute length */
 	add	r8,r8,r5
 	lwz	r9,CFG_ICACHE_LOGBLOCKSZ(r10)
diff --git a/arch/powerpc/kernel/vdso64/datapage.S b/arch/powerpc/kernel/vdso64/datapage.S
index dc84f5ae3802..067247d3efb9 100644
--- a/arch/powerpc/kernel/vdso64/datapage.S
+++ b/arch/powerpc/kernel/vdso64/datapage.S
@@ -10,35 +10,13 @@
 #include <asm/asm-offsets.h>
 #include <asm/unistd.h>
 #include <asm/vdso.h>
+#include <asm/vdso_datapage.h>
 
 	.text
 .global	__kernel_datapage_offset;
 __kernel_datapage_offset:
 	.long	0
 
-V_FUNCTION_BEGIN(__get_datapage)
-  .cfi_startproc
-	/* We don't want that exposed or overridable as we want other objects
-	 * to be able to bl directly to here
-	 */
-	.protected __get_datapage
-	.hidden __get_datapage
-
-	mflr	r0
-  .cfi_register lr,r0
-
-	bcl	20,31,data_page_branch
-data_page_branch:
-	mflr	r3
-	mtlr	r0
-	addi	r3, r3, __kernel_datapage_offset-data_page_branch
-	lwz	r0,0(r3)
-  .cfi_restore lr
-	add	r3,r0,r3
-	blr
-  .cfi_endproc
-V_FUNCTION_END(__get_datapage)
-
 /*
  * void *__kernel_get_syscall_map(unsigned int *syscall_count) ;
  *
@@ -53,7 +31,7 @@ V_FUNCTION_BEGIN(__kernel_get_syscall_map)
 	mflr	r12
   .cfi_register lr,r12
 	mr	r4,r3
-	bl	V_LOCAL_FUNC(__get_datapage)
+	get_datapage	r3, r0
 	mtlr	r12
 	addi	r3,r3,CFG_SYSCALL_MAP64
 	cmpldi	cr0,r4,0
@@ -75,7 +53,7 @@ V_FUNCTION_BEGIN(__kernel_get_tbfreq)
   .cfi_startproc
 	mflr	r12
   .cfi_register lr,r12
-	bl	V_LOCAL_FUNC(__get_datapage)
+	get_datapage	r3, r0
 	ld	r3,CFG_TB_TICKS_PER_SEC(r3)
 	mtlr	r12
 	crclr	cr0*4+so
diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/kernel/vdso64/gettimeofday.S
index 1c9a04703250..e54c4ce4d356 100644
--- a/arch/powerpc/kernel/vdso64/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
@@ -26,7 +26,7 @@ V_FUNCTION_BEGIN(__kernel_gettimeofday)
 
 	mr	r11,r3			/* r11 holds tv */
 	mr	r10,r4			/* r10 holds tz */
-	bl	V_LOCAL_FUNC(__get_datapage)	/* get data page */
+	get_datapage	r3, r0
 	cmpldi	r11,0			/* check if tv is NULL */
 	beq	2f
 	lis	r7,1000000@ha		/* load up USEC_PER_SEC */
@@ -71,7 +71,7 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
 	mflr	r12			/* r12 saves lr */
   .cfi_register lr,r12
 	mr	r11,r4			/* r11 saves tp */
-	bl	V_LOCAL_FUNC(__get_datapage)	/* get data page */
+	get_datapage	r3, r0
 	lis	r7,NSEC_PER_SEC@h	/* want nanoseconds */
 	ori	r7,r7,NSEC_PER_SEC@l
 	beq	cr5,70f
@@ -188,7 +188,7 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
 
 	mflr	r12
   .cfi_register lr,r12
-	bl	V_LOCAL_FUNC(__get_datapage)
+	get_datapage	r3, r0
 	lwz	r5, CLOCK_HRTIMER_RES(r3)
 	mtlr	r12
 	li	r3,0
@@ -221,7 +221,7 @@ V_FUNCTION_BEGIN(__kernel_time)
   .cfi_register lr,r12
 
 	mr	r11,r3			/* r11 holds t */
-	bl	V_LOCAL_FUNC(__get_datapage)
+	get_datapage	r3, r0
 
 	ld	r4,STAMP_XTIME_SEC(r3)
 
-- 
2.25.0
