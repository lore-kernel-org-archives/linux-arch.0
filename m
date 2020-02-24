From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 02/27] hardirq/nmi: Allow nested nmi_enter()
Date: Mon, 24 Feb 2020 17:13:18 +0100
Message-ID: <20200224161318.GG14897@hirez.programming.kicks-ass.net>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.149193474@infradead.org>
 <20200221222129.GB28251@lenoir>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:52752 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbgBXQNv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Feb 2020 11:13:51 -0500
Content-Disposition: inline
In-Reply-To: <20200221222129.GB28251@lenoir>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, dan.carpenter@oracle.com, mhiramat@kernel.org, Will Deacon <will@kernel.org>, Petr Mladek <pmladek@suse.com>, Marc Zyngier <maz@kernel.org>

On Fri, Feb 21, 2020 at 11:21:30PM +0100, Frederic Weisbecker wrote:
> On Fri, Feb 21, 2020 at 02:34:18PM +0100, Peter Zijlstra wrote:
> > Since there are already a number of sites (ARM64, PowerPC) that
> > effectively nest nmi_enter(), lets make the primitive support this
> > before adding even more.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > Acked-by: Will Deacon <will@kernel.org>
> > Acked-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  arch/arm64/include/asm/hardirq.h |    4 ++--
> >  arch/arm64/kernel/sdei.c         |   14 ++------------
> >  arch/arm64/kernel/traps.c        |    8 ++------
> >  arch/powerpc/kernel/traps.c      |   22 ++++++----------------
> >  include/linux/hardirq.h          |    5 ++++-
> >  include/linux/preempt.h          |    4 ++--
> >  kernel/printk/printk_safe.c      |    6 ++++--
> >  7 files changed, 22 insertions(+), 41 deletions(-)
> > 
> > --- a/kernel/printk/printk_safe.c
> > +++ b/kernel/printk/printk_safe.c
> > @@ -296,12 +296,14 @@ static __printf(1, 0) int vprintk_nmi(co
> >  
> >  void notrace printk_nmi_enter(void)
> >  {
> > -	this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
> > +	if (!in_nmi())
> > +		this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
> >  }
> >  
> >  void notrace printk_nmi_exit(void)
> >  {
> > -	this_cpu_and(printk_context, ~PRINTK_NMI_CONTEXT_MASK);
> > +	if (!in_nmi())
> > +		this_cpu_and(printk_context, ~PRINTK_NMI_CONTEXT_MASK);
> >  }
> 
> If the outermost NMI is interrupted while between printk_nmi_enter()
> and preempt_count_add(), there is still a risk that we race and clear?

Damn, true. That also means I need to fix the arm64 bits, and that's a
little more tricky.

Something like so perhaps.. hmm?

---
--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -32,30 +32,52 @@ u64 smp_irq_stat_cpu(unsigned int cpu);
 
 struct nmi_ctx {
 	u64 hcr;
+	unsigned int cnt;
 };
 
 DECLARE_PER_CPU(struct nmi_ctx, nmi_contexts);
 
-#define arch_nmi_enter()							\
-	do {									\
-		if (is_kernel_in_hyp_mode() && !in_nmi()) {			\
-			struct nmi_ctx *nmi_ctx = this_cpu_ptr(&nmi_contexts);	\
-			nmi_ctx->hcr = read_sysreg(hcr_el2);			\
-			if (!(nmi_ctx->hcr & HCR_TGE)) {			\
-				write_sysreg(nmi_ctx->hcr | HCR_TGE, hcr_el2);	\
-				isb();						\
-			}							\
-		}								\
-	} while (0)
+#define arch_nmi_enter()						\
+do {									\
+	struct nmi_ctx *___ctx;						\
+	unsigned int ___cnt;						\
+									\
+	if (!is_kernel_in_hyp_mode() || in_nmi())			\
+		break;							\
+									\
+	___ctx = this_cpu_ptr(&nmi_contexts);				\
+	___cnt = ___ctx->cnt;						\
+	if (!(___cnt & 1) && __cnt) {					\
+		___ctx->cnt += 2;					\
+		break;							\
+	}								\
+									\
+	___ctx->cnt |= 1;						\
+	barrier();							\
+	nmi_ctx->hcr = read_sysreg(hcr_el2);				\
+	if (!(nmi_ctx->hcr & HCR_TGE)) {				\
+		write_sysreg(nmi_ctx->hcr | HCR_TGE, hcr_el2);		\
+		isb();							\
+	}								\
+	barrier();							\
+	if (!(___cnt & 1))						\
+		___ctx->cnt++;						\
+} while (0)
 
-#define arch_nmi_exit()								\
-	do {									\
-		if (is_kernel_in_hyp_mode() && !in_nmi()) {			\
-			struct nmi_ctx *nmi_ctx = this_cpu_ptr(&nmi_contexts);	\
-			if (!(nmi_ctx->hcr & HCR_TGE))				\
-				write_sysreg(nmi_ctx->hcr, hcr_el2);		\
-		}								\
-	} while (0)
+#define arch_nmi_exit()							\
+do {									\
+	struct nmi_ctx *___ctx;						\
+									\
+	if (!is_kernel_in_hyp_mode() || in_nmi())			\
+		break;							\
+									\
+	___ctx = this_cpu_ptr(&nmi_contexts);				\
+	if ((___ctx->cnt & 1) || (___ctx->cnt -= 2))			\
+		break;							\
+									\
+	if (!(nmi_ctx->hcr & HCR_TGE))					\
+		write_sysreg(nmi_ctx->hcr, hcr_el2);			\
+} while (0)
 
 static inline void ack_bad_irq(unsigned int irq)
 {
