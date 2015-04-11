From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 23/24] arch: Remove exec_domain from remaining archs
Date: Sat, 11 Apr 2015 22:48:02 +0200
Message-ID: <1428785283-20501-24-git-send-email-richard@nod.at>
References: <1428785283-20501-1-git-send-email-richard@nod.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428785283-20501-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com, linux@arm.linux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, monstr@monstr.eu, ralf@linux-mips.org, yasutake.koichi@jp.panasonic.com, lftan@altera.com, jonas@southpole.se, jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, liqin.linux@gmail.com, lennox.wu@gmail.com, davem@davemloft.net, cmetcalf@ezchip.com, jdike@addtoit.com, akpm@linux-foundation.org, oleg@redhat.com, hch@inf
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/alpha/include/asm/thread_info.h    | 2 --
 arch/avr32/include/asm/thread_info.h    | 3 ---
 arch/avr32/kernel/asm-offsets.c         | 1 -
 arch/c6x/include/asm/thread_info.h      | 2 --
 arch/cris/arch-v10/kernel/signal.c      | 2 --
 arch/cris/arch-v32/kernel/signal.c      | 2 --
 arch/cris/include/asm/thread_info.h     | 2 --
 arch/hexagon/include/asm/thread_info.h  | 2 --
 arch/ia64/include/asm/thread_info.h     | 2 --
 arch/metag/include/asm/thread_info.h    | 2 --
 arch/metag/kernel/irq.c                 | 2 --
 arch/mips/include/asm/thread_info.h     | 2 --
 arch/mips/kernel/asm-offsets.c          | 1 -
 arch/nios2/include/asm/thread_info.h    | 2 --
 arch/openrisc/include/asm/thread_info.h | 2 --
 arch/openrisc/kernel/signal.c           | 2 --
 arch/parisc/include/asm/thread_info.h   | 2 --
 arch/parisc/kernel/asm-offsets.c        | 1 -
 arch/powerpc/include/asm/thread_info.h  | 2 --
 arch/score/include/asm/thread_info.h    | 2 --
 arch/score/kernel/asm-offsets.c         | 1 -
 21 files changed, 39 deletions(-)

diff --git a/arch/alpha/include/asm/thread_info.h b/arch/alpha/include/asm/thread_info.h
index d5b98ab..32e920a 100644
--- a/arch/alpha/include/asm/thread_info.h
+++ b/arch/alpha/include/asm/thread_info.h
@@ -18,7 +18,6 @@ struct thread_info {
 	unsigned int		flags;		/* low level flags */
 	unsigned int		ieee_state;	/* see fpu.h */
 
-	struct exec_domain	*exec_domain;	/* execution domain */
 	mm_segment_t		addr_limit;	/* thread address space */
 	unsigned		cpu;		/* current CPU */
 	int			preempt_count; /* 0 => preemptable, <0 => BUG */
@@ -35,7 +34,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)			\
 {						\
 	.task		= &tsk,			\
-	.exec_domain	= &default_exec_domain,	\
 	.addr_limit	= KERNEL_DS,		\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
 }
diff --git a/arch/avr32/include/asm/thread_info.h b/arch/avr32/include/asm/thread_info.h
index d56afa9..d4d3079 100644
--- a/arch/avr32/include/asm/thread_info.h
+++ b/arch/avr32/include/asm/thread_info.h
@@ -17,11 +17,9 @@
 #include <asm/types.h>
 
 struct task_struct;
-struct exec_domain;
 
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
-	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
 	__u32			cpu;
 	__s32			preempt_count;	/* 0 => preemptable, <0 => BUG */
@@ -36,7 +34,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)						\
 {									\
 	.task		= &tsk,						\
-	.exec_domain	= &default_exec_domain,				\
 	.flags		= 0,						\
 	.cpu		= 0,						\
 	.preempt_count	= INIT_PREEMPT_COUNT,				\
diff --git a/arch/avr32/kernel/asm-offsets.c b/arch/avr32/kernel/asm-offsets.c
index e41c845..2c9764f 100644
--- a/arch/avr32/kernel/asm-offsets.c
+++ b/arch/avr32/kernel/asm-offsets.c
@@ -12,7 +12,6 @@
 void foo(void)
 {
 	OFFSET(TI_task, thread_info, task);
-	OFFSET(TI_exec_domain, thread_info, exec_domain);
 	OFFSET(TI_flags, thread_info, flags);
 	OFFSET(TI_cpu, thread_info, cpu);
 	OFFSET(TI_preempt_count, thread_info, preempt_count);
diff --git a/arch/c6x/include/asm/thread_info.h b/arch/c6x/include/asm/thread_info.h
index 584e253..acc70c1 100644
--- a/arch/c6x/include/asm/thread_info.h
+++ b/arch/c6x/include/asm/thread_info.h
@@ -40,7 +40,6 @@ typedef struct {
  */
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
-	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
 	int			cpu;		/* cpu we're on */
 	int			preempt_count;	/* 0 = preemptable, <0 = BUG */
@@ -55,7 +54,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)			\
 {						\
 	.task		= &tsk,			\
-	.exec_domain	= &default_exec_domain,	\
 	.flags		= 0,			\
 	.cpu		= 0,			\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
diff --git a/arch/cris/arch-v10/kernel/signal.c b/arch/cris/arch-v10/kernel/signal.c
index 74d7ba3..7122d97 100644
--- a/arch/cris/arch-v10/kernel/signal.c
+++ b/arch/cris/arch-v10/kernel/signal.c
@@ -321,8 +321,6 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 	if (err)
 		return -EFAULT;
 
-	/* TODO what is the current->exec_domain stuff and invmap ? */
-
 	/* Set up registers for signal handler */
 
 	/* What we enter NOW   */
diff --git a/arch/cris/arch-v32/kernel/signal.c b/arch/cris/arch-v32/kernel/signal.c
index 870e3e0..0c9ce9e 100644
--- a/arch/cris/arch-v32/kernel/signal.c
+++ b/arch/cris/arch-v32/kernel/signal.c
@@ -287,8 +287,6 @@ setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		return -EFAULT;
 
-	/* TODO: what is the current->exec_domain stuff and invmap ? */
-
 	err |= __put_user(&frame->info, &frame->pinfo);
 	err |= __put_user(&frame->uc, &frame->puc);
 	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
diff --git a/arch/cris/include/asm/thread_info.h b/arch/cris/include/asm/thread_info.h
index 7286db5..4ead1b4 100644
--- a/arch/cris/include/asm/thread_info.h
+++ b/arch/cris/include/asm/thread_info.h
@@ -28,7 +28,6 @@
 #ifndef __ASSEMBLY__
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
-	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
 	__u32			cpu;		/* current CPU */
 	int			preempt_count;	/* 0 => preemptable, <0 => BUG */
@@ -50,7 +49,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)				\
 {							\
 	.task		= &tsk,				\
-	.exec_domain	= &default_exec_domain,		\
 	.flags		= 0,				\
 	.cpu		= 0,				\
 	.preempt_count	= INIT_PREEMPT_COUNT,		\
diff --git a/arch/hexagon/include/asm/thread_info.h b/arch/hexagon/include/asm/thread_info.h
index bacd3d6..b80fe1d 100644
--- a/arch/hexagon/include/asm/thread_info.h
+++ b/arch/hexagon/include/asm/thread_info.h
@@ -47,7 +47,6 @@ typedef struct {
 
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
-	struct exec_domain      *exec_domain;   /* execution domain */
 	unsigned long		flags;          /* low level flags */
 	__u32                   cpu;            /* current cpu */
 	int                     preempt_count;  /* 0=>preemptible,<0=>BUG */
@@ -77,7 +76,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)                   \
 {                                               \
 	.task           = &tsk,                 \
-	.exec_domain    = &default_exec_domain, \
 	.flags          = 0,                    \
 	.cpu            = 0,                    \
 	.preempt_count  = 1,                    \
diff --git a/arch/ia64/include/asm/thread_info.h b/arch/ia64/include/asm/thread_info.h
index c16f21a..aa995b6 100644
--- a/arch/ia64/include/asm/thread_info.h
+++ b/arch/ia64/include/asm/thread_info.h
@@ -20,7 +20,6 @@
  */
 struct thread_info {
 	struct task_struct *task;	/* XXX not really needed, except for dup_task_struct() */
-	struct exec_domain *exec_domain;/* execution domain */
 	__u32 flags;			/* thread_info flags (see TIF_*) */
 	__u32 cpu;			/* current CPU */
 	__u32 last_cpu;			/* Last CPU thread ran on */
@@ -40,7 +39,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)			\
 {						\
 	.task		= &tsk,			\
-	.exec_domain	= &default_exec_domain,	\
 	.flags		= 0,			\
 	.cpu		= 0,			\
 	.addr_limit	= KERNEL_DS,		\
diff --git a/arch/metag/include/asm/thread_info.h b/arch/metag/include/asm/thread_info.h
index afb3ca4..32677cc 100644
--- a/arch/metag/include/asm/thread_info.h
+++ b/arch/metag/include/asm/thread_info.h
@@ -28,7 +28,6 @@
 /* This must be 8 byte aligned so we can ensure stack alignment. */
 struct thread_info {
 	struct task_struct *task;	/* main task structure */
-	struct exec_domain *exec_domain;	/* execution domain */
 	unsigned long flags;	/* low level flags */
 	unsigned long status;	/* thread-synchronous flags */
 	u32 cpu;		/* current CPU */
@@ -68,7 +67,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)			\
 {						\
 	.task		= &tsk,			\
-	.exec_domain	= &default_exec_domain,	\
 	.flags		= 0,			\
 	.cpu		= 0,			\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
diff --git a/arch/metag/kernel/irq.c b/arch/metag/kernel/irq.c
index 5385dd1..4f8f1f8 100644
--- a/arch/metag/kernel/irq.c
+++ b/arch/metag/kernel/irq.c
@@ -132,7 +132,6 @@ void irq_ctx_init(int cpu)
 
 	irqctx = (union irq_ctx *) &hardirq_stack[cpu * THREAD_SIZE];
 	irqctx->tinfo.task              = NULL;
-	irqctx->tinfo.exec_domain       = NULL;
 	irqctx->tinfo.cpu               = cpu;
 	irqctx->tinfo.preempt_count     = HARDIRQ_OFFSET;
 	irqctx->tinfo.addr_limit        = MAKE_MM_SEG(0);
@@ -141,7 +140,6 @@ void irq_ctx_init(int cpu)
 
 	irqctx = (union irq_ctx *) &softirq_stack[cpu * THREAD_SIZE];
 	irqctx->tinfo.task              = NULL;
-	irqctx->tinfo.exec_domain       = NULL;
 	irqctx->tinfo.cpu               = cpu;
 	irqctx->tinfo.preempt_count     = 0;
 	irqctx->tinfo.addr_limit        = MAKE_MM_SEG(0);
diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index 55ed660..8408a30 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -23,7 +23,6 @@
  */
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
-	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
 	unsigned long		tp_value;	/* thread pointer */
 	__u32			cpu;		/* current CPU */
@@ -44,7 +43,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)			\
 {						\
 	.task		= &tsk,			\
-	.exec_domain	= &default_exec_domain, \
 	.flags		= _TIF_FIXADE,		\
 	.cpu		= 0,			\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 750d67a..8f89102 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -92,7 +92,6 @@ void output_thread_info_defines(void)
 {
 	COMMENT("MIPS thread_info offsets.");
 	OFFSET(TI_TASK, thread_info, task);
-	OFFSET(TI_EXEC_DOMAIN, thread_info, exec_domain);
 	OFFSET(TI_FLAGS, thread_info, flags);
 	OFFSET(TI_TP_VALUE, thread_info, tp_value);
 	OFFSET(TI_CPU, thread_info, cpu);
diff --git a/arch/nios2/include/asm/thread_info.h b/arch/nios2/include/asm/thread_info.h
index 1f26657..faf97e6 100644
--- a/arch/nios2/include/asm/thread_info.h
+++ b/arch/nios2/include/asm/thread_info.h
@@ -39,7 +39,6 @@ typedef struct {
  */
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
-	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
 	__u32			cpu;		/* current CPU */
 	int			preempt_count;	/* 0 => preemptable,<0 => BUG */
@@ -59,7 +58,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)			\
 {						\
 	.task		= &tsk,			\
-	.exec_domain	= &default_exec_domain,	\
 	.flags		= 0,			\
 	.cpu		= 0,			\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
diff --git a/arch/openrisc/include/asm/thread_info.h b/arch/openrisc/include/asm/thread_info.h
index 875f084..6e619a7 100644
--- a/arch/openrisc/include/asm/thread_info.h
+++ b/arch/openrisc/include/asm/thread_info.h
@@ -48,7 +48,6 @@ typedef unsigned long mm_segment_t;
 
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
-	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
 	__u32			cpu;		/* current CPU */
 	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
@@ -73,7 +72,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)				\
 {							\
 	.task		= &tsk,				\
-	.exec_domain	= &default_exec_domain,		\
 	.flags		= 0,				\
 	.cpu		= 0,				\
 	.preempt_count	= 1,				\
diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
index 4112175b..c82be69 100644
--- a/arch/openrisc/kernel/signal.c
+++ b/arch/openrisc/kernel/signal.c
@@ -193,8 +193,6 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 	if (err)
 		return -EFAULT;
 
-	/* TODO what is the current->exec_domain stuff and invmap ? */
-
 	/* Set up registers for signal handler */
 	regs->pc = (unsigned long)ksig->ka.sa.sa_handler; /* what we enter NOW */
 	regs->gpr[9] = (unsigned long)return_ip;     /* what we enter LATER */
diff --git a/arch/parisc/include/asm/thread_info.h b/arch/parisc/include/asm/thread_info.h
index fb13e38..e96e693 100644
--- a/arch/parisc/include/asm/thread_info.h
+++ b/arch/parisc/include/asm/thread_info.h
@@ -9,7 +9,6 @@
 
 struct thread_info {
 	struct task_struct *task;	/* main task structure */
-	struct exec_domain *exec_domain;/* execution domain */
 	unsigned long flags;		/* thread_info flags (see TIF_*) */
 	mm_segment_t addr_limit;	/* user-level address space limit */
 	__u32 cpu;			/* current CPU */
@@ -19,7 +18,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)			\
 {						\
 	.task		= &tsk,			\
-	.exec_domain	= &default_exec_domain,	\
 	.flags		= 0,			\
 	.cpu		= 0,			\
 	.addr_limit	= KERNEL_DS,		\
diff --git a/arch/parisc/kernel/asm-offsets.c b/arch/parisc/kernel/asm-offsets.c
index dcd5510..59001ce 100644
--- a/arch/parisc/kernel/asm-offsets.c
+++ b/arch/parisc/kernel/asm-offsets.c
@@ -242,7 +242,6 @@ int main(void)
 	DEFINE(PT_SZ_ALGN, align_frame(sizeof(struct pt_regs), FRAME_ALIGN));
 	BLANK();
 	DEFINE(TI_TASK, offsetof(struct thread_info, task));
-	DEFINE(TI_EXEC_DOMAIN, offsetof(struct thread_info, exec_domain));
 	DEFINE(TI_FLAGS, offsetof(struct thread_info, flags));
 	DEFINE(TI_CPU, offsetof(struct thread_info, cpu));
 	DEFINE(TI_SEGMENT, offsetof(struct thread_info, addr_limit));
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 7248979..7efee4a 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -39,7 +39,6 @@
  */
 struct thread_info {
 	struct task_struct *task;		/* main task structure */
-	struct exec_domain *exec_domain;	/* execution domain */
 	int		cpu;			/* cpu we're on */
 	int		preempt_count;		/* 0 => preemptable,
 						   <0 => BUG */
@@ -55,7 +54,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)			\
 {						\
 	.task =		&tsk,			\
-	.exec_domain =	&default_exec_domain,	\
 	.cpu =		0,			\
 	.preempt_count = INIT_PREEMPT_COUNT,	\
 	.flags =	0,			\
diff --git a/arch/score/include/asm/thread_info.h b/arch/score/include/asm/thread_info.h
index 33864fa..7d9ffb1 100644
--- a/arch/score/include/asm/thread_info.h
+++ b/arch/score/include/asm/thread_info.h
@@ -28,7 +28,6 @@
  */
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
-	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
 	unsigned long		tp_value;	/* thread pointer */
 	__u32			cpu;		/* current CPU */
@@ -53,7 +52,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)			\
 {						\
 	.task		= &tsk,			\
-	.exec_domain	= &default_exec_domain,	\
 	.cpu		= 0,			\
 	.preempt_count	= 1,			\
 	.addr_limit	= KERNEL_DS,		\
diff --git a/arch/score/kernel/asm-offsets.c b/arch/score/kernel/asm-offsets.c
index b4d5214..52794f9 100644
--- a/arch/score/kernel/asm-offsets.c
+++ b/arch/score/kernel/asm-offsets.c
@@ -100,7 +100,6 @@ void output_thread_info_defines(void)
 {
 	COMMENT("SCORE thread_info offsets.");
 	OFFSET(TI_TASK, thread_info, task);
-	OFFSET(TI_EXEC_DOMAIN, thread_info, exec_domain);
 	OFFSET(TI_FLAGS, thread_info, flags);
 	OFFSET(TI_TP_VALUE, thread_info, tp_value);
 	OFFSET(TI_CPU, thread_info, cpu);
-- 
1.8.4.5
