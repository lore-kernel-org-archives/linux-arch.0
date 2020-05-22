From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: Some -serious- BPF-related litmus tests
Date: Fri, 22 May 2020 03:56:59 -0700
Message-ID: <20200522105659.GH2869@paulmck-ThinkPad-P72>
References: <20200522003850.GA32698@paulmck-ThinkPad-P72>
 <20200522094407.GK325280@hirez.programming.kicks-ass.net>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbgEVK5A (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 May 2020 06:57:00 -0400
Content-Disposition: inline
In-Reply-To: <20200522094407.GK325280@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, andriin@fb.com

On Fri, May 22, 2020 at 11:44:07AM +0200, Peter Zijlstra wrote:
> On Thu, May 21, 2020 at 05:38:50PM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > Just wanted to call your attention to some pretty cool and pretty serious
> > litmus tests that Andrii did as part of his BPF ring-buffer work:
> > 
> > https://lore.kernel.org/bpf/20200517195727.279322-3-andriin@fb.com/
> > 
> > Thoughts?
> 
> I find:
> 
> 	smp_wmb()
> 	smp_store_release()
> 
> a _very_ weird construct. What is that supposed to even do?

Indeed, and I asked about that in my review of the patch containing the
code.  It -could- make sense if there is a prior read and a later store:

	r1 = READ_ONCE(a);
	WRITE_ONCE(b, 1);
	smp_wmb();
	smp_store_release(&c, 1);
	WRITE_ONCE(d, 1);

So a->c and b->c is smp_store_release() and b->d is smp_wmb().  But if
there were only stores, the smp_wmb() would suffice.  And if there wasn't
the trailing store, smp_store_release() would suffice.

But that would at least want a comment, in my opinion.  ;-)

							Thanx, Paul
