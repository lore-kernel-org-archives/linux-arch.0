From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v6][RESEND] clocksource/drivers: Suspend/resume Hyper-V
 clocksource for hibernation
Date: Thu, 9 Jan 2020 12:57:09 +0100
Message-ID: <e3432a0a-6520-c321-f4a3-26afcdd8338d@linaro.org>
References: <1578350617-130430-1-git-send-email-decui@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1578350617-130430-1-git-send-email-decui@microsoft.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: decui@microsoft.com, arnd@arndb.de, bp@alien8.de, haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, sashal@kernel.org, sthemmin@microsoft.com, tglx@linutronix.de, x86@kernel.org, mikelley@microsoft.com, Alexander.Levin@microsoft.com, vkuznets@redhat.com
Cc: linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 06/01/2020 23:43, Dexuan Cui wrote:
> This is needed for hibernation, e.g. when we resume the old kernel, we need
> to disable the "current" kernel's TSC page and then resume the old kernel's.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> ---
> 
> This is a RESEND of https://lore.kernel.org/patchwork/patch/1156212/ .
> 
> Daniel Lezcano said "Applied, thanks!" on 12/4/2019 (see the above link),
> but I still can not find it in the mainline tree, or the tip tree. 

Yes, it is applied but it did not reached the tip tree yet.

> So, let me resend it just in case.
> 
>  drivers/clocksource/hyperv_timer.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index 287d8d58c21a..1aec08e82b7a 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -330,12 +330,37 @@ static u64 read_hv_sched_clock_tsc(void)
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
> +	.resume	= resume_hv_clock_tsc,
>  };
>  
>  static u64 notrace read_hv_clock_msr(struct clocksource *arg)
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
