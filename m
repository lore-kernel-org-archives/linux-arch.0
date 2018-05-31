From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
Date: Thu, 31 May 2018 10:27:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1805311008460.1607-100000@iolanthe.rowland.org>
References: <20180530231441.GO7063@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180530231441.GO7063@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, andrea.parri@amarulasolutions.com, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nick Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>, Roman Pen <roman.penyaev@profitbricks.com>
List-Id: linux-arch.vger.kernel.org

On Wed, 30 May 2018, Paul E. McKenney wrote:

> On Wed, May 30, 2018 at 05:01:01PM -0500, Linus Torvalds wrote:
> > On Wed, May 30, 2018 at 2:08 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > Indeed.  The very first line Linus quoted in his first reply to me
> > > (elided above) was:
> > >
> > >         Putting this into herd would be extremely difficult, if not impossible,
> > >         because it involves analyzing code that was not executed.
> > >
> > > It should be clear from this that I was talking about herd.  Not gcc or
> > > real hardware.
> > 
> > So what does herd actually work on? The source code or the executable,
> > or a trace?
> 
> The source code, that is, the source code of the litmus test.
> There are definitions for the various Linux operations, partly within
> the herd tool and partly in the linux.def file in tools/memory-model.
> The problem we are having is nailing down control dependencies and
> compiler optimizations.  The bit about limiting control dependencies
> through the end of "if" statement itself works well in a great many cases,
> but this clearly is not one of them.
> 
> > I found the herd paper, but I'm on the road helping my daughter in
> > college move, and I don't have the background to skim the paper
> > quickly and come up with the obvious answer, so I'l just ask.
> 
> It is not a short learning curve.
> 
> > Because I really think that from our memory model standpoint, we
> > really do have the rule that
> > 
> >    load -> cond -> store
> > 
> > is ordered - even if the store address and store data is in no way
> > dependent on the load. The only thing that matters is that there's a
> > conditional that is dependent on the load in between the load and the
> > store.

This is true for all the architectures supported by the Linux kernel.  
However, in the future it might not always hold.  I can imagine that
CPU designers would want to include an optimization that checks a
conditional branch to see if it skips over only the following
instruction (and the following instruction can't affect the flow of
control); in that situation, they might decide there doesn't need to be
a control dependency to future stores.  Such an optimization would not
violate the C11 memory model.

Of course, this is purely theoretical.  And if anybody does decide to
try doing that, the memory-model people might scream at them so hard
they change their minds.  :-)

...

> > But I don't know what level 'herd' works on. If it doesn't see
> > compiler barriers (eg our own "barrier()" macro that literally is just
> > that), only sees the generated code, then it really has no other
> > information than what he compiler _happened_ to do - it doesn't know
> > if the compiler did the store after the conditional because it *had*
> > to do so, or whether it was just a random instruction scheduling
> > decision.
> 
> The 'herd' tool works on litmus-test source, and has almost no idea of
> what compilers get up to.  In this particular case, it would be better
> off being even more ignorant of what compilers get up to.  ;-)

In more detail, herd analyzes the source code and constructs a set of
all possible candidate executions.  herd then checks each execution to
see if it violates the rules of the memory model as expressed in the
.bell and .cat files.  If any of the non-violating executions satisfies
the litmus test's final "exists" condition, herd reports that the test
is allowed.

The point here is that when herd checks any one particular execution, 
it pays attention _only_ to the statements which are part of that 
execution.  Statements belonging to an untaken "if" branch are ignored 
completely.  That's why I think it would be difficult to make herd do 
exactly what we want in this case.

Alan
