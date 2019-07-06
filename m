From: Dexuan Cui <decui@microsoft.com>
Subject: RE: [tip:timers/core] clocksource/drivers: Make Hyper-V clocksource
 ISA agnostic
Date: Sat, 6 Jul 2019 01:09:06 +0000
Message-ID: <PU1P153MB0169E8E3898897BF3B3BE0F6BFF40@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1561955054-1838-2-git-send-email-mikelley@microsoft.com>
 <tip-fd1fea6834d0f9f93062ae6685862908a9baed39@git.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <tip-fd1fea6834d0f9f93062ae6685862908a9baed39@git.kernel.org>
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
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "sashal@kernel.org" <sashal@kernel.org>, "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>, "bp@alien8.de" <bp@alien8.de>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "apw@canonical.com" <apw@canonical.com>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "paul.burton@mips.com" <paul.burton@mips.com>, Michael Kelley <mikelley@microsoft.com>, Sunil Muthuswamy <sunilmut@microsoft.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "huw@codeweavers.com" <huw@codeweavers.com>, "ralf@linux-mips.org" <ralf@linux-mips.org>ma
List-Id: linux-arch.vger.kernel.org

> From: linux-hyperv-owner@vger.kernel.org
> <linux-hyperv-owner@vger.kernel.org> On Behalf Of tip-bot for Michael Kelley
> Sent: Wednesday, July 3, 2019 2:07 AM
> clocksource/drivers: Make Hyper-V clocksource ISA agnostic
> 
> Hyper-V clock/timer code and data structures are currently mixed
> in with other code in the ISA independent drivers/hv directory as
> well as the ISA dependent Hyper-V code under arch/x86.
> 
> Consolidate this code and data structures into a Hyper-V clocksource driver
> to better follow the Linux model. In doing so, separate out the ISA
> dependent portions so the new clocksource driver works for x86 and for the
> in-process Hyper-V on ARM64 code.
> 
> To start, move the existing clockevents code to create the new clocksource
> driver. Update the VMbus driver to call initialization and cleanup routines
> since the Hyper-V synthetic timers are not independently enumerated in
> ACPI.
> 
> No behavior is changed and no new functionality is added.
>... 
> +void hv_stimer_cleanup(unsigned int cpu)
> +{
> +	struct clock_event_device *ce;
> +
> +	/* Turn off clockevent device */
> +	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
> +		ce = per_cpu_ptr(hv_clock_event, cpu);
> +		hv_ce_shutdown(ce);
> +	}
> +}

Actually, there is a behavior change (see https://lkml.org/lkml/2019/7/1/9):
	Removed call to clockevents_unbind_device() [Thomas Gleixner]
and this breaks my ongoing work of Linux guest hibernation on Hyper-V. :-(

I guess Thomas suggested we remove the call because the clockevent device
can be automatically cleaned up in tick_cleanup_dead_cpu(), when a CPU is 
offlined? BTW, I didn't find Thomas's mail suggesting the change.

In the case of hibernation, this is not true for CPU0, because 
tick_cleanup_dead_cpu() is not called for CPU0. As a result, when the
system resumes from hibernation, we add the same clock_event_device
into the global list clockevent_devices twice in hv_stimer_init(0) ->
clockevents_config_and_register() for CPU0, causing unexpected
behaviors...

Should we call clockevents_unbind_device() or tick_cleanup_dead_cpu()
somewher for CPU0, in the case of hibernation? 

Or, in clockevents_config_and_register(), should we not add the event
device, if it's already in the global list?

Thanks,
-- Dexuan
