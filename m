From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
Date: Wed, 30 May 2018 14:10:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1805301204590.1502-100000@iolanthe.rowland.org>
References: <CA+55aFy2SqVr3XggBS6_N+EUZMABa0xwpme5BW4qmLQ1h6J3pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFy2SqVr3XggBS6_N+EUZMABa0xwpme5BW4qmLQ1h6J3pQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nick Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>, Roman Pen <roman.penyaev@profitbricks.com>
List-Id: linux-arch.vger.kernel.org

On Wed, 30 May 2018, Linus Torvalds wrote:

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

I'll do my best not to conflate them.

Your phrasing was not the greatest in this regard; it looked like you
were trying to talk about a different static source program.

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

Can you explain in greater detail?  A lot of people would say that
something which occurs under either condition _is_ unconditional, by
definition.

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

That is not entirely clear.  The semantics of a source program are
partly determined by the memory model, and the quality of the memory
model is exactly what this email thread is about.  Under a defective
memory model, this code might indeed have different semantics from the
original.

Granted, it _shouldn't_ -- but our LKMM is not ideal.  As an example,
one of the known defects of the memory model (we have pointed it out
repeatedly from the very beginning) is that when identical writes occur
in the two branches of an "if" statement, just as in your code above,
the model does not allow for the possibility that the compiler may
combine the two writes into one and move it up before the "if".

That's not the issue in this case, but it does show that the memory
model we are working with isn't perfect.  The subject of this
discussion is another example in which the memory model fails to give
the desired result.

[It's also worth pointing out that semantics vary with context.  Is
"x = 1; y = 2;" semantically equivalent to "y = 2; x = 1;"?  It is in
a single-threaded setting.  But in a multi-threaded setting it need not
be.]

> So if you get hung up on trivial syntactic issues, you are by definition
> confused, and your tool is garbage. You're doing memory ordering analysis,
> not syntax parsing, for chrissake!

To be fair, we are (or rather, herd is) doing both.

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

Sorry, not clear enough.  Do you mean that the CPU ends up executing
essentially the same sequence of assembly instructions as you would get
from a naive compilation of this source code?  If so, then I agree.

By the same reasoning, at run-time the code also ends up being

	A
	if (B)
		;
	D

(that is, the sequence of executed assembly instructions would be
essentially the same).

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

Sure, in the code you wrote there is a control dependency from A to D.  
I would never say otherwise.

But my earlier email concerned the original source code outline.  
Whether the two are semantically equivalent or not, they are certainly
different syntactically.  herd's analysis has a large syntactic
component; given the original source code, LKMM does not generate a
control dependency from A to D.

You may think this is a weakness in LKMM: It treats two semantically
equivalent programs differently just because of syntactic variations.  
I wouldn't disagree.  (Much the same could be said of real C
compilers.)

In fact, the whole point of my original email was that this code 
pattern illustrates a weakness in LKMM.

> Anybody - or any tool - that doesn't see that is fundamentally wrong, and
> has been confused by syntax.
> 
> A *compiler* will very much also make that distinction. If it doesn't make
> that distinction, it's not a compiler, it's a buggy piece of shit.
> 
> Because semantics matter.
> 
> Think about it.

In the end, it seems that we are in violent agreement.  :-)

Alan
