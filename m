From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: Interesting csd deadlock on ARC
Date: Tue, 23 Feb 2016 10:51:42 +0530
Message-ID: <56CBEC66.2030401@synopsys.com>
References: <56C6BA82.1060909@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:52886 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbcBWFWc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 23 Feb 2016 00:22:32 -0500
In-Reply-To: <56C6BA82.1060909@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, arcml <linux-snps-arc@lists.infradead.org>, Noam Camus <noamc@ezchip.com>, lkml <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>

On Friday 19 February 2016 12:17 PM, Vineet Gupta wrote:
> Hi Peter,
> 
> I've been debugging a csd_lock_wait() deadlock on SMP+PREEMPT ARC HS38x2 and it
> turned out to be lot more interesting than I'd hoped for. This is stock v4.4
> 
> Trouble starts with an IPI to self which doesn't get delivered as the inter-core
> interrupt providing h/w is not capable of IPI to self (which I found as part of
> debugging this). Subsequent IPIs from other cores to this core get elided as well
> due to the IPI coalescing optimization in arch/arc/kernel/smp.c: ipi_send_msg_one()
> 
> There are ways to use a different h/w mechanism to solve the trigger issue and I'd
> hoped to just implement arch_irq_work_raise(). But the trouble is the call stack
> for this issue: IPI to self is triggered from
> 
> sys_sched_setscheduler
>    __balance_callback
>        pull_rt_task
>          irq_work_queue_on  <-- called with @cpu == self
> 
> Looking into irq_work.c, irq_work_queue() is what is semantically needed,
> specifically arch_irq_work_raise() will not be called, which means I need
> arch_send_call_function_single_ipi() to be able to IPI to self cpu also. Is that
> expected from arch code....

What I actually meant was is it OK for irq_work_queue_on() to be called locally
(is this a sched bug/optimization(. Further if it is OK to be called, does it need
to do behave more like irq_work_queue() i.e. call arch_irq_work_raise() or
arch_send_call_function_single_ipi() is expected to handle sending IPI to self !

> 
> Just wanted to understand before writing patches...
> 
> Test case triggering is harmless looking LTP: trace_sched -c 1
> It is kind of scheduler fizzer as it triggers a whole bunch of sched activity.
> 
> Thx,
> -Vineet
> 
