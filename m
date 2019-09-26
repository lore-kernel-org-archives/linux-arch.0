From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v5 1/3] x86/hyper-v: Suspend/resume the hypercall page for hibernation
Date: Thu, 26 Sep 2019 12:44:16 +0200
Message-ID: <87ef0372wv.fsf@vitty.brq.redhat.com>
References: <1567723581-29088-1-git-send-email-decui@microsoft.com> <1567723581-29088-2-git-send-email-decui@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1567723581-29088-2-git-send-email-decui@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dexuan Cui <decui@microsoft.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Haiyang Zhang <haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "sashal@kernel.org" <sashal@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, Michael Kelley <mikelley@microsoft.com>, Sasha Levin <Alexander.Levin@microsoft.com>
List-Id: linux-arch.vger.kernel.org

Dexuan Cui <decui@microsoft.com> writes:

> This is needed for hibernation, e.g. when we resume the old kernel, we need
> to disable the "current" kernel's hypercall page and then resume the old
> kernel's.
>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 866dfb3..037b0f3 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -20,6 +20,7 @@
>  #include <linux/hyperv.h>
>  #include <linux/slab.h>
>  #include <linux/cpuhotplug.h>
> +#include <linux/syscore_ops.h>
>  #include <clocksource/hyperv_timer.h>
>  
>  void *hv_hypercall_pg;
> @@ -223,6 +224,34 @@ static int __init hv_pci_init(void)
>  	return 1;
>  }
>  
> +static int hv_suspend(void)
> +{
> +	union hv_x64_msr_hypercall_contents hypercall_msr;
> +
> +	/* Reset the hypercall page */
> +	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> +	hypercall_msr.enable = 0;
> +	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> +

(trying to think out loud, not sure there's a real issue):

When PV IPIs (or PV TLB flush) are enabled we do the following checks:

	if (!hv_hypercall_pg)
		return false;

or
        if (!hv_hypercall_pg)
                goto do_native;

which will pass as we're not invalidating the pointer. Can we actually
be sure that the kernel will never try to send an IPI/do TLB flush
before we resume?

-- 
Vitaly
