From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 02/28] ARCv2: Support for ARCv2 ISA and HS38x cores
Date: Tue, 9 Jun 2015 17:18:02 +0530
Message-ID: <1433850508-26317-3-git-send-email-vgupta@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:33136 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753754AbbFILvi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 07:51:38 -0400
In-Reply-To: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

The notable features are:
    - SMP configurations of upto 4 cores with coherency
    - Optional L2 Cache and IO-Coherency
    - Revised Interrupt Architecture (multiple priorites, reg banks,
        auto stack switch, auto regfile save/restore)
    - MMUv4 (PIPT dcache, Huge Pages)
    - Instructions for
	* 64bit load/store: LDD, STD
	* Hardware assisted divide/remainder: DIV, REM
	* Function prologue/epilogue: ENTER_S, LEAVE_S
	* IRQ enable/disable: CLRI, SETI
	* pop count: FFS, FLS
	* SETcc, BMSKN, XBFU...

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/Kconfig                        |  80 +++++++++++++-
 arch/arc/Makefile                       |   8 +-
 arch/arc/include/asm/arcregs.h          |  53 ++++++++-
 arch/arc/include/asm/bitops.h           |  71 ++++++++++++
 arch/arc/include/asm/elf.h              |   5 +
 arch/arc/include/asm/entry-arcv2.h      | 190 ++++++++++++++++++++++++++++++++
 arch/arc/include/asm/entry.h            |   4 +
 arch/arc/include/asm/irq.h              |   5 +
 arch/arc/include/asm/irqflags-arcv2.h   |   3 +
 arch/arc/include/asm/irqflags-compact.h |   2 +
 arch/arc/include/asm/irqflags.h         |   4 +
 arch/arc/include/asm/ptrace.h           |  43 ++++++++
 arch/arc/include/asm/thread_info.h      |   1 +
 arch/arc/kernel/Makefile                |   3 +-
 arch/arc/kernel/entry-arcv2.S           | 189 +++++++++++++++++++++++++++++++
 arch/arc/kernel/head.S                  |   2 -
 arch/arc/kernel/process.c               |  12 +-
 arch/arc/kernel/ptrace.c                |   2 +-
 arch/arc/kernel/setup.c                 |  45 +++++++-
 arch/arc/kernel/signal.c                |   6 +-
 arch/arc/kernel/troubleshoot.c          |  33 +++++-
 arch/arc/mm/tlbex.S                     |   2 -
 22 files changed, 730 insertions(+), 33 deletions(-)
 create mode 100644 arch/arc/include/asm/entry-arcv2.h
 create mode 100644 arch/arc/kernel/entry-arcv2.S

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 1eeefd9763d1..f72398847b5b 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -88,11 +88,31 @@ source "arch/arc/plat-axs10x/Kconfig"
 
 endmenu
 
+choice
+	prompt "ARC Instruction Set"
+	default ISA_ARCOMPACT
+
+config ISA_ARCOMPACT
+	bool "ARCompact ISA"
+	help
+	  The original ARC ISA of ARC600/700 cores
+
+### For bisectability, disable ARCv2 support until we have all the bits in place
+#config ISA_ARCV2
+#	bool "ARC ISA v2"
+#	help
+#	  ISA for the Next Generation ARC-HS cores
+
+endchoice
+
 menu "ARC CPU Configuration"
 
 choice
 	prompt "ARC Core"
-	default ARC_CPU_770
+	default ARC_CPU_770 if ISA_ARCOMPACT
+	default ARC_CPU_HS if ISA_ARCV2
+
+if ISA_ARCOMPACT
 
 config ARC_CPU_750D
 	bool "ARC750D"
@@ -110,6 +130,27 @@ config ARC_CPU_770
 	  -Caches: New Prog Model, Region Flush
 	  -Insns: endian swap, load-locked/store-conditional, time-stamp-ctr
 
+endif	#ISA_ARCOMPACT
+
+config ARC_CPU_HS
+	bool "ARC-HS"
+	depends on ISA_ARCV2
+	help
+	  Support for ARC HS38x Cores based on ARCv2 ISA
+	  The notable features are:
+	    - SMP configurations of upto 4 core with coherency
+	    - Optional L2 Cache and IO-Coherency
+	    - Revised Interrupt Architecture (multiple priorites, reg banks,
+	        auto stack switch, auto regfile save/restore)
+	    - MMUv4 (PIPT dcache, Huge Pages)
+	    - Instructions for
+		* 64bit load/store: LDD, STD
+		* Hardware assisted divide/remainder: DIV, REM
+		* Function prologue/epilogue: ENTER_S, LEAVE_S
+		* IRQ enable/disable: CLRI, SETI
+		* pop count: FFS, FLS
+		* SETcc, BMSKN, XBFU...
+
 endchoice
 
 config CPU_BIG_ENDIAN
@@ -134,7 +175,7 @@ config ARC_HAS_COH_CACHES
 config ARC_HAS_REENTRANT_IRQ_LV2
 	def_bool n
 
-endif
+endif	#SMP
 
 config NR_CPUS
 	int "Maximum number of CPUs (2-4096)"
@@ -223,7 +264,7 @@ config ARC_HAS_HW_MPY
 	  Multipler. Otherwise software multipy lib is used
 
 choice
-	prompt "ARC700 MMU Version"
+	prompt "MMU Version"
 	default ARC_MMU_V3 if ARC_CPU_770
 	default ARC_MMU_V2 if ARC_CPU_750D
 
@@ -268,6 +309,8 @@ config ARC_PAGE_SIZE_4K
 
 endchoice
 
+if ISA_ARCOMPACT
+
 config ARC_COMPACT_IRQ_LEVELS
 	bool "ARCompact IRQ Priorities: High(2)/Low(1)"
 	default n
@@ -287,7 +330,7 @@ config ARC_IRQ5_LV2
 config ARC_IRQ6_LV2
 	bool
 
-endif
+endif	#ARC_COMPACT_IRQ_LEVELS
 
 config ARC_FPU_SAVE_RESTORE
 	bool "Enable FPU state persistence across context switch"
@@ -300,18 +343,43 @@ config ARC_FPU_SAVE_RESTORE
 	  based on actual usage of FPU by a task. Thus our implemn does
 	  this for all tasks in system.
 
+endif	#ISA_ARCOMPACT
+
 config ARC_CANT_LLSC
 	def_bool n
 
 config ARC_HAS_LLSC
 	bool "Insn: LLOCK/SCOND (efficient atomic ops)"
 	default y
-	depends on ARC_CPU_770 && !ARC_CANT_LLSC
+	depends on !ARC_CPU_750D && !ARC_CANT_LLSC
 
 config ARC_HAS_SWAPE
 	bool "Insn: SWAPE (endian-swap)"
 	default y
 
+if ISA_ARCV2
+
+config ARC_HAS_LL64
+	bool "Insn: 64bit LDD/STD"
+	help
+	  Enable gcc to generate 64-bit load/store instructions
+	  ISA mandates even/odd registers to allow encoding of two
+	  dest operands with 2 possible source operands.
+	default y
+
+config ARC_NUMBER_OF_INTERRUPTS
+	int "Number of interrupts"
+	range 8 240
+	default 32
+	help
+	  This defines the number of interrupts on the ARCv2HS core.
+	  It affects the size of vector table.
+	  The initial 8 IRQs are fixed (Timer, ICI etc) and although configurable
+	  in hardware, it keep things simple for Linux to assume they are always
+	  present.
+
+endif	# ISA_ARCV2
+
 endmenu   # "ARC CPU Configuration"
 
 config LINUX_LINK_BASE
@@ -337,8 +405,10 @@ config ARC_CURR_IN_REG
 
 config ARC_EMUL_UNALIGNED
 	bool "Emulate unaligned memory access (userspace only)"
+	default N
 	select SYSCTL_ARCH_UNALIGN_NO_WARN
 	select SYSCTL_ARCH_UNALIGN_ALLOW
+	depends on ISA_ARCOMPACT
 	help
 	  This enables misaligned 16 & 32 bit memory access from user space.
 	  Use ONLY-IF-ABS-NECESSARY as it will be very slow and also can hide
diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index 86c71b2089d2..bf68dc5a08be 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -14,7 +14,9 @@ endif
 
 KBUILD_DEFCONFIG := nsim_700_defconfig
 
-cflags-y	+= -mA7 -fno-common -pipe -fno-builtin -D__linux__
+cflags-y	+= -fno-common -pipe -fno-builtin -D__linux__
+cflags-${CONFIG_ISA_ARCOMPACT}	+= -mA7
+cflags-${CONFIG_ISA_ARCV2}	+= -mcpu=archs
 
 ifdef CONFIG_ARC_CURR_IN_REG
 # For a global register defintion, make sure it gets passed to every file
@@ -34,6 +36,10 @@ cflags-$(atleast_gcc44)			+= -fsection-anchors
 cflags-$(CONFIG_ARC_HAS_LLSC)		+= -mlock
 cflags-$(CONFIG_ARC_HAS_SWAPE)		+= -mswape
 
+ifndef CONFIG_ARC_HAS_LL64
+cflags-y				+= -mno-ll64
+endif
+
 cflags-$(CONFIG_ARC_DW2_UNWIND)		+= -fasynchronous-unwind-tables
 
 # By default gcc 4.8 generates dwarf4 which kernel unwinder can't grok
diff --git a/arch/arc/include/asm/arcregs.h b/arch/arc/include/asm/arcregs.h
index 336a9f694c2e..d77362dbb864 100644
--- a/arch/arc/include/asm/arcregs.h
+++ b/arch/arc/include/asm/arcregs.h
@@ -16,6 +16,7 @@
 #define ARC_REG_PERIBASE_BCR	0x69
 #define ARC_REG_FP_BCR		0x6B	/* ARCompact: Single-Precision FPU */
 #define ARC_REG_DPFP_BCR	0x6C	/* ARCompact: Dbl Precision FPU */
+#define ARC_REG_FP_V2_BCR	0xc8	/* ARCv2 FPU */
 #define ARC_REG_DCCM_BCR	0x74	/* DCCM Present + SZ */
 #define ARC_REG_TIMERS_BCR	0x75
 #define ARC_REG_AP_BCR		0x76
@@ -51,6 +52,7 @@
  * [15: 8] = Exception Cause Code
  * [ 7: 0] = Exception Parameters (for certain types only)
  */
+#ifdef CONFIG_ISA_ARCOMPACT
 #define ECR_V_MEM_ERR			0x01
 #define ECR_V_INSN_ERR			0x02
 #define ECR_V_MACH_CHK			0x20
@@ -58,6 +60,15 @@
 #define ECR_V_DTLB_MISS			0x22
 #define ECR_V_PROTV			0x23
 #define ECR_V_TRAP			0x25
+#else
+#define ECR_V_MEM_ERR			0x01
+#define ECR_V_INSN_ERR			0x02
+#define ECR_V_MACH_CHK			0x03
+#define ECR_V_ITLB_MISS			0x04
+#define ECR_V_DTLB_MISS			0x05
+#define ECR_V_PROTV			0x06
+#define ECR_V_TRAP			0x09
+#endif
 
 /* DTLB Miss and Protection Violation Cause Codes */
 
@@ -201,9 +212,11 @@ struct bcr_identity {
 
 struct bcr_isa {
 #ifdef CONFIG_CPU_BIG_ENDIAN
-	unsigned int pad1:23, atomic1:1, ver:8;
+	unsigned int div_rem:4, pad2:4, ldd:1, unalign:1, atomic:1, be:1,
+		     pad1:11, atomic1:1, ver:8;
 #else
-	unsigned int ver:8, atomic1:1, pad1:23;
+	unsigned int ver:8, atomic1:1, pad1:11, be:1, atomic:1, unalign:1,
+		     ldd:1, pad2:4, div_rem:4;
 #endif
 };
 
@@ -266,11 +279,19 @@ struct bcr_fp_arcompact {
 #endif
 };
 
+struct bcr_fp_arcv2 {
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	unsigned int pad2:15, dp:1, pad1:7, sp:1, ver:8;
+#else
+	unsigned int ver:8, sp:1, pad1:7, dp:1, pad2:15;
+#endif
+};
+
 struct bcr_timer {
 #ifdef CONFIG_CPU_BIG_ENDIAN
-	unsigned int pad2:15, rtsc:1, pad1:6, t1:1, t0:1, ver:8;
+	unsigned int pad2:15, rtsc:1, pad1:5, rtc:1, t1:1, t0:1, ver:8;
 #else
-	unsigned int ver:8, t0:1, t1:1, pad1:6, rtsc:1, pad2:15;
+	unsigned int ver:8, t0:1, t1:1, rtc:1, pad1:5, rtsc:1, pad2:15;
 #endif
 };
 
@@ -282,6 +303,14 @@ struct bcr_bpu_arcompact {
 #endif
 };
 
+struct bcr_bpu_arcv2 {
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	unsigned int pad:6, fbe:2, tqe:2, ts:4, ft:1, rse:2, pte:3, bce:3, ver:8;
+#else
+	unsigned int ver:8, bce:3, pte:3, rse:2, ft:1, ts:4, tqe:2, fbe:2, pad:6;
+#endif
+};
+
 struct bcr_generic {
 #ifdef CONFIG_CPU_BIG_ENDIAN
 	unsigned int pad:24, ver:8;
@@ -333,6 +362,22 @@ struct cpuinfo_arc {
 
 extern struct cpuinfo_arc cpuinfo_arc700[];
 
+static inline int is_isa_arcv2(void)
+{
+	return IS_ENABLED(CONFIG_ISA_ARCV2);
+}
+
+static inline int is_isa_arcompact(void)
+{
+	return IS_ENABLED(CONFIG_ISA_ARCOMPACT);
+}
+
+#if defined(CONFIG_ISA_ARCOMPACT) && !defined(_CPU_DEFAULT_A7)
+#error "Toolchain not configured for ARCompact builds"
+#elif defined(CONFIG_ISA_ARCV2) && !defined(_CPU_DEFAULT_HS)
+#error "Toolchain not configured for ARCv2 builds"
+#endif
+
 #endif /* __ASEMBLY__ */
 
 #endif /* _ASM_ARC_ARCREGS_H */
diff --git a/arch/arc/include/asm/bitops.h b/arch/arc/include/asm/bitops.h
index 4051e9525939..829a8a2e9704 100644
--- a/arch/arc/include/asm/bitops.h
+++ b/arch/arc/include/asm/bitops.h
@@ -402,6 +402,8 @@ test_bit(unsigned int nr, const volatile unsigned long *addr)
 	return ((mask & *addr) != 0);
 }
 
+#ifdef CONFIG_ISA_ARCOMPACT
+
 /*
  * Count the number of zeros, starting from MSB
  * Helper for fls( ) friends
@@ -494,6 +496,75 @@ static inline __attribute__ ((const)) int __ffs(unsigned long word)
 	return ffs(word) - 1;
 }
 
+#else	/* CONFIG_ISA_ARCV2 */
+
+/*
+ * fls = Find Last Set in word
+ * @result: [1-32]
+ * fls(1) = 1, fls(0x80000000) = 32, fls(0) = 0
+ */
+static inline __attribute__ ((const)) int fls(unsigned long x)
+{
+	int n;
+
+	asm volatile(
+	"	fls.f	%0, %1		\n"  /* 0:31; 0(Z) if src 0 */
+	"	add.nz	%0, %0, 1	\n"  /* 0:31 -> 1:32 */
+	: "=r"(n)	/* Early clobber not needed */
+	: "r"(x)
+	: "cc");
+
+	return n;
+}
+
+/*
+ * __fls: Similar to fls, but zero based (0-31). Also 0 if no bit set
+ */
+static inline __attribute__ ((const)) int __fls(unsigned long x)
+{
+	/* FLS insn has exactly same semantics as the API */
+	return	__builtin_arc_fls(x);
+}
+
+/*
+ * ffs = Find First Set in word (LSB to MSB)
+ * @result: [1-32], 0 if all 0's
+ */
+static inline __attribute__ ((const)) int ffs(unsigned long x)
+{
+	int n;
+
+	asm volatile(
+	"	ffs.f	%0, %1		\n"  /* 0:31; 31(Z) if src 0 */
+	"	add.nz	%0, %0, 1	\n"  /* 0:31 -> 1:32 */
+	"	mov.z	%0, 0		\n"  /* 31(Z)-> 0 */
+	: "=r"(n)	/* Early clobber not needed */
+	: "r"(x)
+	: "cc");
+
+	return n;
+}
+
+/*
+ * __ffs: Similar to ffs, but zero based (0-31)
+ */
+static inline __attribute__ ((const)) int __ffs(unsigned long x)
+{
+	int n;
+
+	asm volatile(
+	"	ffs.f	%0, %1		\n"  /* 0:31; 31(Z) if src 0 */
+	"	mov.z	%0, 0		\n"  /* 31(Z)-> 0 */
+	: "=r"(n)
+	: "r"(x)
+	: "cc");
+
+	return n;
+
+}
+
+#endif	/* CONFIG_ISA_ARCOMPACT */
+
 /*
  * ffz = Find First Zero in word.
  * @return:[0-31], 32 if all 1's
diff --git a/arch/arc/include/asm/elf.h b/arch/arc/include/asm/elf.h
index a26282857683..51a99e25fe33 100644
--- a/arch/arc/include/asm/elf.h
+++ b/arch/arc/include/asm/elf.h
@@ -15,6 +15,11 @@
 /* These ELF defines belong to uapi but libc elf.h already defines them */
 #define EM_ARCOMPACT		93
 
+#define EM_ARCV2		195	/* ARCv2 Cores */
+
+#define EM_ARC_INUSE		(IS_ENABLED(CONFIG_ISA_ARCOMPACT) ? \
+					EM_ARCOMPACT : EM_ARCV2)
+
 /* ARC Relocations (kernel Modules only) */
 #define  R_ARC_32		0x4
 #define  R_ARC_32_ME		0x1B
diff --git a/arch/arc/include/asm/entry-arcv2.h b/arch/arc/include/asm/entry-arcv2.h
new file mode 100644
index 000000000000..b5ff87e6f4b7
--- /dev/null
+++ b/arch/arc/include/asm/entry-arcv2.h
@@ -0,0 +1,190 @@
+
+#ifndef __ASM_ARC_ENTRY_ARCV2_H
+#define __ASM_ARC_ENTRY_ARCV2_H
+
+#include <asm/asm-offsets.h>
+#include <asm/irqflags-arcv2.h>
+#include <asm/thread_info.h>	/* For THREAD_SIZE */
+
+/*------------------------------------------------------------------------*/
+.macro INTERRUPT_PROLOGUE	called_from
+
+	; Before jumping to Interrupt Vector, hardware micro-ops did following:
+	;   1. SP auto-switched to kernel mode stack
+	;   2. STATUS32.Z flag set to U mode at time of interrupt (U:1, K:0)
+	;   3. Auto saved: r0-r11, blink, LPE,LPS,LPC, JLI,LDI,EI, PC, STAT32
+	;
+	; Now manually save: r12, sp, fp, gp, r25
+
+	PUSH	r12
+
+	; Saving pt_regs->sp correctly requires some extra work due to the way
+	; Auto stack switch works
+	;  - U mode: retrieve it from AUX_USER_SP
+	;  - K mode: add the offset from current SP where H/w starts auto push
+	;
+	; Utilize the fact that Z bit is set if Intr taken in U mode
+	mov.nz	r9, sp
+	add.nz	r9, r9, SZ_PT_REGS - PT_sp - 4
+	bnz	1f
+
+	lr	r9, [AUX_USER_SP]
+1:
+	PUSH	r9	; SP
+
+	PUSH	fp
+	PUSH	gp
+
+#ifdef CONFIG_ARC_CURR_IN_REG
+	PUSH	r25			; user_r25
+	GET_CURR_TASK_ON_CPU	r25
+#else
+	sub	sp, sp, 4
+#endif
+
+.ifnc \called_from, exception
+	sub	sp, sp, 12	; BTA/ECR/orig_r0 placeholder per pt_regs
+.endif
+
+.endm
+
+/*------------------------------------------------------------------------*/
+.macro INTERRUPT_EPILOGUE	called_from
+
+.ifnc \called_from, exception
+	add	sp, sp, 12	; skip BTA/ECR/orig_r0 placeholderss
+.endif
+
+#ifdef CONFIG_ARC_CURR_IN_REG
+	POP	r25
+#else
+	add	sp, sp, 4
+#endif
+
+	POP	gp
+	POP	fp
+
+	; Don't touch AUX_USER_SP if returning to K mode (Z bit set)
+	; (Z bit set on K mode is inverse of INTERRUPT_PROLOGUE)
+	add.z	sp, sp, 4
+	bz	1f
+
+	POPAX	AUX_USER_SP
+1:
+	POP	r12
+
+.endm
+
+/*------------------------------------------------------------------------*/
+.macro EXCEPTION_PROLOGUE
+
+	; Before jumping to Exception Vector, hardware micro-ops did following:
+	;   1. SP auto-switched to kernel mode stack
+	;   2. STATUS32.Z flag set to U mode at time of interrupt (U:1,K:0)
+	;
+	; Now manually save the complete reg file
+
+	PUSH	r9		; freeup a register: slot of erstatus
+
+	PUSHAX	eret
+	sub	sp, sp, 12	; skip JLI, LDI, EI
+	PUSH	lp_count
+	PUSHAX	lp_start
+	PUSHAX	lp_end
+	PUSH	blink
+
+	PUSH	r11
+	PUSH	r10
+
+	ld.as	r9,  [sp, 10]	; load stashed r9 (status32 stack slot)
+	lr	r10, [erstatus]
+	st.as	r10, [sp, 10]	; save status32 at it's right stack slot
+
+	PUSH	r9
+	PUSH	r8
+	PUSH	r7
+	PUSH	r6
+	PUSH	r5
+	PUSH	r4
+	PUSH	r3
+	PUSH	r2
+	PUSH	r1
+	PUSH	r0
+
+	; -- for interrupts, regs above are auto-saved by h/w in that order --
+	; Now do what ISR prologue does (manually save r12, sp, fp, gp, r25)
+	;
+	; Set Z flag if this was from U mode (expected by INTERRUPT_PROLOGUE)
+	; Although H/w exception micro-ops do set Z flag for U mode (just like
+	; for interrupts), it could get clobbered in case we soft land here from
+	; a TLB Miss exception handler (tlbex.S)
+
+	and	r10, r10, STATUS_U_MASK
+	xor.f	0, r10, STATUS_U_MASK
+
+	INTERRUPT_PROLOGUE  exception
+
+	PUSHAX	erbta
+	PUSHAX	ecr		; r9 contains ECR, expected by EV_Trap
+
+	PUSH	r0		; orig_r0
+.endm
+
+/*------------------------------------------------------------------------*/
+.macro EXCEPTION_EPILOGUE
+
+	; Assumes r0 has PT_status32
+	btst   r0, STATUS_U_BIT	; Z flag set if K, used in INTERRUPT_EPILOGUE
+
+	add	sp, sp, 8	; orig_r0/ECR don't need restoring
+	POPAX	erbta
+
+	INTERRUPT_EPILOGUE  exception
+
+	POP	r0
+	POP	r1
+	POP	r2
+	POP	r3
+	POP	r4
+	POP	r5
+	POP	r6
+	POP	r7
+	POP	r8
+	POP	r9
+	POP	r10
+	POP	r11
+
+	POP	blink
+	POPAX	lp_end
+	POPAX	lp_start
+
+	POP	r9
+	mov	lp_count, r9
+
+	add	sp, sp, 12	; skip JLI, LDI, EI
+	POPAX	eret
+	POPAX	erstatus
+
+	ld.as	r9, [sp, -12]	; reload r9 which got clobbered
+.endm
+
+.macro FAKE_RET_FROM_EXCPN
+	lr      r9, [status32]
+	bic     r9, r9, (STATUS_U_MASK|STATUS_DE_MASK|STATUS_AE_MASK)
+	or      r9, r9, (STATUS_L_MASK|STATUS_IE_MASK)
+	kflag   r9
+.endm
+
+/* Get thread_info of "current" tsk */
+.macro GET_CURR_THR_INFO_FROM_SP  reg
+	bmskn \reg, sp, THREAD_SHIFT - 1
+.endm
+
+/* Get CPU-ID of this core */
+.macro  GET_CPU_ID  reg
+	lr  \reg, [identity]
+	xbfu \reg, \reg, 0xE8	/* 00111    01000 */
+				/* M = 8-1  N = 8 */
+.endm
+
+#endif
diff --git a/arch/arc/include/asm/entry.h b/arch/arc/include/asm/entry.h
index f61032c53d51..29d0ab6e10f5 100644
--- a/arch/arc/include/asm/entry.h
+++ b/arch/arc/include/asm/entry.h
@@ -16,7 +16,11 @@
 #include <asm/processor.h>	/* For VMALLOC_START */
 #include <asm/mmu.h>
 
+#ifdef CONFIG_ISA_ARCOMPACT
 #include <asm/entry-compact.h>	/* ISA specific bits */
+#else
+#include <asm/entry-arcv2.h>
+#endif
 
 /* Note on the LD/ST addr modes with addr reg wback
  *
diff --git a/arch/arc/include/asm/irq.h b/arch/arc/include/asm/irq.h
index f38652fb2ed7..49014f0ef36d 100644
--- a/arch/arc/include/asm/irq.h
+++ b/arch/arc/include/asm/irq.h
@@ -13,8 +13,13 @@
 #define NR_IRQS		128 /* allow some CPU external IRQ handling */
 
 /* Platform Independent IRQs */
+#ifdef CONFIG_ISA_ARCOMPACT
 #define TIMER0_IRQ      3
 #define TIMER1_IRQ      4
+#else
+#define TIMER0_IRQ      16
+#define TIMER1_IRQ      17
+#endif
 
 #include <linux/interrupt.h>
 #include <asm-generic/irq.h>
diff --git a/arch/arc/include/asm/irqflags-arcv2.h b/arch/arc/include/asm/irqflags-arcv2.h
index c946c56f141c..1eb41b00aac5 100644
--- a/arch/arc/include/asm/irqflags-arcv2.h
+++ b/arch/arc/include/asm/irqflags-arcv2.h
@@ -27,6 +27,9 @@
 #define AUX_IRQ_SELECT		0x40b
 #define AUX_IRQ_ENABLE		0x40c
 
+/* Was Intr taken in User Mode */
+#define AUX_IRQ_ACT_BIT_U	31
+
 /* 0 is highest level, but taken by FIRQs, if present in design */
 #define ARCV2_IRQ_DEF_PRIO		0
 
diff --git a/arch/arc/include/asm/irqflags-compact.h b/arch/arc/include/asm/irqflags-compact.h
index 18f3634ac347..aa805575c320 100644
--- a/arch/arc/include/asm/irqflags-compact.h
+++ b/arch/arc/include/asm/irqflags-compact.h
@@ -39,6 +39,8 @@
 #define AUX_ITRIGGER		0x40d
 #define AUX_IPULSE		0x415
 
+#define ISA_INIT_STATUS_BITS	STATUS_IE_MASK
+
 #ifndef __ASSEMBLY__
 
 /******************************************************************
diff --git a/arch/arc/include/asm/irqflags.h b/arch/arc/include/asm/irqflags.h
index 333972600680..59bc6a64f75d 100644
--- a/arch/arc/include/asm/irqflags.h
+++ b/arch/arc/include/asm/irqflags.h
@@ -10,6 +10,10 @@
 #ifndef __ASM_ARC_IRQFLAGS_H
 #define __ASM_ARC_IRQFLAGS_H
 
+#ifdef CONFIG_ISA_ARCOMPACT
 #include <asm/irqflags-compact.h>
+#else
+#include <asm/irqflags-arcv2.h>
+#endif
 
 #endif
diff --git a/arch/arc/include/asm/ptrace.h b/arch/arc/include/asm/ptrace.h
index 1bfeec2c0558..91755972b9a2 100644
--- a/arch/arc/include/asm/ptrace.h
+++ b/arch/arc/include/asm/ptrace.h
@@ -16,6 +16,7 @@
 
 /* THE pt_regs: Defines how regs are saved during entry into kernel */
 
+#ifdef CONFIG_ISA_ARCOMPACT
 struct pt_regs {
 
 	/* Real registers */
@@ -56,6 +57,48 @@ struct pt_regs {
 
 	long user_r25;
 };
+#else
+
+struct pt_regs {
+
+	long orig_r0;
+
+	union {
+		struct {
+#ifdef CONFIG_CPU_BIG_ENDIAN
+			unsigned long state:8, ecr_vec:8,
+				      ecr_cause:8, ecr_param:8;
+#else
+			unsigned long ecr_param:8, ecr_cause:8,
+				      ecr_vec:8, state:8;
+#endif
+		};
+		unsigned long event;
+	};
+
+	long bta;	/* bta_l1, bta_l2, erbta */
+
+	long user_r25;
+
+	long r26;	/* gp */
+	long fp;
+	long sp;	/* user/kernel sp depending on where we came from  */
+
+	long r12;
+
+	/*------- Below list auto saved by h/w -----------*/
+	long r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11;
+
+	long blink;
+	long lp_end, lp_start, lp_count;
+
+	long ei, ldi, jli;
+
+	long ret;
+	long status32;
+};
+
+#endif
 
 /* Callee saved registers - need to be saved only when you are scheduled out */
 
diff --git a/arch/arc/include/asm/thread_info.h b/arch/arc/include/asm/thread_info.h
index aca0d5a45c7b..3af67455659a 100644
--- a/arch/arc/include/asm/thread_info.h
+++ b/arch/arc/include/asm/thread_info.h
@@ -25,6 +25,7 @@
 #endif
 
 #define THREAD_SIZE     (PAGE_SIZE << THREAD_SIZE_ORDER)
+#define THREAD_SHIFT	(PAGE_SHIFT << THREAD_SIZE_ORDER)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arc/kernel/Makefile b/arch/arc/kernel/Makefile
index cc929c0e2133..0be7ba087260 100644
--- a/arch/arc/kernel/Makefile
+++ b/arch/arc/kernel/Makefile
@@ -10,7 +10,8 @@ CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
 
 obj-y	:= arcksyms.o setup.o irq.o time.o reset.o ptrace.o process.o devtree.o
 obj-y	+= signal.o traps.o sys.o troubleshoot.o stacktrace.o disasm.o clk.o
-obj-y	+= entry-compact.o intc-compact.o
+obj-$(CONFIG_ISA_ARCOMPACT)		+= entry-compact.o intc-compact.o
+obj-$(CONFIG_ISA_ARCV2)			+= entry-arcv2.o intc-arcv2.o
 
 obj-$(CONFIG_MODULES)			+= arcksyms.o module.o
 obj-$(CONFIG_SMP) 			+= smp.o
diff --git a/arch/arc/kernel/entry-arcv2.S b/arch/arc/kernel/entry-arcv2.S
new file mode 100644
index 000000000000..c59a396b7b98
--- /dev/null
+++ b/arch/arc/kernel/entry-arcv2.S
@@ -0,0 +1,189 @@
+/*
+ * ARCv2 ISA based core Low Level Intr/Traps/Exceptions(non-TLB) Handling
+ *
+ * Copyright (C) 2013 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>   /* ARC_{EXTRY,EXIT} */
+#include <asm/entry.h>       /* SAVE_ALL_{INT1,INT2,TRAP...} */
+#include <asm/errno.h>
+#include <asm/arcregs.h>
+#include <asm/irqflags.h>
+
+	.cpu HS
+
+#define VECTOR	.word
+
+;############################ Vector Table #################################
+
+	.section .vector,"a",@progbits
+	.align 4
+
+# Initial 16 slots are Exception Vectors
+VECTOR	stext			; Restart Vector (jump to entry point)
+VECTOR	mem_service		; Mem exception
+VECTOR	instr_service		; Instrn Error
+VECTOR	EV_MachineCheck		; Fatal Machine check
+VECTOR	EV_TLBMissI		; Intruction TLB miss
+VECTOR	EV_TLBMissD		; Data TLB miss
+VECTOR	EV_TLBProtV		; Protection Violation
+VECTOR	EV_PrivilegeV		; Privilege Violation
+VECTOR	EV_SWI			; Software Breakpoint
+VECTOR	EV_Trap			; Trap exception
+VECTOR	EV_Extension		; Extn Instruction Exception
+VECTOR	EV_DivZero		; Divide by Zero
+VECTOR	EV_DCError		; Data Cache Error
+VECTOR	EV_Misaligned		; Misaligned Data Access
+VECTOR	reserved		; Reserved slots
+VECTOR	reserved		; Reserved slots
+
+# Begin Interrupt Vectors
+VECTOR	handle_interrupt	; (16) Timer0
+VECTOR	handle_interrupt	; unused (Timer1)
+VECTOR	handle_interrupt	; unused (WDT)
+VECTOR	handle_interrupt	; (19) ICI (inter core interrupt)
+VECTOR	handle_interrupt
+VECTOR	handle_interrupt
+VECTOR	handle_interrupt
+VECTOR	handle_interrupt	; (23) End of fixed IRQs
+
+.rept CONFIG_ARC_NUMBER_OF_INTERRUPTS - 8
+	VECTOR	handle_interrupt
+.endr
+
+	.section .text, "ax",@progbits
+
+res_service:		; processor restart
+	flag    0x1     ; not implemented
+	nop
+	nop
+
+reserved:		; processor restart
+	rtie            ; jump to processor initializations
+
+;##################### Interrupt Handling ##############################
+
+ENTRY(handle_interrupt)
+
+	INTERRUPT_PROLOGUE  irq
+
+	clri		; To make status32.IE agree with CPU internal state
+
+	lr  r0, [ICAUSE]
+
+	mov   blink, ret_from_exception
+
+	b.d  arch_do_IRQ
+	mov r1, sp
+
+END(handle_interrupt)
+
+;################### Non TLB Exception Handling #############################
+
+ENTRY(EV_SWI)
+	flag 1
+END(EV_SWI)
+
+ENTRY(EV_DivZero)
+	flag 1
+END(EV_DivZero)
+
+ENTRY(EV_DCError)
+	flag 1
+END(EV_DCError)
+
+ENTRY(EV_Misaligned)
+
+	EXCEPTION_PROLOGUE
+
+	lr  r0, [efa]	; Faulting Data address
+	mov r1, sp
+
+	FAKE_RET_FROM_EXCPN
+
+	SAVE_CALLEE_SAVED_USER
+	mov r2, sp              ; callee_regs
+
+	bl  do_misaligned_access
+
+	; TBD: optimize - do this only if a callee reg was involved
+	; either a dst of emulated LD/ST or src with address-writeback
+	RESTORE_CALLEE_SAVED_USER
+
+	b   ret_from_exception
+END(EV_Misaligned)
+
+; ---------------------------------------------
+; Protection Violation Exception Handler
+; ---------------------------------------------
+
+ENTRY(EV_TLBProtV)
+
+	EXCEPTION_PROLOGUE
+
+	lr  r0, [efa]	; Faulting Data address
+	mov r1, sp	; pt_regs
+
+	FAKE_RET_FROM_EXCPN
+
+	mov blink, ret_from_exception
+	b   do_page_fault
+
+END(EV_TLBProtV)
+
+; From Linux standpoint Slow Path I/D TLB Miss is same a ProtV as they
+; need to call do_page_fault().
+; ECR in pt_regs provides whether access was R/W/X
+
+.global        call_do_page_fault
+.set call_do_page_fault, EV_TLBProtV
+
+;############# Common Handlers for ARCompact and ARCv2 ##############
+
+#include "entry.S"
+
+;############# Return from Intr/Excp/Trap (ARCv2 ISA Specifics) ##############
+;
+; Restore the saved sys context (common exit-path for EXCPN/IRQ/Trap)
+; IRQ shd definitely not happen between now and rtie
+; All 2 entry points to here already disable interrupts
+
+.Lrestore_regs:
+
+	ld	r0, [sp, PT_status32]	; U/K mode at time of entry
+	lr	r10, [AUX_IRQ_ACT]
+
+	bmsk	r11, r10, 15	; AUX_IRQ_ACT.ACTIVE
+	breq	r11, 0, .Lexcept_ret	; No intr active, ret from Exception
+
+;####### Return from Intr #######
+
+debug_marker_l1:
+	; Handle special case #1: (Entry via Exception, Return via IRQ)
+	;
+	; Exception in U mode, preempted in kernel, Intr taken (K mode), orig
+	; task now returning to U mode (riding the Intr)
+	; AUX_IRQ_ACTIVE won't have U bit set (since intr in K mode), hence SP
+	; won't be switched to correct U mode value (from AUX_SP)
+	; So force AUX_IRQ_ACT.U for such a case
+
+	btst	r0, STATUS_U_BIT		; Z flag set if K (Z clear for U)
+	bset.nz	r11, r11, AUX_IRQ_ACT_BIT_U	; NZ means U
+	sr	r11, [AUX_IRQ_ACT]
+
+	INTERRUPT_EPILOGUE  irq
+	rtie
+
+;####### Return from Exception / pure kernel mode #######
+
+.Lexcept_ret:	; Expects r0 has PT_status32
+
+debug_marker_syscall:
+	EXCEPTION_EPILOGUE
+	rtie
+
+END(ret_from_exception)
diff --git a/arch/arc/kernel/head.S b/arch/arc/kernel/head.S
index 64a92e0b1e53..812f95e6ae69 100644
--- a/arch/arc/kernel/head.S
+++ b/arch/arc/kernel/head.S
@@ -49,8 +49,6 @@
 1:
 .endm
 
-	.cpu A7
-
 	.section .init.text, "ax",@progbits
 	.type stext, @function
 	.globl stext
diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index b5426babd3c8..6abe5e7cac8f 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -44,7 +44,10 @@ SYSCALL_DEFINE0(arc_gettls)
 void arch_cpu_idle(void)
 {
 	/* sleep, but enable all interrupts before committing */
-	__asm__("sleep 0x3");
+	if (is_isa_arcompact())
+		__asm__("sleep 0x3");
+	else
+		__asm__("sleep 0x10");
 }
 
 asmlinkage void ret_from_fork(void);
@@ -166,7 +169,7 @@ void start_thread(struct pt_regs * regs, unsigned long pc, unsigned long usp)
 	 * [L] ZOL loop inhibited to begin with - cleared by a LP insn
 	 * Interrupts enabled
 	 */
-	regs->status32 = STATUS_U_MASK | STATUS_L_MASK | STATUS_IE_MASK;
+	regs->status32 = STATUS_U_MASK | STATUS_L_MASK | ISA_INIT_STATUS_BITS;
 
 	/* bogus seed values for debugging */
 	regs->lp_start = 0x10;
@@ -196,8 +199,11 @@ int elf_check_arch(const struct elf32_hdr *x)
 {
 	unsigned int eflags;
 
-	if (x->e_machine != EM_ARCOMPACT)
+	if (x->e_machine != EM_ARC_INUSE) {
+		pr_err("ELF not built for %s ISA\n",
+			is_isa_arcompact() ? "ARCompact":"ARCv2");
 		return 0;
+	}
 
 	eflags = x->e_flags;
 	if ((eflags & EF_ARC_OSABI_MSK) < EF_ARC_OSABI_CURRENT) {
diff --git a/arch/arc/kernel/ptrace.c b/arch/arc/kernel/ptrace.c
index 4dd9e3a8c2da..4442204fe238 100644
--- a/arch/arc/kernel/ptrace.c
+++ b/arch/arc/kernel/ptrace.c
@@ -200,7 +200,7 @@ static const struct user_regset arc_regsets[] = {
 
 static const struct user_regset_view user_arc_view = {
 	.name		= UTS_MACHINE,
-	.e_machine	= EM_ARCOMPACT,
+	.e_machine	= EM_ARC_INUSE,
 	.regsets	= arc_regsets,
 	.n		= ARRAY_SIZE(arc_regsets)
 };
diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index 96d44805ea56..d6fe80070bbf 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -96,7 +96,7 @@ static void read_arc_build_cfg_regs(void)
 	read_decode_mmu_bcr();
 	read_decode_cache_bcr();
 
-	{
+	if (is_isa_arcompact()) {
 		struct bcr_fp_arcompact sp, dp;
 		struct bcr_bpu_arcompact bpu;
 
@@ -112,6 +112,19 @@ static void read_arc_build_cfg_regs(void)
 			cpu->bpu.num_cache = 256 << (bpu.ent - 1);
 			cpu->bpu.num_pred = 256 << (bpu.ent - 1);
 		}
+	} else {
+		struct bcr_fp_arcv2 spdp;
+		struct bcr_bpu_arcv2 bpu;
+
+		READ_BCR(ARC_REG_FP_V2_BCR, spdp);
+		cpu->extn.fpu_sp = spdp.sp ? 1 : 0;
+		cpu->extn.fpu_dp = spdp.dp ? 1 : 0;
+
+		READ_BCR(ARC_REG_BPU_BCR, bpu);
+		cpu->bpu.ver = bpu.ver;
+		cpu->bpu.full = bpu.ft;
+		cpu->bpu.num_cache = 256 << bpu.bce;
+		cpu->bpu.num_pred = 2048 << bpu.pte;
 	}
 
 	READ_BCR(ARC_REG_AP_BCR, bcr);
@@ -131,6 +144,7 @@ static const struct cpuinfo_data arc_cpu_tbl[] = {
 	{ {0x30, "ARC 700"      }, 0x33},
 	{ {0x34, "ARC 700 R4.10"}, 0x34},
 	{ {0x35, "ARC 700 R4.11"}, 0x35},
+	{ {0x50, "ARC HS38"	}, 0x51},
 	{ {0x00, NULL		} }
 };
 
@@ -149,13 +163,17 @@ static char *arc_cpu_mumbojumbo(int cpu_id, char *buf, int len)
 
 	FIX_PTR(cpu);
 
-	{
+	if (is_isa_arcompact()) {
 		isa_nm = "ARCompact";
 		be = IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
 
 		atomic = cpu->isa.atomic1;
 		if (!cpu->isa.ver)	/* ISA BCR absent, use Kconfig info */
 			atomic = IS_ENABLED(CONFIG_ARC_HAS_LLSC);
+	} else {
+		isa_nm = "ARCv2";
+		be = cpu->isa.be;
+		atomic = cpu->isa.atomic;
 	}
 
 	n += scnprintf(buf + n, len - n,
@@ -184,14 +202,31 @@ static char *arc_cpu_mumbojumbo(int cpu_id, char *buf, int len)
 		       IS_AVAIL1(cpu->timers.t0, "Timer0 "),
 		       IS_AVAIL1(cpu->timers.t1, "Timer1 "));
 
-	n += i = scnprintf(buf + n, len - n, "%s%s",
-			   IS_AVAIL2(atomic, "atomic ", CONFIG_ARC_HAS_LLSC));
+	n += i = scnprintf(buf + n, len - n, "%s%s%s%s%s",
+			   IS_AVAIL2(atomic, "atomic ", CONFIG_ARC_HAS_LLSC),
+			   IS_AVAIL2(cpu->isa.ldd, "ll64 ", CONFIG_ARC_HAS_LL64),
+			   IS_AVAIL1(cpu->isa.unalign, "unalign (not used)"));
 
 	if (i)
 		n += scnprintf(buf + n, len - n, "\n\t\t: ");
 
+	if (cpu->extn_mpy.ver) {
+		if (cpu->extn_mpy.ver <= 0x2) {	/* ARCompact */
+			n += scnprintf(buf + n, len - n, "mpy ");
+		} else {
+			int opt = 2;	/* stock MPY/MPYH */
+
+			if (cpu->extn_mpy.dsp)	/* OPT 7-9 */
+				opt = cpu->extn_mpy.dsp + 6;
+
+			n += scnprintf(buf + n, len - n, "mpy[opt %d] ", opt);
+		}
+		n += scnprintf(buf + n, len - n, "%s",
+			       IS_USED(CONFIG_ARC_HAS_HW_MPY));
+	}
+
 	n += scnprintf(buf + n, len - n, "%s%s%s%s%s%s%s%s\n",
-		       IS_AVAIL1(cpu->extn_mpy.ver, "mpy "),
+		       IS_AVAIL1(cpu->isa.div_rem, "div_rem "),
 		       IS_AVAIL1(cpu->extn.norm, "norm "),
 		       IS_AVAIL1(cpu->extn.barrel, "barrel-shift "),
 		       IS_AVAIL1(cpu->extn.swap, "swap "),
diff --git a/arch/arc/kernel/signal.c b/arch/arc/kernel/signal.c
index b15d2fe9c461..004b7f0bc76c 100644
--- a/arch/arc/kernel/signal.c
+++ b/arch/arc/kernel/signal.c
@@ -336,7 +336,7 @@ static void arc_restart_syscall(struct k_sigaction *ka, struct pt_regs *regs)
 		 * their orig user space value when we ret from kernel
 		 */
 		regs->r0 = regs->orig_r0;
-		regs->ret -= 4;
+		regs->ret -= is_isa_arcv2() ? 2 : 4;
 		break;
 	}
 }
@@ -377,10 +377,10 @@ void do_signal(struct pt_regs *regs)
 		if (regs->r0 == -ERESTARTNOHAND ||
 		    regs->r0 == -ERESTARTSYS || regs->r0 == -ERESTARTNOINTR) {
 			regs->r0 = regs->orig_r0;
-			regs->ret -= 4;
+			regs->ret -= is_isa_arcv2() ? 2 : 4;
 		} else if (regs->r0 == -ERESTART_RESTARTBLOCK) {
 			regs->r8 = __NR_restart_syscall;
-			regs->ret -= 4;
+			regs->ret -= is_isa_arcv2() ? 2 : 4;
 		}
 		syscall_wont_restart(regs);	/* No more restarts */
 	}
diff --git a/arch/arc/kernel/troubleshoot.c b/arch/arc/kernel/troubleshoot.c
index e00a01879025..e0cf99893212 100644
--- a/arch/arc/kernel/troubleshoot.c
+++ b/arch/arc/kernel/troubleshoot.c
@@ -14,6 +14,7 @@
 #include <linux/proc_fs.h>
 #include <linux/file.h>
 #include <asm/arcregs.h>
+#include <asm/irqflags.h>
 
 /*
  * Common routine to print scratch regs (r0-r12) or callee regs (r13-r25)
@@ -34,7 +35,10 @@ static noinline void print_reg_file(long *reg_rev, int start_num)
 			n += scnprintf(buf + n, len - n, "\n");
 
 		/* because pt_regs has regs reversed: r12..r0, r25..r13 */
-		reg_rev--;
+		if (is_isa_arcv2() && start_num == 0)
+			reg_rev++;
+		else
+			reg_rev--;
 	}
 
 	if (start_num != 0)
@@ -152,6 +156,15 @@ static void show_ecr_verbose(struct pt_regs *regs)
 				((cause_code == 0x02) ? "Write" : "EX"));
 	} else if (vec == ECR_V_INSN_ERR) {
 		pr_cont("Illegal Insn\n");
+#ifdef CONFIG_ISA_ARCV2
+	} else if (vec == ECR_V_MEM_ERR) {
+		if (cause_code == 0x00)
+			pr_cont("Bus Error from Insn Mem\n");
+		else if (cause_code == 0x10)
+			pr_cont("Bus Error from Data Mem\n");
+		else
+			pr_cont("Bus Error, check PRM\n");
+#endif
 	} else {
 		pr_cont("Check Programmer's Manual\n");
 	}
@@ -185,12 +198,20 @@ void show_regs(struct pt_regs *regs)
 
 	pr_info("[STAT32]: 0x%08lx", regs->status32);
 
-#define STS_BIT(r, bit)	r->status32 & STATUS_##bit##_MASK ? #bit : ""
-	if (!user_mode(regs))
-		pr_cont(" : %2s %2s %2s %2s %2s\n",
-			STS_BIT(regs, AE), STS_BIT(regs, A2), STS_BIT(regs, A1),
-			STS_BIT(regs, E2), STS_BIT(regs, E1));
+#define STS_BIT(r, bit)	r->status32 & STATUS_##bit##_MASK ? #bit" " : ""
 
+#ifdef CONFIG_ISA_ARCOMPACT
+	pr_cont(" : %2s%2s%2s%2s%2s%2s%2s\n",
+			(regs->status32 & STATUS_U_MASK) ? "U " : "K ",
+			STS_BIT(regs, DE), STS_BIT(regs, AE),
+			STS_BIT(regs, A2), STS_BIT(regs, A1),
+			STS_BIT(regs, E2), STS_BIT(regs, E1));
+#else
+	pr_cont(" : %2s%2s%2s%2s\n",
+			STS_BIT(regs, IE),
+			(regs->status32 & STATUS_U_MASK) ? "U " : "K ",
+			STS_BIT(regs, DE), STS_BIT(regs, AE));
+#endif
 	pr_info("BTA: 0x%08lx\t SP: 0x%08lx\t FP: 0x%08lx\n",
 		regs->bta, regs->sp, regs->fp);
 	pr_info("LPS: 0x%08lx\tLPE: 0x%08lx\tLPC: 0x%08lx\n",
diff --git a/arch/arc/mm/tlbex.S b/arch/arc/mm/tlbex.S
index d224bf0feefc..00c8d7f772bc 100644
--- a/arch/arc/mm/tlbex.S
+++ b/arch/arc/mm/tlbex.S
@@ -35,8 +35,6 @@
  * Rahul Trivedi, Amit Bhor: Codito Technologies 2004
  */
 
-	.cpu A7
-
 #include <linux/linkage.h>
 #include <asm/entry.h>
 #include <asm/mmu.h>
-- 
1.9.1
