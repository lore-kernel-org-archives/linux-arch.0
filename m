Return-Path: <SRS0=lzY1=6F=kvack.org=owner-linux-mm@kernel.org>
Date: Tue, 21 Apr 2020 11:49:35 +0300
From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 02/21] mm: make early_pfn_to_nid() and related defintions
 close to each other
Message-ID: <20200421084935.GB14260@kernel.org>
References: <20200412194859.12663-1-rppt@kernel.org>
 <20200412194859.12663-3-rppt@kernel.org>
 <20200421022435.GP4247@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421022435.GP4247@MiWiFi-R3L-srv>
Sender: owner-linux-mm@kvack.org
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Brian Cain <bcain@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, Hoan Tran <Hoan@os.amperecomputing.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jonathan Corbet <corbet@lwn.net>, Ley Foon Tan <ley.foon.tan@intel.com>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@kernel.org>, Michal Simek <monstr@monstr.eu>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>, Richard Weinberger <richard@nod.at>, Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Tony Luck <tony.luck@intel.com>, Vineet Gupta <vgupta@synopsys.com>, x86@kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200421084935.nLOhN0hbaUC_0E_P-QlD7J1mad02qef3CxRiC8vRzXY@z>

On Tue, Apr 21, 2020 at 10:24:35AM +0800, Baoquan He wrote:
> On 04/12/20 at 10:48pm, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The early_pfn_to_nid() and it's helper __early_pfn_to_nid() are spread
> > around include/linux/mm.h, include/linux/mmzone.h and mm/page_alloc.c.
> > 
> > Drop unused stub for __early_pfn_to_nid() and move its actual generic
> > implementation close to its users.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  include/linux/mm.h     |  4 ++--
> >  include/linux/mmzone.h |  9 --------
> >  mm/page_alloc.c        | 51 +++++++++++++++++++++---------------------
> >  3 files changed, 27 insertions(+), 37 deletions(-)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 5a323422d783..a404026d14d4 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2388,9 +2388,9 @@ extern void sparse_memory_present_with_active_regions(int nid);
> >  
> >  #if !defined(CONFIG_HAVE_MEMBLOCK_NODE_MAP) && \
> >      !defined(CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID)
> > -static inline int __early_pfn_to_nid(unsigned long pfn,
> > -					struct mminit_pfnnid_cache *state)
> > +static inline int early_pfn_to_nid(unsigned long pfn)
> >  {
> > +	BUILD_BUG_ON(IS_ENABLED(CONFIG_NUMA));
> >  	return 0;
> >  }
> 
> It's better to make a separate patch to drop __early_pfn_to_nid() here.

Not sure it's really worth it.
This patch anyway only moves the code around without any actual changes.

> >  #else
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 1b9de7d220fb..7b5b6eba402f 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -1078,15 +1078,6 @@ static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
> >  #include <asm/sparsemem.h>
> >  #endif
> >  
> > -#if !defined(CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID) && \
> > -	!defined(CONFIG_HAVE_MEMBLOCK_NODE_MAP)
> > -static inline unsigned long early_pfn_to_nid(unsigned long pfn)
> > -{
> > -	BUILD_BUG_ON(IS_ENABLED(CONFIG_NUMA));
> > -	return 0;
> > -}
> > -#endif
> > -
> >  #ifdef CONFIG_FLATMEM
> >  #define pfn_to_nid(pfn)		(0)
> >  #endif
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 0d012eda1694..1ac775bfc9cf 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1504,6 +1504,31 @@ void __free_pages_core(struct page *page, unsigned int order)
> 
> #if defined(CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID) || \
>         defined(CONFIG_HAVE_MEMBLOCK_NODE_MAP)
> 
> This is the upper layer of ifdeffery scope.
> >  
> >  static struct mminit_pfnnid_cache early_pfnnid_cache __meminitdata;
> >  
> > +#ifndef CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID
> 
> Moving __early_pfn_to_nid() here makes the upper layer of ifdeferry
> scope a little werid. But seems no better way to optimize it.

It gets a bit better after patch 3 :)

> Otherwise, this patch looks good to me.
> 
> Reviewed-by: Baoquan He <bhe@redhat.com>

Thanks!

> > +
> > +/*
> > + * Required by SPARSEMEM. Given a PFN, return what node the PFN is on.
> > + */
> > +int __meminit __early_pfn_to_nid(unsigned long pfn,
> > +					struct mminit_pfnnid_cache *state)
> > +{
> > +	unsigned long start_pfn, end_pfn;
> > +	int nid;
> > +
> > +	if (state->last_start <= pfn && pfn < state->last_end)
> > +		return state->last_nid;
> > +
> > +	nid = memblock_search_pfn_nid(pfn, &start_pfn, &end_pfn);
> > +	if (nid != NUMA_NO_NODE) {
> > +		state->last_start = start_pfn;
> > +		state->last_end = end_pfn;
> > +		state->last_nid = nid;
> > +	}
> > +
> > +	return nid;
> > +}
> > +#endif /* CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID */
> > +
> >  int __meminit early_pfn_to_nid(unsigned long pfn)
> >  {
> >  	static DEFINE_SPINLOCK(early_pfn_lock);
> > @@ -6298,32 +6323,6 @@ void __meminit init_currently_empty_zone(struct zone *zone,
> >  	zone->initialized = 1;
> >  }
> >  
> > -#ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
> > -#ifndef CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID
> > -
> > -/*
> > - * Required by SPARSEMEM. Given a PFN, return what node the PFN is on.
> > - */
> > -int __meminit __early_pfn_to_nid(unsigned long pfn,
> > -					struct mminit_pfnnid_cache *state)
> > -{
> > -	unsigned long start_pfn, end_pfn;
> > -	int nid;
> > -
> > -	if (state->last_start <= pfn && pfn < state->last_end)
> > -		return state->last_nid;
> > -
> > -	nid = memblock_search_pfn_nid(pfn, &start_pfn, &end_pfn);
> > -	if (nid != NUMA_NO_NODE) {
> > -		state->last_start = start_pfn;
> > -		state->last_end = end_pfn;
> > -		state->last_nid = nid;
> > -	}
> > -
> > -	return nid;
> > -}
> > -#endif /* CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID */
> > -
> >  /**
> >   * free_bootmem_with_active_regions - Call memblock_free_early_nid for each active range
> >   * @nid: The node to free memory on. If MAX_NUMNODES, all nodes are freed.
> > -- 
> > 2.25.1
> > 
> 

-- 
Sincerely yours,
Mike.
