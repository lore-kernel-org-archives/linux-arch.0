From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 16/24] sparc: Remove signal translation and exec_domain
Date: Sat, 11 Apr 2015 22:47:55 +0200
Message-ID: <1428785283-20501-17-git-send-email-richard@nod.at>
References: <1428785283-20501-1-git-send-email-richard@nod.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428785283-20501-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com, linux@arm.linux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, monstr@monstr.eu, ralf@linux-mips.org, yasutake.koichi@jp.panasonic.com, lftan@altera.com, jonas@southpole.se, jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, liqin.linux@gmail.com, lennox.wu@gmail.com, davem@davemloft.net, cmetcalf@ezchip.com, jdike@addtoit.com, akpm@linux-foundation.org, oleg@redhat.com, hch@inf
List-Id: linux-arch.vger.kernel.org

As execution domain support is gone we can remove
signal translation from the signal code and remove
exec_domain from thread_info.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/sparc/include/asm/thread_info_32.h | 27 ++++++++++++---------------
 arch/sparc/include/asm/thread_info_64.h | 26 +++++++++++---------------
 arch/sparc/kernel/traps_32.c            |  1 -
 arch/sparc/kernel/traps_64.c            |  2 --
 4 files changed, 23 insertions(+), 33 deletions(-)

diff --git a/arch/sparc/include/asm/thread_info_32.h b/arch/sparc/include/asm/thread_info_32.h
index fd7bd0a..a7a1814 100644
--- a/arch/sparc/include/asm/thread_info_32.h
+++ b/arch/sparc/include/asm/thread_info_32.h
@@ -27,7 +27,6 @@
 struct thread_info {
 	unsigned long		uwinmask;
 	struct task_struct	*task;		/* main task structure */
-	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
 	int			cpu;		/* cpu we're on */
 	int			preempt_count;	/* 0 => preemptable,
@@ -56,7 +55,6 @@ struct thread_info {
 {							\
 	.uwinmask	=	0,			\
 	.task		=	&tsk,			\
-	.exec_domain	=	&default_exec_domain,	\
 	.flags		=	0,			\
 	.cpu		=	0,			\
 	.preempt_count	=	INIT_PREEMPT_COUNT,	\
@@ -85,19 +83,18 @@ register struct thread_info *current_thread_info_reg asm("g6");
  */
 #define TI_UWINMASK	0x00	/* uwinmask */
 #define TI_TASK		0x04
-#define TI_EXECDOMAIN	0x08	/* exec_domain */
-#define TI_FLAGS	0x0c
-#define TI_CPU		0x10
-#define TI_PREEMPT	0x14	/* preempt_count */
-#define TI_SOFTIRQ	0x18	/* softirq_count */
-#define TI_HARDIRQ	0x1c	/* hardirq_count */
-#define TI_KSP		0x20	/* ksp */
-#define TI_KPC		0x24	/* kpc (ldd'ed with kpc) */
-#define TI_KPSR		0x28	/* kpsr */
-#define TI_KWIM		0x2c	/* kwim (ldd'ed with kpsr) */
-#define TI_REG_WINDOW	0x30
-#define TI_RWIN_SPTRS	0x230
-#define TI_W_SAVED	0x250
+#define TI_FLAGS	0x08
+#define TI_CPU		0x0c
+#define TI_PREEMPT	0x10	/* preempt_count */
+#define TI_SOFTIRQ	0x14	/* softirq_count */
+#define TI_HARDIRQ	0x18	/* hardirq_count */
+#define TI_KSP		0x1c	/* ksp */
+#define TI_KPC		0x20	/* kpc (ldd'ed with kpc) */
+#define TI_KPSR		0x24	/* kpsr */
+#define TI_KWIM		0x28	/* kwim (ldd'ed with kpsr) */
+#define TI_REG_WINDOW	0x2c
+#define TI_RWIN_SPTRS	0x22c
+#define TI_W_SAVED	0x24c
 
 /*
  * thread information flag bit numbers
diff --git a/arch/sparc/include/asm/thread_info_64.h b/arch/sparc/include/asm/thread_info_64.h
index ff45516..bde5982 100644
--- a/arch/sparc/include/asm/thread_info_64.h
+++ b/arch/sparc/include/asm/thread_info_64.h
@@ -31,7 +31,6 @@
 #include <asm/types.h>
 
 struct task_struct;
-struct exec_domain;
 
 struct thread_info {
 	/* D$ line 1 */
@@ -44,7 +43,6 @@ struct thread_info {
 	/* D$ line 2 */
 	unsigned long		fault_address;
 	struct pt_regs		*kregs;
-	struct exec_domain	*exec_domain;
 	int			preempt_count;	/* 0 => preemptable, <0 => BUG */
 	__u8			new_child;
 	__u8			current_ds;
@@ -80,18 +78,17 @@ struct thread_info {
 #define TI_KSP		0x00000018
 #define TI_FAULT_ADDR	0x00000020
 #define TI_KREGS	0x00000028
-#define TI_EXEC_DOMAIN	0x00000030
-#define TI_PRE_COUNT	0x00000038
-#define TI_NEW_CHILD	0x0000003c
-#define TI_CURRENT_DS	0x0000003d
-#define TI_CPU		0x0000003e
-#define TI_UTRAPS	0x00000040
-#define TI_REG_WINDOW	0x00000048
-#define TI_RWIN_SPTRS	0x000003c8
-#define TI_GSR		0x00000400
-#define TI_XFSR		0x00000438
-#define TI_KUNA_REGS	0x00000470
-#define TI_KUNA_INSN	0x00000478
+#define TI_PRE_COUNT	0x00000030
+#define TI_NEW_CHILD	0x00000034
+#define TI_CURRENT_DS	0x00000035
+#define TI_CPU		0x00000036
+#define TI_UTRAPS	0x00000038
+#define TI_REG_WINDOW	0x00000040
+#define TI_RWIN_SPTRS	0x000003c0
+#define TI_GSR		0x000003f8
+#define TI_XFSR		0x00000430
+#define TI_KUNA_REGS	0x00000468
+#define TI_KUNA_INSN	0x00000470
 #define TI_FPREGS	0x00000480
 
 /* We embed this in the uppermost byte of thread_info->flags */
@@ -119,7 +116,6 @@ struct thread_info {
 {							\
 	.task		=	&tsk,			\
 	.current_ds	=	ASI_P,			\
-	.exec_domain	=	&default_exec_domain,	\
 	.preempt_count	=	INIT_PREEMPT_COUNT,	\
 }
 
diff --git a/arch/sparc/kernel/traps_32.c b/arch/sparc/kernel/traps_32.c
index 6fd386c..4f21df7 100644
--- a/arch/sparc/kernel/traps_32.c
+++ b/arch/sparc/kernel/traps_32.c
@@ -433,7 +433,6 @@ void trap_init(void)
 	/* Force linker to barf if mismatched */
 	if (TI_UWINMASK    != offsetof(struct thread_info, uwinmask) ||
 	    TI_TASK        != offsetof(struct thread_info, task) ||
-	    TI_EXECDOMAIN  != offsetof(struct thread_info, exec_domain) ||
 	    TI_FLAGS       != offsetof(struct thread_info, flags) ||
 	    TI_CPU         != offsetof(struct thread_info, cpu) ||
 	    TI_PREEMPT     != offsetof(struct thread_info, preempt_count) ||
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 0e69974..d21cd62 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -2691,8 +2691,6 @@ void __init trap_init(void)
 					       fault_address) ||
 		     TI_KREGS != offsetof(struct thread_info, kregs) ||
 		     TI_UTRAPS != offsetof(struct thread_info, utraps) ||
-		     TI_EXEC_DOMAIN != offsetof(struct thread_info,
-						exec_domain) ||
 		     TI_REG_WINDOW != offsetof(struct thread_info,
 					       reg_window) ||
 		     TI_RWIN_SPTRS != offsetof(struct thread_info,
-- 
1.8.4.5
