From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
Date: Tue, 29 May 2018 15:53:21 -0700
Message-ID: <20180529225321.GQ3803@linux.vnet.ibm.com>
References: <20180529190332.GO3803@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1805291521570.1458-100000@iolanthe.rowland.org>
 <CA+55aFzYca7EBTEbhJMoJcGspVGhmty243WQR_w7Eykmw9HX9w@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFzYca7EBTEbhJMoJcGspVGhmty243WQR_w7Eykmw9HX9w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, andrea.parri@amarulasolutions.com, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nick Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>, Roman Pen <roman.penyaev@profitbricks.com>
List-Id: linux-arch.vger.kernel.org

On Tue, May 29, 2018 at 04:10:02PM -0500, Linus Torvalds wrote:
> On Tue, May 29, 2018 at 3:49 PM Alan Stern <stern@rowland.harvard.edu>
> wrote:
> 
> > Putting this into herd would be extremely difficult, if not impossible,
> > because it involves analyzing code that was not executed.

One (ugly) way to handle it, assuming we are correct about what it
happening, would be to place ordering on the other side of the "if"
that is at least as strong as on the first side.  Probably some example
that completely breaks this approach, though...

> Does it?
> 
> Can't we simplify the whole sequence as basically
> 
>      A
>      if (!B)
>          D
> 
> for that "not B" case, and just think about that. IOW, let's ignore the
> whole "not executed" code.
> 
> If B depends on A like you state, then that already implies that the write
> in D cannot come before the read of A.
> 
> You fundamentally cannot do a conditional write before the read that the
> write condition depends on. So *any* write after a conditional is dependent
> on the read.
> 
> So the existence of C - whether it has a barrier or not - is entirely
> immaterial at run-time.
> 
> Now, the *compiler* can use the whole existence of that memory barrier in C
> to determine whether it can re-order the write to D or not, of course, but
> that's a separate issue, and then the whole "code that isn't executed" is
> not the issue any more. The compiler obviously sees all code, whether
> executing or not.
> 
> Or am I being stupid and missing something entirely? That's possible.

This will take some analysis, both to make sure that I got Roman's
example correct and to get to the bottom of exactly what LKMM thinks
can be reordered.  I am shifting timezones eastward, so I am not going
to dig into it today.

But here are a couple of things that take some getting used to:

1.	The "if (r1 == x)" would likely be "if (r1 == &x)" in the Linux
	kernel.

2.	Unless there is something explicit stopping the reordering, the
	herd tool assumes that the compiler can reorder unrelated code
	completely across the entirety of an "if" statement.  It might
	well have decided that it could do so in this case, due to the
	fact that the "if" statement isn't doing anything with x (just
	with its address).

	But yes, given that r1 comes from the load from *c, it would
	be difficult (at best) to actually apply that optimization in
	this case.

But let's find out what is really happening.  Easy to speculate, but
much harder to speculate correctly.  ;-)

							Thanx, Paul
