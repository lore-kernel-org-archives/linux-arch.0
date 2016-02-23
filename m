From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Interesting csd deadlock on ARC
Date: Tue, 23 Feb 2016 10:58:24 +0100
Message-ID: <20160223095824.GH6356@twins.programming.kicks-ass.net>
References: <56C6BA82.1060909@synopsys.com>
 <56CBEC66.2030401@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <56CBEC66.2030401@synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Frederic Weisbecker <fweisbec@gmail.com>, lkml <linux-kernel@vger.kernel.org>, Noam Camus <noamc@ezchip.com>, arcml <linux-snps-arc@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Feb 23, 2016 at 10:51:42AM +0530, Vineet Gupta wrote:
> On Friday 19 February 2016 12:17 PM, Vineet Gupta wrote:
> > Hi Peter,
> > 
> > I've been debugging a csd_lock_wait() deadlock on SMP+PREEMPT ARC HS38x2 and it
> > turned out to be lot more interesting than I'd hoped for. This is stock v4.4
> > 
> > Trouble starts with an IPI to self which doesn't get delivered as the inter-core
> > interrupt providing h/w is not capable of IPI to self (which I found as part of
> > debugging this). Subsequent IPIs from other cores to this core get elided as well
> > due to the IPI coalescing optimization in arch/arc/kernel/smp.c: ipi_send_msg_one()
> > 
> > There are ways to use a different h/w mechanism to solve the trigger issue and I'd
> > hoped to just implement arch_irq_work_raise(). 

Yes, there are other architectures that use other means for self-IPI,
IIRC PowerPC has to program their timer in the past to generate a local
interrupt.

> > But the trouble is the call stack
> > for this issue: IPI to self is triggered from
> > 
> > sys_sched_setscheduler
> >    __balance_callback
> >        pull_rt_task
> >          irq_work_queue_on  <-- called with @cpu == self
> > 
> > Looking into irq_work.c, irq_work_queue() is what is semantically needed,
> > specifically arch_irq_work_raise() will not be called, which means I need
> > arch_send_call_function_single_ipi() to be able to IPI to self cpu also. Is that
> > expected from arch code....
> 
> What I actually meant was is it OK for irq_work_queue_on() to be called locally
> (is this a sched bug/optimization(. Further if it is OK to be called, does it need
> to do behave more like irq_work_queue() i.e. call arch_irq_work_raise() or
> arch_send_call_function_single_ipi() is expected to handle sending IPI to self !

Right, so I'm not actually sure we started out with this requirement.
But you're not the first to run into this, see:

  lkml.kernel.org/r/CAJZ5v0gLankSuziQq25qTCyNqeOX43yD9jnJu_XXwbdyajfmKg@mail.gmail.com

Initially I think irq_work_queue_on() was only used remotely, but I
think it makes sense to allow the current cpu, esp. since people seem to
be using it like that.

Now the distinct difference between arch_irq_work_raise() and
arch_send_call_function_single_ipi() is that arch_irq_work_raise()
should be NMI-safe.

So on x86 it has to be extra careful about the lapic state, whereas the
regular IPI code doesn't.

I seem to have forgotten the status of NMIs on ARC, but this is
something to make a note of.
