From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 3/5] asm-generic, kcsan: Add KCSAN instrumentation for
 bitops
Date: Mon, 20 Jan 2020 08:27:25 -0800
Message-ID: <20200120162725.GE2935@paulmck-ThinkPad-P72>
References: <20200120141927.114373-1-elver@google.com>
 <20200120141927.114373-3-elver@google.com>
 <20200120144048.GB14914@hirez.programming.kicks-ass.net>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgATQ10 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Jan 2020 11:27:26 -0500
Content-Disposition: inline
In-Reply-To: <20200120144048.GB14914@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Marco Elver <elver@google.com>, andreyknvl@google.com, glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, mark.rutland@arm.com, will@kernel.org, boqun.feng@gmail.com, arnd@arndb.de, viro@zeniv.linux.org.uk, christophe.leroy@c-s.fr, dja@axtens.net, mpe@ellerman.id.au, rostedt@goodmis.org, mhiramat@kernel.org, mingo@kernel.org, christian.brauner@ubuntu.com, daniel@iogearbox.net, cyphar@cyphar.com, keescook@chromium.org, linux-arch@vger.kernel.org

On Mon, Jan 20, 2020 at 03:40:48PM +0100, Peter Zijlstra wrote:
> On Mon, Jan 20, 2020 at 03:19:25PM +0100, Marco Elver wrote:
> > Add explicit KCSAN checks for bitops.
> > 
> > Note that test_bit() is an atomic bitop, and we instrument it as such,
> 
> Well, it is 'atomic' in the same way that atomic_read() is. Both are
> very much not atomic ops, but are part of an interface that facilitates
> atomic operations.

True, but they all are either inline assembly or have either an
implicit or explicit cast to volatile, so they could be treated
the same as atomic_read(), correct?  If not, what am I missing?

(There is one exception, but it is in arch/x86/boot/bitops.h,
which I UP-only, correct?)

						Thanx, Paul
