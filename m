From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
Date: Thu, 7 Jun 2018 10:57:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1806071023440.1416-100000@iolanthe.rowland.org>
References: <20180607094314.GF3593@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180607094314.GF3593@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Roman Pen <roman.penyaev@profitbricks.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, andrea.parri@amarulasolutions.com, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nick Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, 7 Jun 2018, Paul E. McKenney wrote:

> On Wed, Jun 06, 2018 at 12:23:33PM -0700, Linus Torvalds wrote:
> > On Wed, Jun 6, 2018 at 12:05 PM Paul E. McKenney
> > <paulmck@linux.vnet.ibm.com> wrote:
> > >
> > > 3.      Introduce a new marking/attribute in the .def file that indicates
> > >         whether an access is volatile or implies a compiler barrier.
> > >         This might allow herd to be more selective about control dependencies,
> > >         for example, extending them past the end of "if" statements
> > >         containing compiler barriers.
> > >
> > >         One tricky aspect of this approach is working out what the
> > >         compiler can do to the "if" statement.  We definitely do not
> > >         want to put the complexity of all possible compilers into herd!
> > 
> > This _smells_ like the right thing to do.
> > 
> > Aren't the litmus-tests effectively always going to be using READ_ONCE
> > etc volatile accesses anyway?
> 
> Yes, right now LKMM handles only volatile (READ_ONCE and WRITE_ONCE)
> or stronger.
> 
> > Most of what the LKMM litmus tests test for is things with side effects, no?
> > 
> > And honestly, that is exactly the kind of litmus test behavior we
> > *want* our memory model to have, in that any CPU designer (or compiler
> > designer) that uses our LKMM litmus tests should very much be aware of
> > the fact that we expect a conditional->store memory ordering to be a
> > ordering.
> > 
> > We have real code that depends on it, so I think LKMM should expose
> > those ordering requirements.
> 
> Good point.  And I did manage to advocate for control dependencies at an
> academic conference earlier this week without the need for a bodyguard,
> so perhaps things are improving.  ;-)
> 
> > I'm also perfectly happy with no markings at all: all memory accesses
> > are "voiatile" as fat as C is concerned, and cannot be moved around by
> > the compiler at all - and all that LKMM tests is memory _ordering_,
> > not "compiler can do X".
> 
> We are considering adding unmarked accesses, for example, accesses
> protected by locks.  One possible litmus test (not yet supported!)
> might look like this:
> 
> 	C Z6.0+pooncelock+pooncelock+pombonce
> 
> 	{}
> 
> 	P0(int *x, int *y, spinlock_t *mylock)
> 	{
> 		spin_lock(mylock);
> 		WRITE_ONCE(*x, 1);
> 		y = 1;
> 		spin_unlock(mylock);
> 	}
> 
> 	P1(int *y, int *z, spinlock_t *mylock)
> 	{
> 		int r0;
> 
> 		spin_lock(mylock);
> 		r0 = y;
> 		WRITE_ONCE(*z, 1);
> 		spin_unlock(mylock);
> 	}
> 
> 	P2(int *x, int *z)
> 	{
> 		int r1;
> 
> 		WRITE_ONCE(*z, 2);
> 		smp_mb();
> 		r1 = READ_ONCE(x);
> 	}
> 
> 	exists (1:r0=1 /\ z=2 /\ 2:r1=0)
> 
> Because y is only ever accessed under a lock, the compiler cannot do
> anything to mess it up.  In this particular case, the compiler would
> have a hard time messing up the other accesses, aside from extremely
> unfriendly measures such as load/store tearing, but we have seen
> Linux-kernel examples where the compiler could very reasonably repeat
> and fuse loads and stores and so on.
> 
> Thoughts?
> 
> > Because I think your option 1. is absolutely against everything we
> > want to happen:
> > 
> > > 1.      Status quo.  This works reasonably well, but we have already
> > >         seen that your scenario makes it ask for more synchronization
> > >         than necessary.
> > 
> > We absolutely do *not* want CPU designers etc thinking that we'll add
> > insane synchronization.
> > 
> > We were already burned by insane bad CPU design once in the form of
> > the garbage that alpha desigers gave us.
> > 
> > I am personally not at all interested in seeing our memory ordering
> > rules be "nice". They should be as tight as possible, and *not* allow
> > any crazy shit that some insane person can come up with. No more
> > "dependent reads out of ordetr" garbage, and no more "store done
> > before the condition it depends on" garbage.
> > 
> > A CPU designer (or a C++ memory ordering person) who tries to sneak
> > shit like that past us should be shunned, and not taken seriously.
> 
> Given that I am writing this in a C++ Standards Committee meeting,
> I do like the call for sanity.
> 
> > And our memory ordering rules should be very explicit about it, so
> > that people don't even _try_ to do insane things.
> > 
> > I want any memory ordering litmus tests to say "we depend on this, so
> > as a CPU designer don't mess it up, because then we won't run on the
> > resulting crap".
> > 
> > I'm not in the least interested in the LKMM litmus tests being an
> > excuse for unnecessarily weak memory ordering. That's the *opposite*
> > of what I would want any litmus tests to do.
> > 
> > If people are looking to use them that way, then I'm going to remove
> > them, because such litmus tests are not in the best interest of the
> > kernel.
> > 
> > Future CPU designs need to be *saner*, not perpetuate the kind of
> > garbage insanity we have seen so far.
> 
> OK, I think we all agree that we need to move away from status quo.
> The workaround buys us some time, but the need to move is undisputed.
> (If someone does dispute it, this would be a great time for them to make
> their concerns known!)
> 
> I will take a hard look at option #3, and see if there any hidden gotchas.

There's another aspect to this discussion.

You can look at a memory model from three points of view:

1.	To a programmer, the model provides both guarantees (a certain
	code snippet will never yield a particular undesired result)
	and warnings (another snippet might yield an undesired result).

2.	To a CPU designer, the model provides limits on what the
	hardware should be allowed to do (e.g., never execute a store
	before the condition of a preceding conditional branch has been
	determined -- not even if the CPU knows that the store would be
	executed on both legs of the branch).

3.	To a compiler writer, the model provides limits on what code
	manipulations should be allowed.

Linus's comments mostly fall under viewpoint 2 (AFAICT), and a lot of
our thinking to date has been in viewpoint 1.  But viewpoint 3 is the
one most relevant to the code we have been discussing here.

Saying that a control dependency should extend beyond the end of an
"if" statement is basically equivalent to saying that compiler writers
are forbidden to implement certain optimizations.  Now, my experience
has been that compiler writers are loathe to give up an optimization
unless someone can point to a specific part of the language spec and
show that the proposed optimization would violate it.

Given that the LKMM has no official standing whatsoever with the C and 
C++ standards committees, how likely is it that we would be able to 
convince them to change the spec merely to satisfy our desires?

It's all very well for Linus to say "no more 'store done before the
condition it depends on' garbage", but that is an empty rant if we are
unable to exert any pressure on the standards or compiler writers.

Perhaps the best we could hope for would be to have a command-line flag
added to gcc (and LLVM?) that would forbid:

	combining two identical volatile stores in the two legs of an 
	"if" statement and moving the result up before the "if", and

	moving a volatile store up before a preceding "if" statement

(or something along those lines -- even expressing this idea precisely
is a difficult thing to do).  I seriously doubt the standards people
would entertain the idea of making these restrictions universal.  
Especially since the specs currently do not include any notion of
dependency at all.

Alan
