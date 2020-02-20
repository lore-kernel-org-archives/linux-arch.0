From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 03/22] x86: Replace ist_enter() with nmi_enter()
Date: Thu, 20 Feb 2020 13:11:13 +0100
Message-ID: <20200220121113.GY18400@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.547288232@infradead.org>
 <20200220105439.GA507@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:50318 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgBTMLh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Feb 2020 07:11:37 -0500
Content-Disposition: inline
In-Reply-To: <20200220105439.GA507@zn.tnic>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

On Thu, Feb 20, 2020 at 11:54:39AM +0100, Borislav Petkov wrote:
> On Wed, Feb 19, 2020 at 03:47:27PM +0100, Peter Zijlstra wrote:
> > @@ -1220,7 +1220,7 @@ static void mce_kill_me_maybe(struct cal
> >   * MCE broadcast. However some CPUs might be broken beyond repair,
> >   * so be always careful when synchronizing with others.
> >   */
> > -void do_machine_check(struct pt_regs *regs, long error_code)
> > +notrace void do_machine_check(struct pt_regs *regs, long error_code)
> 
> Is there a convention where the notrace marker should come in the
> function signature? I see all possible combinations while grepping...

Same place as inline I think.

> >  {
> >  	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
> >  	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
> > @@ -1254,10 +1254,10 @@ void do_machine_check(struct pt_regs *re
> >  	 */
> >  	int lmce = 1;
> >  
> > -	if (__mc_check_crashing_cpu(cpu))
> > -		return;
> > +	nmi_enter();
> >  
> > -	ist_enter(regs);
> > +	if (__mc_check_crashing_cpu(cpu))
> > +		goto out;
> >  
> >  	this_cpu_inc(mce_exception_count);
> >  
> 
> Should that __mc_check_crashing_cpu() happen before nmi_enter? The
> function is doing only a bunch of checks and clearing MSRs for bystander
> CPUs...

You'll note the lack of notrace on that function, and we must not call
into tracers before nmi_enter().

AFAICT there really is no benefit to trying to lift it before
nmi_enter().
