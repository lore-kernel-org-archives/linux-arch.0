From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove
 smp_read_barrier_depends()
Date: Wed, 11 Oct 2017 18:12:20 +0200
Message-ID: <20171011161220.zqkdhynxerrcmvdd@hirez.programming.kicks-ass.net>
References: <20171011122217.GD11106@arm.com>
 <20171010155042.GD3521@linux.vnet.ibm.com>
 <1507594969-8347-12-git-send-email-paulmck@linux.vnet.ibm.com>
 <20171010001951.GA6476@linux.vnet.ibm.com>
 <8079.1507628146@warthog.procyon.org.uk>
 <26455.1507724399@warthog.procyon.org.uk>
 <6309.1507735045@warthog.procyon.org.uk>
 <20171011155948.GE3521@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171011155948.GE3521@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>, dvyukov@google.com
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 11, 2017 at 08:59:48AM -0700, Paul E. McKenney wrote:
> On Wed, Oct 11, 2017 at 04:17:25PM +0100, David Howells wrote:
> > I will, however, quibble with the appropriateness of the name READ_ONCE()...
> > I still think it's not sufficiently obvious that this is a barrier and the
> > barrier is after.  Maybe READ_AND_BARRIER()?
> 
> Linus was unhappy with READ_ONCE_CTRL() to tag control dependencies, but
> indicated that he might consider it if it helped code-analysis tools.
> Adding Dmitry Vyukov for his thoughts on whether tagging READ_ONCE()
> for dependencies would help.  Me, I would suggest READ_ONCE_DEP(), but
> let's figure out if the bikeshed needs to be painted before arguing over
> the color.  ;-)

Count me one vote for the READ_ONCE() name. This is about dependent
reads, which are nothing special on anything except Alpha.

We want to remove the exception/specialness from the memory model; and
therefore have to fix up all primitives that could possibly be used for
these reads to unconditionally issue the barrier (on Alpha). The
alternative is: rm -rf arch/alpha.

Adding something like READ_ONCE_DEP() does not rid us of the idea that
dependent reads are special and thus defeats the purpose, we might as
well retain lockless_dereference().

Now; any user of dependent reads must use READ_ONCE() in any case, to
avoid load tearing and reloads. So using READ_ONCE() for the dependent
reads is not extra or additional (note we'll also have to add the
barrier to all our relaxed and release atomics and anything else that
implies READ_ONCE and doesn't already imply smp_mb() after).
