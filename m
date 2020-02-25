From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v4 02/27] hardirq/nmi: Allow nested nmi_enter()
Date: Tue, 25 Feb 2020 23:10:32 +0100
Message-ID: <20200225221031.GB9599@lenoir>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.149193474@infradead.org>
 <20200221222129.GB28251@lenoir>
 <20200224161318.GG14897@hirez.programming.kicks-ass.net>
 <20200225030905.GB28329@lenoir>
 <20200225154111.GM18400@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbgBYWKg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Feb 2020 17:10:36 -0500
Content-Disposition: inline
In-Reply-To: <20200225154111.GM18400@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, dan.carpenter@oracle.com, mhiramat@kernel.org, Will Deacon <will@kernel.org>, Petr Mladek <pmladek@suse.com>, Marc Zyngier <maz@kernel.org>

On Tue, Feb 25, 2020 at 04:41:11PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 25, 2020 at 04:09:06AM +0100, Frederic Weisbecker wrote:
> > On Mon, Feb 24, 2020 at 05:13:18PM +0100, Peter Zijlstra wrote:
> 
> > > +#define arch_nmi_enter()						\
> > > +do {									\
> > > +	struct nmi_ctx *___ctx;						\
> > > +	unsigned int ___cnt;						\
> > > +									\
> > > +	if (!is_kernel_in_hyp_mode() || in_nmi())			\
> > > +		break;							\
> > > +									\
> > > +	___ctx = this_cpu_ptr(&nmi_contexts);				\
> > > +	___cnt = ___ctx->cnt;						\
> > > +	if (!(___cnt & 1) && __cnt) {					\
> > > +		___ctx->cnt += 2;					\
> > > +		break;							\
> > > +	}								\
> > > +									\
> > > +	___ctx->cnt |= 1;						\
> > > +	barrier();							\
> > > +	nmi_ctx->hcr = read_sysreg(hcr_el2);				\
> > > +	if (!(nmi_ctx->hcr & HCR_TGE)) {				\
> > > +		write_sysreg(nmi_ctx->hcr | HCR_TGE, hcr_el2);		\
> > > +		isb();							\
> > > +	}								\
> > > +	barrier();							\
> > 
> > Suppose the first NMI is interrupted here. nmi_ctx->hcr has HCR_TGE unset.
> > The new NMI is going to overwrite nmi_ctx->hcr with HCR_TGE set. Then the
> > first NMI will not restore the correct value upon arch_nmi_exit().
> > 
> > So perhaps the below, but I bet I overlooked something obvious.
> 
> Well, none of this is obvious :/
> 
> The basic idea was that the LSB signifies 'pending/in-progress' and when
> that is set, nobody else touches no nothing. Enter will unconditionally
> (re) write_sysreg(), exit will nothing.

So here is my previous proposal, based on a simple counter, this time
with comments and a few fixes:

#define arch_nmi_enter()						\
do {									\
	struct nmi_ctx *___ctx;						\
	u64 ___hcr;							\
									\
	if (!is_kernel_in_hyp_mode())					\
		break;							\
									\
	___ctx = this_cpu_ptr(&nmi_contexts);				\
	if (___ctx->cnt) {						\
		___ctx->cnt++;						\
		break;							\
	}								\
									\
	___hcr = read_sysreg(hcr_el2);					\
	if (!(___hcr & HCR_TGE)) {					\
		write_sysreg(___hcr | HCR_TGE, hcr_el2);		\
		isb();							\
	}								\
	/*								\
	 * Make sure the sysreg write is performed before ___ctx->cnt	\
	 * is set to 1. NMIs that see cnt == 1 will rely on us.		\
	 */								\
	barrier();							\
	___ctx->cnt = 1;                                                \
	/*								\
	 * Make sure ___ctx->cnt is set before we save ___hcr. We	\
	 * don't want ___ctx->hcr to be overwritten.			\
	 */								\
	barrier();							\
	___ctx->hcr = ___hcr;						\
} while (0)

#define arch_nmi_exit()							\
do {									\
	struct nmi_ctx *___ctx;						\
	u64 ___hcr;							\
									\
	if (!is_kernel_in_hyp_mode())					\
		break;							\
									\
	___ctx = this_cpu_ptr(&nmi_contexts);				\
	___hcr = ___ctx->hcr;						\
	/*								\
	 * Make sure we read ___ctx->hcr before we release		\
	 * ___ctx->cnt as it makes ___ctx->hcr updatable again.		\
	 */								\
	barrier();							\
	___ctx->cnt--;							\
	/*								\
	 * Make sure ___ctx->cnt release is visible before we		\
	 * restore the sysreg. Otherwise a new NMI occuring		\
	 * right after write_sysreg() can be fooled and think		\
	 * we secured things for it.					\
	 */								\
	barrier();							\
	if (!___ctx->cnt && !(___hcr & HCR_TGE))			\
            write_sysreg(___hcr, hcr_el2);				\
} while (0)
