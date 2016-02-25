From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: Interesting csd deadlock on ARC
Date: Thu, 25 Feb 2016 19:53:39 +0530
Message-ID: <56CF0E6B.5020903@synopsys.com>
References: <56C6BA82.1060909@synopsys.com> <56CBEC66.2030401@synopsys.com>
 <20160223095824.GH6356@twins.programming.kicks-ass.net>
 <56CD36CD.2080303@synopsys.com>
 <20160225140654.GL6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:53774 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760085AbcBYOZr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 25 Feb 2016 09:25:47 -0500
In-Reply-To: <20160225140654.GL6357@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Will Deacon <Will.Deacon@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Marc Zyngier <marc.zyngier@arm.com>, Frederic Weisbecker <fweisbec@gmail.com>, lkml <linux-kernel@vger.kernel.org>, Noam Camus <noamc@ezchip.com>, arcml <linux-snps-arc@lists.infradead.org>

On Thursday 25 February 2016 07:36 PM, Peter Zijlstra wrote:
> On Wed, Feb 24, 2016 at 10:21:25AM +0530, Vineet Gupta wrote:
>>>> What I actually meant was is it OK for irq_work_queue_on() to be called locally
>>>> (is this a sched bug/optimization(. Further if it is OK to be called, does it need
>>>> to do behave more like irq_work_queue() i.e. call arch_irq_work_raise() or
>>>> arch_send_call_function_single_ipi() is expected to handle sending IPI to self !
>>>
>>> Right, so I'm not actually sure we started out with this requirement.
>>> But you're not the first to run into this, see:
>>>
>>>   lkml.kernel.org/r/CAJZ5v0gLankSuziQq25qTCyNqeOX43yD9jnJu_XXwbdyajfmKg@mail.gmail.com
>>>
>>> Initially I think irq_work_queue_on() was only used remotely, but I
>>> think it makes sense to allow the current cpu, esp. since people seem to
>>> be using it like that.
>>
>> So it seems Russell's questions in the thread above stands still. IMO we need to
>> massage irq_work_queue_on() to handle the case of called for local cpu. This will
>> automatically take care of CONFIG_SMP kernel running on UP hardware.
> 
> Hmm, I missed that there was still an open question.
> 
> Afaict the only thing that needs doing to the generic code is drop the
> CONFIG_SMP guard, no?

But then ARM CONFIG_SMP on UP hardware will still crap out because there is no way
to send IPI to self. Same as the bug in above discussion. I'm surprised they way
ARM guys worked around it.

But yeah what you propose needs to be done and additionally make
irq_work_queue_on() behave like irq_work_queue() if @cpu == smp_processor_id(). So
the IPI will not be involved at all. But that means arch has to implement
arch_irq_work_raise() or maybe not - per comment there "Lame architectures will
get the timer tick callback" !

This would be a cleaner solution IMHO !
