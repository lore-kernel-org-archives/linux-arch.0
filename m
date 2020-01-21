Return-Path: <SRS0=zjVl=3K=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:41306 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUJQH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jan 2020 04:16:07 -0500
Date: Tue, 21 Jan 2020 10:15:01 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/5] asm-generic, kcsan: Add KCSAN instrumentation for
 bitops
Message-ID: <20200121091501.GF14914@hirez.programming.kicks-ass.net>
References: <20200120141927.114373-1-elver@google.com>
 <20200120141927.114373-3-elver@google.com>
 <20200120144048.GB14914@hirez.programming.kicks-ass.net>
 <20200120162725.GE2935@paulmck-ThinkPad-P72>
 <20200120165223.GC14914@hirez.programming.kicks-ass.net>
 <20200120202359.GF2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120202359.GF2935@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Marco Elver <elver@google.com>, andreyknvl@google.com, glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, mark.rutland@arm.com, will@kernel.org, boqun.feng@gmail.com, arnd@arndb.de, viro@zeniv.linux.org.uk, christophe.leroy@c-s.fr, dja@axtens.net, mpe@ellerman.id.au, rostedt@goodmis.org, mhiramat@kernel.org, mingo@kernel.org, christian.brauner@ubuntu.com, daniel@iogearbox.net, cyphar@cyphar.com, keescook@chromium.org, linux-arch@vger.kernel.org
Message-ID: <20200121091501.SZ42_151ZfoJEr8YiwHsMMpE6r_VVXRwcfyn7ZgSE60@z>

On Mon, Jan 20, 2020 at 12:23:59PM -0800, Paul E. McKenney wrote:
> We also don't have __atomic_read() and __atomic_set(), yet atomic_read()
> and atomic_set() are considered to be non-racy, right?

What is racy? :-) You can make data races with atomic_{read,set}() just
fine.

Anyway, traditionally we call the read-modify-write stuff atomic, not
the trivial load-store stuff. The only reason we care about the
load-store stuff in the first place is because C compilers are shit.

atomic_read() / test_bit() are just a load, all we need is the C
compiler not to be an ass and split it. Yes, we've invented the term
single-copy atomicity for that, but that doesn't make it more or less of
a load.

And exactly because it is just a load, there is no __test_bit(), which
would be the exact same load.
