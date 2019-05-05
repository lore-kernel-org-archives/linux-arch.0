From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 12/15] powerpc/nohash/64: switch to generic version of
 pte allocation
Date: Sun, 5 May 2019 09:23:39 +0300
Message-ID: <20190505062339.GF15755@rapoport-lnx>
References: <1556810922-20248-1-git-send-email-rppt@linux.ibm.com>
 <1556810922-20248-13-git-send-email-rppt@linux.ibm.com>
 <adcb6ae6-48d9-5ba9-2732-a0ab1d96667c@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <adcb6ae6-48d9-5ba9-2732-a0ab1d96667c@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Palmer Dabbelt <palmer@sifive.com>, linux-mips@vger.kernel.org, Guo Ren <guoren@kernel.org>, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Matthew Wilcox <willy@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Matt Turner <mattst88@gmail.com>, Sam Creasey <sammy@sammy.net>, Arnd Bergmann <arnd@arndb.de>, linux-um@lists.infradead.org, Richard Weinberger <richard@nod.at>, linux-m68k@lists.linux-m68k.org, Greentime Hu <green.hu@gmail.com>, nios2-dev@lists.rocketboards.org, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-ker
List-Id: linux-arch.vger.kernel.org

On Thu, May 02, 2019 at 06:56:07PM +0200, Christophe Leroy wrote:
> 
> 
> Le 02/05/2019 à 17:28, Mike Rapoport a écrit :
> >The 64-bit book-E powerpc implements pte_alloc_one(),
> >pte_alloc_one_kernel(), pte_free_kernel() and pte_free() the same way as
> >the generic version.
> 
> Will soon be converted to the same as the 3 other PPC subarches, see
> https://patchwork.ozlabs.org/patch/1091590/
 
Thanks for the heads up. I'll drop this from the next re-spin.

> Christophe
> 
> >
> >Switch it to the generic version that does exactly the same thing.
> >
> >Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> >---
> >  arch/powerpc/include/asm/nohash/64/pgalloc.h | 35 ++--------------------------
> >  1 file changed, 2 insertions(+), 33 deletions(-)
> >
> >diff --git a/arch/powerpc/include/asm/nohash/64/pgalloc.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
> >index 66d086f..bfb53a0 100644
> >--- a/arch/powerpc/include/asm/nohash/64/pgalloc.h
> >+++ b/arch/powerpc/include/asm/nohash/64/pgalloc.h
> >@@ -11,6 +11,8 @@
> >  #include <linux/cpumask.h>
> >  #include <linux/percpu.h>
> >+#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
> >+
> >  struct vmemmap_backing {
> >  	struct vmemmap_backing *list;
> >  	unsigned long phys;
> >@@ -92,39 +94,6 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
> >  	kmem_cache_free(PGT_CACHE(PMD_CACHE_INDEX), pmd);
> >  }
> >-
> >-static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
> >-{
> >-	return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> >-}
> >-
> >-static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
> >-{
> >-	struct page *page;
> >-	pte_t *pte;
> >-
> >-	pte = (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT);
> >-	if (!pte)
> >-		return NULL;
> >-	page = virt_to_page(pte);
> >-	if (!pgtable_page_ctor(page)) {
> >-		__free_page(page);
> >-		return NULL;
> >-	}
> >-	return page;
> >-}
> >-
> >-static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
> >-{
> >-	free_page((unsigned long)pte);
> >-}
> >-
> >-static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
> >-{
> >-	pgtable_page_dtor(ptepage);
> >-	__free_page(ptepage);
> >-}
> >-
> >  static inline void pgtable_free(void *table, int shift)
> >  {
> >  	if (!shift) {
> >
> 

-- 
Sincerely yours,
Mike.
