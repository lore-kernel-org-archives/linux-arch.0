From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
Date: Wed, 6 Jun 2018 09:54:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1806060950050.1359-100000@iolanthe.rowland.org>
References: <CAJrWOzBMB-6e1pKms4L216k=TN_Lr52_gWxj-ny8yitgf+K5gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJrWOzBMB-6e1pKms4L216k=TN_Lr52_gWxj-ny8yitgf+K5gg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roman Penyaev <roman.penyaev@profitbricks.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, andrea.parri@amarulasolutions.com, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nick Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, 6 Jun 2018, Roman Penyaev wrote:

> > Preserving the order of volatile accesses isn't sufficient.  The
> > compiler is still allowed to translate
> >
> >         r1 = READ_ONCE(x);
> >         if (r1) {
> >                 ...
> >         }
> >         WRITE_ONCE(y, r2);
> >
> > into something resembling
> >
> >         r1 = READ_ONCE(x);
> >         WRITE_ONCE(y, r2);
> >         if (r1) {
> >                 ...
> >         }
> 
> Hi Alan,
> 
> According to the standard C99 Annex C "the controlling expression of
> a selection statement (if or switch)" are the sequence points, just
> like a volatile access (READ_ONCE or WRITE_ONCE).
> 
> "5.1.2.3 Program execution" states:
> "At certain specified points in the execution sequence called sequence
> points, all side effects of previous evaluations shall be complete
> and no side effects of subsequent evaluations shall have taken place."
> 
> So in the example we have 3 sequence points: "READ_ONCE", "if" and
> "WRITE_ONCE", which it seems can't be reordered.  Am I mistaken
> interpreting standard?  Could you please clarify.

Well, for one thing, we're talking about C11, not C99.

For another, as far as I understand it, the standard means the program
should behave _as if_ the side effects are completed in the order
stated.  It doesn't mean that the generated code has to behave that way
literally.  And in particular, the standard is referring to the
behavior of a single thread, not the interaction between multiple
concurrent threads.

Alan
