From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v3 16/22] locking/atomics, kcsan: Add KCSAN
 instrumentation
Date: Wed, 19 Feb 2020 08:50:20 -0800
Message-ID: <20200219165020.GF2935@paulmck-ThinkPad-P72>
References: <20200219144724.800607165@infradead.org>
 <20200219150745.299217979@infradead.org>
 <20200219104626.633f0650@gandalf.local.home>
 <20200219160318.GG18400@hirez.programming.kicks-ass.net>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbgBSQuV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 11:50:21 -0500
Content-Disposition: inline
In-Reply-To: <20200219160318.GG18400@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org, Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>

On Wed, Feb 19, 2020 at 05:03:18PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 19, 2020 at 10:46:26AM -0500, Steven Rostedt wrote:
> > On Wed, 19 Feb 2020 15:47:40 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > From: Marco Elver <elver@google.com>
> > > 
> > > This adds KCSAN instrumentation to atomic-instrumented.h.
> > > 
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > [peterz: removed the actual kcsan hooks]
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> > > ---
> > >  include/asm-generic/atomic-instrumented.h |  390 +++++++++++++++---------------
> > >  scripts/atomic/gen-atomic-instrumented.sh |   14 -
> > >  2 files changed, 212 insertions(+), 192 deletions(-)
> > > 
> > 
> > 
> > Does this and the rest of the series depend on the previous patches in
> > the series? Or can this be a series on to itself (patches 16-22)?
> 
> It can probably stand on its own, but it very much is related in so far
> that it's fallout from staring at all this nonsense.
> 
> Without these the do_int3() can actually have accidental tracing before
> reaching it's nmi_enter().

The original is already in -tip, so some merge magic will be required.

							Thanx, Paul
