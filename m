From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 1/2] Drivers: hv: Create Hyper-V clocksource driver
 from existing clockevents code
Date: Sat, 29 Jun 2019 08:50:16 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1906290827340.1802@nanos.tec.linutronix.de>
References: <1561746758-23216-1-git-send-email-mikelley@microsoft.com>
 <1561746758-23216-2-git-send-email-mikelley@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1561746758-23216-2-git-send-email-mikelley@microsoft.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Michael Kelley <mikelley@microsoft.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>, "rkrcmar@redhat.com" <rkrcmar@redhat.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>, "shuah@kernel.org" <shuah@kernel.org>, "sashal@kernel.org" <sashal@kernel.org>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, KY Srinivasan <kys@microsoft.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>
List-Id: linux-arch.vger.kernel.org

Micheal,

On Fri, 28 Jun 2019, Michael Kelley wrote:

> [PATCH v4 1/2] Drivers: hv: Create Hyper-V clocksource driver from existing clockevents code

As this creates a new clocksource driver, please use the

   'clocksource/drivers: '

prefix and provide a more concise summary phrase. Something like:

   'clocksource/drivers: Make Hyper-V clocksource ISA agnostic'

The longer explanation is already in the changelog.

> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -0,0 +1,191 @@
> +static int hv_ce_set_next_event(unsigned long delta,
> +				struct clock_event_device *evt)
> +{
> +	u64 current_tick;
> +
> +	WARN_ON(!clockevent_state_oneshot(evt));

If at all that wants to be a WARN_ON_ONCE, but there is really no point in
sprinkling these WARN_ONs into functions which are called from generic
infrastructure code.

Generic infrastructure wants to have warnings because the functions are
called from random places.

> +
> +	current_tick = hyperv_cs->read(NULL);
> +	current_tick += delta;
> +	hv_init_timer(0, current_tick);
> +	return 0;
> +}
> +/*
> + * hv_stimer_init - Per-cpu initialization of the clockevent
> + */
> +int hv_stimer_init(unsigned int cpu)
> +{
> +	struct clock_event_device *ce;
> +
> +	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
> +		ce = per_cpu_ptr(hv_clock_event, cpu);
> +		ce->name = "Hyper-V clockevent";
> +		ce->features = CLOCK_EVT_FEAT_ONESHOT;
> +		ce->cpumask = cpumask_of(cpu);
> +		ce->rating = 1000;
> +		ce->set_state_shutdown = hv_ce_shutdown;
> +		ce->set_state_oneshot = hv_ce_set_oneshot;
> +		ce->set_next_event = hv_ce_set_next_event;
> +
> +		clockevents_config_and_register(ce,
> +						HV_CLOCK_HZ,
> +						HV_MIN_DELTA_TICKS,
> +						HV_MAX_MAX_DELTA_TICKS);
> +	}
> +	return 0;

Why is this returning success if there is no timer available?

> +}
> +EXPORT_SYMBOL_GPL(hv_stimer_init);
> +
> +/*
> + * hv_stimer_cleanup - Per-cpu cleanup of the clockevent
> + */
> +int hv_stimer_cleanup(unsigned int cpu)
> +{
> +	struct clock_event_device *ce;
> +
> +	/* Turn off clockevent device */
> +	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
> +		ce = per_cpu_ptr(hv_clock_event, cpu);
> +		clockevents_unbind_device(ce, cpu);

Can you please explain why this unbind is needed?

> +		hv_ce_shutdown(ce);
> +	}
> +
> +	return 0;

Why does that function need a return value?

> +}
> +EXPORT_SYMBOL_GPL(hv_stimer_cleanup);
> +
> +/* hv_stimer_alloc - Global initialization of the clockevent and stimer0 */
> +int hv_stimer_alloc(int sint)
> +{
> +	hv_clock_event = alloc_percpu(struct clock_event_device);
> +	if (!hv_clock_event)
> +		return -ENOMEM;
> +
> +	direct_mode_enabled = ms_hyperv.misc_features &
> +			HV_STIMER_DIRECT_MODE_AVAILABLE;
> +	if (direct_mode_enabled &&
> +	    hv_setup_stimer0_irq(&stimer0_irq, &stimer0_vector,
> +				hv_stimer0_isr)) {
> +		free_percpu(hv_clock_event);

Leaves a dangling pointer around.

> +		return -EINVAL;

Hrm. Doesn't hv_setup_stimer0_irq() return a useful return value? -EINVAL
looks pretty strange here.

> +	}
> +
> +	stimer0_message_sint = sint;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(hv_stimer_alloc);
> +
> +/* hv_stimer_free - Free global resources allocated by hv_stimer_alloc() */
> +void hv_stimer_free(void)
> +{
> +	if (direct_mode_enabled)
> +		hv_remove_stimer0_irq(stimer0_irq);
> +	free_percpu(hv_clock_event);

Again dangling pointer. Also is it guaranteed that stimer0_irq has been set
up when this is invoked? As a general rule, make such functions defensive
then you don't need state tracking at the call site and you can invoke them
unconditionally.

> +}
> +EXPORT_SYMBOL_GPL(hv_stimer_free);
> +
> +/*
> + * Do a global cleanup of clockevents for the cases of kexec and
> + * vmbus exit
> + */
> +void hv_stimer_global_cleanup(void)
> +{
> +	int	cpu;
> +	struct clock_event_device *ce;
> +
> +	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE)
> +		for_each_present_cpu(cpu) {
> +			ce = per_cpu_ptr(hv_clock_event, cpu);
> +			clockevents_unbind_device(ce, cpu);
> +		}

Please put braces after the if () because the 4 lines following it do not
qualify as a single line statement.

Thanks,

	tglx
