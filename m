From: Roman Penyaev <roman.penyaev@profitbricks.com>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
Date: Wed, 6 Jun 2018 11:40:13 +0200
Message-ID: <CAJrWOzBMB-6e1pKms4L216k=TN_Lr52_gWxj-ny8yitgf+K5gg@mail.gmail.com>
References: <20180530183826.GI7063@linux.vnet.ibm.com> <Pine.LNX.4.44L0.1805301449350.1502-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1805301449350.1502-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, andrea.parri@amarulasolutions.com, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nick Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, May 30, 2018 at 9:08 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Wed, 30 May 2018, Paul E. McKenney wrote:
>
>> On Wed, May 30, 2018 at 09:59:28AM -0500, Linus Torvalds wrote:
>> > On Wed, May 30, 2018 at 9:29 AM Alan Stern <stern@rowland.harvard.edu>
>> > wrote:
>> >
>> > > >
>> > > > Can't we simplify the whole sequence as basically
>> > > >
>> > > >      A
>> > > >      if (!B)
>> > > >          D
>> > > >
>> > > > for that "not B" case, and just think about that. IOW, let's ignore the
>> > > > whole "not executed" code.
>> >
>> > > Your listing is slightly misleading.
>> >
>> > No. You're confused.
>> >
>> > You're confused because you're conflating two *entirely* different things.
>> >
>> > You're conflating the static source code with the dynamic execution. They
>> > are NOT THE SAME.
>>
>> I am going to go out on a limb and assert that Linus is talking about
>> what gcc and hardware do, while Alan is talking about what the tool and
>> memory model do.
>
> Indeed.  The very first line Linus quoted in his first reply to me
> (elided above) was:
>
>         Putting this into herd would be extremely difficult, if not impossible,
>         because it involves analyzing code that was not executed.
>
> It should be clear from this that I was talking about herd.  Not gcc or
> real hardware.
>
> (After rereading his message a few times, I'm not sure exactly what
> Linus was talking about...)
>
>>  In a perfect world, these would be the same, but it
>> appears that the world might not be perfect just now.
>>
>> My current guess is that we need to change the memory-model tool.  If
>> that is the case, here are some possible resolutions:
>>
>> 1.    Make herd's C-language control dependencies work the same as its
>>       assembly language, so that they extend beyond the end of the
>>       "if" statement.  I believe that this would make Roman's case
>>       work, but it could claim that other situations are safe that
>>       are actually problematic due to compiler optimizations.
>>
>>       The fact that the model currently handles only READ_ONCE()
>>       and WRITE_ONCE() and not unmarked reads and writes make this
>>       option more attractive than it otherwise be, compilers not
>>       being allowed to reorder volatile accesses, but we are likely
>>       to introduce unmarked accesses sometime in the future.
>
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

Hi Alan,

According to the standard C99 Annex C "the controlling expression of
a selection statement (if or switch)" are the sequence points, just
like a volatile access (READ_ONCE or WRITE_ONCE).

"5.1.2.3 Program execution" states:
"At certain specified points in the execution sequence called sequence
points, all side effects of previous evaluations shall be complete
and no side effects of subsequent evaluations shall have taken place."

So in the example we have 3 sequence points: "READ_ONCE", "if" and
"WRITE_ONCE", which it seems can't be reordered.  Am I mistaken
interpreting standard?  Could you please clarify.

--
Roman
