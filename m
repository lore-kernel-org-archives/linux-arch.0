Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751241AbeFHRcP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Jun 2018 13:32:15 -0400
Date: Fri, 8 Jun 2018 18:32:07 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 04/24] 32-bit userspace ABI: introduce ARCH_32BIT_OFF_T
 config option
Message-ID: <20180608173207.nwoi25jee52gpdwy@armageddon.cambridge.arm.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20180516081910.10067-5-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516081910.10067-5-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Joseph Myers <joseph@codesourcery.com>, Steve Ellcey <sellcey@caviumnetworks.com>, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, Andreas Schwab <schwab@suse.de>, Alexander Graf <agraf@suse.de>, Bamvor Zhangjian <bamv2005@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Dave Martin <Dave.Martin@arm.com>, Adam Borowski <kilobyte@angband.pl>, Manuel Montezelo <manuel.montezelo@gmail.com>, James Hogan <james.hogan@imgtec.com>, Chris Metcalf <cmetcalf@mellanox.com>, Andrew Pinski <pinskia@gmail.com>, Lin Yongting <linyongting@huawei.com>, Alexey Klimov <klimov.linux@gmail.com>, Mark Brown <broonie@kernel.org>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Florian Weimer <fweimer@redhat.com>, Nathan_Lynch <Nathan_Lynch@mentor.com>, James Morse <james.morse@arm.com>, Ramana Radhakrishnan <ramana.gcc@googlemail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "David S . Miller" <davem@davemloft.net>, Christoph Muellner <christoph.muellner@theobroma-systems.com>
Message-ID: <20180608173207.PxoBnqe22rXFJ-QlcJnEgD9VrmM-QUbY62gio2Xqous@z>

On Wed, May 16, 2018 at 11:18:49AM +0300, Yury Norov wrote:
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 76c0b54443b1..ee079244dc3c 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -264,6 +264,21 @@ config ARCH_THREAD_STACK_ALLOCATOR
>  config ARCH_WANTS_DYNAMIC_TASK_STRUCT
>  	bool
>  
> +config ARCH_32BIT_OFF_T
> +	bool
> +	depends on !64BIT
> +	help
> +	  All new 32-bit architectures should have 64-bit off_t type on
> +	  userspace side which corresponds to the loff_t kernel type. This
> +	  is the requirement for modern ABIs. Some existing architectures
> +	  already have 32-bit off_t. This option is enabled for all such
> +	  architectures explicitly. Namely: arc, arm, blackfin, cris, frv,
> +	  h8300, hexagon, m32r, m68k, metag, microblaze, mips32, mn10300,
> +	  nios2, openrisc, parisc32, powerpc32, score, sh, sparc, tile32,
> +	  unicore32, x86_32 and xtensa. This is the complete list. Any
> +	  new 32-bit architecture should declare 64-bit off_t type on user
> +	  side and so should not enable this option.

Do you know if this is the case for riscv and nds32, merged in the
meantime? If not, I suggest you drop this patch altogether and just
define force_o_largefile() for arm64/ilp32 as we don't seem to stick to
"all new 32-bit architectures should have 64-bit off_t".

-- 
Catalin
