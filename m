From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH 18/19] arm64:ilp32: add vdso-ilp32 and use for signal return
Date: Mon, 20 Jun 2016 16:54:17 +0200
Message-ID: <mvminx3ud0m.fsf@hawking.suse.de>
References: <1466207668-10549-1-git-send-email-ynorov@caviumnetworks.com>
	<1466207668-10549-19-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <libc-alpha-return-70801-glibc-alpha=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
In-Reply-To: <1466207668-10549-19-git-send-email-ynorov@caviumnetworks.com>
	(Yury Norov's message of "Sat, 18 Jun 2016 02:54:27 +0300")
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net
List-Id: linux-arch.vger.kernel.org

Yury Norov <ynorov@caviumnetworks.com> writes:

> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index 2a0de6f..e48ea34 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -40,6 +40,12 @@ extern char vdso_start, vdso_end;
>  static unsigned long vdso_pages;
>  static struct page **vdso_pagelist;
>  
> +#ifdef CONFIG_ARM64_ILP32
> +extern char vdso_ilp32_start, vdso_ilp32_end;
> +static unsigned long vdso_ilp32_pages;
> +static struct page **vdso_ilp32_pagelist;
> +#endif
> +
>  /*
>   * The vDSO data page.
>   */
> @@ -110,24 +116,29 @@ int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
>  }
>  #endif /* CONFIG_AARCH32_EL0 */
>  
> -static struct vm_special_mapping vdso_spec[2];
> -
> -static int __init vdso_init(void)
> +static int __init vdso_init_common(char *vdso_start, char *vdso_end,

Using the same name for the parameter as for the global variable is
dangerous ....

> +					  unsigned long *vdso_pagesp,
> +					  struct page ***vdso_pagelistp,
> +					  struct vm_special_mapping* vdso_spec)
>  {
>  	int i;
> +	unsigned long vdso_pages;
> +	struct page **vdso_pagelist;
>  
> -	if (memcmp(&vdso_start, "\177ELF", 4)) {
> +	if (memcmp(vdso_start, "\177ELF", 4)) {

... because forgetting to remove & can be fatal, and your compiler may
not even warn you.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
