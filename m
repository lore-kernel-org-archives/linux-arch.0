From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
Date: Wed, 30 May 2018 17:01:01 -0500
Message-ID: <CA+55aFxXgECHW+Pekiuvt1htsDfML2ximrLrmr99xewGYpmEng@mail.gmail.com>
References: <20180530183826.GI7063@linux.vnet.ibm.com> <Pine.LNX.4.44L0.1805301449350.1502-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1805301449350.1502-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, andrea.parri@amarulasolutions.com, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nick Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>, Roman Pen <roman.penyaev@profitbricks.com>
List-Id: linux-arch.vger.kernel.org

On Wed, May 30, 2018 at 2:08 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> Indeed.  The very first line Linus quoted in his first reply to me
> (elided above) was:
>
>         Putting this into herd would be extremely difficult, if not impossible,
>         because it involves analyzing code that was not executed.
>
> It should be clear from this that I was talking about herd.  Not gcc or
> real hardware.

So what does herd actually work on? The source code or the executable,
or a trace?

I found the herd paper, but I'm on the road helping my daughter in
college move, and I don't have the background to skim the paper
quickly and come up with the obvious answer, so I'l just ask.

Because I really think that from our memory model standpoint, we
really do have the rule that

   load -> cond -> store

is ordered - even if the store address and store data is in no way
dependent on the load. The only thing that matters is that there's a
conditional that is dependent on the load in between the load and the
store.

Note that this is *independent* of how you get to the store. It
doesn't matter  if it's a fallthrough conditional jump or  a taken
conditional jump, or whether  there is a joining.

The only thing that *does* matter is whether the conditional can be
turned into a "select" statement. If the conditional can be turned
into a data dependency, then the ordering goes away. That is why it
was relevant whether "C" contained a barrier or not (it doesn't even
have to be a *memory* barrier, it just has to be a barrier for code
generation).

Note that the "C doesn't even have to have a memory barrier" is
important, because the orderin from load->cond->store doesn't actually
have anything to do with any memory ordering imposed by C, it's much
more fundamental than that.

> Preserving the order of volatile accesses isn't sufficient.  The
> compiler is still allowed to translate
>
>         r1 = READ_ONCE(x);
>         if (r1) {
>                 ...
>         }
>         WRITE_ONCE(y, r2);
>
> into something resembling
>
>         r1 = READ_ONCE(x);
>         WRITE_ONCE(y, r2);
>         if (r1) {
>                 ...
>         }

Correct.

What matter is that the code in C (now called "..." above ;^) has a
build-time barrier that means that the compiler cannot do that.

That barrier can be pretty much anything. The important part is
literally that there's a guarantee that the write cannot  be migrated
below the conditional.

But I don't know what level 'herd' works on. If it doesn't see
compiler barriers (eg our own "barrier()" macro that literally is just
that), only sees the generated code, then it really has no other
information than what he compiler _happened_ to do - it doesn't know
if the compiler did the store after the conditional because it *had*
to do so, or whether it was just a random instruction scheduling
decision.

            Linus
