From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 00/22] add support for Clang LTO
Date: Mon, 6 Jul 2020 16:41:36 -0700
Message-ID: <20200706234136.GS9247@paulmck-ThinkPad-P72>
References: <20200701150512.GH4817@hirez.programming.kicks-ass.net>
 <20200701160338.GN9247@paulmck-ThinkPad-P72>
 <20200702082040.GB4781@hirez.programming.kicks-ass.net>
 <20200702175948.GV9247@paulmck-ThinkPad-P72>
 <20200703131330.GX4800@hirez.programming.kicks-ass.net>
 <20200703144228.GF9247@paulmck-ThinkPad-P72>
 <20200706162633.GA13288@paulmck-ThinkPad-P72>
 <20200706182926.GH4800@hirez.programming.kicks-ass.net>
 <20200706183933.GE9247@paulmck-ThinkPad-P72>
 <20200706194012.GA5523@worktop.programming.kicks-ass.net>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbgGFXlh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 6 Jul 2020 19:41:37 -0400
Content-Disposition: inline
In-Reply-To: <20200706194012.GA5523@worktop.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Marco Elver <elver@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Sami Tolvanen <samitolvanen@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>

On Mon, Jul 06, 2020 at 09:40:12PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 06, 2020 at 11:39:33AM -0700, Paul E. McKenney wrote:
> > On Mon, Jul 06, 2020 at 08:29:26PM +0200, Peter Zijlstra wrote:
> > > On Mon, Jul 06, 2020 at 09:26:33AM -0700, Paul E. McKenney wrote:
> 
> > > If they do not consider their Linux OS running correctly :-)
> > 
> > Many of them really do not care at all.  In fact, some would consider
> > Linux failing to run as an added bonus.
> 
> This I think is why we have compiler people in the thread that care a
> lot more.

Here is hoping! ;-)

> > > > Nevertheless, yes, control dependencies also need attention.
> > > 
> > > Today I added one more \o/
> > 
> > Just make sure you continually check to make sure that compilers
> > don't break it, along with the others you have added.  ;-)
> 
> There's:
> 
> kernel/locking/mcs_spinlock.h:  smp_cond_load_acquire(l, VAL);                          \
> kernel/sched/core.c:                    smp_cond_load_acquire(&p->on_cpu, !VAL);
> kernel/smp.c:   smp_cond_load_acquire(&csd->node.u_flags, !(VAL & CSD_FLAG_LOCK));
> 
> arch/x86/kernel/alternative.c:          atomic_cond_read_acquire(&desc.refs, !VAL);
> kernel/locking/qrwlock.c:               atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
> kernel/locking/qrwlock.c:       atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
> kernel/locking/qrwlock.c:               atomic_cond_read_acquire(&lock->cnts, VAL == _QW_WAITING);
> kernel/locking/qspinlock.c:             atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_MASK));
> kernel/locking/qspinlock.c:     val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK));
> 
> include/linux/refcount.h:               smp_acquire__after_ctrl_dep();
> ipc/mqueue.c:                   smp_acquire__after_ctrl_dep();
> ipc/msg.c:                      smp_acquire__after_ctrl_dep();
> ipc/sem.c:                      smp_acquire__after_ctrl_dep();
> kernel/locking/rwsem.c:                 smp_acquire__after_ctrl_dep();
> kernel/sched/core.c:    smp_acquire__after_ctrl_dep();
> 
> kernel/events/ring_buffer.c:__perf_output_begin()
> 
> And I'm fairly sure I'm forgetting some... One could argue there's too
> many of them to check already.
> 
> Both GCC and CLANG had better think about it.

That would be good!

I won't list the number of address/data dependencies given that there
are well over a thousand of them.

							Thanx, Paul
