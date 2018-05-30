From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
Date: Wed, 30 May 2018 11:38:26 -0700
Message-ID: <20180530183826.GI7063@linux.vnet.ibm.com>
References: <CA+55aFzYca7EBTEbhJMoJcGspVGhmty243WQR_w7Eykmw9HX9w@mail.gmail.com>
 <Pine.LNX.4.44L0.1805301009340.1502-100000@iolanthe.rowland.org>
 <CA+55aFy2SqVr3XggBS6_N+EUZMABa0xwpme5BW4qmLQ1h6J3pQ@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFy2SqVr3XggBS6_N+EUZMABa0xwpme5BW4qmLQ1h6J3pQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, andrea.parri@amarulasolutions.com, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nick Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>, Roman Pen <roman.penyaev@profitbricks.com>
List-Id: linux-arch.vger.kernel.org

On Wed, May 30, 2018 at 09:59:28AM -0500, Linus Torvalds wrote:
> On Wed, May 30, 2018 at 9:29 AM Alan Stern <stern@rowland.harvard.edu>
> wrote:
> 
> > >
> > > Can't we simplify the whole sequence as basically
> > >
> > >      A
> > >      if (!B)
> > >          D
> > >
> > > for that "not B" case, and just think about that. IOW, let's ignore the
> > > whole "not executed" code.
> 
> > Your listing is slightly misleading.
> 
> No. You're confused.
> 
> You're confused because you're conflating two *entirely* different things.
> 
> You're conflating the static source code with the dynamic execution. They
> are NOT THE SAME.

I am going to go out on a limb and assert that Linus is talking about
what gcc and hardware do, while Alan is talking about what the tool and
memory model do.  In a perfect world, these would be the same, but it
appears that the world might not be perfect just now.

My current guess is that we need to change the memory-model tool.  If
that is the case, here are some possible resolutions:

1.	Make herd's C-language control dependencies work the same as its
	assembly language, so that they extend beyond the end of the
	"if" statement.  I believe that this would make Roman's case
	work, but it could claim that other situations are safe that
	are actually problematic due to compiler optimizations.

	The fact that the model currently handles only READ_ONCE()
	and WRITE_ONCE() and not unmarked reads and writes make this
	option more attractive than it otherwise be, compilers not
	being allowed to reorder volatile accesses, but we are likely
	to introduce unmarked accesses sometime in the future.

2.	Like #1 above, but only if something in one of the "if"'s
	branches would prevent the compiler from reordering
	(smp_mb(), synchronize_rcu(), value-returning non-relaxed
	RMW atomic, ...).  Easy for me to say, but I am guessing
	that much violence would be needed to the tooling to make
	this work.  ;-)

If I understand Alan correctly, there is not an obvious way to make
this change within the confines of the memory model's .bell and .cat
files.

						Thanx, Paul

>    It really should be:
> 
> >          A
> >          if (!B)
> >                  ; // NOP
> >          D
> 
> No it really really shouldn't.
> 
> There are two completely different situations:
> 
> (1) there is the source code:
> 
>      A
>      if (B)
>           C
>      D
> 
> where  C contains a barrier, and B depends on A and is not statically
> determinable.
> 
> In the source code, 'D' looks unconditional BUT IT DAMN WELL IS NOT.
> 
> It's not unconditional - it's just done in both conditions! That's a big
> big difference.
> 
> > In other words, D should be beyond the end of the "if" statement, not
> > inside one of the branches.
> 
> You're just completely confused.
> 
> What you are stating makes no sense at all.
> 
> Seriously, your reading of the code is entirely monsenscal, and seems to be
> about syntax, not about semantics. Which is crazy.
> 
> Lookie here, you can change the syntactic model of that code to just be
> 
>      A
>      if (B)
>          C
>          D
>      else
>          D
> 
> and that code obviously has the EXACT SAME SEMANTICS.
> 
> So if you get hung up on trivial syntactic issues, you are by definition
> confused, and your tool is garbage. You're doing memory ordering analysis,
> not syntax parsing, for chrissake!
> 
> >   At run time, of course, it doesn't matter;
> > CPUs don't try to detect where the two branches of an "if" recombine.
> > (Leaving aside issues like implementing an "if" as a move-conditional.)
> 
> You cannot do it as a move-conditional, since that code generation would
> have been buggy shit, exactly because of C. But that's a code generation
> issue, not a run-time decision.
> 
> So at run-time, the code ends up being
> 
>      A
>      if (!B)
>          D
> 
> and D cannot be written before A has been read, because B depends on A, and
> you cannot expose specutive writes before the preconditions have been
> evaluated.
> 
> > Remember, the original code was:
> 
> >          A
> >          if (!B)
> >                  C
> >          D
> 
> > So the execution of D is _not_ conditional, and it doesn't depend on A
> > or B.  (Again, CPUs don't make this distinction, but compilers do.)
> 
> Again, the above is nothing but confused bullshit.
> 
> D depends on B, which depends on A.
> 
> Really. Really really.
> 
> Anybody - or any tool - that doesn't see that is fundamentally wrong, and
> has been confused by syntax.
> 
> A *compiler* will very much also make that distinction. If it doesn't make
> that distinction, it's not a compiler, it's a buggy piece of shit.
> 
> Because semantics matter.
> 
> Think about it.
> 
>                   Linus
> 
