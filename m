From: Roman Penyaev <roman.penyaev@profitbricks.com>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
Date: Wed, 6 Jun 2018 16:41:20 +0200
Message-ID: <CAJrWOzB8hz2qzNJAWfNdW_U_ArHmvCpzZVJBebsfQ3=eEiSh7w@mail.gmail.com>
References: <CAJrWOzBMB-6e1pKms4L216k=TN_Lr52_gWxj-ny8yitgf+K5gg@mail.gmail.com>
 <Pine.LNX.4.44L0.1806060950050.1359-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1806060950050.1359-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, andrea.parri@amarulasolutions.com, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nick Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 6, 2018 at 3:54 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Wed, 6 Jun 2018, Roman Penyaev wrote:
>
>> > Preserving the order of volatile accesses isn't sufficient.  The
>> > compiler is still allowed to translate
>> >
>> >         r1 = READ_ONCE(x);
>> >         if (r1) {
>> >                 ...
>> >         }
>> >         WRITE_ONCE(y, r2);
>> >
>> > into something resembling
>> >
>> >         r1 = READ_ONCE(x);
>> >         WRITE_ONCE(y, r2);
>> >         if (r1) {
>> >                 ...
>> >         }
>>
>> Hi Alan,
>>
>> According to the standard C99 Annex C "the controlling expression of
>> a selection statement (if or switch)" are the sequence points, just
>> like a volatile access (READ_ONCE or WRITE_ONCE).
>>
>> "5.1.2.3 Program execution" states:
>> "At certain specified points in the execution sequence called sequence
>> points, all side effects of previous evaluations shall be complete
>> and no side effects of subsequent evaluations shall have taken place."
>>
>> So in the example we have 3 sequence points: "READ_ONCE", "if" and
>> "WRITE_ONCE", which it seems can't be reordered.  Am I mistaken
>> interpreting standard?  Could you please clarify.
>
> Well, for one thing, we're talking about C11, not C99.

C11 is a n1570, ISO/IEC 9899:2011 ? (according to wiki).  Found pdf on
the web contains similar lines, so should not be any differences for
that particular case.

> For another, as far as I understand it, the standard means the program
> should behave _as if_ the side effects are completed in the order
> stated.  It doesn't mean that the generated code has to behave that way
> literally.

Then I do not understand what are the differences between "side effects
are completed" and "code generated".  Abstract machine state should
provide some guarantees between sequence points, e.g.:

    foo();    /* function call */
    ------------|
    *a = 1;     |
    *b = 12;    | Compiler in his right to reorder.
    *c = 123;   |
    ------------|
    boo();    /* function call */

compiler in his right to reorder memory accesses between foo() and
boo() calls (foo and boo are sequence points, but memory accesses
are not), but:

   foo();    /* function call */
   *(volatile int *)a = 1;
   *(volatile int *)b = 12;
   *(volatile int *)c = 123;
   boo();    /* function call */

are all sequence points, so compiler can't reorder them.

Where am I mistaken?

> And in particular, the standard is referring to the
> behavior of a single thread, not the interaction between multiple
> concurrent threads.

Yes, that is clear: we are talking about code reordering in one
particular function in a single threaded environment.

--
Roman
