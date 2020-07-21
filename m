From: Marco Elver <elver@google.com>
Subject: Re: [PATCH 3/8] kcsan: Skew delay to be longer for certain access
 types
Date: Tue, 21 Jul 2020 16:26:54 +0200
Message-ID: <20200721142654.GA3396394@elver.google.com>
References: <20200721103016.3287832-1-elver@google.com>
 <20200721103016.3287832-4-elver@google.com>
 <20200721140523.GA10769@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgGUO1D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 10:27:03 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E9FC061794
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 07:27:03 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a15so6467508wrh.10
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 07:27:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200721140523.GA10769@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: paulmck@kernel.org, will@kernel.org, arnd@arndb.de, mark.rutland@arm.com, dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, Jul 21, 2020 at 04:05PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 21, 2020 at 12:30:11PM +0200, Marco Elver wrote:
> > For compound instrumentation and assert accesses, skew the watchpoint
> > delay to be longer. We still shouldn't exceed the maximum delays, but it
> > is safe to skew the delay for these accesses.
> 
> Complete lack of actual justification.. *why* are you doing this, and
> *why* is it safe etc..

CONFIG_KCSAN_UDELAY_{TASK,INTERRUPT} define the upper bound. When
randomized, the delays aggregate around a mean of KCSAN_UDELAY/2. We're
not breaking the promise of not exceeding the max by skewing the delay
if randomized. That's all this was meant to say.

I'll rewrite the commit message:

	For compound instrumentation and assert accesses, skew the
	watchpoint delay to be longer if randomized. This is useful to
	improve race detection for such accesses.

	For compound accesses we should increase the delay as we've
	aggregated both read and write instrumentation. By giving up 1
	call into the runtime, we're less likely to set up a watchpoint
	and thus less likely to detect a race. We can balance this by
	increasing the watchpoint delay.

	For assert accesses, we know these are of increased interest,
	and we wish to increase our chances of detecting races for such
	checks.

	Note that, CONFIG_KCSAN_UDELAY_{TASK,INTERRUPT} define the upper
	bound delays. Skewing the delay does not break this promise as
	long as the defined upper bounds are still adhered to.

Thanks,
-- Marco
