From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 10/18] arm64: ilp32: introduce binfmt_ilp32.c
Date: Mon, 5 Dec 2016 15:38:01 +0000
Message-ID: <20161205153801.GE14429@e104818-lin.cambridge.arm.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <1477081997-4770-11-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477081997-4770-11-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, zhouchengming1@huawei.com, Prasun.Kapoor@caviumnetworks.com, agraf@suse.de, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, pinskia@gmail.com, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, maxim.kuvyrkov@linaro.org, Nathan_Lynch@mentor.com, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com
List-Id: linux-arch.vger.kernel.org

On Fri, Oct 21, 2016 at 11:33:09PM +0300, Yury Norov wrote:
> binfmt_ilp32.c is needed to handle ILP32 binaries
> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> Signed-off-by: Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>
> ---
>  arch/arm64/include/asm/elf.h     |  6 +++
>  arch/arm64/kernel/Makefile       |  1 +
>  arch/arm64/kernel/binfmt_ilp32.c | 97 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 104 insertions(+)
>  create mode 100644 arch/arm64/kernel/binfmt_ilp32.c
> 
> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index f259fe8..be29dde 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -175,10 +175,16 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
>  
>  #define COMPAT_ELF_ET_DYN_BASE		(2 * TASK_SIZE_32 / 3)
>  
> +#ifndef USE_AARCH64_GREG
>  /* AArch32 registers. */
>  #define COMPAT_ELF_NGREG		18
>  typedef unsigned int			compat_elf_greg_t;
>  typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
> +#else /* AArch64 registers for AARCH64/ILP32 */
> +#define COMPAT_ELF_NGREG	ELF_NGREG
> +#define compat_elf_greg_t	elf_greg_t
> +#define compat_elf_gregset_t	elf_gregset_t
> +#endif

I think you only need compat_elf_gregset_t definition here and leave the
other two undefined.

-- 
Catalin
