Return-Path: <SRS0=8zp0=4W=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from foss.arm.com ([217.140.110.172]:44192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgCEHef (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Mar 2020 02:34:35 -0500
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] mm/special: Create generic fallbacks for pte_special()
 and pte_mkspecial()
References: <1583114190-7678-1-git-send-email-anshuman.khandual@arm.com>
Message-ID: <58aecdcf-ea16-c958-0deb-97541792e081@arm.com>
Date: Thu, 5 Mar 2020 13:04:19 +0530
MIME-Version: 1.0
In-Reply-To: <1583114190-7678-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mm@kvack.org, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>
Cc: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Sam Creasey <sammy@sammy.net>, Michal Simek <monstr@monstr.eu>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Ley Foon Tan <ley.foon.tan@intel.com>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Guan Xuetao <gxt@pku.edu.cn>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20200305073419.IBNesHDsyJ-u-lJkxGzMmR0H03mqjBSGCT9082DI9-U@z>


On 03/02/2020 07:26 AM, Anshuman Khandual wrote:
> diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
> index aef5378f909c..8e4e4be1ca00 100644
> --- a/arch/mips/include/asm/pgtable.h
> +++ b/arch/mips/include/asm/pgtable.h
> @@ -269,6 +269,36 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
>   */
>  extern pgd_t swapper_pg_dir[];
>  
> +/*
> + * Platform specific pte_special() and pte_mkspecial() definitions
> + * are required only when ARCH_HAS_PTE_SPECIAL is enabled.
> + */
> +#if !defined(CONFIG_32BIT) && !defined(CONFIG_CPU_HAS_RIXI)
> +#if defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
> +static inline int pte_special(pte_t pte)
> +{
> +	return pte.pte_low & _PAGE_SPECIAL;
> +}
> +
> +static inline pte_t pte_mkspecial(pte_t pte)
> +{
> +	pte.pte_low |= _PAGE_SPECIAL;
> +	return pte;
> +}
> +#else
> +static inline int pte_special(pte_t pte)
> +{
> +	return pte_val(pte) & _PAGE_SPECIAL;
> +}
> +
> +static inline pte_t pte_mkspecial(pte_t pte)
> +{
> +	pte_val(pte) |= _PAGE_SPECIAL;
> +	return pte;
> +}
> +#endif
> +#endif
> +

Hello Ralf/Paul,

This change now restricts mips definitions for pte_special() and pte_mkspecial()
and makes them visible only for configs where ARCH_HAS_PTE_SPECIAL is enabled.
Does this look okay ? In almost all other platforms we drop the stub definitions
for pte_special() and pte_mkspecial().

- Anshuman
