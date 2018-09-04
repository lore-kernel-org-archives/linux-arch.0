Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:36192 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbeIDNkP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 4 Sep 2018 09:40:15 -0400
Date: Tue, 4 Sep 2018 11:15:36 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 04/16] x86/smpboot: smp init nodelay and no flush
 caches before sleep
Message-ID: <20180904091536.GE32615@zn.tnic>
References: <cover.1535459012.git.puwen@hygon.cn>
 <eaa743fb27e191e9e353db34c0960eede18c7213.1535459013.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eaa743fb27e191e9e353db34c0960eede18c7213.1535459013.git.puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20180904091536.b5mcEdesMGcO1q1bvqJrrQidDeIoLw9OOoAlgvR0DY4@z>

On Wed, Aug 29, 2018 at 08:43:41PM +0800, Pu Wen wrote:
> Dhyana use no delay in smp_quirk_init_udelay(), and return in
> mwait_play_dead() as AMD does.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/kernel/smpboot.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index f02ecaf..5369d7f 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -676,6 +676,7 @@ static void __init smp_quirk_init_udelay(void)
>  
>  	/* if modern processor, use no delay */
>  	if (((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) && (boot_cpu_data.x86 == 6)) ||
> +	    ((boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) && (boot_cpu_data.x86 >= 0x18)) ||
>  	    ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) && (boot_cpu_data.x86 >= 0xF))) {
>  		init_udelay = 0;
>  		return;
> @@ -1592,7 +1593,8 @@ static inline void mwait_play_dead(void)
>  	void *mwait_ptr;
>  	int i;
>  
> -	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
> +	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
>  		return;
>  	if (!this_cpu_has(X86_FEATURE_MWAIT))
>  		return;
> -- 

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
