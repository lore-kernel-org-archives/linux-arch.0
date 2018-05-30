From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
Date: Wed, 30 May 2018 10:46:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1805301035140.1502-100000@iolanthe.rowland.org>
References: <20180529225321.GQ3803@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180529225321.GQ3803@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, andrea.parri@amarulasolutions.com, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nick Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>, Roman Pen <roman.penyaev@profitbricks.com>
List-Id: linux-arch.vger.kernel.org

On Tue, 29 May 2018, Paul E. McKenney wrote:

> On Tue, May 29, 2018 at 04:10:02PM -0500, Linus Torvalds wrote:
> > On Tue, May 29, 2018 at 3:49 PM Alan Stern <stern@rowland.harvard.edu>
> > wrote:
> > 
> > > Putting this into herd would be extremely difficult, if not impossible,
> > > because it involves analyzing code that was not executed.
> 
> One (ugly) way to handle it, assuming we are correct about what it
> happening, would be to place ordering on the other side of the "if"
> that is at least as strong as on the first side.  Probably some example
> that completely breaks this approach, though...
> 
> > Does it?
> > 
> > Can't we simplify the whole sequence as basically
> > 
> >      A
> >      if (!B)
> >          D
> > 
> > for that "not B" case, and just think about that. IOW, let's ignore the
> > whole "not executed" code.
> > 
> > If B depends on A like you state, then that already implies that the write
> > in D cannot come before the read of A.
> > 
> > You fundamentally cannot do a conditional write before the read that the
> > write condition depends on. So *any* write after a conditional is dependent
> > on the read.
> > 
> > So the existence of C - whether it has a barrier or not - is entirely
> > immaterial at run-time.
> > 
> > Now, the *compiler* can use the whole existence of that memory barrier in C
> > to determine whether it can re-order the write to D or not, of course, but
> > that's a separate issue, and then the whole "code that isn't executed" is
> > not the issue any more. The compiler obviously sees all code, whether
> > executing or not.
> > 
> > Or am I being stupid and missing something entirely? That's possible.
> 
> This will take some analysis, both to make sure that I got Roman's
> example correct and to get to the bottom of exactly what LKMM thinks
> can be reordered.  I am shifting timezones eastward, so I am not going
> to dig into it today.
> 
> But here are a couple of things that take some getting used to:
> 
> 1.	The "if (r1 == x)" would likely be "if (r1 == &x)" in the Linux
> 	kernel.
> 
> 2.	Unless there is something explicit stopping the reordering, the
> 	herd tool assumes that the compiler can reorder unrelated code
> 	completely across the entirety of an "if" statement.  It might
> 	well have decided that it could do so in this case, due to the
> 	fact that the "if" statement isn't doing anything with x (just
> 	with its address).
> 
> 	But yes, given that r1 comes from the load from *c, it would
> 	be difficult (at best) to actually apply that optimization in
> 	this case.
> 
> But let's find out what is really happening.  Easy to speculate, but
> much harder to speculate correctly.  ;-)

What's really happening is that herd doesn't realize the load from *c
must execute before the store to x (as in your 2 above).  You can see
this if you add the following to linux-kernel.cat:

let prop2 = ((prop \ id) & int)

and then run the modified litmus test through herd with "-show prop
-doshow prop2 -gv".  The output graph has a prop2 link from the store
to x leading back to the load from c, indicating that in this
execution, the store must execute before the load.

Alan
