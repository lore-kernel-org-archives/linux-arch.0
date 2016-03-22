From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 4/4] nmi_backtrace: generate one-line reports for idle cpus
Date: Tue, 22 Mar 2016 23:31:11 +0100
Message-ID: <54039485.X1biSGXPBa@vostro.rjw.lan>
References: <1458667179-19630-1-git-send-email-cmetcalf@mellanox.com> <1458667179-19630-5-git-send-email-cmetcalf@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61129 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752156AbcCVW3B (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2016 18:29:01 -0400
In-Reply-To: <1458667179-19630-5-git-send-email-cmetcalf@mellanox.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Aaron Tomlin <atomlin@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>, Daniel Thompson <daniel.thompson@linaro.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tuesday, March 22, 2016 01:19:39 PM Chris Metcalf wrote:
> When doing an nmi backtrace of many cores, most of which are idle,
> the output is a little overwhelming and very uninformative.  Suppress
> messages for cpus that are idling when they are interrupted and just
> emit one line, "NMI backtrace for N skipped: idling at pc 0xNNN".
> 
> We do this by grouping all the cpuidle code together into a new
> .cpuidle.text section, and then checking the address of the
> interrupted PC to see if it lies within that section.
> 
> This commit suitably tags x86, arm64, and tile idle routines,
> and only adds in the minimal framework for other architectures.
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Chris Metcalf <cmetcalf@mellanox.com>
> ---

[cut]

> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index cd4510a63375..924554f920fb 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -725,8 +725,8 @@ static struct cpuidle_state avn_cstates[] = {
>   *
>   * Must be called under local_irq_disable().
>   */
> -static int intel_idle(struct cpuidle_device *dev,
> -		struct cpuidle_driver *drv, int index)
> +static __cpuidle int intel_idle(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int index)
>  {
>  	unsigned long ecx = 1; /* break on interrupt flag */
>  	struct cpuidle_state *state = &drv->states[index];

Well, what about intel_idle_freeze()?  Or do we not care?

And analogous stuff in processor_idle.c for that matter?

acpi_idle_enter()/acpi_idle_enter_freeze() plus stuff called by those?

Thanks,
Rafael
