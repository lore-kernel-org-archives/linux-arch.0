From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v6 08/16] x86/apic: Add Hygon Dhyana support to APIC
Date: Tue, 11 Sep 2018 12:14:54 +0200
Message-ID: <20180911101454.GE12094@zn.tnic>
References: <cover.1536550549.git.puwen@hygon.cn>
 <4f03e734faa5b2b69b0947a156bea29cddcc95ce.1536550550.git.puwen@hygon.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4f03e734faa5b2b69b0947a156bea29cddcc95ce.1536550550.git.puwen@hygon.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Sep 10, 2018 at 09:17:27PM +0800, Pu Wen wrote:
> Add Hygon Dhyana support to the APIC subsystem as it use modern APIC.
> When running on 32 bit mode, bigsmp should be enabled if there are
> more than 8 cores online.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/kernel/apic/apic.c     | 13 +++++++++++--
>  arch/x86/kernel/apic/probe_32.c |  1 +
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 84132ed..709daf2 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -224,6 +224,11 @@ static int modern_apic(void)
>  	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
>  	    boot_cpu_data.x86 >= 0xf)
>  		return 1;
> +
> +	/* Hygon systems use modern APIC */
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> +		return 1;
> +
>  	return lapic_get_version() >= 0x14;
>  }
>  
> @@ -1211,9 +1216,11 @@ void __init sync_Arb_IDs(void)
>  {
>  	/*
>  	 * Unsupported on P4 - see Intel Dev. Manual Vol. 3, Ch. 8.6.1 And not
> -	 * needed on AMD.
> +	 * needed on AMD or Hygon.
>  	 */
> -	if (modern_apic() || boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> +	if (modern_apic() ||
> +	    boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
> +	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)

This change is not needed, after the above hunk in modern_apic(), right?

With it removed:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
