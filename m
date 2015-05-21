From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Compilers and RCU readers: Once more unto the breach!
Date: Thu, 21 May 2015 13:02:12 -0700
Message-ID: <20150521200212.GW6776@linux.vnet.ibm.com>
References: <20150520005510.GA23559@linux.vnet.ibm.com>
 <CA+55aFy_8V-rbE9FQMHx6tXjj8HHKZuKSJvnRPVYvpk46EQA1g@mail.gmail.com>
 <CA+55aFxOtcB8AYCpLQBGSXK=8_Vh4uDs5HEpzGpPy+hgz542ag@mail.gmail.com>
 <20150520024148.GD6776@linux.vnet.ibm.com>
 <20150520114745.GC11498@arm.com>
 <20150520121522.GH6776@linux.vnet.ibm.com>
 <20150520154617.GE11498@arm.com>
 <20150520181606.GT6776@linux.vnet.ibm.com>
 <20150521192422.GC19204@arm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:51473 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756200AbbEUUCj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 21 May 2015 16:02:39 -0400
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 21 May 2015 14:02:38 -0600
Content-Disposition: inline
In-Reply-To: <20150521192422.GC19204@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "c++std-parallel@accu.org" <c++std-parallel@accu.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, p796231 <Peter.Sewell@cl.cam.ac.uk>, "mark.batty@cl.cam.ac.uk" <Mark.Batty@cl.cam.ac.uk>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "michaelw@ca.ibm.com" <michaelw@ca.ibm.com>

On Thu, May 21, 2015 at 08:24:22PM +0100, Will Deacon wrote:
> On Wed, May 20, 2015 at 07:16:06PM +0100, Paul E. McKenney wrote:
> > On Wed, May 20, 2015 at 04:46:17PM +0100, Will Deacon wrote:
> > > On Wed, May 20, 2015 at 01:15:22PM +0100, Paul E. McKenney wrote:
> > > > Indeed, something like this does -not- carry a dependency from the
> > > > memory_order_consume load to q:
> > > > 
> > > > 	char *p, q;
> > > > 
> > > > 	p = atomic_load_explicit(&gp, memory_order_consume);
> > > > 	q = gq + (intptr_t)p - (intptr_t)p;
> > > > 
> > > > If this was compiled with -O0, ARM and Power might well carry a
> > > > dependency, but given any optimization, the assembly language would have
> > > > no hint of any such dependency.  So I am not seeing any particular danger.
> > > 
> > > The above is a welcome relaxation over C11, since ARM doesn't even give
> > > you ordering based off false data dependencies. My concern is more to do
> > > with how this can be specified precisely without prohibing honest compiler
> > > and hardware optimisations.
> > 
> > That last is the challenge.  I believe that I am pretty close, but I am
> > sure that additional adjustment will be required.  Especially given that
> > we also need the memory model to be amenable to formal analysis.
> 
> Well, there's still the whole thin-air problem which unfortunately doesn't
> go away with your proposal... (I was hoping that differentiating between
> true and false dependencies would solve that, but your set of rules isn't
> broad enough and I don't blame you at all for that!).
> 
> > > Out of interest, how do you tackle examples (4) and (5) of (assuming the
> > > reads are promoted to consume loads)?:
> > > 
> > >   http://www.cl.cam.ac.uk/~pes20/cpp/notes42.html
> > > 
> > > my understanding is that you permit both outcomes (I appreciate you're
> > > not directly tackling out-of-thin-air, but treatment of dependencies
> > > is heavily related).
> 
> Thanks for taking the time to walk these two examples through.

;-) ;-) ;-)

> > Let's see...  #4 is as follows, given promotion to memory_order_consume
> > and (I am guessing) memory_order_relaxed:
> > 
> > 	r1 = atomic_load_explicit(&x, memory_order_consume);
> > 	if (r1 == 42)
> > 	  atomic_store_explicit(&y, r1, memory_order_relaxed);
> > 	------------------------------------------------------
> > 	r2 = atomic_load_explicit(&y, memory_order_consume);
> > 	if (r2 == 42)
> > 	  atomic_store_explicit(&x, 42, memory_order_relaxed);
> > 	else
> > 	  atomic_store_explicit(&x, 42, memory_order_relaxed);
> > 
> > The second thread does not have a proper control dependency, even with
> > the memory_order_consume load because both branches assign the same
> > value to "x".  This means that the compiler is within its rights to
> > optimize this into the following:
> > 
> > 	r1 = atomic_load_explicit(&x, memory_order_consume);
> > 	if (r1 == 42)
> > 	  atomic_store_explicit(&y, r1, memory_order_relaxed);
> > 	------------------------------------------------------
> > 	r2 = atomic_load_explicit(&y, memory_order_consume);
> > 	atomic_store_explicit(&x, 42, memory_order_relaxed);
> > 
> > There is no dependency between the second thread's pair of statements,
> > so both the compiler and the CPU are within their rights to optimize
> > further as follows:
> > 
> > 	r1 = atomic_load_explicit(&x, memory_order_consume);
> > 	if (r1 == 42)
> > 	  atomic_store_explicit(&y, r1, memory_order_relaxed);
> > 	------------------------------------------------------
> > 	atomic_store_explicit(&x, 42, memory_order_relaxed);
> > 	r2 = atomic_load_explicit(&y, memory_order_consume);
> > 
> > If the compiler makes this final optimization, even mythical SC hardware
> > is within its rights to end up with (r1 == 42 && r2 == 42).  Which is
> > fine, as far as I am concerned.  Or at least something that can be
> > lived with.
> 
> Agreed.
> 
> > On to #5:
> > 
> > 	r1 = atomic_load_explicit(&x, memory_order_consume);
> > 	if (r1 == 42)
> > 	  atomic_store_explicit(&y, r1, memory_order_relaxed);
> > 	----------------------------------------------------
> > 	r2 = atomic_load_explicit(&y, memory_order_consume);
> > 	if (r2 == 42)
> > 	  atomic_store_explicit(&x, 42, memory_order_relaxed);
> > 
> > The first thread's accesses are dependency ordered.  The second thread's
> > ordering is in a corner case that memory-barriers.txt does not cover.
> > You are supposed to start control dependencies with READ_ONCE_CTRL(), not
> > a memory_order_consume load (AKA rcu_dereference and friends).  However,
> > Alpha would have a full barrier as part of the memory_order_consume load,
> > and the rest of the processors would (one way or another) respect the
> > control dependency.  And the compiler would have some fun trying to
> > break it.
> 
> But this is interesting because the first thread is ordered whilst the
> second is not, so doesn't that effectively forbid the compiler from
> constant-folding values if it can't prove that there is no dependency
> chain?

You lost me on this one.  Are you suggesting that the compiler
speculate the second thread's atomic store?  That would be very
bad regardless of dependency chains.

So what constant-folding optimization are you thinking of here?
If the above example is not amenable to such an optimization, could
you please give me an example where constant folding would apply
in a way that is sensitive to dependency chains?

> > So the current Linux memory model would allow (r1 == 42 && r2 == 42),
> > but I don't know of any hardware/compiler combination that would
> > allow it.  And no, I am -not- going to update memory-barriers.txt for
> > this litmus test, its theoretical interest notwithstanding!  ;-)
> 
> Indeed, I also don't know of any hardware which permits speculative
> writes to become visible, but it's the compiler (and the language
> definition) that we need to think about here.

The compiler can (and does) speculate non-atomic non-volatile writes
in some cases, but I do not believe that it is permitted to speculate
either volatile or atomic writes.  All that aside, I reiterate that I am
assuming that the compiler does not speculate the value of pointer loads.

> > In summary, both #4 and #5 would be allowed, as modified above.
> > Seem reasonable?
> 
> It feels like it's suppressing a reasonable compiler optimisation, but again,
> I'm not a compiler writer ;)

The intent of this proposal is to avoid suppressing reasonable compiler
optimizations, so could you please send along an example?

							Thanx, Paul
