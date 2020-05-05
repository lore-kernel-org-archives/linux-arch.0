From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH v3 1/2] arm64: tlb: Detect the ARMv8.4 TLBI RANGE
 feature
Date: Tue, 5 May 2020 11:14:05 +0100
Message-ID: <20200505101405.GB82424@C02TD0UTHF1T.local>
References: <20200414112835.1121-1-yezhenyu2@huawei.com>
 <20200414112835.1121-2-yezhenyu2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:36356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728422AbgEEKOR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 May 2020 06:14:17 -0400
Content-Disposition: inline
In-Reply-To: <20200414112835.1121-2-yezhenyu2@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Zhenyu Ye <yezhenyu2@huawei.com>
Cc: will@kernel.org, catalin.marinas@arm.com, suzuki.poulose@arm.com, maz@kernel.org, steven.price@arm.com, guohanjun@huawei.com, olof@lixom.net, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, xiexiangyou@huawei.com, zhangshaokun@hisilicon.com, linux-mm@kvack.org, arm@kernel.org, prime.zeng@hisilicon.com, kuhn.chenqun@huawei.com, linux-arm-kernel@lists.infradead.org

On Tue, Apr 14, 2020 at 07:28:34PM +0800, Zhenyu Ye wrote:
> ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
> range of input addresses. This patch detect this feature.
> 
> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
> ---
>  arch/arm64/include/asm/cpucaps.h |  3 ++-
>  arch/arm64/include/asm/sysreg.h  |  4 ++++
>  arch/arm64/kernel/cpufeature.c   | 11 +++++++++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> index 8eb5a088ae65..950095a72617 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -61,7 +61,8 @@
>  #define ARM64_HAS_AMU_EXTN			51
>  #define ARM64_HAS_ADDRESS_AUTH			52
>  #define ARM64_HAS_GENERIC_AUTH			53
> +#define ARM64_HAS_TLBI_RANGE			54
>  
> -#define ARM64_NCAPS				54
> +#define ARM64_NCAPS				55
>  
>  #endif /* __ASM_CPUCAPS_H */
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index ebc622432831..ac1b98650234 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -592,6 +592,7 @@
>  
>  /* id_aa64isar0 */
>  #define ID_AA64ISAR0_RNDR_SHIFT		60
> +#define ID_AA64ISAR0_TLBI_RANGE_SHIFT	56
>  #define ID_AA64ISAR0_TS_SHIFT		52
>  #define ID_AA64ISAR0_FHM_SHIFT		48
>  #define ID_AA64ISAR0_DP_SHIFT		44
> @@ -605,6 +606,9 @@
>  #define ID_AA64ISAR0_SHA1_SHIFT		8
>  #define ID_AA64ISAR0_AES_SHIFT		4
>  
> +#define ID_AA64ISAR0_TLBI_RANGE_NI	0x0
> +#define ID_AA64ISAR0_TLBI_RANGE		0x2
> +
>  /* id_aa64isar1 */
>  #define ID_AA64ISAR1_I8MM_SHIFT		52
>  #define ID_AA64ISAR1_DGH_SHIFT		48
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 9fac745aa7bb..31bcfd0722b5 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -124,6 +124,7 @@ static bool __system_matches_cap(unsigned int n);
>   */
>  static const struct arm64_ftr_bits ftr_id_aa64isar0[] = {
>  	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_RNDR_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_TLBI_RANGE_SHIFT, 4, 0),

This should be FTR_HIDDEN as userspace has no reason to see this.

Otherwise this all seems to match the ARM ARM.

Mark.

>  	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_TS_SHIFT, 4, 0),
>  	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_FHM_SHIFT, 4, 0),
>  	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_DP_SHIFT, 4, 0),
> @@ -1779,6 +1780,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.min_field_value = 1,
>  	},
>  #endif
> +	{
> +		.desc = "TLB range maintenance instruction",
> +		.capability = ARM64_HAS_TLBI_RANGE,
> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.matches = has_cpuid_feature,
> +		.sys_reg = SYS_ID_AA64ISAR0_EL1,
> +		.field_pos = ID_AA64ISAR0_TLBI_RANGE_SHIFT,
> +		.sign = FTR_UNSIGNED,
> +		.min_field_value = ID_AA64ISAR0_TLBI_RANGE,
> +	},
>  	{},
>  };
>  
> -- 
> 2.19.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
