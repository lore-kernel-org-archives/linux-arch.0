From: Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [tip:timers/core] clocksource/drivers: Make Hyper-V clocksource
 ISA agnostic
Date: Sat, 6 Jul 2019 10:33:43 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1907061032400.3648@nanos.tec.linutronix.de>
References: <1561955054-1838-2-git-send-email-mikelley@microsoft.com>
 <tip-fd1fea6834d0f9f93062ae6685862908a9baed39@git.kernel.org>
 <PU1P153MB0169E8E3898897BF3B3BE0F6BFF40@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <alpine.DEB.2.21.1907060944200.3648@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.21.1907060944200.3648@nanos.tec.linutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dexuan Cui <decui@microsoft.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "rkrcmar@redhat.com" <rkrcmar@redhat.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>, "shuah@kernel.org" <shuah@kernel.org>, "mingo@kernel.org" <mingo@kernel.org>, "sashal@kernel.org" <sashal@kernel.org>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>, "linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>, "daniel.lezcano@linaro.org" <daniel.le>
List-Id: linux-arch.vger.kernel.org

On Sat, 6 Jul 2019, Thomas Gleixner wrote:

> On Sat, 6 Jul 2019, Dexuan Cui wrote:
> > > From: linux-hyperv-owner@vger.kernel.org
> > > <linux-hyperv-owner@vger.kernel.org> On Behalf Of tip-bot for Michael Kelley
> > > No behavior is changed and no new functionality is added.
> > >... 
> > > +void hv_stimer_cleanup(unsigned int cpu)
> > > +{
> > > +	struct clock_event_device *ce;
> > > +
> > > +	/* Turn off clockevent device */
> > > +	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
> > > +		ce = per_cpu_ptr(hv_clock_event, cpu);
> > > +		hv_ce_shutdown(ce);
> > > +	}
> > > +}
> > 
> > Actually, there is a behavior change (see https://lkml.org/lkml/2019/7/1/9):
> > 	Removed call to clockevents_unbind_device() [Thomas Gleixner]
> > and this breaks my ongoing work of Linux guest hibernation on Hyper-V. :-(
> > 
> > I guess Thomas suggested we remove the call because the clockevent device
> > can be automatically cleaned up in tick_cleanup_dead_cpu(), when a CPU is 
> > offlined? BTW, I didn't find Thomas's mail suggesting the change.
> > 
> > In the case of hibernation, this is not true for CPU0, because 
> > tick_cleanup_dead_cpu() is not called for CPU0. As a result, when the
> > system resumes from hibernation, we add the same clock_event_device
> > into the global list clockevent_devices twice in hv_stimer_init(0) ->
> > clockevents_config_and_register() for CPU0, causing unexpected
> > behaviors...
> 
> The way this is normally done is to suspend the clockevent device on
> hibernation and resume it when coming back. From a kernel POV resume is
> really different than boot.
> 
> But that needs probably more surgery. I'll add the unbind() call back for
> now.

Second thoughts. As it was just on top of the branch, I dropped the two
patches and we can sort it out for 5.4 without a hurry.

Thanks,

	tglx
