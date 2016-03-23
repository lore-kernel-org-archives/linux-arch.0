From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 4/4] nmi_backtrace: generate one-line reports for idle cpus
Date: Wed, 23 Mar 2016 01:50 +0100
Message-ID: <8028886.DUEJzF47F1@vostro.rjw.lan>
References: <1458667179-19630-1-git-send-email-cmetcalf@mellanox.com> <54039485.X1biSGXPBa@vostro.rjw.lan> <20160322224557.GG6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58767 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751833AbcCWAru (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2016 20:47:50 -0400
In-Reply-To: <20160322224557.GG6356@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Chris Metcalf <cmetcalf@mellanox.com>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Aaron Tomlin <atomlin@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>, Daniel Thompson <daniel.thompson@linaro.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tuesday, March 22, 2016 11:45:57 PM Peter Zijlstra wrote:
> On Tue, Mar 22, 2016 at 11:31:11PM +0100, Rafael J. Wysocki wrote:
> 
> > > diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> > > index cd4510a63375..924554f920fb 100644
> > > --- a/drivers/idle/intel_idle.c
> > > +++ b/drivers/idle/intel_idle.c
> > > @@ -725,8 +725,8 @@ static struct cpuidle_state avn_cstates[] = {
> > >   *
> > >   * Must be called under local_irq_disable().
> > >   */
> > > -static int intel_idle(struct cpuidle_device *dev,
> > > -		struct cpuidle_driver *drv, int index)
> > > +static __cpuidle int intel_idle(struct cpuidle_device *dev,
> > > +				struct cpuidle_driver *drv, int index)
> > >  {
> > >  	unsigned long ecx = 1; /* break on interrupt flag */
> > >  	struct cpuidle_state *state = &drv->states[index];
> > 
> > Well, what about intel_idle_freeze()?  Or do we not care?
> 
> I argued against it; when you're suspended the NMI watchdog is stopped
> too.

Is it also stopped for suspend-to-idle?  I'm not sure about that.

Where do I need to look to find out?

> Then again, you've more experience debugging that thing, so if
> you think its useful its not much effort adding it.
> 
> > And analogous stuff in processor_idle.c for that matter?
> > 
> > acpi_idle_enter()/acpi_idle_enter_freeze() plus stuff called by those?
> 
> Ah, I only tagged acpi_processor_ffh_cstate_enter() because I went from
> mwait_idle_with_hints(), I suppose acpi_safe_halt() and
> acpi_idle_do_entry() itself for the INB method should cover it?

Yes, these two should be sufficient.

> (This being one of the reasons I asked Chris to Cc you; you know this
> stuff far better than I do)
> 
> ---
>  drivers/acpi/processor_idle.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 175c86bee3a9..d5b11fff9e88 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -111,7 +111,7 @@ static const struct dmi_system_id processor_power_dmi_table[] = {
>   * Callers should disable interrupts before the call and enable
>   * interrupts after return.
>   */
> -static void acpi_safe_halt(void)
> +__cpuidle static void acpi_safe_halt(void)
>  {
>  	if (!tif_need_resched()) {
>  		safe_halt();
> @@ -680,7 +680,7 @@ static int acpi_idle_bm_check(void)
>   *
>   * Caller disables interrupt before call and enables interrupt after return.
>   */
> -static void acpi_idle_do_entry(struct acpi_processor_cx *cx)
> +__cpuidle static void acpi_idle_do_entry(struct acpi_processor_cx *cx)
>  {
>  	if (cx->entry_method == ACPI_CSTATE_FFH) {
>  		/* Call into architectural FFH based C-state */
