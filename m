From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove
 smp_read_barrier_depends()
Date: Wed, 11 Oct 2017 18:19:52 +0100
Message-ID: <20171011171951.GC26449@leverpostej>
References: <20171011122217.GD11106@arm.com>
 <20171010155042.GD3521@linux.vnet.ibm.com>
 <1507594969-8347-12-git-send-email-paulmck@linux.vnet.ibm.com>
 <20171010001951.GA6476@linux.vnet.ibm.com>
 <8079.1507628146@warthog.procyon.org.uk>
 <26455.1507724399@warthog.procyon.org.uk>
 <6309.1507735045@warthog.procyon.org.uk>
 <20171011155948.GE3521@linux.vnet.ibm.com>
 <20171011161220.zqkdhynxerrcmvdd@hirez.programming.kicks-ass.net>
 <20171011162412.o6lmjiag7spwabge@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171011162412.o6lmjiag7spwabge@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>, dvyukov@google.com
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 11, 2017 at 06:24:12PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 11, 2017 at 06:12:20PM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 11, 2017 at 08:59:48AM -0700, Paul E. McKenney wrote:
> > > On Wed, Oct 11, 2017 at 04:17:25PM +0100, David Howells wrote:
> > > > I will, however, quibble with the appropriateness of the name READ_ONCE()...
> > > > I still think it's not sufficiently obvious that this is a barrier and the
> > > > barrier is after.  Maybe READ_AND_BARRIER()?
> > > 
> > > Linus was unhappy with READ_ONCE_CTRL() to tag control dependencies, but
> > > indicated that he might consider it if it helped code-analysis tools.
> > > Adding Dmitry Vyukov for his thoughts on whether tagging READ_ONCE()
> > > for dependencies would help.  Me, I would suggest READ_ONCE_DEP(), but
> > > let's figure out if the bikeshed needs to be painted before arguing over
> > > the color.  ;-)
> > 
> > Count me one vote for the READ_ONCE() name. This is about dependent
> > reads, which are nothing special on anything except Alpha.
> > 
> > We want to remove the exception/specialness from the memory model; and
> > therefore have to fix up all primitives that could possibly be used for
> > these reads to unconditionally issue the barrier (on Alpha). The
> > alternative is: rm -rf arch/alpha.
> > 
> > Adding something like READ_ONCE_DEP() does not rid us of the idea that
> > dependent reads are special and thus defeats the purpose, we might as
> > well retain lockless_dereference().
> > 
> > Now; any user of dependent reads must use READ_ONCE() in any case, to
> > avoid load tearing and reloads. So using READ_ONCE() for the dependent
> > reads is not extra or additional (note we'll also have to add the
> > barrier to all our relaxed and release atomics and anything else that
> > implies READ_ONCE and doesn't already imply smp_mb() after).
> 
> Add the per-cpu ops to that list, they imply READ_ONCE(). Consider for
> example this example:
> 
> 
> 	for_each_possible_cpu(cpu)
> 		smp_store_release(per_cpu_ptr(&foo, cpu), obj);
> 
> -vs-
> 
> 	obj = this_cpu_read(foo);
> 	if (obj->ponies)
> 		fart_rainbow(obj);

Sorry to derail things, but per the docs, this_cpu_read() (as with other
this_cpu_*() ops) is not atomic w.r.t. stores from another CPU.

Today in practice, that only matters for accesses larger than the native
word size, but the API explicitly doesn't guarantee a lack of tearing
for the above example. I'm sure we have bugs...

Thanks,
Mark.
