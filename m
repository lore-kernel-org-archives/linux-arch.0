Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37388 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730405AbfJVRnC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Oct 2019 13:43:02 -0400
Received: by mail-oi1-f194.google.com with SMTP id i16so14941563oie.4
        for <linux-arch@vger.kernel.org>; Tue, 22 Oct 2019 10:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191017141305.146193-1-elver@google.com> <20191017141305.146193-2-elver@google.com>
 <20191022154858.GA13700@redhat.com>
In-Reply-To: <20191022154858.GA13700@redhat.com>
From: Marco Elver <elver@google.com>
Date: Tue, 22 Oct 2019 19:42:48 +0200
Message-ID: <CANpmjNPUT2B3rWaa=5Ee2Xs3HHDaUiBGpG09Q4h9Gemhsp9KFw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] kcsan: Add Kernel Concurrency Sanitizer infrastructure
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Alexander Potapenko <glider@google.com>, Andrea Parri <parri.andrea@gmail.com>, Andrey Konovalov <andreyknvl@google.com>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>, Daniel Lustig <dlustig@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Howells <dhowells@redhat.com>, Dmitry Vyukov <dvyukov@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Joel Fernandes <joel@joelfernandes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@redhat.com>, Luc Maranget <luc.maranget@inria.fr>, Mark Rutland <mark.rutland@arm.com>, Nicholas Piggin <npiggin@gmail.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, linux-arch <linux-arch@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-efi@vger.kernel.org, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, the arch/x86 maintainers <x86@kernel.org>
Message-ID: <20191022174248.uIidDHjYOqUbouhm9TuEt1MpTZSIU6aR3WSH4A8oYWQ@z>

On Tue, 22 Oct 2019 at 17:49, Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 10/17, Marco Elver wrote:
> >
> > +     /*
> > +      * Delay this thread, to increase probability of observing a racy
> > +      * conflicting access.
> > +      */
> > +     udelay(get_delay());
> > +
> > +     /*
> > +      * Re-read value, and check if it is as expected; if not, we infer a
> > +      * racy access.
> > +      */
> > +     switch (size) {
> > +     case 1:
> > +             is_expected = expect_value._1 == READ_ONCE(*(const u8 *)ptr);
> > +             break;
> > +     case 2:
> > +             is_expected = expect_value._2 == READ_ONCE(*(const u16 *)ptr);
> > +             break;
> > +     case 4:
> > +             is_expected = expect_value._4 == READ_ONCE(*(const u32 *)ptr);
> > +             break;
> > +     case 8:
> > +             is_expected = expect_value._8 == READ_ONCE(*(const u64 *)ptr);
> > +             break;
> > +     default:
> > +             break; /* ignore; we do not diff the values */
> > +     }
> > +
> > +     /* Check if this access raced with another. */
> > +     if (!remove_watchpoint(watchpoint)) {
> > +             /*
> > +              * No need to increment 'race' counter, as the racing thread
> > +              * already did.
> > +              */
> > +             kcsan_report(ptr, size, is_write, smp_processor_id(),
> > +                          kcsan_report_race_setup);
> > +     } else if (!is_expected) {
> > +             /* Inferring a race, since the value should not have changed. */
> > +             kcsan_counter_inc(kcsan_counter_races_unknown_origin);
> > +#ifdef CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN
> > +             kcsan_report(ptr, size, is_write, smp_processor_id(),
> > +                          kcsan_report_race_unknown_origin);
> > +#endif
> > +     }
>
> Not sure I understand this code...
>
> Just for example. Suppose that task->state = TASK_UNINTERRUPTIBLE, this task
> does __set_current_state(TASK_RUNNING), another CPU does wake_up_process(task)
> which does the same UNINTERRUPTIBLE -> RUNNING transition.
>
> Looks like, this is the "data race" according to kcsan?

Yes, they are "data races". They are probably not "race conditions" though.

This is a fair distinction to make, and we never claimed to find "race
conditions" only -- race conditions are logic bugs that result in bad
state due to unexpected interleaving of threads. Data races are more
subtle, and become relevant at the programming language level.

In Documentation we summarize: "Informally, two operations conflict if
they access the same memory location, and at least one of them is a
write operation. In an execution, two memory operations from different
threads form a data-race if they conflict, at least one of them is a
*plain* access (non-atomic), and they are unordered in the
"happens-before" order according to the LKMM."

KCSAN's goal is to find *data races* according to the LKMM.  Some data
races are race conditions (usually the more interesting bugs) -- but
not *all* data races are race conditions. Those are what are usually
referred to as "benign", but they can still become bugs on the wrong
arch/compiler combination. Hence, the need to annotate these accesses
with READ_ONCE, WRITE_ONCE or use atomic_t:
- https://lwn.net/Articles/793253/
- https://lwn.net/Articles/799218/

> Hmm. even the "if (!(p->state & state))" check in try_to_wake_up() can trigger
> kcsan_report() ?

We blacklisted sched (KCSAN_SANITIZE := n   in kernel/sched/Makefile),
so these data races won't actually be reported.

Thanks,
-- Marco

> Oleg.
>
