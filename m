From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v3 1/6] arm64: Detect the ARMv8.4 TTL feature
Date: Tue, 26 May 2020 08:09:03 +0530
Message-ID: <c6b6eb07-2606-9fc0-280a-e53b81a6491c@arm.com>
References: <20200525125300.794-1-yezhenyu2@huawei.com>
 <20200525125300.794-2-yezhenyu2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200525125300.794-2-yezhenyu2@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Zhenyu Ye <yezhenyu2@huawei.com>, catalin.marinas@arm.com, peterz@infradead.org, mark.rutland@arm.com, will@kernel.org, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
List-Id: linux-arch.vger.kernel.org

Hello Zhenyu,

On 05/25/2020 06:22 PM, Zhenyu Ye wrote:
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index c4ac0ac25a00..477d84ba1056 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -725,6 +725,7 @@
>  
>  /* id_aa64mmfr2 */
>  #define ID_AA64MMFR2_E0PD_SHIFT		60
> +#define ID_AA64MMFR2_TTL_SHIFT		48
>  #define ID_AA64MMFR2_FWB_SHIFT		40
>  #define ID_AA64MMFR2_AT_SHIFT		32
>  #define ID_AA64MMFR2_LVA_SHIFT		16
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 9fac745aa7bb..d993dc6dc7d5 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -244,6 +244,7 @@ static const struct arm64_ftr_bits ftr_id_aa64mmfr1[] = {
>  
>  static const struct arm64_ftr_bits ftr_id_aa64mmfr2[] = {
>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_E0PD_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_TTL_SHIFT, 4, 0),
>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_FWB_SHIFT, 4, 0),
>  	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_AT_SHIFT, 4, 0),
>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_LVA_SHIFT, 4, 0),
> @@ -1622,6 +1623,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.matches = has_cpuid_feature,
>  		.cpu_enable = cpu_has_fwb,
>  	},

This patch (https://patchwork.kernel.org/patch/11557359/) is adding some
more ID_AA64MMFR2 features including the TTL. I am going to respin parts
of the V4 series patches along with the above mentioned patch. So please
rebase this series accordingly, probably on latest next.

- Anshuman
