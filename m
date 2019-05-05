From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 04/15] arm64: switch to generic version of pte allocation
Date: Sun, 5 May 2019 09:19:57 +0300
Message-ID: <20190505061956.GE15755@rapoport-lnx>
References: <1556810922-20248-1-git-send-email-rppt@linux.ibm.com>
 <1556810922-20248-5-git-send-email-rppt@linux.ibm.com>
 <20190503100508.GB47811@lakrids.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190503100508.GB47811@lakrids.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>, Ley Foon Tan <lftan@altera.com>, Matthew Wilcox <willy@infradead.org>, Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Palmer Dabbelt <palmer@sifive.com>, Paul Burton <paul.burton@mips.com>, Richard Kuo <rkuo@codeaurora.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Sam Creasey <sammy@sammy.net>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.orglinux-
List-Id: linux-arch.vger.kernel.org

On Fri, May 03, 2019 at 11:05:09AM +0100, Mark Rutland wrote:
> Hi,
> 
> On Thu, May 02, 2019 at 06:28:31PM +0300, Mike Rapoport wrote:
> > The PTE allocations in arm64 are identical to the generic ones modulo the
> > GFP flags.
> > 
> > Using the generic pte_alloc_one() functions ensures that the user page
> > tables are allocated with __GFP_ACCOUNT set.
> > 
> > The arm64 definition of PGALLOC_GFP is removed and replaced with
> > GFP_PGTABLE_USER for p[gum]d_alloc_one() and for KVM memory cache.
> > 
> > The mappings created with create_pgd_mapping() are now using
> > GFP_PGTABLE_KERNEL.
> > 
> > The conversion to the generic version of pte_free_kernel() removes the NULL
> > check for pte.
> > 
> > The pte_free() version on arm64 is identical to the generic one and
> > can be simply dropped.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  arch/arm64/include/asm/pgalloc.h | 43 ++++------------------------------------
> >  arch/arm64/mm/mmu.c              |  2 +-
> >  arch/arm64/mm/pgd.c              |  4 ++--
> >  virt/kvm/arm/mmu.c               |  2 +-
> >  4 files changed, 8 insertions(+), 43 deletions(-)
> 
> [...]
> 
> > diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
> > index 289f911..2ef1a53 100644
> > --- a/arch/arm64/mm/pgd.c
> > +++ b/arch/arm64/mm/pgd.c
> > @@ -31,9 +31,9 @@ static struct kmem_cache *pgd_cache __ro_after_init;
> >  pgd_t *pgd_alloc(struct mm_struct *mm)
> >  {
> >  	if (PGD_SIZE == PAGE_SIZE)
> > -		return (pgd_t *)__get_free_page(PGALLOC_GFP);
> > +		return (pgd_t *)__get_free_page(GFP_PGTABLE_USER);
> >  	else
> > -		return kmem_cache_alloc(pgd_cache, PGALLOC_GFP);
> > +		return kmem_cache_alloc(pgd_cache, GFP_PGTABLE_USER);
> >  }
> 
> In efi_virtmap_init() we use pgd_alloc() to allocate a pgd for EFI
> runtime services, which we map with a special kernel page table.
> 
> I'm not sure if accounting that is problematic, as it's allocated in a
> kernel thread off the back of an early_initcall.

The accounting bypasses kernel threads so there should be no problem.
 
> Just to check, Is that sound, or do we need a pgd_alloc_kernel()?
> 
> Thanks,
> Mark.
> 

-- 
Sincerely yours,
Mike.
