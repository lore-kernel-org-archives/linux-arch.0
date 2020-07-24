From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2 0/8] kcsan: Compound read-write instrumentation
Date: Fri, 24 Jul 2020 15:40:52 -0700
Message-ID: <20200724224052.GX9247@paulmck-ThinkPad-P72>
References: <20200724070008.1389205-1-elver@google.com>
 <20200724083920.GV10769@hirez.programming.kicks-ass.net>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbgGXWkx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Jul 2020 18:40:53 -0400
Content-Disposition: inline
In-Reply-To: <20200724083920.GV10769@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Marco Elver <elver@google.com>, will@kernel.org, arnd@arndb.de, mark.rutland@arm.com, dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Fri, Jul 24, 2020 at 10:39:20AM +0200, Peter Zijlstra wrote:
> On Fri, Jul 24, 2020 at 09:00:00AM +0200, Marco Elver wrote:
> 
> > Marco Elver (8):
> >   kcsan: Support compounded read-write instrumentation
> >   objtool, kcsan: Add __tsan_read_write to uaccess whitelist
> >   kcsan: Skew delay to be longer for certain access types
> >   kcsan: Add missing CONFIG_KCSAN_IGNORE_ATOMICS checks
> >   kcsan: Test support for compound instrumentation
> >   instrumented.h: Introduce read-write instrumentation hooks
> >   asm-generic/bitops: Use instrument_read_write() where appropriate
> >   locking/atomics: Use read-write instrumentation for atomic RMWs
> 
> Looks good to me,
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Applied with ack, thank you both!

							Thanx, Paul
