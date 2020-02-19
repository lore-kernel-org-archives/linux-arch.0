From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 05/22] rcu: Make RCU IRQ enter/exit functions rely on
 in_nmi()
Date: Wed, 19 Feb 2020 17:37:00 +0100
Message-ID: <20200219163700.GK18400@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.661923520@infradead.org>
 <20200219163156.GY2935@paulmck-ThinkPad-P72>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:33404 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgBSQh3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 11:37:29 -0500
Content-Disposition: inline
In-Reply-To: <20200219163156.GY2935@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

On Wed, Feb 19, 2020 at 08:31:56AM -0800, Paul E. McKenney wrote:
> On Wed, Feb 19, 2020 at 03:47:29PM +0100, Peter Zijlstra wrote:
> > From: Paul E. McKenney <paulmck@kernel.org>
> > 
> > The rcu_nmi_enter_common() and rcu_nmi_exit_common() functions take an
> > "irq" parameter that indicates whether these functions are invoked from
> > an irq handler (irq==true) or an NMI handler (irq==false).  However,
> > recent changes have applied notrace to a few critical functions such
> > that rcu_nmi_enter_common() and rcu_nmi_exit_common() many now rely
> > on in_nmi().  Note that in_nmi() works no differently than before,
> > but rather that tracing is now prohibited in code regions where in_nmi()
> > would incorrectly report NMI state.
> > 
> > This commit therefore removes the "irq" parameter and inlines
> > rcu_nmi_enter_common() and rcu_nmi_exit_common() into rcu_nmi_enter()
> > and rcu_nmi_exit(), respectively.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Again, thank you.
> 
> Would you like to also take the added comment for NOKPROBE_SYMBOL(),
> or would you prefer that I carry that separately?  (I dropped it for
> now to avoid the conflict with the patch below.)
> 
> Here is the latest version of that comment, posted by Steve Rostedt.
> 
> 							Thanx, Paul
> 
> /*
>  * All functions called in the breakpoint trap handler (e.g. do_int3()
>  * on x86), must not allow kprobes until the kprobe breakpoint handler
>  * is called, otherwise it can cause an infinite recursion.
>  * On some archs, rcu_nmi_enter() is called in the breakpoint handler
>  * before the kprobe breakpoint handler is called, thus it must be
>  * marked as NOKPROBE.
>  */

Oh right, let me stick that in a separate patch. Best we not loose that
I suppose ;-)
