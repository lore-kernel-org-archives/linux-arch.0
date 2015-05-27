Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52584 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751626AbbE0Ogz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 27 May 2015 10:36:55 -0400
Date: Wed, 27 May 2015 15:36:48 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2] arm64: Preserve the user r/w register tpidr_el0 on
 context switch and fork in compat mode
Message-ID: <20150527143648.GA4232@arm.com>
References: <555CB3D5.7000307@dawncrow.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <555CB3D5.7000307@dawncrow.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Hentschel <nerv@dawncrow.de>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Nathan Lynch <nathan_lynch@mentor.com>
Message-ID: <20150527143648.PzbkN7Tb8bXVnS5kqlIlI0w2LD2XK0XZAcvHIZIB3-o@z>

Hi André,

On Wed, May 20, 2015 at 05:18:29PM +0100, André Hentschel wrote:
> From: André Hentschel <nerv@dawncrow.de>
> 
> Since commit a4780adeefd042482f624f5e0d577bf9cdcbb760 the user writeable TLS
> register on ARM is preserved per thread.
> 
> This patch does it analogous to the ARM patch, but for compat mode on ARM64.
> 
> Signed-off-by: André Hentschel <nerv@dawncrow.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> 
> ---
> This patch is against Linux 4.1-rc1 (b787f68c36d49bb1d9236f403813641efa74a031)
> 
> v2: Trying to address suggestions by Will Deacon
> 
> @Will Deacon: 	The macro you suggested is not helpful it seems, instead i introduced
> 		static functions. They also could be macros i guess, but it seems
> 		much cleaner to me to use functions as it only affects one file.

I wanted to understand in more detail why the macro didn't work out for
you, so I trued hacking together my own version of the patch (see below).
It seems to hold up to light testing, so it would be good to know where
you ran into problems.

> Should the final version be send to rmk's patchtracker or will someone
> else pick it up?

This is an arm64 patch, so either Catalin or me will pick it up directly
when it's ready to be merged.

Will

--->8

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index d2c37a1df0eb..e4c893e54f01 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -78,13 +78,30 @@ struct cpu_context {
 
 struct thread_struct {
 	struct cpu_context	cpu_context;	/* cpu context */
-	unsigned long		tp_value;
+	unsigned long		tp_value;	/* TLS register */
+#ifdef CONFIG_COMPAT
+	unsigned long		tp2_value;
+#endif
 	struct fpsimd_state	fpsimd_state;
 	unsigned long		fault_address;	/* fault info */
 	unsigned long		fault_code;	/* ESR_EL1 value */
 	struct debug_info	debug;		/* debugging */
 };
 
+#ifdef CONFIG_COMPAT
+#define task_user_tls(t)						\
+({									\
+	unsigned long *__tls;						\
+	if (is_compat_thread(task_thread_info(t)))			\
+		__tls = &(t)->thread.tp2_value;				\
+	else								\
+		__tls = &(t)->thread.tp_value;				\
+	__tls;								\
+ })
+#else
+#define task_user_tls(t)	(&(t)->thread.tp_value)
+#endif
+
 #define INIT_THREAD  {	}
 
 static inline void start_thread_common(struct pt_regs *regs, unsigned long pc)
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index c6b1f3b96f45..c96927e83446 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -254,35 +254,35 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 		unsigned long stk_sz, struct task_struct *p)
 {
 	struct pt_regs *childregs = task_pt_regs(p);
-	unsigned long tls = p->thread.tp_value;
 
 	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
 
 	if (likely(!(p->flags & PF_KTHREAD))) {
 		*childregs = *current_pt_regs();
 		childregs->regs[0] = 0;
-		if (is_compat_thread(task_thread_info(p))) {
-			if (stack_start)
+
+		/*
+		 * Read the current TLS pointer from tpidr_el0 as it may be
+		 * out-of-sync with the saved value.
+		 */
+		asm("mrs %0, tpidr_el0" : "=r" (*task_user_tls(p)));
+
+		if (stack_start) {
+			if (is_compat_thread(task_thread_info(p)))
 				childregs->compat_sp = stack_start;
-		} else {
-			/*
-			 * Read the current TLS pointer from tpidr_el0 as it may be
-			 * out-of-sync with the saved value.
-			 */
-			asm("mrs %0, tpidr_el0" : "=r" (tls));
-			if (stack_start) {
-				/* 16-byte aligned stack mandatory on AArch64 */
-				if (stack_start & 15)
-					return -EINVAL;
+			/* 16-byte aligned stack mandatory on AArch64 */
+			else if (stack_start & 15)
+				return -EINVAL;
+			else
 				childregs->sp = stack_start;
-			}
 		}
+
 		/*
 		 * If a TLS pointer was passed to clone (4th argument), use it
 		 * for the new thread.
 		 */
 		if (clone_flags & CLONE_SETTLS)
-			tls = childregs->regs[3];
+			p->thread.tp_value = childregs->regs[3];
 	} else {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->pstate = PSR_MODE_EL1h;
@@ -291,7 +291,6 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	}
 	p->thread.cpu_context.pc = (unsigned long)ret_from_fork;
 	p->thread.cpu_context.sp = (unsigned long)childregs;
-	p->thread.tp_value = tls;
 
 	ptrace_hw_copy_thread(p);
 
@@ -302,18 +301,12 @@ static void tls_thread_switch(struct task_struct *next)
 {
 	unsigned long tpidr, tpidrro;
 
-	if (!is_compat_task()) {
-		asm("mrs %0, tpidr_el0" : "=r" (tpidr));
-		current->thread.tp_value = tpidr;
-	}
+	asm("mrs %0, tpidr_el0" : "=r" (tpidr));
+	*task_user_tls(current) = tpidr;
 
-	if (is_compat_thread(task_thread_info(next))) {
-		tpidr = 0;
-		tpidrro = next->thread.tp_value;
-	} else {
-		tpidr = next->thread.tp_value;
-		tpidrro = 0;
-	}
+	tpidr = *task_user_tls(next);
+	tpidrro = is_compat_thread(task_thread_info(next)) ?
+		  next->thread.tp_value : 0;
 
 	asm(
 	"	msr	tpidr_el0, %0\n"
