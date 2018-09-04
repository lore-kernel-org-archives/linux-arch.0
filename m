From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 06/16] x86/nops: init ideal_nops for Hygon
Date: Tue, 4 Sep 2018 16:01:55 +0200
Message-ID: <20180904140155.GH32615@zn.tnic>
References: <cover.1535459012.git.puwen@hygon.cn>
 <afb6dd7821d014932dbc5c7d80aa6bffe6aef2c8.1535459013.git.puwen@hygon.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <afb6dd7821d014932dbc5c7d80aa6bffe6aef2c8.1535459013.git.puwen@hygon.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Aug 29, 2018 at 08:44:07PM +0800, Pu Wen wrote:
> The ideal_nops for Dhyana processors should be p6_nops.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/kernel/alternative.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 014f214..3f51d1c 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -222,6 +222,10 @@ void __init arch_init_ideal_nops(void)
>  		}
>  		break;
>  
> +	case X86_VENDOR_HYGON:
> +		ideal_nops = p6_nops;
> +		return;
> +
>  	case X86_VENDOR_AMD:
>  		if (boot_cpu_data.x86 > 0xf) {
>  			ideal_nops = p6_nops;
> -- 

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
