Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40863 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbfIYXVO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Sep 2019 19:21:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id x127so476394pfb.7
        for <linux-arch@vger.kernel.org>; Wed, 25 Sep 2019 16:21:12 -0700 (PDT)
Subject: Re: [PATCH v5 3/3] clocksource/drivers: Suspend/resume Hyper-V
 clocksource for hibernation
References: <1567723581-29088-1-git-send-email-decui@microsoft.com>
 <1567723581-29088-4-git-send-email-decui@microsoft.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8ba5e2fd-6a9f-b61b-685e-23a69cabe3a2@linaro.org>
Date: Thu, 26 Sep 2019 01:21:08 +0200
MIME-Version: 1.0
In-Reply-To: <1567723581-29088-4-git-send-email-decui@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dexuan Cui <decui@microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>, Haiyang Zhang <haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "sashal@kernel.org" <sashal@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, Michael Kelley <mikelley@microsoft.com>, Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20190925232108.TMwoEfu4TYJGOcCPoj3Dto6ztyPva3XiFJzBfhEMVj0@z>

On 06/09/2019 00:47, Dexuan Cui wrote:
> This is needed for hibernation, e.g. when we resume the old kernel, we need
> to disable the "current" kernel's TSC page and then resume the old kernel's.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

I can take this patch if needed.

> ---
>  drivers/clocksource/hyperv_timer.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index 726a65e..07f4747 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -237,12 +237,37 @@ static u64 read_hv_sched_clock_tsc(void)
>  	return read_hv_clock_tsc(NULL) - hv_sched_clock_offset;
>  }
>  
> +static void suspend_hv_clock_tsc(struct clocksource *arg)
> +{
> +	u64 tsc_msr;
> +
> +	/* Disable the TSC page */
> +	hv_get_reference_tsc(tsc_msr);
> +	tsc_msr &= ~BIT_ULL(0);
> +	hv_set_reference_tsc(tsc_msr);
> +}
> +
> +
> +static void resume_hv_clock_tsc(struct clocksource *arg)
> +{
> +	phys_addr_t phys_addr = virt_to_phys(&tsc_pg);
> +	u64 tsc_msr;
> +
> +	/* Re-enable the TSC page */
> +	hv_get_reference_tsc(tsc_msr);
> +	tsc_msr &= GENMASK_ULL(11, 0);
> +	tsc_msr |= BIT_ULL(0) | (u64)phys_addr;
> +	hv_set_reference_tsc(tsc_msr);
> +}
> +
>  static struct clocksource hyperv_cs_tsc = {
>  	.name	= "hyperv_clocksource_tsc_page",
>  	.rating	= 400,
>  	.read	= read_hv_clock_tsc,
>  	.mask	= CLOCKSOURCE_MASK(64),
>  	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
> +	.suspend= suspend_hv_clock_tsc,
> +	.resume	= resume_hv_clock_ts,>  };
>  
>  static u64 notrace read_hv_clock_msr(struct clocksource *arg)
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
