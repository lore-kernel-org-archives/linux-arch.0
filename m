From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [c++std-parallel-1632] Re: Compilers and RCU readers: Once more
 unto the breach!
Date: Thu, 21 May 2015 08:10:06 -0700
Message-ID: <20150521151006.GQ6776@linux.vnet.ibm.com>
References: <20150520005510.GA23559@linux.vnet.ibm.com>
 <CA+55aFy_8V-rbE9FQMHx6tXjj8HHKZuKSJvnRPVYvpk46EQA1g@mail.gmail.com>
 <CA+55aFxOtcB8AYCpLQBGSXK=8_Vh4uDs5HEpzGpPy+hgz542ag@mail.gmail.com>
 <20150520024148.GD6776@linux.vnet.ibm.com>
 <20150520114745.GC11498@arm.com>
 <20150520121522.GH6776@linux.vnet.ibm.com>
 <20150520154617.GE11498@arm.com>
 <555CAE4B.4050202@redhat.com>
 <20150520181647.GU6776@linux.vnet.ibm.com>
 <alpine.LSU.2.20.1505211607040.27315@wotan.suse.de>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1505211607040.27315@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Matz <matz@suse.de>
Cc: c++std-parallel@accu.org, Will Deacon <will.deacon@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, p796231 <Peter.Sewell@cl.cam.ac.uk>, "mark.batty@cl.cam.ac.uk" <Mark.Batty@cl.cam.ac.uk>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "michaelw@ca.ibm.com" <michaelw@vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Thu, May 21, 2015 at 04:22:38PM +0200, Michael Matz wrote:
> Hi,
> 
> On Wed, 20 May 2015, Paul E. McKenney wrote:
> 
> > > > I'm not sure... you'd require the compiler to perform static analysis of
> > > > loops to determine the state of the machine when they exit (if they exit!)
> > > > in order to show whether or not a dependency is carried to subsequent
> > > > operations. If it can't prove otherwise, it would have to assume that a
> > > > dependency *is* carried, and it's not clear to me how it would use this
> > > > information to restrict any subsequent dependency removing optimisations.
> > > 
> > > It'd just convert consume to acquire.
> > 
> > It should not need to, actually.
> 
> [with GCC hat, and having only lightly read your document]

Understood.

> Then you need to provide language or at least informal reasons why the 
> compiler is allowed to not do that.  Without that a compiler would have to 
> be conservative, if it can't _prove_ that a dependency chain is stopped, 
> then it has to assume it hasn't.
> 
> For instance I can't really make out easily what your document says about 
> the following simple situation (well, actually I have difficulties to 
> differ between what you're proposing as the good-new model of this all, 
> and what you're merely describing as different current states of affair):

The point is -exactly- to codify the current state of affairs.  I expect
a follow-on effort to specify some sort of marking regimen, as noted in
the last paragraph of 7.9 and as discussed with Torvald Riegel.  However,
given that there are not yet any implementations or practical experience
with such markings, I suspect that some time will be required to hammer
out a good marking scheme.

>   char * fancy_assign (char *in) { return in; }
>   ...
>   char *x, *y;
>   
>   x = atomic_load_explicit(p, memory_order_consume);
>   y = fancy_assign (x);
>   atomic_store_explicit(q, y, memory_order_relaxed);
> 
> So, is there, or is there not a dependency carried from x to y in your 
> proposed model (and which rule in your document states so)?  Clearly, 
> without any other language the compiler would have to assume that there is 
> (because the equivalent 'y = x' assignment would carry the dependency).  

The dependency is not carried, though this is due to the current set
of rules not covering atomic loads and stores, which I need to fix.
Here is the sequence of events:

o	A memory_order_consume load heads a dependency chain.

o	Rule 2 says that if a value is part of a dependency chain and
	is used as the right-hand side of an assignment operator,
	the expression extends the chain to cover the assignment.
	And I switched to numbered bullet items here:
	http://www2.rdrop.com/users/paulmck/RCU/consume.2015.05.21a.pdf

o	Rule 14 says that if a value is part of a dependency chain and
	is used as the actual parameter of a function call, then the
	dependency chain extends to the corresponding formal parameter,
	namely "in" of fancy_assign().

o	Rule 15 says that if a value is part of a dependency chain and
	is returned from a function, then the dependency chain extends
	to the returned value in the calling function.

o	And you are right.  I need to make the first and second rules
	cover the relaxed atomic operations, or at least atomic loads and
	stores.  Not that this is an issue for existing Linux-kernel code.

	But given such a change, the new version of rule 2 would
	extend the dependency chain to cover the atomic_store_explicit().

> If it has to assume this, then the whole model is not going to work very 
> well, as usual with models that assume a certain less-optimal fact 
> ("carries-dep" is less optimal for code generation purposes that 
> "not-carries-dep") unless very specific circumstances say it can be 
> ignored.

Although that is a good general rule of thumb, I do not believe that it
applies to this situation, with the exception that I do indeed assume
that no one is insane enough to do value-speculation optimizations for
non-NULL values on loads from pointers.

So what am I missing here?  Do you have a specific example where the
compiler would need to suppress a production-quality optimization?

							Thanx, Paul
