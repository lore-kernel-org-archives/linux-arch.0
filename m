From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
Date: Wed, 6 Jun 2018 12:23:33 -0700
Message-ID: <CA+55aFwZTAp3wZYGSJR1kPkc=QhPNMdEEPttsM4REcWPPDH9Bw@mail.gmail.com>
References: <20180530183826.GI7063@linux.vnet.ibm.com> <Pine.LNX.4.44L0.1805301449350.1502-100000@iolanthe.rowland.org>
 <CAJrWOzBMB-6e1pKms4L216k=TN_Lr52_gWxj-ny8yitgf+K5gg@mail.gmail.com> <20180606190710.GY3593@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606190710.GY3593@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Roman Pen <roman.penyaev@profitbricks.com>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, andrea.parri@amarulasolutions.com, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nick Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 6, 2018 at 12:05 PM Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
>
> 3.      Introduce a new marking/attribute in the .def file that indicates
>         whether an access is volatile or implies a compiler barrier.
>         This might allow herd to be more selective about control dependencies,
>         for example, extending them past the end of "if" statements
>         containing compiler barriers.
>
>         One tricky aspect of this approach is working out what the
>         compiler can do to the "if" statement.  We definitely do not
>         want to put the complexity of all possible compilers into herd!

This _smells_ like the right thing to do.

Aren't the litmus-tests effectively always going to be using READ_ONCE
etc volatile accesses anyway?

Most of what the LKMM litmus tests test for is things with side effects, no?

And honestly, that is exactly the kind of litmus test behavior we
*want* our memory model to have, in that any CPU designer (or compiler
designer) that uses our LKMM litmus tests should very much be aware of
the fact that we expect a conditional->store memory ordering to be a
ordering.

We have real code that depends on it, so I think LKMM should expose
those ordering requirements.

I'm also perfectly happy with no markings at all: all memory accesses
are "voiatile" as fat as C is concerned, and cannot be moved around by
the compiler at all - and all that LKMM tests is memory _ordering_,
not "compiler can do X".

Because I think your option 1. is absolutely against everything we
want to happen:

> 1.      Status quo.  This works reasonably well, but we have already
>         seen that your scenario makes it ask for more synchronization
>         than necessary.

We absolutely do *not* want CPU designers etc thinking that we'll add
insane synchronization.

We were already burned by insane bad CPU design once in the form of
the garbage that alpha desigers gave us.

I am personally not at all interested in seeing our memory ordering
rules be "nice". They should be as tight as possible, and *not* allow
any crazy shit that some insane person can come up with. No more
"dependent reads out of ordetr" garbage, and no more "store done
before the condition it depends on" garbage.

A CPU designer (or a C++ memory ordering person) who tries to sneak
shit like that past us should be shunned, and not taken seriously.

And our memory ordering rules should be very explicit about it, so
that people don't even _try_ to do insane things.

I want any memory ordering litmus tests to say "we depend on this, so
as a CPU designer don't mess it up, because then we won't run on the
resulting crap".

I'm not in the least interested in the LKMM litmus tests being an
excuse for unnecessarily weak memory ordering. That's the *opposite*
of what I would want any litmus tests to do.

If people are looking to use them that way, then I'm going to remove
them, because such litmus tests are not in the best interest of the
kernel.

Future CPU designs need to be *saner*, not perpetuate the kind of
garbage insanity we have seen so far.

                 Linus
