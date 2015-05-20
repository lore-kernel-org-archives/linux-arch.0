From: Will Deacon <will.deacon@arm.com>
Subject: Re: Compilers and RCU readers: Once more unto the breach!
Date: Wed, 20 May 2015 16:46:17 +0100
Message-ID: <20150520154617.GE11498@arm.com>
References: <20150520005510.GA23559@linux.vnet.ibm.com>
 <CA+55aFy_8V-rbE9FQMHx6tXjj8HHKZuKSJvnRPVYvpk46EQA1g@mail.gmail.com>
 <CA+55aFxOtcB8AYCpLQBGSXK=8_Vh4uDs5HEpzGpPy+hgz542ag@mail.gmail.com>
 <20150520024148.GD6776@linux.vnet.ibm.com>
 <20150520114745.GC11498@arm.com>
 <20150520121522.GH6776@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38808 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932395AbbETPqW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 May 2015 11:46:22 -0400
Content-Disposition: inline
In-Reply-To: <20150520121522.GH6776@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "c++std-parallel@accu.org" <c++std-parallel@accu.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, p796231 <Peter.Sewell@cl.cam.ac.uk>, "mark.batty@cl.cam.ac.uk" <Mark.Batty@cl.cam.ac.uk>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "michaelw@ca.ibm.com" <michaelw@ca.ibm.com>

On Wed, May 20, 2015 at 01:15:22PM +0100, Paul E. McKenney wrote:
> On Wed, May 20, 2015 at 12:47:45PM +0100, Will Deacon wrote:
> > On Wed, May 20, 2015 at 03:41:48AM +0100, Paul E. McKenney wrote:
> > > 	If a pointer is part of a dependency chain, and if the values
> > > 	added to or subtracted from that pointer cancel the pointer
> > > 	value so as to allow the compiler to precisely determine the
> > > 	resulting value, then the resulting value will not be part of
> > > 	any dependency chain.  For example, if p is part of a dependency
> > > 	chain, then ((char *)p-(uintptr_t)p)+65536 will not be.
> > > 
> > > Seem reasonable?
> > 
> > Whilst I understand what you're saying (the ARM architecture makes these
> > sorts of distinctions when calling out dependency-based ordering), it
> > feels like we're dangerously close to defining the difference between a
> > true and a false dependency. If we want to do this in the context of the
> > C language specification, you run into issues because you need to evaluate
> > the program in order to determine data values in order to determine the
> > nature of the dependency.
> 
> Indeed, something like this does -not- carry a dependency from the
> memory_order_consume load to q:
> 
> 	char *p, q;
> 
> 	p = atomic_load_explicit(&gp, memory_order_consume);
> 	q = gq + (intptr_t)p - (intptr_t)p;
> 
> If this was compiled with -O0, ARM and Power might well carry a
> dependency, but given any optimization, the assembly language would have
> no hint of any such dependency.  So I am not seeing any particular danger.

The above is a welcome relaxation over C11, since ARM doesn't even give
you ordering based off false data dependencies. My concern is more to do
with how this can be specified precisely without prohibing honest compiler
and hardware optimisations.

Out of interest, how do you tackle examples (4) and (5) of (assuming the
reads are promoted to consume loads)?:

  http://www.cl.cam.ac.uk/~pes20/cpp/notes42.html

my understanding is that you permit both outcomes (I appreciate you're
not directly tackling out-of-thin-air, but treatment of dependencies
is heavily related).

> > You tackle this above by saying "to allow the compiler to precisely
> > determine the resulting value", but I can't see how that can be cleanly
> > fitted into something like the C language specification.
> 
> I am sure that there will be significant rework from where this document
> is to language appropriate from the standard.  Which is why I am glad
> that Jens is taking an interest in this, as he is particularly good at
> producing standards language.

Ok. I'm curious to see how that comes along.

> >                                                          Even if it can,
> > then we'd need to reword the "?:" treatment that you currently have:
> > 
> >   "If a pointer is part of a dependency chain, and that pointer appears
> >    in the entry of a ?: expression selected by the condition, then the
> >    chain extends to the result."
> > 
> > which I think requires the state of the condition to be known statically
> > if we only want to extend the chain from the selected expression. In the
> > general case, wouldn't a compiler have to assume that the chain is
> > extended from both?
> 
> In practice, yes, if the compiler cannot determine which expression is
> selected, it must arrange for the dependency to be carried from either,
> depending on the run-time value of the condition.  But you would have
> to work pretty hard to create code that did not carry the dependencies
> as require, not?

I'm not sure... you'd require the compiler to perform static analysis of
loops to determine the state of the machine when they exit (if they exit!)
in order to show whether or not a dependency is carried to subsequent
operations. If it can't prove otherwise, it would have to assume that a
dependency *is* carried, and it's not clear to me how it would use this
information to restrict any subsequent dependency removing optimisations.

I guess that's one for the GCC folks.

> > Additionally, what about the following code?
> > 
> >   char *x = y ? z : z;
> > 
> > Does that extend a dependency chain from z to x? If so, I can imagine a
> > CPU breaking that in practice.
> 
> I am not seeing this.  I would expect the compiler to optimize to
> something like this:
> 
> 	char *x = z;
> 
> How does this avoid carrying the dependency?  Or are you saying that
> ARM loses the dependency via a store to memory and a later reload?
> That would be a bit surprising...

I was thinking that the compiler would have to preserve the conditional
structure so that the dependency chain could be tracked correctly, but
if it can just assume that the dependency is carried regardless of y then
I agree that it doesn't matter for this code. All the CPU could do is
remove the conditional hazard.

> > > > Humans will understand, and compiler writers won't care. They will
> > > > either depend on hardware semantics anyway (and argue that your
> > > > language is tight enough that they don't need to do anything special)
> > > > or they will turn the consume into an acquire (on platforms that have
> > > > too weak hardware).
> > > 
> > > Agreed.  Plus Core Working Group will hammer out the exact wording,
> > > should this approach meet their approval.
> > 
> > For the avoidance of doubt, I'm completely behind any attempts to tackle
> > this problem, but I anticipate an uphill struggle getting this text into
> > the C standard. Is your intention to change the carries-a-dependency
> > relation to encompass this change?
> 
> I completely agree that this won't be easy, but this is the task at hand.
> And yes, the intent is to change carries-a-dependency, given that the
> current wording isn't helping anything.  ;-)

Agreed on that!

Will
