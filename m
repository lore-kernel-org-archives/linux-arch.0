From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 09/18] arm64: introduce binfmt_elf32.c
Date: Mon, 5 Dec 2016 15:10:19 +0000
Message-ID: <20161205151018.GD14429@e104818-lin.cambridge.arm.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <1477081997-4770-10-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751100AbcLEPK0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 5 Dec 2016 10:10:26 -0500
Content-Disposition: inline
In-Reply-To: <1477081997-4770-10-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, zhouchengming1@huawei.com, Prasun.Kapoor@caviumnetworks.com, agraf@suse.de, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, pinskia@gmail.com, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, maxim.kuvyrkov@linaro.org, Nathan_Lynch@mentor.com, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com

On Fri, Oct 21, 2016 at 11:33:08PM +0300, Yury Norov wrote:
> As we support more than one compat formats, it looks more reasonable
> to not use fs/compat_binfmt.c. Custom binfmt_elf32.c allows to move aarch32
> specific definitions there and make code more maintainable and readable.

Can you remind me why we need this patch (rather than using the default
fs/compat_binfmt_elf.c which you include here anyway)?

> --- /dev/null
> +++ b/arch/arm64/kernel/binfmt_elf32.c
> @@ -0,0 +1,31 @@
> +/*
> + * Support for AArch32 Linux ELF binaries.
> + */
> +
> +/* AArch32 EABI. */
> +#define EF_ARM_EABI_MASK		0xff000000
> +
> +#define compat_start_thread		compat_start_thread
> +#define COMPAT_SET_PERSONALITY(ex)		\
> +do {						\
> +	clear_thread_flag(TIF_32BIT_AARCH64);	\
> +	set_thread_flag(TIF_32BIT);		\
> +} while (0)

You introduce this here but it seems to still be present in asm/elf.h.

-- 
Catalin
