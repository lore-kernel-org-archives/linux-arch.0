Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55730 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfHPPA1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Aug 2019 11:00:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id f72so4291105wmf.5
        for <linux-arch@vger.kernel.org>; Fri, 16 Aug 2019 08:00:25 -0700 (PDT)
Subject: Re: [PATCH V2 1/2] clocksource/Hyper-v: Allocate Hyper-V tsc page
 statically
References: <20190814123216.32245-1-Tianyu.Lan@microsoft.com>
 <20190814123216.32245-2-Tianyu.Lan@microsoft.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <78625f69-550d-212c-d3a0-89356ba98d2a@linaro.org>
Date: Fri, 16 Aug 2019 17:00:22 +0200
MIME-Version: 1.0
In-Reply-To: <20190814123216.32245-2-Tianyu.Lan@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: lantianyu1986@gmail.com, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org, arnd@arndb.de, michael.h.kelley@microsoft.com
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20190816150022.YFdDK9-1C5uBdaWrq0vAn44ol1THkTdJm8rz_o76dtw@z>

On 14/08/2019 14:32, lantianyu1986@gmail.com wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> Prepare to add Hyper-V sched clock callback and move Hyper-V
> Reference TSC initialization much earlier in the boot process.  Earlier
> initialization is needed so that it happens while the timestamp value
> is still 0 and no discontinuity in the timestamp will occur when
> pv_ops.time.sched_clock calculates its offset.  The earlier
> initialization requires that the Hyper-V TSC page be allocated
> statically instead of with vmalloc(), so fixup the references
> to the TSC page and the method of getting its physical address.
> 
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>     Change since v1:
>            - Update commit log
>            - Remove and operation of tsc page's va with PAGE_MASK
> 
>  arch/x86/entry/vdso/vma.c          |  2 +-
>  drivers/clocksource/hyperv_timer.c | 12 ++++--------
>  2 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> index 349a61d8bf34..f5937742b290 100644
> --- a/arch/x86/entry/vdso/vma.c
> +++ b/arch/x86/entry/vdso/vma.c
> @@ -122,7 +122,7 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
>  
>  		if (tsc_pg && vclock_was_used(VCLOCK_HVCLOCK))
>  			return vmf_insert_pfn(vma, vmf->address,
> -					vmalloc_to_pfn(tsc_pg));
> +					virt_to_phys(tsc_pg) >> PAGE_SHIFT);
>  	}
>  
>  	return VM_FAULT_SIGBUS;
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index ba2c79e6a0ee..432aa331df04 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -214,17 +214,17 @@ EXPORT_SYMBOL_GPL(hyperv_cs);
>  
>  #ifdef CONFIG_HYPERV_TSCPAGE
>  
> -static struct ms_hyperv_tsc_page *tsc_pg;
> +static struct ms_hyperv_tsc_page tsc_pg __aligned(PAGE_SIZE);
>  
>  struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
>  {
> -	return tsc_pg;
> +	return &tsc_pg;
>  }
>  EXPORT_SYMBOL_GPL(hv_get_tsc_page);
>  
>  static u64 notrace read_hv_sched_clock_tsc(void)
>  {
> -	u64 current_tick = hv_read_tsc_page(tsc_pg);
> +	u64 current_tick = hv_read_tsc_page(&tsc_pg);
>  
>  	if (current_tick == U64_MAX)
>  		hv_get_time_ref_count(current_tick);
> @@ -280,12 +280,8 @@ static bool __init hv_init_tsc_clocksource(void)
>  	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
>  		return false;
>  
> -	tsc_pg = vmalloc(PAGE_SIZE);
> -	if (!tsc_pg)
> -		return false;
> -
>  	hyperv_cs = &hyperv_cs_tsc;
> -	phys_addr = page_to_phys(vmalloc_to_page(tsc_pg));
> +	phys_addr = virt_to_phys(&tsc_pg);
>  
>  	/*
>  	 * The Hyper-V TLFS specifies to preserve the value of reserved
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
