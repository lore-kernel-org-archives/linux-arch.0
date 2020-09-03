Return-Path: <SRS0=8TOP=CM=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD532C433E2
	for <linux-arch@archiver.kernel.org>; Thu,  3 Sep 2020 01:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6ED92078E
	for <linux-arch@archiver.kernel.org>; Thu,  3 Sep 2020 01:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599097202;
	bh=MgYu88uIRM8lHPCIdiU6D2AiMr9bGOj93dXzi799BuA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2KzRsO6WCXmKSkBT22HPXNOMx2VN2fDZtDv+Xxwtx5y1n0tl+JfWGisZArgQdwLH4
	 6gz6CykywdoU4EVmtLcMj54nYR9g9Hzf1eaOjXBrpmdXIndsGnUuypW9yWNlsk3Bke
	 Eh50HUppqg6ym2dBnYbWJtH6j7fDVTAiH56OF9+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgICBkC (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 2 Sep 2020 21:40:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:42726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgICBkB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Sep 2020 21:40:01 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1AF720665;
        Thu,  3 Sep 2020 01:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599097200;
        bh=MgYu88uIRM8lHPCIdiU6D2AiMr9bGOj93dXzi799BuA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oNUa/IclUYmhYkvH/rPLSR52iMCn9ao43eTETSu+ASmKo6FTW2wo2Ujgu3qVwTqJk
         6WXMHmjSrvmIJfLJFqKDkoxPS08rErmwwbmDMOwmMW3auA2lKP3463rZtxXQCLoVeg
         AdjTwCoKAu7cjMoFLPLsVyUucTITkRM8oK3jSnFc=
Date:   Thu, 3 Sep 2020 10:39:54 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     peterz@infradead.org
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org, systemtap@sourceware.org
Subject: Re: [PATCH v5 00/21] kprobes: Unify kretprobe trampoline handlers
 and make kretprobe lockless
Message-Id: <20200903103954.68f0c97da57b3679169ce3a7@kernel.org>
In-Reply-To: <20200902134252.GH1362448@hirez.programming.kicks-ass.net>
References: <159870598914.1229682.15230803449082078353.stgit@devnote2>
        <20200901190808.GK29142@worktop.programming.kicks-ass.net>
        <20200902093739.8bd13603380951eaddbcd8a5@kernel.org>
        <20200902070226.GG2674@hirez.programming.kicks-ass.net>
        <20200902171755.b126672093a3c5d1b3a62a4f@kernel.org>
        <20200902093613.GY1362448@hirez.programming.kicks-ass.net>
        <20200902221926.f5cae5b4ad00b8d8f9ad99c7@kernel.org>
        <20200902134252.GH1362448@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2 Sep 2020 15:42:52 +0200
peterz@infradead.org wrote:

> On Wed, Sep 02, 2020 at 10:19:26PM +0900, Masami Hiramatsu wrote:
> > On Wed, 2 Sep 2020 11:36:13 +0200
> > peterz@infradead.org wrote:
> > 
> > > On Wed, Sep 02, 2020 at 05:17:55PM +0900, Masami Hiramatsu wrote:
> > > 
> > > > > Ok, but then lockdep will yell at you if you have that enabled and run
> > > > > the unoptimized things.
> > > > 
> > > > Oh, does it warn for all spinlock things in kprobes if it is unoptimized?
> > > > Hmm, it has to be noted in the documentation.
> > > 
> > > Lockdep will warn about spinlocks used in NMI context that are also used
> > > outside NMI context.
> > 
> > OK, but raw_spin_lock_irqsave() will not involve lockdep, correct?
> 
> It will. The distinction between spin_lock and raw_spin_lock is only
> that raw_spin_lock stays a spinlock on PREEMPT_RT, while spin_lock will
> turn into a (PI) mutex in that case.
> 
> But both will call into lockdep. Unlike local_irq_disable() and
> raw_local_irq_disable(), where the latter will not. Yes your prefixes
> are a mess :/

Yeah, that's really confusing...

> > > Now, for the kretprobe that kprobe_busy flag prevents the actual
> > > recursion self-deadlock, but lockdep isn't smart enough to see that.
> > > 
> > > One way around this might be to use SINGLE_DEPTH_NESTING for locks when
> > > we use them from INT3 context. That way they'll have a different class
> > > and lockdep will not see the recursion.
> > 
> > Hmm, so lockdep warns only when it detects the spinlock in NMI context,
> > and int3 is now always NMI, thus all spinlock (except raw_spinlock?)
> > in kprobe handlers should get warned, right?
> > I have tested this series up to [16/21] with optprobe disabled, but
> > I haven't see the lockdep warnings.
> 
> There's a bug, that might make it miss it. I have a patch. I'll send it
> shortly.

OK, I've confirmed that the lockdep warns on kretprobe from INT3
with your fix. Of course make it lockless then warning is gone.
But even without the lockless patch, this warning can be false-positive
because we prohibit nested kprobe call, right?

If the kprobe user handler uses a spinlock, the spinlock is used
only in that handler (and in the context between kprobe_busy_begin/end),
it will be safe since the spinlock is not nested.
But if the spinlock is shared with other context, it will be dangerous
because it can be interrupted by NMI (including INT3). This also applied
to the function which is called from kprobe user handlers, thus user
has to take care of it.
BTW, what would you think about setting NMI count between kprobe_busy_begin/end?

> 
> > > pre_handler_kretprobe() is always called from INT3, right?
> > 
> > No, not always, it can be called from optprobe (same as original code
> > context) or ftrace handler.
> > But if you set 0 to /proc/sys/debug/kprobe_optimization, and compile
> > the kernel without function tracer, it should always be called from
> > INT3.
> 
> D'oh, ofcourse! Arguably I should make the optprobe context NMI like
> too.. but that's for another day.

Hmm, we still have kprobe-on-ftrace. Would you consider we will
make it NMI like too? (and what the ftrace does for this)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
