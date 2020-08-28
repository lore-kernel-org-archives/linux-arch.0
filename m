Return-Path: <SRS0=gEkT=CG=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42923C433E2
	for <linux-arch@archiver.kernel.org>; Fri, 28 Aug 2020 14:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DFE8207DF
	for <linux-arch@archiver.kernel.org>; Fri, 28 Aug 2020 14:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598625815;
	bh=MApO7IXUAC6FNjyRIIj5d7nxPW2xAsj7WUutz95Xyqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=H7tAW3n3dc2sHz7Y4/GI9oxGHw2uAAxDcGFTCWwG4t4gw+rkX94Q/HxgTA+0811kN
	 nfXxXR3hLOLjo77UbSdVRIQ+QBGd9ieQ+NHmqGaypqs/t4Iu6N6NEogYtSgkaTiF7J
	 sp/GwxADtLeXRxvt8clUklvMCZ1FJcfZ2KAXV0DA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgH1Onc (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:43:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727912AbgH1Olc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 10:41:32 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B15B020757;
        Fri, 28 Aug 2020 14:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598625687;
        bh=MApO7IXUAC6FNjyRIIj5d7nxPW2xAsj7WUutz95Xyqg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a4nxuEPFYWe+mitbJg8k/3/xHYjWwm7zcHFWaceJ8o+6JQbMJAw1fxA8m9xacqKtT
         IQ82vAR3yWmOwMtfcdGMO7aVHEYhZL/0KofUjreowr1fZMqKcvoofRvtVIe4Z2G4ZZ
         FJ267yddp/UCr2FVdAvkh/+R3B0vdpwCAi4L3abk=
Date:   Fri, 28 Aug 2020 23:41:23 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     peterz@infradead.org
Cc:     "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
        "anil.s.keshavamurthy@intel.com" <anil.s.keshavamurthy@intel.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "cameron@moodycamel.com" <cameron@moodycamel.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>
Subject: Re: [RFC][PATCH 3/7] kprobes: Remove kretprobe hash
Message-Id: <20200828234123.f033d15e4d345c03eef97e88@kernel.org>
In-Reply-To: <20200828141917.GE1362448@hirez.programming.kicks-ass.net>
References: <20200827161237.889877377@infradead.org>
        <20200827161754.359432340@infradead.org>
        <7df0a1af432040d9908517661c32dc34@trendmicro.com>
        <20200828225113.9541a5f67a3bcb17c4ce930c@kernel.org>
        <23d43cfb12c54a1fbc766ea313ecb5a6@trendmicro.com>
        <20200828141917.GE1362448@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 28 Aug 2020 16:19:17 +0200
peterz@infradead.org wrote:

> On Fri, Aug 28, 2020 at 02:11:18PM +0000, Eddy_Wu@trendmicro.com wrote:
> > > From: Masami Hiramatsu <mhiramat@kernel.org>
> > >
> > > OK, schedule function will be the key. I guess the senario is..
> > >
> > > 1) kretporbe replace the return address with kretprobe_trampoline on task1's kernel stack
> > > 2) the task1 forks task2 before returning to the kretprobe_trampoline
> > > 3) while copying the process with the kernel stack, task2->kretprobe_instances.first = NULL
> > 
> > I think new process created by fork/clone uses a brand new kernel
> > stack? I thought only user stack are copied.  Otherwise any process
> > launch should crash in the same way
> 
> I was under the same impression, we create a brand new stack-frame for
> the new task, this 'fake' frame we can schedule into.
> 
> It either points to ret_from_fork() for new user tasks, or
> kthread_frame_init() for kernel threads.

Ah sorry, then it's my misreading... anyway, I could reproduce the crash with
probing on schedule(). Hmm, it is better to dump the current comm with
BUG().

Thank you,



-- 
Masami Hiramatsu <mhiramat@kernel.org>
