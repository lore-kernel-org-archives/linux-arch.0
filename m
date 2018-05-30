From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
Date: Wed, 30 May 2018 10:29:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1805301009340.1502-100000@iolanthe.rowland.org>
References: <CA+55aFzYca7EBTEbhJMoJcGspVGhmty243WQR_w7Eykmw9HX9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFzYca7EBTEbhJMoJcGspVGhmty243WQR_w7Eykmw9HX9w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, andrea.parri@amarulasolutions.com, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nick Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>, Roman Pen <roman.penyaev@profitbricks.com>
List-Id: linux-arch.vger.kernel.org

On Tue, 29 May 2018, Linus Torvalds wrote:

> On Tue, May 29, 2018 at 3:49 PM Alan Stern <stern@rowland.harvard.edu>
> wrote:
> 
> > Putting this into herd would be extremely difficult, if not impossible,
> > because it involves analyzing code that was not executed.
> 
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

Your listing is slightly misleading.  It really should be:

	A
	if (!B)
		; // NOP
	D

In other words, D should be beyond the end of the "if" statement, not 
inside one of the branches.  At run time, of course, it doesn't matter; 
CPUs don't try to detect where the two branches of an "if" recombine.
(Leaving aside issues like implementing an "if" as a move-conditional.)

> If B depends on A like you state, then that already implies that the write
> in D cannot come before the read of A.
> 
> You fundamentally cannot do a conditional write before the read that the
> write condition depends on. So *any* write after a conditional is dependent
> on the read.

Remember, the original code was:

	A
	if (!B)
		C
	D

So the execution of D is _not_ conditional, and it doesn't depend on A 
or B.  (Again, CPUs don't make this distinction, but compilers do.)

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

Not at all -- that point about the compiler is exactly what I was
trying to get at.  The object code the compiler generates depends on
the contents of _both_ branches of the "if" statement, even though only
one branch is executed at run time.  Hence an analysis based entirely
on what instructions are executed in a particular run (which is what
herd does) will necessarily be incomplete.

That's what happened here.  The LKMM herd model treats statements
beyond the end of an "if" statement as though the compiler can reorder
them before the start of the "if", unless something in the branch which
was taken prevents this reordering.  But herd ignores the contents of
the untaken branch, even when they would block the reordering.

Alan
