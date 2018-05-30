From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
Date: Wed, 30 May 2018 09:59:28 -0500
Message-ID: <CA+55aFy2SqVr3XggBS6_N+EUZMABa0xwpme5BW4qmLQ1h6J3pQ@mail.gmail.com>
References: <CA+55aFzYca7EBTEbhJMoJcGspVGhmty243WQR_w7Eykmw9HX9w@mail.gmail.com>
 <Pine.LNX.4.44L0.1805301009340.1502-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1805301009340.1502-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, andrea.parri@amarulasolutions.com, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nick Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>, Roman Pen <roman.penyaev@profitbricks.com>
List-Id: linux-arch.vger.kernel.org

On Wed, May 30, 2018 at 9:29 AM Alan Stern <stern@rowland.harvard.edu>
wrote:

> >
> > Can't we simplify the whole sequence as basically
> >
> >      A
> >      if (!B)
> >          D
> >
> > for that "not B" case, and just think about that. IOW, let's ignore the
> > whole "not executed" code.

> Your listing is slightly misleading.

No. You're confused.

You're confused because you're conflating two *entirely* different things.

You're conflating the static source code with the dynamic execution. They
are NOT THE SAME.

   It really should be:

>          A
>          if (!B)
>                  ; // NOP
>          D

No it really really shouldn't.

There are two completely different situations:

(1) there is the source code:

     A
     if (B)
          C
     D

where  C contains a barrier, and B depends on A and is not statically
determinable.

In the source code, 'D' looks unconditional BUT IT DAMN WELL IS NOT.

It's not unconditional - it's just done in both conditions! That's a big
big difference.

> In other words, D should be beyond the end of the "if" statement, not
> inside one of the branches.

You're just completely confused.

What you are stating makes no sense at all.

Seriously, your reading of the code is entirely monsenscal, and seems to be
about syntax, not about semantics. Which is crazy.

Lookie here, you can change the syntactic model of that code to just be

     A
     if (B)
         C
         D
     else
         D

and that code obviously has the EXACT SAME SEMANTICS.

So if you get hung up on trivial syntactic issues, you are by definition
confused, and your tool is garbage. You're doing memory ordering analysis,
not syntax parsing, for chrissake!

>   At run time, of course, it doesn't matter;
> CPUs don't try to detect where the two branches of an "if" recombine.
> (Leaving aside issues like implementing an "if" as a move-conditional.)

You cannot do it as a move-conditional, since that code generation would
have been buggy shit, exactly because of C. But that's a code generation
issue, not a run-time decision.

So at run-time, the code ends up being

     A
     if (!B)
         D

and D cannot be written before A has been read, because B depends on A, and
you cannot expose specutive writes before the preconditions have been
evaluated.

> Remember, the original code was:

>          A
>          if (!B)
>                  C
>          D

> So the execution of D is _not_ conditional, and it doesn't depend on A
> or B.  (Again, CPUs don't make this distinction, but compilers do.)

Again, the above is nothing but confused bullshit.

D depends on B, which depends on A.

Really. Really really.

Anybody - or any tool - that doesn't see that is fundamentally wrong, and
has been confused by syntax.

A *compiler* will very much also make that distinction. If it doesn't make
that distinction, it's not a compiler, it's a buggy piece of shit.

Because semantics matter.

Think about it.

                  Linus
