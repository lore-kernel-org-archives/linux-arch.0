Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:55784 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbeIDW7q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 4 Sep 2018 18:59:46 -0400
Date: Tue, 4 Sep 2018 20:33:01 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 08/16] x86/apic: add modern APIC support for Hygon
Message-ID: <20180904183301.GN32615@zn.tnic>
References: <cover.1535459012.git.puwen@hygon.cn>
 <969a367a0b2d58f3e68bc6f97b6e8238e2390991.1535459013.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <969a367a0b2d58f3e68bc6f97b6e8238e2390991.1535459013.git.puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20180904183301.M7vYwYywXPdsLtyOF10h2YhoOLgAjMpbJkinrzBSk0I@z>

On Wed, Aug 29, 2018 at 08:44:30PM +0800, Pu Wen wrote:
> Hygon processors use modern APIC, so just return in modern_apic() and
> sync_Arb_IDs(). And should break in switch case in detect_init_API().
> 
> When running on 32 bit mode, should set bigsmp if there are more than
> 8 cores.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/kernel/apic/apic.c     | 19 ++++++++++++++-----
>  arch/x86/kernel/apic/probe_32.c |  1 +
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 84132ed..a62968e 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -220,10 +220,15 @@ static inline int lapic_is_integrated(void)
>   */
>  static int modern_apic(void)
>  {
> -	/* AMD systems use old APIC versions, so check the CPU */
> -	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
> -	    boot_cpu_data.x86 >= 0xf)
> +	/*
> +	 * Old AMD systems use old APIC versions, newer AMD systems
> +	 * and Hygon systems use modern APIC, so check the CPU
> +	 */
> +	if ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
> +	     boot_cpu_data.x86 >= 0xf) ||
> +	     boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
>  		return 1;

Those compound conditionals are not nice to read. Just add yours
underneath:

	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
	    boot_cpu_data.x86 >= 0xf)
		return 1;

	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
		return 1;

Do that where applicable and where it makes sense, syntax-wise to have a
separate vendor == HYGON check in the other patches too.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
