From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: Interesting csd deadlock on ARC
Date: Tue, 23 Feb 2016 15:51:23 +0530
Message-ID: <56CC32A3.5020804@synopsys.com>
References: <56C6BA82.1060909@synopsys.com> <56CBEC66.2030401@synopsys.com>
 <20160223095824.GH6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160223095824.GH6356@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Frederic Weisbecker <fweisbec@gmail.com>, lkml <linux-kernel@vger.kernel.org>, Noam Camus <noamc@ezchip.com>, arcml <linux-snps-arc@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

>> What I actually meant was is it OK for irq_work_queue_on() to be called locally
>> (is this a sched bug/optimization(. Further if it is OK to be called, does it need
>> to do behave more like irq_work_queue() i.e. call arch_irq_work_raise() or
>> arch_send_call_function_single_ipi() is expected to handle sending IPI to self !
> 
> Right, so I'm not actually sure we started out with this requirement.
> But you're not the first to run into this, see:
> 
>   lkml.kernel.org/r/CAJZ5v0gLankSuziQq25qTCyNqeOX43yD9jnJu_XXwbdyajfmKg@mail.gmail.com

Thx for the link, very helpful. I've posted fix for ARC which uses software
interrupt and is thus UP/SMP safe.

> Initially I think irq_work_queue_on() was only used remotely, but I
> think it makes sense to allow the current cpu, esp. since people seem to
> be using it like that.
> 
> Now the distinct difference between arch_irq_work_raise() and
> arch_send_call_function_single_ipi() is that arch_irq_work_raise()
> should be NMI-safe.

Ok - so when I implement interrupt priorities (aka NMI for ARC), this needs to be
highest.

> 
> So on x86 it has to be extra careful about the lapic state, whereas the
> regular IPI code doesn't.
> 
> I seem to have forgotten the status of NMIs on ARC, but this is
> something to make a note of.

Not had a chance to go back to it since we last discussed.
I've just been swamped with bug fixing like this one :-(

Thx,
-Vineet
