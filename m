From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 6/7] mm: convert generic code to 5-level paging
Date: Wed, 8 Mar 2017 14:57:35 +0100
Message-ID: <20170308135734.GA11034@dhcp22.suse.cz>
References: <20170306204514.1852-1-kirill.shutemov@linux.intel.com>
 <20170306204514.1852-7-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20170306204514.1852-7-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon 06-03-17 23:45:13, Kirill A. Shutemov wrote:
> Convert all non-architecture-specific code to 5-level paging.
> 
> It's mostly mechanical adding handling one more page table level in
> places where we deal with pud_t.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

OK, I haven't spotted anything major. I am just scratching my head about
the __ARCH_HAS_5LEVEL_HACK leak into kasan_init.c (see below). Why do we
need it?  It looks more than ugly but I am not familiar with kasan so
maybe this is really necessary.

Other than that free to to add
Acked-by: Michal Hocko <mhocko@suse.com>

The rest of the series look good (as good as all the pte hackery can get
;)) as well.

[...]
> diff --git a/mm/kasan/kasan_init.c b/mm/kasan/kasan_init.c
> index 31238dad85fb..7870ad44ee20 100644
> --- a/mm/kasan/kasan_init.c
> +++ b/mm/kasan/kasan_init.c
> @@ -30,6 +30,9 @@
>   */
>  unsigned char kasan_zero_page[PAGE_SIZE] __page_aligned_bss;
>  
> +#if CONFIG_PGTABLE_LEVELS > 4
> +p4d_t kasan_zero_p4d[PTRS_PER_P4D] __page_aligned_bss;
> +#endif
>  #if CONFIG_PGTABLE_LEVELS > 3
>  pud_t kasan_zero_pud[PTRS_PER_PUD] __page_aligned_bss;
>  #endif
[...]
> @@ -136,8 +157,12 @@ void __init kasan_populate_zero_shadow(const void *shadow_start,
>  			 * puds,pmds, so pgd_populate(), pud_populate()
>  			 * is noops.
>  			 */
> -			pgd_populate(&init_mm, pgd, lm_alias(kasan_zero_pud));
> -			pud = pud_offset(pgd, addr);
> +#ifndef __ARCH_HAS_5LEVEL_HACK
> +			pgd_populate(&init_mm, pgd, lm_alias(kasan_zero_p4d));
> +#endif
> +			p4d = p4d_offset(pgd, addr);
> +			p4d_populate(&init_mm, p4d, lm_alias(kasan_zero_pud));
> +			pud = pud_offset(p4d, addr);
>  			pud_populate(&init_mm, pud, lm_alias(kasan_zero_pmd));
>  			pmd = pmd_offset(pud, addr);
>  			pmd_populate_kernel(&init_mm, pmd, lm_alias(kasan_zero_pte));
-- 
Michal Hocko
SUSE Labs

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
