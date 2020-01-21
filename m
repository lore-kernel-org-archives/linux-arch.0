From: Marco Elver <elver@google.com>
Subject: Re: [PATCH 3/5] asm-generic, kcsan: Add KCSAN instrumentation for bitops
Date: Tue, 21 Jan 2020 16:07:56 +0100
Message-ID: <CANpmjNNM_5=tBJhPdgGKbG6kaFpniyHZ1RyPypC-7qxEYBBkPA@mail.gmail.com>
References: <20200120141927.114373-1-elver@google.com> <20200120141927.114373-3-elver@google.com>
 <20200120144048.GB14914@hirez.programming.kicks-ass.net> <20200120162725.GE2935@paulmck-ThinkPad-P72>
 <20200120165223.GC14914@hirez.programming.kicks-ass.net> <20200120202359.GF2935@paulmck-ThinkPad-P72>
 <20200121091501.GF14914@hirez.programming.kicks-ass.net> <20200121142109.GQ2935@paulmck-ThinkPad-P72>
 <20200121144716.GQ14879@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38828 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbgAUPIJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jan 2020 10:08:09 -0500
Received: by mail-oi1-f193.google.com with SMTP id l9so2828144oii.5
        for <linux-arch@vger.kernel.org>; Tue, 21 Jan 2020 07:08:09 -0800 (PST)
In-Reply-To: <20200121144716.GQ14879@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Andrey Konovalov <andreyknvl@google.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev <kasan-dev@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>, christophe leroy <christophe.leroy@c-s.fr>, Daniel Axtens <dja@axtens.net>, Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>, Christian Brauner <christian.brauner@ubuntu.com>, Daniel Borkmann <daniel@iogearbox.net>, cyphar@cyphar.com, Kees

On Tue, 21 Jan 2020 at 15:47, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jan 21, 2020 at 06:21:09AM -0800, Paul E. McKenney wrote:
> > On Tue, Jan 21, 2020 at 10:15:01AM +0100, Peter Zijlstra wrote:
> > > On Mon, Jan 20, 2020 at 12:23:59PM -0800, Paul E. McKenney wrote:
> > > > We also don't have __atomic_read() and __atomic_set(), yet atomic_read()
> > > > and atomic_set() are considered to be non-racy, right?
> > >
> > > What is racy? :-) You can make data races with atomic_{read,set}() just
> > > fine.
> >
> > Like "fairness", lots of definitions of "racy".  ;-)
> >
> > > Anyway, traditionally we call the read-modify-write stuff atomic, not
> > > the trivial load-store stuff. The only reason we care about the
> > > load-store stuff in the first place is because C compilers are shit.
> > >
> > > atomic_read() / test_bit() are just a load, all we need is the C
> > > compiler not to be an ass and split it. Yes, we've invented the term
> > > single-copy atomicity for that, but that doesn't make it more or less of
> > > a load.
> > >
> > > And exactly because it is just a load, there is no __test_bit(), which
> > > would be the exact same load.
> >
> > Very good!  Shouldn't KCSAN then define test_bit() as non-racy just as
> > for atomic_read()?
>
> Sure it does; but my comment was aimed at the gripe that test_bit()
> lives in the non-atomic bitops header. That is arguably entirely
> correct.

I will also point out that test_bit() is listed in
Documentation/atomic_bitops.txt.  What I gather from
atomic_bitops.txt, is that the semantics of test_bit() is simply an
unordered atomic operation: the interface promises that the load will
be executed as one indivisible step, i.e. (single-copy) atomically
(after compiler optimizations etc.).

Although at this point probably not too important, I checked Alpha's
implementation of test_bit(), and there is no
smp_read_barrier_depends(). Is it safe to say that test_bit() should
then be weaker in terms of ordering than READ_ONCE()?

My assumption was that test_bit() is as strong as READ_ONCE().

Thanks,
-- Marco
