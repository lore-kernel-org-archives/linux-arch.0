From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 18/22] asm-generic/atomic: Use __always_inline for
 fallback wrappers
Date: Wed, 19 Feb 2020 18:06:09 +0100
Message-ID: <20200219170609.GN18400@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150745.416854783@infradead.org>
 <20200219165521.GG2935@paulmck-ThinkPad-P72>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:37052 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgBSRGm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 12:06:42 -0500
Content-Disposition: inline
In-Reply-To: <20200219165521.GG2935@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org, Mark Rutland <mark.rutland@arm.com>, Marco Elver <elver@google.com>

On Wed, Feb 19, 2020 at 08:55:21AM -0800, Paul E. McKenney wrote:
> On Wed, Feb 19, 2020 at 03:47:42PM +0100, Peter Zijlstra wrote:
> > While the fallback wrappers aren't pure wrappers, they are trivial
> > nonetheless, and the function they wrap should determine the final
> > inlining policy.
> > 
> > For x86 tinyconfig we observe:
> >  - vmlinux baseline: 1315988
> >  - vmlinux with patch: 1315928 (-60 bytes)
> > 
> > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Marco Elver <elver@google.com>
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> And this one and the previous one are also already in -tip, FYI.

That's where I found them ;-) Stole them from tip/locking/kcsan.
