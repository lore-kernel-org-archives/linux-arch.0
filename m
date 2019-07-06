From: Dexuan Cui <decui@microsoft.com>
Subject: RE: [tip:timers/core] clocksource/drivers: Make Hyper-V clocksource
 ISA agnostic
Date: Sat, 6 Jul 2019 17:39:14 +0000
Message-ID: <PU1P153MB0169C8A38643B9284C938353BFF40@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1561955054-1838-2-git-send-email-mikelley@microsoft.com>
 <tip-fd1fea6834d0f9f93062ae6685862908a9baed39@git.kernel.org>
 <PU1P153MB0169E8E3898897BF3B3BE0F6BFF40@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <alpine.DEB.2.21.1907060944200.3648@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907061032400.3648@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.21.1907061032400.3648@nanos.tec.linutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "rkrcmar@redhat.com" <rkrcmar@redhat.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>, "shuah@kernel.org" <shuah@kernel.org>, "mingo@kernel.org" <mingo@kernel.org>, "sashal@kernel.org" <sashal@kernel.org>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>, "linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>, "daniel.lezcano@linaro.org" <daniel.le>
List-Id: linux-arch.vger.kernel.org

> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Saturday, July 6, 2019 1:34 AM
> 
> On Sat, 6 Jul 2019, Thomas Gleixner wrote:
> 
> > On Sat, 6 Jul 2019, Dexuan Cui wrote:
> > > > From: linux-hyperv-owner@vger.kernel.org
> > > > <linux-hyperv-owner@vger.kernel.org> On Behalf Of tip-bot for Michael
> Kelley
> > > > No behavior is changed and no new functionality is added.
> > > >...
> > > > +void hv_stimer_cleanup(unsigned int cpu)
> > > > +{
> > > > +	struct clock_event_device *ce;
> > > > +
> > > > +	/* Turn off clockevent device */
> > > > +	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
> > > > +		ce = per_cpu_ptr(hv_clock_event, cpu);
> > > > +		hv_ce_shutdown(ce);
> > > > +	}
> > > > +}
> > >
> > > Actually, there is a behavior change (see ...):
> > > 	Removed call to clockevents_unbind_device() [Thomas Gleixner]
> > > and this breaks my ongoing work of Linux guest hibernation on Hyper-V. :-(
> > >
> > > I guess Thomas suggested we remove the call because the clockevent
> device
> > > can be automatically cleaned up in tick_cleanup_dead_cpu(), when a CPU is
> > > offlined? BTW, I didn't find Thomas's mail suggesting the change.
> > >
> > > In the case of hibernation, this is not true for CPU0, because
> > > tick_cleanup_dead_cpu() is not called for CPU0. As a result, when the
> > > system resumes from hibernation, we add the same clock_event_device
> > > into the global list clockevent_devices twice in hv_stimer_init(0) ->
> > > clockevents_config_and_register() for CPU0, causing unexpected
> > > behaviors...
> >
> > The way this is normally done is to suspend the clockevent device on
> > hibernation and resume it when coming back. From a kernel POV resume is
> > really different than boot.

Hi Thomas,
Thanks for the important reminder! I realized actually Michael's patches are
good, and hibernation can not work because my own hibernation code is buggy:
in the resume path, on CPU0, I should NOT call hv_stimer_init() -> 
clockevents_config_and_register(): instead, I should use the event device's 
suspend/resume callbacks to save/restore the device's state.

With this kept in mind, I made some small changes to my code and hibernation
can work fine for me now!

> > But that needs probably more surgery. I'll add the unbind() call back for
> > now.

Can you please drop the unbind() call again? :-)

I realized we don't really need it, and hibernation can work for me without it.
I checked the related functions in detail: tick_cleanup_dead_cpu(), 
timekeeping_suspend() and timekeeping_resume(), and I think the unbind()
call is indeed unnecessary.

I also checked the CPU offlining scenario, and I think the unbind() call is
also unnecessary.
 
> Second thoughts. As it was just on top of the branch, I dropped the two
> patches and we can sort it out for 5.4 without a hurry.
> 
> 	tglx

Hmm, I'm sorry for providing misleading info in my previous mail.
IMHO I really think the 2 patches are good. They have been there quite
a while and it's already the 5th version. I hope they can be in 5.3-rc1 so
life would be a lot easier for everyone. :-) Especially, my hiberation work
has been rebased onto the 2 patches; if they can not be in 5.3, I'll have
to rebase my code again and once my code is accepted, it would make
it harder to rebase the 2 patches.

May I know if there is any concern about the 2 patches? If yes, I 
definitely want to help sort it out now.

Thanks,
-- Dexuan
