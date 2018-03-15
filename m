From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 2/4] ioremap: Implement TLB_INV before huge mapping
Date: Thu, 15 Mar 2018 13:31:58 +0000
Message-ID: <20180315133157.ucbdg25jo5ew3t2h@lakrids.cambridge.arm.com>
References: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
 <1521117906-20107-3-git-send-email-cpandya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1521117906-20107-3-git-send-email-cpandya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, toshi.kani@hpe.com
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 15, 2018 at 06:15:04PM +0530, Chintan Pandya wrote:
> @@ -91,10 +93,15 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
>  
>  		if (ioremap_pmd_enabled() &&
>  		    ((next - addr) == PMD_SIZE) &&
> -		    IS_ALIGNED(phys_addr + addr, PMD_SIZE) &&
> -		    pmd_free_pte_page(pmd)) {
> -			if (pmd_set_huge(pmd, phys_addr + addr, prot))
> +		    IS_ALIGNED(phys_addr + addr, PMD_SIZE)) {
> +			old_pmd = *pmd;
> +			pmd_clear(pmd);
> +			flush_tlb_pgtable(&init_mm, addr);
> +			if (pmd_set_huge(pmd, phys_addr + addr, prot)) {
> +				pmd_free_pte_page(&old_pmd);
>  				continue;
> +			} else
> +				set_pmd(pmd, old_pmd);
>  		}
>  

Can we have something like a pmd_can_set_huge() helper? Then we could
avoid pointless modification and TLB invalidation work when
pmd_set_huge() will fail.

	if (ioremap_pmd_enabled() &&
	    ((next - addr) == PMD_SIZE) &&
	    IS_ALIGNED(phys_addr + addr, PMD_SIZE) &&
	    pmd_can_set_huge(pmd, phys_addr + addr, prot)) {
	    	// clear entries, invalidate TLBs, and free tables
		...
		continue;

	}

Thanks,
MArk.
