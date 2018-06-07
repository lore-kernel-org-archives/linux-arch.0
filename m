From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
Date: Thu, 7 Jun 2018 08:40:49 -0700
Message-ID: <CA+55aFyAYY_SDFYNVv=eZ02kt6a6zkR2urBOdx7TyD_tWHQ1SQ@mail.gmail.com>
References: <20180607094314.GF3593@linux.vnet.ibm.com> <Pine.LNX.4.44L0.1806071023440.1416-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1806071023440.1416-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, Roman Pen <roman.penyaev@profitbricks.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, andrea.parri@amarulasolutions.com, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nick Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Jun 7, 2018 at 7:57 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> You can look at a memory model from three points of view:
>
> 1.      To a programmer, the model provides both guarantees (a certain
>         code snippet will never yield a particular undesired result)
>         and warnings (another snippet might yield an undesired result).
>
> 2.      To a CPU designer, the model provides limits on what the
>         hardware should be allowed to do (e.g., never execute a store
>         before the condition of a preceding conditional branch has been
>         determined -- not even if the CPU knows that the store would be
>         executed on both legs of the branch).
>
> 3.      To a compiler writer, the model provides limits on what code
>         manipulations should be allowed.
>
> Linus's comments mostly fall under viewpoint 2 (AFAICT), and a lot of
> our thinking to date has been in viewpoint 1.  But viewpoint 3 is the
> one most relevant to the code we have been discussing here.

Hmm. Yes. I've been ignoring it because we've historically just
"solved" it by having barriers (either "asm volatile" with a memory
clobber, or just a volatile access) for the cases under discussion.
There isn't a lot of room for compiler games there. We've had issues
with compilers _elsewhere_, but when it comes to memory models, we've
always solved it with "hey, let's make that access volatile", or "we
will force the compiler to use *this* instruction and nothing else".

So we've never actually had much worry about what a compiler could do
for these particular issues.

In fact, one of the reasons I personally doubt we will ever use the
C++ memory model things is that I simply don't trust the stanards body
to do the right thing. The discussion about control dependencies vs
data dependencies made me 100% convinced that there is no way in hell
that the C++ standards body model can ever work reliably.

Writing the requirements down as English, and writing them down as an
"abstract machine" that had a lot of syntax caused untold and
completely unnecessary verbiage, and made the end result
incomprehensible to any normal human. Very much so to a compiler
writer.

So honestly, I've given up on the C++ memory model. We've done quite
well with inline asm and "volatile", and since I do not believe we
will ever get rid of either, the C++ memory model isn't much of an
improvement.

And notice that this is very much a fundamental doubt about the whole
approach that the standards language is taking. I'm not doubting that
a memory model cannot be defined. I'm doubting that it can sanely be
described with the approach that the C standards body has.

Honestly, if the C++ standards body had taken a completely different
approach of actually *definining* a virtual machine, and defining the
actual code generation (ie the language would actually *define* what
every operation did in the virtual machine), and defining what the
memory ordering within that virtual machine was, I would give it a
chance in hell of working.

But that's not what the C++ standards body did. Instead, it tried to
define things in terms of "dependency chains" and other very
high-level abstractions.

So I do not believe for a second in the C++ memory ordering. It's
broken. It's broken for fundamental reasons, and I doubt we'll ever
use it because no compiler writer will ever get it remotely right.

> Saying that a control dependency should extend beyond the end of an
> "if" statement is basically equivalent to saying that compiler writers
> are forbidden to implement certain optimizations.

Honestly, what I think the standard should do is *define* that

     if (a) B else C

is defined to generate the code

      load a
      test
      je label1;
      B
      jmp label2
 label1:
      C
 label2:

in the virtual machine.  And then each operation (like "load" vs
"load_acquire" vs "load_volatile") would have well-defined semantics
in that virtual machine. And then a compiler writer would be able to
do any optimization he dam,n well please, as long as it is
semantically 100% equivalent.

That would actually give a program well-defined semantics, and I
guarantee it would make compiler writers happier too, because they'd
have a definition they can follow and think about. The memory ordering
requirements would fall out from the memory ordering defined for the
virtual machine, and then that machine could be described sanely.

In the above kind of situation, I believe we could have described what
"control vs data dependency" means, because you could have specified
it for the virtual machine, and then the compiler writers could
determine from that well-defined flow (and the kind of load they had)
whether they could turn a data dependency into a control dependency
during optimization or not.

But that's not how the C standard is written, and it's not how the
people involved *want* to write it. They want to write it at a high
level, not a low level.

End result: I really don't trust what the C++ memory ordering
semantics are. It's all much too wishy-washy, and I don't think a
compiler writer can ever understand it.

>  Now, my experience
> has been that compiler writers are loathe to give up an optimization
> unless someone can point to a specific part of the language spec and
> show that the proposed optimization would violate it.

I agree. Which is why we sometimes use the big hammer approach and
just say "don't do this optimization at all".

But it's also why the language definition being unclear is so
horrible. It's sometimes simply not all that obvious what the standard
actually allows and what it doesn't, and memory ordering is going to
be way more fragile than even the existing confusion.

So I agree 100% with you that the LKMM cases are not likely to affect
the C standard, and not affect compiler writers.

But I also think that's largely irrelevant, because I don't think it's
worth worrying about. I don't believe we will be using the standard
memory ordering, because it's not going to end up usable, and we'll
continue to roll our own.

I did hope a few years ago that that wouldn't be the case. But the
discussions I was involved with convinced me that there's no hope.

                Linus
