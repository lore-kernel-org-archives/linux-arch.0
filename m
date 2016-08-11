From: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Subject: Re: [PATCH 05/19] arm64: rename COMPAT to AARCH32_EL0 in Kconfig
Date: Thu, 11 Aug 2016 15:35:01 +0800
Message-ID: <57AC2AA5.1030808@huawei.com>
References: <1466207668-10549-1-git-send-email-ynorov@caviumnetworks.com>
 <1466207668-10549-6-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <libc-alpha-return-72425-glibc-alpha=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
In-Reply-To: <1466207668-10549-6-git-send-email-ynorov@caviumnetworks.com>
To: Yury Norov <ynorov@caviumnetworks.com>, arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net, Andrew Pinski <apinski@cavium.com>, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>, Hanjun Guo <guohanjun@huawei.com>, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
List-Id: linux-arch.vger.kernel.org

Hi, Yury

On 2016/6/18 7:54, Yury Norov wrote:
> From: Andrew Pinski <apinski@cavium.com>
>
> In this patchset  ILP32 ABI support is added. Additionally to AARCH32,
> which is binary-compatible with ARM, ILP32 is (mostly) ABI-compatible.
>
>  From now, AARCH32_EL0 (former COMPAT) config option means the support of
> AARCH32 userspace, ARM64_ILP32 - support of ILP32 ABI (see next patches),
> and COMPAT indicates that one of them, or both, is enabled.
>
> Where needed, CONFIG_COMPAT is changed over to use CONFIG_AARCH32_EL0 instead
>
> Reviewed-by: David Daney <ddaney@caviumnetworks.com>
> Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> Signed-off-by: Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
...
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index c173d32..af200a8 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -134,15 +134,17 @@ static int c_show(struct seq_file *m, void *v)
>   		 */
>   		seq_puts(m, "Features\t:");
>   		if (compat) {
> -#ifdef CONFIG_COMPAT
> -			for (j = 0; compat_hwcap_str[j]; j++)
> -				if (compat_elf_hwcap & (1 << j))
> -					seq_printf(m, " %s", compat_hwcap_str[j]);
> -
> -			for (j = 0; compat_hwcap2_str[j]; j++)
> -				if (compat_elf_hwcap2 & (1 << j))
> -					seq_printf(m, " %s", compat_hwcap2_str[j]);
> -#endif /* CONFIG_COMPAT */
> +#ifdef CONFIG_AARCH32_EL0
I saw that compat_hwcap_str and compat_hwcap2_str is defined when
"CONFIG_COMPAT" is true. Why we only change it to CONFIG_AARCH32_EL0
in c show()?
> +			if (personality(current->personality) == PER_LINUX32) {
And "compat" is "personality(current->personality) == PER_LINUX32;",
it seems that there is no need to add this twice.

Regards

Bamvor
> +				for (j = 0; compat_hwcap_str[j]; j++)
> +					if (compat_elf_hwcap & (1 << j))
> +						seq_printf(m, " %s", compat_hwcap_str[j]);
> +
> +				for (j = 0; compat_hwcap2_str[j]; j++)
> +					if (compat_elf_hwcap2 & (1 << j))
> +						seq_printf(m, " %s", compat_hwcap2_str[j]);
> +			}
> +#endif /* CONFIG_AARCH32_EL0 */
>   		} else {
>   			for (j = 0; hwcap_str[j]; j++)
>   				if (elf_hwcap & (1 << j))
