Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38942 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750972AbeCZJzq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Mar 2018 05:55:46 -0400
Date: Mon, 26 Mar 2018 10:55:41 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 2/3] arm64: Implement page table free interfaces
Message-ID: <20180326095541.izogc4iak6d7nerm@lakrids.cambridge.arm.com>
References: <1521546314-31753-1-git-send-email-cpandya@codeaurora.org>
 <1521546314-31753-3-git-send-email-cpandya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521546314-31753-3-git-send-email-cpandya@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, toshi.kani@hpe.com
Message-ID: <20180326095541.ir7lU_Vpc4HlqWdSGiMtuJmRgZqEV937Jg6Juocr6Dg@z>

On Tue, Mar 20, 2018 at 05:15:13PM +0530, Chintan Pandya wrote:
> +static int __pmd_free_pte_page(pmd_t *pmd, unsigned long addr, bool tlb_inv)
> +{
> +	pmd_t *table;
> +
> +	if (pmd_val(*pmd)) {
> +		table = __va(pmd_val(*pmd));
> +		pmd_clear(pmd);
> +		/*
> +		 * FIXME: __flush_tlb_pgtable(&init_mm, addr) is
> +		 *        ideal candidate here, which exactly
> +		 *        flushes intermediate pgtables. But,
> +		 *        this is broken (evident from tests).
> +		 *        So, use safe TLB op unless that is fixed.
> +		 */
> +		if (tlb_inv)
> +			flush_tlb_kernel_range(addr, addr + PMD_SIZE);

I don't think that __flush_tlb_pgtable() is broken. It's only valid to
call it for user page tables, since it doesn't affect all ASIDs.

We can add a simlar helper for kernel mappings, which affects all ASIDs,
e.g.

static inline void __flush_tlb_kernel_pgtable(unsigned long addr)
{
	addr >>= 12;
	__tlbi(vaae1is, addr);
	dsb(ish);
}

Thanks,
Mark.
