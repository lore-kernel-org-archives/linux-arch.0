Return-Path: <SRS0=nYHR=3J=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:42570 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATQxD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jan 2020 11:53:03 -0500
Date: Mon, 20 Jan 2020 17:52:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/5] asm-generic, kcsan: Add KCSAN instrumentation for
 bitops
Message-ID: <20200120165223.GC14914@hirez.programming.kicks-ass.net>
References: <20200120141927.114373-1-elver@google.com>
 <20200120141927.114373-3-elver@google.com>
 <20200120144048.GB14914@hirez.programming.kicks-ass.net>
 <20200120162725.GE2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120162725.GE2935@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Marco Elver <elver@google.com>, andreyknvl@google.com, glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, mark.rutland@arm.com, will@kernel.org, boqun.feng@gmail.com, arnd@arndb.de, viro@zeniv.linux.org.uk, christophe.leroy@c-s.fr, dja@axtens.net, mpe@ellerman.id.au, rostedt@goodmis.org, mhiramat@kernel.org, mingo@kernel.org, christian.brauner@ubuntu.com, daniel@iogearbox.net, cyphar@cyphar.com, keescook@chromium.org, linux-arch@vger.kernel.org
Message-ID: <20200120165223.xqRZwQEMLoOad4ROVV49gVXZap7da9al-Ek_vOt4ptU@z>

On Mon, Jan 20, 2020 at 08:27:25AM -0800, Paul E. McKenney wrote:
> On Mon, Jan 20, 2020 at 03:40:48PM +0100, Peter Zijlstra wrote:
> > On Mon, Jan 20, 2020 at 03:19:25PM +0100, Marco Elver wrote:
> > > Add explicit KCSAN checks for bitops.
> > > 
> > > Note that test_bit() is an atomic bitop, and we instrument it as such,
> > 
> > Well, it is 'atomic' in the same way that atomic_read() is. Both are
> > very much not atomic ops, but are part of an interface that facilitates
> > atomic operations.
> 
> True, but they all are either inline assembly or have either an
> implicit or explicit cast to volatile, so they could be treated
> the same as atomic_read(), correct?  If not, what am I missing?

Sure, but that is due to instrumentation requirements, not anything
else.

Also note the distinct lack of __test_bit(), to mirror the non-atomic
__set_bit() and __clear_bit().
