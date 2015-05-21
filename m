From: Michael Matz <matz@suse.de>
Subject: Re: [c++std-parallel-1632] Re: Compilers and RCU readers: Once more
 unto the breach!
Date: Thu, 21 May 2015 18:17:43 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1505211731360.27315@wotan.suse.de>
References: <20150520005510.GA23559@linux.vnet.ibm.com> <CA+55aFy_8V-rbE9FQMHx6tXjj8HHKZuKSJvnRPVYvpk46EQA1g@mail.gmail.com> <CA+55aFxOtcB8AYCpLQBGSXK=8_Vh4uDs5HEpzGpPy+hgz542ag@mail.gmail.com> <20150520024148.GD6776@linux.vnet.ibm.com> <20150520114745.GC11498@arm.com>
 <20150520121522.GH6776@linux.vnet.ibm.com> <20150520154617.GE11498@arm.com> <555CAE4B.4050202@redhat.com> <20150520181647.GU6776@linux.vnet.ibm.com> <alpine.LSU.2.20.1505211607040.27315@wotan.suse.de> <20150521151006.GQ6776@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150521151006.GQ6776@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: c++std-parallel@accu.org, Will Deacon <will.deacon@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, p796231 <Peter.Sewell@cl.cam.ac.uk>, "mark.batty@cl.cam.ac.uk" <Mark.Batty@cl.cam.ac.uk>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "michaelw@ca.ibm.com" <michaelw@vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

Hi,

On Thu, 21 May 2015, Paul E. McKenney wrote:

> The point is -exactly- to codify the current state of affairs.

Ah, I see, so it's not yet about creating a more useful (for compilers, 
that is) model.

> >   char * fancy_assign (char *in) { return in; }
> >   ...
> >   char *x, *y;
> >   
> >   x = atomic_load_explicit(p, memory_order_consume);
> >   y = fancy_assign (x);
> >   atomic_store_explicit(q, y, memory_order_relaxed);
> > 
> > So, is there, or is there not a dependency carried from x to y in your 
> > proposed model (and which rule in your document states so)?  Clearly, 
> > without any other language the compiler would have to assume that there is 
> > (because the equivalent 'y = x' assignment would carry the dependency).  
> 
> The dependency is not carried, though this is due to the current set
> of rules not covering atomic loads and stores, which I need to fix.

Okay, so with the current regime(s), the dependency carries ...

> o	Rule 14 says that if a value is part of a dependency chain and
> 	is used as the actual parameter of a function call, then the
> 	dependency chain extends to the corresponding formal parameter,
> 	namely "in" of fancy_assign().
> 
> o	Rule 15 says that if a value is part of a dependency chain and
> 	is returned from a function, then the dependency chain extends
> 	to the returned value in the calling function.
> 
> o	And you are right.  I need to make the first and second rules
> 	cover the relaxed atomic operations, or at least atomic loads and
> 	stores.  Not that this is an issue for existing Linux-kernel code.
> 
> 	But given such a change, the new version of rule 2 would
> 	extend the dependency chain to cover the atomic_store_explicit().

... (if this detail would be fixed).  Okay, that's quite awful ...

> > If it has to assume this, then the whole model is not going to work 
> > very well, as usual with models that assume a certain less-optimal 
> > fact ("carries-dep" is less optimal for code generation purposes that 
> > "not-carries-dep") unless very specific circumstances say it can be 
> > ignored.
> 
> Although that is a good general rule of thumb, I do not believe that it 
> applies to this situation, with the exception that I do indeed assume 
> that no one is insane enough to do value-speculation optimizations for 
> non-NULL values on loads from pointers.
> 
> So what am I missing here?

... because you are then missing that if "carries-dep" can flow through 
function calls from arguments to return values by default, the compiler 
has to assume this in fact always happens when it can't see the function 
body, or can't analyze it.  In effect that's making the whole "carries-dep 
stops at these and those uses" a useless excercise because a malicious 
user (malicious in the sense of abusing the model to show that it's 
hindering optimizations), i.e. me, can hide all such carries-dep stopping 
effects inside a function, et voila, the dependecy carries through.  So 
for a slightly more simple example:

  extern void *foo (void *);  // body not available
  x = load
  y = foo (x);
  store (y)

the compiler has to assume that there's a dep-chain from x to y; always.  
What's worse, it also has to assume a carries-dep for this:

  extern void foo (void *in, void **out1, void **out2);
  x = load
  foo (x, &o1, &o2);
  store (o1);
  store (o2);

Now the compiler has to assume that the body of 'foo' is just mean enough 
to make the dep-chain carry from in to *out1 or *out2 (i.e. it has to 
assume that for both).  This extends to _all_ memory accessible from foo's 
body, i.e. generally all global and all local address-taken variables, so 
as soon as you have a function call into which a dep-chain value flows 
you're creating a dep-chain extension from that value to each and every 
global piece of memory, because the compiler cannot assume that the 
black box called foo is not mean.  This could conceivably be stopped by 
making normal stores not to carry the dependency; then only the return 
value might be infected; but I don't see that in your rules, as a "normal 
store" is just an assigment in your model and hence rules 1 and 2 apply 
(that is, carries-dep flows through all assignments, incl. loads and 
stores).

Basically whenever you can construct black boxes for the compiler, you 
have to limit their effects on such transitive relations like carries-dep 
by default, at the border of such black boxes; otherwise that transitive 
relation quickly becomes an most-x-everything relation (i.e. 
mostthings carries-dep to everything), and as such is then totally 
useless, because such a universally filled relation (like an empty one) 
doesn't bear any interesting information, at which point it then is 
questionably why the compiler should jump through hoops to analyse the few 
cases that would be allowed to stop the carries-dep flow, when it more 
often than not have to give up anyway and generate slow code.

> Do you have a specific example where the compiler would need to suppress 
> a production-quality optimization?

I can't say; I haven't completely grokked all details of the different sub 
mem-models and their interaction with compiler optimizations, and when to 
convert consume to aquire.  But I do know that transitive relations that 
carry a code generation cost (i.e. that when two entities are related 
you're limited in what you can do), let's call them infections :), have to 
be quite strictly limited in scope, otherwise they become useless.

Real world examples that are quite terrible to get right, and get good 
code out of at the same time, is aliasing and effective-type of memory 
cells, which have some similar properties to the current carries-dep.  
Both concepts added to the language after-the-fact (to capture some 
assumptions that were used in practice, and that seemed sensible), but 
then in a way that weren't limiting their scope very well.  For instance, 
if you follow the c++ language strictly, you can't assume that a 
anonymuous cell that was holding an int before a function call is still 
holding an int afterwards, even without any stores in between, because the 
function could use placement new to change the cells type.  Guess how GCC 
deals with this?  We've designed and redesigned our memory model to 
accomodate for this: It's conservatively assuming that crap-happens-here 
is part of most function calls (because in the real world, it indeed is 
the case that crap-happens-there) :)


Ciao,
Michael.
