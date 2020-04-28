From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v8 3/8] powerpc/vdso: Remove unused \tmp param in
 __get_datapage()
Date: Tue, 28 Apr 2020 13:16:49 +0000 (UTC)
Message-ID: <67fe05dac46f5f46c9870d68816181c7680c4f1f.1588079622.git.christophe.leroy@c-s.fr>
References: <cover.1588079622.git.christophe.leroy@c-s.fr>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:3827 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbgD1NQv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Apr 2020 09:16:51 -0400
In-Reply-To: <cover.1588079622.git.christophe.leroy@c-s.fr>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, nathanl@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, arnd@arndb.de, tglx@linutronix.de, vincenzo.frascino@arm.com, luto@kernel.org, linux-arch@vger.kernel.org

The \tmp param is not used anymore, remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v7: New patch, splitted out of preceding patch
---
 arch/powerpc/include/asm/vdso_datapage.h  | 2 +-
 arch/powerpc/kernel/vdso32/cacheflush.S   | 2 +-
 arch/powerpc/kernel/vdso32/datapage.S     | 4 ++--
 arch/powerpc/kernel/vdso32/gettimeofday.S | 8 ++++----
 arch/powerpc/kernel/vdso64/cacheflush.S   | 2 +-
 arch/powerpc/kernel/vdso64/datapage.S     | 4 ++--
 arch/powerpc/kernel/vdso64/gettimeofday.S | 8 ++++----
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/asm/vdso_datapage.h
index 11886467dfdf..f3d7e4e2a45b 100644
--- a/arch/powerpc/include/asm/vdso_datapage.h
+++ b/arch/powerpc/include/asm/vdso_datapage.h
@@ -116,7 +116,7 @@ extern struct vdso_data *vdso_data;
 
 #else /* __ASSEMBLY__ */
 
-.macro get_datapage ptr, tmp
+.macro get_datapage ptr
 	bcl	20, 31, .+4
 999:
 	mflr	\ptr
diff --git a/arch/powerpc/kernel/vdso32/cacheflush.S b/arch/powerpc/kernel/vdso32/cacheflush.S
index 3440ddf21c8b..017843bf5382 100644
--- a/arch/powerpc/kernel/vdso32/cacheflush.S
+++ b/arch/powerpc/kernel/vdso32/cacheflush.S
@@ -27,7 +27,7 @@ V_FUNCTION_BEGIN(__kernel_sync_dicache)
 #ifdef CONFIG_PPC64
 	mflr	r12
   .cfi_register lr,r12
-	get_datapage	r10, r0
+	get_datapage	r10
 	mtlr	r12
 #endif
 
diff --git a/arch/powerpc/kernel/vdso32/datapage.S b/arch/powerpc/kernel/vdso32/datapage.S
index 5513a4f8253e..0513a2eabec8 100644
--- a/arch/powerpc/kernel/vdso32/datapage.S
+++ b/arch/powerpc/kernel/vdso32/datapage.S
@@ -28,7 +28,7 @@ V_FUNCTION_BEGIN(__kernel_get_syscall_map)
 	mflr	r12
   .cfi_register lr,r12
 	mr.	r4,r3
-	get_datapage	r3, r0
+	get_datapage	r3
 	mtlr	r12
 	addi	r3,r3,CFG_SYSCALL_MAP32
 	beqlr
@@ -49,7 +49,7 @@ V_FUNCTION_BEGIN(__kernel_get_tbfreq)
   .cfi_startproc
 	mflr	r12
   .cfi_register lr,r12
-	get_datapage	r3, r0
+	get_datapage	r3
 	lwz	r4,(CFG_TB_TICKS_PER_SEC + 4)(r3)
 	lwz	r3,CFG_TB_TICKS_PER_SEC(r3)
 	mtlr	r12
diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
index a3951567118a..0bbdce0f2a9c 100644
--- a/arch/powerpc/kernel/vdso32/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
@@ -34,7 +34,7 @@ V_FUNCTION_BEGIN(__kernel_gettimeofday)
 
 	mr.	r10,r3			/* r10 saves tv */
 	mr	r11,r4			/* r11 saves tz */
-	get_datapage	r9, r0
+	get_datapage	r9
 	beq	3f
 	LOAD_REG_IMMEDIATE(r7, 1000000)	/* load up USEC_PER_SEC */
 	bl	__do_get_tspec@local	/* get sec/usec from tb & kernel */
@@ -79,7 +79,7 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
 	mflr	r12			/* r12 saves lr */
   .cfi_register lr,r12
 	mr	r11,r4			/* r11 saves tp */
-	get_datapage	r9, r0
+	get_datapage	r9
 	LOAD_REG_IMMEDIATE(r7, NSEC_PER_SEC)	/* load up NSEC_PER_SEC */
 	beq	cr5, .Lcoarse_clocks
 .Lprecise_clocks:
@@ -206,7 +206,7 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
 
 	mflr	r12
   .cfi_register lr,r12
-	get_datapage	r3, r0
+	get_datapage	r3
 	lwz	r5, CLOCK_HRTIMER_RES(r3)
 	mtlr	r12
 1:	li	r3,0
@@ -240,7 +240,7 @@ V_FUNCTION_BEGIN(__kernel_time)
   .cfi_register lr,r12
 
 	mr	r11,r3			/* r11 holds t */
-	get_datapage	r9, r0
+	get_datapage	r9
 
 	lwz	r3,STAMP_XTIME_SEC+LOPART(r9)
 
diff --git a/arch/powerpc/kernel/vdso64/cacheflush.S b/arch/powerpc/kernel/vdso64/cacheflush.S
index cab14324242b..61985de5758f 100644
--- a/arch/powerpc/kernel/vdso64/cacheflush.S
+++ b/arch/powerpc/kernel/vdso64/cacheflush.S
@@ -25,7 +25,7 @@ V_FUNCTION_BEGIN(__kernel_sync_dicache)
   .cfi_startproc
 	mflr	r12
   .cfi_register lr,r12
-	get_datapage	r10, r0
+	get_datapage	r10
 	mtlr	r12
 
 	lwz	r7,CFG_DCACHE_BLOCKSZ(r10)
diff --git a/arch/powerpc/kernel/vdso64/datapage.S b/arch/powerpc/kernel/vdso64/datapage.S
index 03bb72c440dc..00760dc69d68 100644
--- a/arch/powerpc/kernel/vdso64/datapage.S
+++ b/arch/powerpc/kernel/vdso64/datapage.S
@@ -28,7 +28,7 @@ V_FUNCTION_BEGIN(__kernel_get_syscall_map)
 	mflr	r12
   .cfi_register lr,r12
 	mr	r4,r3
-	get_datapage	r3, r0
+	get_datapage	r3
 	mtlr	r12
 	addi	r3,r3,CFG_SYSCALL_MAP64
 	cmpldi	cr0,r4,0
@@ -50,7 +50,7 @@ V_FUNCTION_BEGIN(__kernel_get_tbfreq)
   .cfi_startproc
 	mflr	r12
   .cfi_register lr,r12
-	get_datapage	r3, r0
+	get_datapage	r3
 	ld	r3,CFG_TB_TICKS_PER_SEC(r3)
 	mtlr	r12
 	crclr	cr0*4+so
diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/kernel/vdso64/gettimeofday.S
index e54c4ce4d356..275f031d0bf1 100644
--- a/arch/powerpc/kernel/vdso64/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
@@ -26,7 +26,7 @@ V_FUNCTION_BEGIN(__kernel_gettimeofday)
 
 	mr	r11,r3			/* r11 holds tv */
 	mr	r10,r4			/* r10 holds tz */
-	get_datapage	r3, r0
+	get_datapage	r3
 	cmpldi	r11,0			/* check if tv is NULL */
 	beq	2f
 	lis	r7,1000000@ha		/* load up USEC_PER_SEC */
@@ -71,7 +71,7 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
 	mflr	r12			/* r12 saves lr */
   .cfi_register lr,r12
 	mr	r11,r4			/* r11 saves tp */
-	get_datapage	r3, r0
+	get_datapage	r3
 	lis	r7,NSEC_PER_SEC@h	/* want nanoseconds */
 	ori	r7,r7,NSEC_PER_SEC@l
 	beq	cr5,70f
@@ -188,7 +188,7 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
 
 	mflr	r12
   .cfi_register lr,r12
-	get_datapage	r3, r0
+	get_datapage	r3
 	lwz	r5, CLOCK_HRTIMER_RES(r3)
 	mtlr	r12
 	li	r3,0
@@ -221,7 +221,7 @@ V_FUNCTION_BEGIN(__kernel_time)
   .cfi_register lr,r12
 
 	mr	r11,r3			/* r11 holds t */
-	get_datapage	r3, r0
+	get_datapage	r3
 
 	ld	r4,STAMP_XTIME_SEC(r3)
 
-- 
2.25.0
