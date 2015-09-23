From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [c++std-parallel-2008] Re: Compilers and RCU readers: Once more
 unto the breach!
Date: Wed, 23 Sep 2015 16:26:10 -0700
Message-ID: <20150923232610.GB4029@linux.vnet.ibm.com>
References: <20150520005510.GA23559@linux.vnet.ibm.com>
 <20150714004459.GA3090@linux.vnet.ibm.com>
 <20150922170031.GA15901@linux.vnet.ibm.com>
 <CAPUmR1aqV_cQWjE8qC9x2sfmW-1ocKKMtCgNbjZH0cJ-AO2WTg@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:34286 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756086AbbIWX0q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 Sep 2015 19:26:46 -0400
Received: from localhost
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Wed, 23 Sep 2015 17:26:46 -0600
Content-Disposition: inline
In-Reply-To: <CAPUmR1aqV_cQWjE8qC9x2sfmW-1ocKKMtCgNbjZH0cJ-AO2WTg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: c++std-parallel@accu.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, gcc@gcc.gnu.org, p796231 <Peter.Sewell@cl.cam.ac.uk>, torvalds@linux-foundation.org, Mark Batty <Mark.Batty@cl.cam.ac.uk>, peterz@infradead.org, will.deacon@arm.com, Ramana.Radhakrishnan@arm.com, dhowells@redhat.com, akpm@linux-foundation.org, mingo@kernel.org, Michael Wong <michaelw@ca.ibm.com>

On Wed, Sep 23, 2015 at 03:30:34PM -0700, Hans Boehm wrote:
> I'd really like this to converge.  It's great that it tries to focus on a
> couple of alternatives.  But I'm not sure they're the right ones.
> 
> I kind of like the 7.9 approach of restricting dependency chain to those
> case in which no sane existing optimization break the dependency anyway.
> The hope would then be that we can restrict future optimizations to not do
> so either without too much cost.  But I'm again very concerned as to
> whether this can be specified acceptably.
> 
> The paper discusses the problem with pointer comparisons that effectively
> allow the compiler to remove a dependency by inferring the identity of a
> pointer.  I don't see how to describe the set of all such cases in a way
> that's comprehensible and acceptable in a standard.
> 
> Consider:
> 
> p = x;
> y = p -> a;
> if (x == well_known_pointer) {
>      foo(well_known_pointer -> a);
>      z = true;
> } else {
>      y = 2;
>      z = false;
> }
> 
> Clearly if z = true, the load of y should have depended on that of x.  But
> this should be transformed to:
> 
> p = x;
> if (x == well_known_pointer) {
>      foo(y = well_known_pointer -> a);
>      z = true;
> } else {
>      y = 2;
>      z = false;
> }
> 
> which no longer has that property.  And I suspect we can construct examples
> in which the conditional is in a subsequent inlined function call, and
> entirely invisible to the programmer.  And there are probably issues with
> compilers using more complicated chains of reasoning to infer that pointers
> must be equal, e.g. because anything else would result in undefined
> behavior.  I'm once again being doubtful that we can pull off anything
> along these lines.

Indeed, the first paragraph of "Equality comparisons" on page 32 says
"This dependency-chain breakage can back-propagate to earlier uses of
the pointer".  The "Narrowing magnitude comparisons" paragraph on that
same page makes this same point for sequences of inequality comparisons
that allow the compiler to deduce the exact value of the pointer.
The comparisons currently in the Linux kernel are against compile-time
initialized constant-value structures, in which case breaking the
dependency chain is OK.

I agree that the compiler could legally introduce a pointer comparison,
as noted in the "Equality comparisons" section, for example, when using
feedback-directed profiling.  Do you see other reasons why the compiler
would do this?

> 7.10 looks like a good direction, but it seems to me that we need to say
> more about handling expression temporaries and function results.
> Presumably at least ordinary expression temporaries implicitly carry
> dependencies?  Thus if both x and y are marked with _Carries_dependency,
> then
> 
> y = ((x ^ x) & 0) * 0
> 
> carries a dependency from x to y?

Yes, but a high-quality implementation would be capable of issuing a
warning in this case.  After all, the developer presumably used
memory_order_consume to gain better performance, but in this case
that added performance is reduced or perhaps even eliminated completely
by the additional code required to maintain the dependency chain.

The reason for carrying the dependency in this case is instead to make
it easier on the people producing tooling.

> I'm leaning again towards something similar to what we attempted to specify
> in the current standard, but restricted to temporaries, maybe function
> locals, and explicitly annotated locations.  This would be some combination
> of 7.10 and maybe 7.5.  It has the down side that it will likely require a
> bunch of explicit attributes (or some kind of C equivalent, though I'm not
> sure storage class works well for function arguments and results).  But it
> should avoid the kill-dependency proliferation required by the current
> standard.  And we could start to actually clean up the remaining problems
> with carries_dependency.

The nice thing about having some sort of marking is that it helps in
generation of good diagnostics.  We also need dependency chains to pass
into and out of functions, and this need will become more acute as
link-time optimization becomes more mainstream, which can remove the
function-call overhead from calls to external functions.  We need the
compiler to know for sure whether or not a given formal parameter or
return value carries a dependency, so some sort of marking is required.
In addition, where structures (as opposed to pointers/references to
structures) are passed into and out of functions, we will very likely
need some way to mark the fields of those structures that are expected
to carry dependencies.  (The Linux kernel tends to avoid this, which
I like, but other projects are likely to make other choices, regardless
of my opinions.)

That marking could be the [[carries_dependency]] attribute (at least
assuming that C adds attributes), a type modifier (which might or might
not go over well in Core), a variable modifier (which I don't understand
well enough to have an opinion), or a storage class as suggested in 7.10.

I am not all that worried about exactly what sort of marking we use,
but I am convinced that marking is required.

So, given that we need to mark things, what sort of marking would work
best from your perspective?

							Thanx, Paul

> On Tue, Sep 22, 2015 at 10:00 AM, Paul E. McKenney <
> paulmck@linux.vnet.ibm.com> wrote:
> 
> > On Mon, Jul 13, 2015 at 05:44:59PM -0700, Paul E. McKenney wrote:
> > > On Tue, May 19, 2015 at 05:55:10PM -0700, Paul E. McKenney wrote:
> > > > Hello!
> > > >
> > > > Following up on last year's discussion (
> > https://lwn.net/Articles/586838/,
> > > > https://lwn.net/Articles/588300/), I believe that we have a
> > solution.  If
> > > > I am wrong, I am sure you all will let me know, and in great detail.
> > ;-)
> > > >
> > > > The key simplification is to "just say no" to RCU-protected array
> > indexes:
> > > > https://lkml.org/lkml/2015/5/12/827, as was suggested by several
> > people.
> > > > This simplification means that rcu_dereference (AKA
> > memory_order_consume)
> > > > need only return pointers.  This in ture avoids things like (x-x),
> > > > (x*0), and (x%1) because if "x" is a pointer, these expressions either
> > > > return non-pointers are compilation errors.  With a very few
> > exceptions,
> > > > dependency chains can lead -to- non-pointers, but cannot pass -through-
> > > > them.
> > > >
> > > > The result is that dependencies are carried only by operations for
> > > > which the compiler cannot easily optimize the away those dependencies,
> > > > these operations including simple assignment, integer offset (including
> > > > indexing), dereferencing, casts, passing as a function argument, return
> > > > values from functions and so on.  A complete list with commentary
> > starts
> > > > on page 28 of:
> > > >
> > > >     http://www.rdrop.com/users/paulmck/RCU/consume.2015.05.18a.pdf
> > >
> > > And an update is available here:
> > >
> > >       http://www.rdrop.com/users/paulmck/RCU/consume.2015.07.13a.pdf
> > >
> > > Among other things, this update addresses the points about equality
> > > comparisons introduced by the compiler, and outlines some of the
> > > issues head-/tail-marked alternatives face with respect to abstraction.
> > > The updated "Restricted Dependency Chains" section starts on page 28.
> > >
> > > Thoughts?
> >
> > This is updated based on many offline discussions.  Section 7.9 has
> > been updated accordingly, but still starts on page 28.  This approach is
> > again intended for large existing RCU code bases such as the Linux kernel.
> >
> > A new Section 7.10 starting on page 35 describes a possible longer-term
> > solution for new-to-RCU code bases.  This approach adds a storage class
> > that indicates that the marked object carries dependencies.  This allows
> > better diagnostics (and arguably better code self-documentation) as well
> > as providing something that formal-verification tools can handle while
> > avoiding the need for compilers to trace dependency chains.
> >
> > http://www.rdrop.com/users/paulmck/submission/consume.2015.09.22a.pdf
> >
> > Thoughts?
> >
> >                                                         Thanx, Paul
> >
> >
> >
