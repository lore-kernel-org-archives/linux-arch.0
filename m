From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 10/16] x86/mce: enable Hygon support to MCE
 infrastructure
Date: Wed, 5 Sep 2018 11:22:34 +0200
Message-ID: <20180905092234.GC2237@zn.tnic>
References: <cover.1535459012.git.puwen@hygon.cn>
 <c1e803bc54984e54ca67278930588e85b65bb26f.1535459013.git.puwen@hygon.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c1e803bc54984e54ca67278930588e85b65bb26f.1535459013.git.puwen@hygon.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-edac@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Aug 29, 2018 at 08:44:54PM +0800, Pu Wen wrote:
> Hygon machine check arch is similar to AMD family 17h. To enable the MCE
> infrastructure support, add CPU vendor check for Hygon to share the code
> path of AMD.
> 
> Add hygon mce init function mce_hygon_feature_init() to minimize further
> maintenance effort.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/include/asm/mce.h                |  5 +++++
>  arch/x86/kernel/cpu/mcheck/mce-severity.c |  3 ++-
>  arch/x86/kernel/cpu/mcheck/mce.c          | 21 +++++++++++++++------
>  3 files changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index 3a17107..12357aa 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -214,6 +214,11 @@ static inline void mce_amd_feature_init(struct cpuinfo_x86 *c) { }
>  static inline int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr) { return -EINVAL; };
>  #endif
>  
> +static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)
> +{
> +	return mce_amd_feature_init(c);
> +}
> +

What happens if CONFIG_X86_MCE_AMD=n ?

In general, since you're using AMD code, you need to make CPU_SUP_HYGON
depend on a bunch of AMD config items like CONFIG_X86_MCE_AMD,
CONFIG_CPU_SUP_AMD, CONFIG_AMD_NB,... Audit your code and see what other
config items need to be selected.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
