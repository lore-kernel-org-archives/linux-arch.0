Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:40090 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727597AbeICXZV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 3 Sep 2018 19:25:21 -0400
Date: Mon, 3 Sep 2018 21:04:38 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 03/16] x86/mtrr: get MTRR number and support TOP_MEM2
Message-ID: <20180903190438.GF10249@zn.tnic>
References: <cover.1535459012.git.puwen@hygon.cn>
 <36ea05160d886ebf8d4a645c0fe8efdc9d6760c3.1535459013.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36ea05160d886ebf8d4a645c0fe8efdc9d6760c3.1535459013.git.puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20180903190438.OuRqAfD4DvUUxHLz9aFNAJmeDxEdB-OU4B42lwqKi38@z>

On Wed, Aug 29, 2018 at 08:43:23PM +0800, Pu Wen wrote:
> Hygon CPU have a special magic MSR way to force WB for memory >4GB,

It was "Hygon Dhyana" before now "Hygon" only. Can we agree on the
naming nomenclature and stick with it.

Also, it is "The ... CPU has a special..."

> and also support TOP_MEM2. Therefore, it is necessary to add Hygon
> support in amd_special_default_mtrr().
> 
> The MtrrFixDramModEn bit on Hygon platform should also be set to 1
> during BIOS initialization of the fixed MTRRs, then cleared to 0 for
> operation.
> 
> The number of variable MTRRs for Hygon is 2 as AMD's.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/kernel/cpu/mtrr/cleanup.c | 3 ++-
>  arch/x86/kernel/cpu/mtrr/generic.c | 5 +++--
>  arch/x86/kernel/cpu/mtrr/mtrr.c    | 2 +-
>  3 files changed, 6 insertions(+), 4 deletions(-)

...

> diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
> index e12ee86..77c3eaa 100644
> --- a/arch/x86/kernel/cpu/mtrr/generic.c
> +++ b/arch/x86/kernel/cpu/mtrr/generic.c
> @@ -49,8 +49,9 @@ static inline void k8_check_syscfg_dram_mod_en(void)
>  {
>  	u32 lo, hi;
>  
> -	if (!((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
> -	      (boot_cpu_data.x86 >= 0x0f)))
> +	if (!((boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
> +	       boot_cpu_data.x86 >= 0x0f) ||
> +	       boot_cpu_data.x86_vendor == X86_VENDOR_HYGON))

Why are you even touching this statement? The function returns early on
!X86_VENDOR_AMD.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
