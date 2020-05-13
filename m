From: Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH 06/12] m68k/mm: move {cache,nocahe}_page() definitions
 close to their user
Date: Wed, 13 May 2020 21:19:45 +1000
Message-ID: <b59ef7eb-537e-c092-949f-225322f94e2c@linux-m68k.org>
References: <20200512184422.12418-1-rppt@kernel.org>
 <20200512184422.12418-7-rppt@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200512184422.12418-7-rppt@kernel.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Vincent Chen <deanbo422@gmail.com>, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Brian Cain <bcain@codeaurora.org>, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>, Mike Rapoport <rppt@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-parisc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi Mike,

On 13/5/20 4:44 am, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The cache_page() and nocache_page() functions are only used by the morotola
                                                                      ^^^^^^^^
                                                                      motorola

> MMU variant for setting caching attributes for the page table pages.
> 
> Move the definitions of these functions from
> arch/m68k/include/asm/motorola_pgtable.h closer to their usage in
> arch/m68k/mm/motorola.c and drop unused definition in
> arch/m68k/include/asm/mcf_pgtable.h.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Regards
Greg


> ---
>   arch/m68k/include/asm/mcf_pgtable.h      | 40 ---------------------
>   arch/m68k/include/asm/motorola_pgtable.h | 44 ------------------------
>   arch/m68k/mm/motorola.c                  | 43 +++++++++++++++++++++++
>   3 files changed, 43 insertions(+), 84 deletions(-)
> 
> diff --git a/arch/m68k/include/asm/mcf_pgtable.h b/arch/m68k/include/asm/mcf_pgtable.h
> index 0031cd387b75..737e826294f3 100644
> --- a/arch/m68k/include/asm/mcf_pgtable.h
> +++ b/arch/m68k/include/asm/mcf_pgtable.h
> @@ -328,46 +328,6 @@ extern pgd_t kernel_pg_dir[PTRS_PER_PGD];
>   #define pte_offset_kernel(dir, address) \
>   	((pte_t *) __pmd_page(*(dir)) + __pte_offset(address))
>   
> -/*
> - * Disable caching for page at given kernel virtual address.
> - */
> -static inline void nocache_page(void *vaddr)
> -{
> -	pgd_t *dir;
> -	p4d_t *p4dp;
> -	pud_t *pudp;
> -	pmd_t *pmdp;
> -	pte_t *ptep;
> -	unsigned long addr = (unsigned long) vaddr;
> -
> -	dir = pgd_offset_k(addr);
> -	p4dp = p4d_offset(dir, addr);
> -	pudp = pud_offset(p4dp, addr);
> -	pmdp = pmd_offset(pudp, addr);
> -	ptep = pte_offset_kernel(pmdp, addr);
> -	*ptep = pte_mknocache(*ptep);
> -}
> -
> -/*
> - * Enable caching for page at given kernel virtual address.
> - */
> -static inline void cache_page(void *vaddr)
> -{
> -	pgd_t *dir;
> -	p4d_t *p4dp;
> -	pud_t *pudp;
> -	pmd_t *pmdp;
> -	pte_t *ptep;
> -	unsigned long addr = (unsigned long) vaddr;
> -
> -	dir = pgd_offset_k(addr);
> -	p4dp = p4d_offset(dir, addr);
> -	pudp = pud_offset(p4dp, addr);
> -	pmdp = pmd_offset(pudp, addr);
> -	ptep = pte_offset_kernel(pmdp, addr);
> -	*ptep = pte_mkcache(*ptep);
> -}
> -
>   /*
>    * Encode and de-code a swap entry (must be !pte_none(e) && !pte_present(e))
>    */
> diff --git a/arch/m68k/include/asm/motorola_pgtable.h b/arch/m68k/include/asm/motorola_pgtable.h
> index 9e5a3de21e15..e1594acf7c7e 100644
> --- a/arch/m68k/include/asm/motorola_pgtable.h
> +++ b/arch/m68k/include/asm/motorola_pgtable.h
> @@ -227,50 +227,6 @@ static inline pte_t *pte_offset_kernel(pmd_t *pmdp, unsigned long address)
>   #define pte_offset_map(pmdp,address) ((pte_t *)__pmd_page(*pmdp) + (((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1)))
>   #define pte_unmap(pte)		((void)0)
>   
> -/* Prior to calling these routines, the page should have been flushed
> - * from both the cache and ATC, or the CPU might not notice that the
> - * cache setting for the page has been changed. -jskov
> - */
> -static inline void nocache_page(void *vaddr)
> -{
> -	unsigned long addr = (unsigned long)vaddr;
> -
> -	if (CPU_IS_040_OR_060) {
> -		pgd_t *dir;
> -		p4d_t *p4dp;
> -		pud_t *pudp;
> -		pmd_t *pmdp;
> -		pte_t *ptep;
> -
> -		dir = pgd_offset_k(addr);
> -		p4dp = p4d_offset(dir, addr);
> -		pudp = pud_offset(p4dp, addr);
> -		pmdp = pmd_offset(pudp, addr);
> -		ptep = pte_offset_kernel(pmdp, addr);
> -		*ptep = pte_mknocache(*ptep);
> -	}
> -}
> -
> -static inline void cache_page(void *vaddr)
> -{
> -	unsigned long addr = (unsigned long)vaddr;
> -
> -	if (CPU_IS_040_OR_060) {
> -		pgd_t *dir;
> -		p4d_t *p4dp;
> -		pud_t *pudp;
> -		pmd_t *pmdp;
> -		pte_t *ptep;
> -
> -		dir = pgd_offset_k(addr);
> -		p4dp = p4d_offset(dir, addr);
> -		pudp = pud_offset(p4dp, addr);
> -		pmdp = pmd_offset(pudp, addr);
> -		ptep = pte_offset_kernel(pmdp, addr);
> -		*ptep = pte_mkcache(*ptep);
> -	}
> -}
> -
>   /* Encode and de-code a swap entry (must be !pte_none(e) && !pte_present(e)) */
>   #define __swp_type(x)		(((x).val >> 4) & 0xff)
>   #define __swp_offset(x)		((x).val >> 12)
> diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
> index 904c2a663977..8e5e74121a78 100644
> --- a/arch/m68k/mm/motorola.c
> +++ b/arch/m68k/mm/motorola.c
> @@ -45,6 +45,49 @@ unsigned long mm_cachebits;
>   EXPORT_SYMBOL(mm_cachebits);
>   #endif
>   
> +/* Prior to calling these routines, the page should have been flushed
> + * from both the cache and ATC, or the CPU might not notice that the
> + * cache setting for the page has been changed. -jskov
> + */
> +static inline void nocache_page(void *vaddr)
> +{
> +	unsigned long addr = (unsigned long)vaddr;
> +
> +	if (CPU_IS_040_OR_060) {
> +		pgd_t *dir;
> +		p4d_t *p4dp;
> +		pud_t *pudp;
> +		pmd_t *pmdp;
> +		pte_t *ptep;
> +
> +		dir = pgd_offset_k(addr);
> +		p4dp = p4d_offset(dir, addr);
> +		pudp = pud_offset(p4dp, addr);
> +		pmdp = pmd_offset(pudp, addr);
> +		ptep = pte_offset_kernel(pmdp, addr);
> +		*ptep = pte_mknocache(*ptep);
> +	}
> +}
> +
> +static inline void cache_page(void *vaddr)
> +{
> +	unsigned long addr = (unsigned long)vaddr;
> +
> +	if (CPU_IS_040_OR_060) {
> +		pgd_t *dir;
> +		p4d_t *p4dp;
> +		pud_t *pudp;
> +		pmd_t *pmdp;
> +		pte_t *ptep;
> +
> +		dir = pgd_offset_k(addr);
> +		p4dp = p4d_offset(dir, addr);
> +		pudp = pud_offset(p4dp, addr);
> +		pmdp = pmd_offset(pudp, addr);
> +		ptep = pte_offset_kernel(pmdp, addr);
> +		*ptep = pte_mkcache(*ptep);
> +	}
> +}
>   
>   /*
>    * Motorola 680x0 user's manual recommends using uncached memory for address
> 
