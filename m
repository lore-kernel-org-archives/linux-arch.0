Return-Path: <SRS0=ftPA=6H=kvack.org=owner-linux-mm@kernel.org>
Date: Thu, 23 Apr 2020 08:55:59 +0300
From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 17/21] mm: free_area_init: allow defining max_zone_pfn in
 descending order
Message-ID: <20200423055559.GF14260@kernel.org>
References: <20200412194859.12663-1-rppt@kernel.org>
 <20200412194859.12663-18-rppt@kernel.org>
 <20200423025311.GZ4247@MiWiFi-R3L-srv>
 <20200423025720.GA4247@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423025720.GA4247@MiWiFi-R3L-srv>
Sender: owner-linux-mm@kvack.org
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Brian Cain <bcain@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, Hoan Tran <Hoan@os.amperecomputing.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jonathan Corbet <corbet@lwn.net>, Ley Foon Tan <ley.foon.tan@intel.com>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@kernel.org>, Michal Simek <monstr@monstr.eu>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>, Richard Weinberger <richard@nod.at>, Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Tony Luck <tony.luck@intel.com>, Vineet Gupta <vgupta@synopsys.com>, x86@kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200423055559._QiIGM73B1kuqOlOlz_3tXnv2nx73ic6cUseH6eJ3W0@z>

On Thu, Apr 23, 2020 at 10:57:20AM +0800, Baoquan He wrote:
> On 04/23/20 at 10:53am, Baoquan He wrote:
> > On 04/12/20 at 10:48pm, Mike Rapoport wrote:
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > 
> > > Some architectures (e.g. ARC) have the ZONE_HIGHMEM zone below the
> > > ZONE_NORMAL. Allowing free_area_init() parse max_zone_pfn array even it is
> > > sorted in descending order allows using free_area_init() on such
> > > architectures.
> > > 
> > > Add top -> down traversal of max_zone_pfn array in free_area_init() and use
> > > the latter in ARC node/zone initialization.
> > 
> > Or maybe leave ARC as is. The change in this patchset doesn't impact
> > ARC's handling about zone initialization, leaving it as is can reduce
> > the complication in implementation of free_area_init(), which is a
> > common function. So I personally don't see a strong motivation to have
> > this patch.
> 
> OK, seems this patch is prepared to simplify free_area_init_node(), so
> take back what I said at above.
> 
> Then this looks necessary, even though it introduces special case into
> common function free_area_init().

The idea is to have a single free_area_init() for all architectures
without keeping two completely different ways of calculating the zone
extents.
Another thing, is that with this we could eventually switch ARC from
DISCONTIGMEM.

> Reviewed-by: Baoquan He <bhe@redhat.com>
> 
> > 
> > > 
> > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > ---
> > >  arch/arc/mm/init.c | 36 +++++++-----------------------------
> > >  mm/page_alloc.c    | 24 +++++++++++++++++++-----
> > >  2 files changed, 26 insertions(+), 34 deletions(-)
> > > 
> > > diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
> > > index 0920c969c466..41eb9be1653c 100644
> > > --- a/arch/arc/mm/init.c
> > > +++ b/arch/arc/mm/init.c
> > > @@ -63,11 +63,13 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
> > >  
> > >  		low_mem_sz = size;
> > >  		in_use = 1;
> > > +		memblock_add_node(base, size, 0);
> > >  	} else {
> > >  #ifdef CONFIG_HIGHMEM
> > >  		high_mem_start = base;
> > >  		high_mem_sz = size;
> > >  		in_use = 1;
> > > +		memblock_add_node(base, size, 1);
> > >  #endif
> > >  	}
> > >  
> > > @@ -83,8 +85,7 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
> > >   */
> > >  void __init setup_arch_memory(void)
> > >  {
> > > -	unsigned long zones_size[MAX_NR_ZONES];
> > > -	unsigned long zones_holes[MAX_NR_ZONES];
> > > +	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
> > >  
> > >  	init_mm.start_code = (unsigned long)_text;
> > >  	init_mm.end_code = (unsigned long)_etext;
> > > @@ -115,7 +116,6 @@ void __init setup_arch_memory(void)
> > >  	 * the crash
> > >  	 */
> > >  
> > > -	memblock_add_node(low_mem_start, low_mem_sz, 0);
> > >  	memblock_reserve(CONFIG_LINUX_LINK_BASE,
> > >  			 __pa(_end) - CONFIG_LINUX_LINK_BASE);
> > >  
> > > @@ -133,22 +133,7 @@ void __init setup_arch_memory(void)
> > >  	memblock_dump_all();
> > >  
> > >  	/*----------------- node/zones setup --------------------------*/
> > > -	memset(zones_size, 0, sizeof(zones_size));
> > > -	memset(zones_holes, 0, sizeof(zones_holes));
> > > -
> > > -	zones_size[ZONE_NORMAL] = max_low_pfn - min_low_pfn;
> > > -	zones_holes[ZONE_NORMAL] = 0;
> > > -
> > > -	/*
> > > -	 * We can't use the helper free_area_init(zones[]) because it uses
> > > -	 * PAGE_OFFSET to compute the @min_low_pfn which would be wrong
> > > -	 * when our kernel doesn't start at PAGE_OFFSET, i.e.
> > > -	 * PAGE_OFFSET != CONFIG_LINUX_RAM_BASE
> > > -	 */
> > > -	free_area_init_node(0,			/* node-id */
> > > -			    zones_size,		/* num pages per zone */
> > > -			    min_low_pfn,	/* first pfn of node */
> > > -			    zones_holes);	/* holes */
> > > +	max_zone_pfn[ZONE_NORMAL] = max_low_pfn;
> > >  
> > >  #ifdef CONFIG_HIGHMEM
> > >  	/*
> > > @@ -168,20 +153,13 @@ void __init setup_arch_memory(void)
> > >  	min_high_pfn = PFN_DOWN(high_mem_start);
> > >  	max_high_pfn = PFN_DOWN(high_mem_start + high_mem_sz);
> > >  
> > > -	zones_size[ZONE_NORMAL] = 0;
> > > -	zones_holes[ZONE_NORMAL] = 0;
> > > -
> > > -	zones_size[ZONE_HIGHMEM] = max_high_pfn - min_high_pfn;
> > > -	zones_holes[ZONE_HIGHMEM] = 0;
> > > -
> > > -	free_area_init_node(1,			/* node-id */
> > > -			    zones_size,		/* num pages per zone */
> > > -			    min_high_pfn,	/* first pfn of node */
> > > -			    zones_holes);	/* holes */
> > > +	max_zone_pfn[ZONE_HIGHMEM] = max_high_pfn;
> > >  
> > >  	high_memory = (void *)(min_high_pfn << PAGE_SHIFT);
> > >  	kmap_init();
> > >  #endif
> > > +
> > > +	free_area_init(max_zone_pfn);
> > >  }
> > >  
> > >  /*
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 343d87b8697d..376434c7a78b 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -7429,7 +7429,8 @@ static void check_for_memory(pg_data_t *pgdat, int nid)
> > >  void __init free_area_init(unsigned long *max_zone_pfn)
> > >  {
> > >  	unsigned long start_pfn, end_pfn;
> > > -	int i, nid;
> > > +	int i, nid, zone;
> > > +	bool descending = false;
> > >  
> > >  	/* Record where the zone boundaries are */
> > >  	memset(arch_zone_lowest_possible_pfn, 0,
> > > @@ -7439,13 +7440,26 @@ void __init free_area_init(unsigned long *max_zone_pfn)
> > >  
> > >  	start_pfn = find_min_pfn_with_active_regions();
> > >  
> > > +	/*
> > > +	 * Some architecturs, e.g. ARC may have ZONE_HIGHMEM below
> > > +	 * ZONE_NORMAL. For such cases we allow max_zone_pfn sorted in the
> > > +	 * descending order
> > > +	 */
> > > +	if (MAX_NR_ZONES > 1 && max_zone_pfn[0] > max_zone_pfn[1])
> > > +		descending = true;
> > > +
> > >  	for (i = 0; i < MAX_NR_ZONES; i++) {
> > > -		if (i == ZONE_MOVABLE)
> > > +		if (descending)
> > > +			zone = MAX_NR_ZONES - i - 1;
> > > +		else
> > > +			zone = i;
> > > +
> > > +		if (zone == ZONE_MOVABLE)
> > >  			continue;
> > >  
> > > -		end_pfn = max(max_zone_pfn[i], start_pfn);
> > > -		arch_zone_lowest_possible_pfn[i] = start_pfn;
> > > -		arch_zone_highest_possible_pfn[i] = end_pfn;
> > > +		end_pfn = max(max_zone_pfn[zone], start_pfn);
> > > +		arch_zone_lowest_possible_pfn[zone] = start_pfn;
> > > +		arch_zone_highest_possible_pfn[zone] = end_pfn;
> > >  
> > >  		start_pfn = end_pfn;
> > >  	}
> > > -- 
> > > 2.25.1
> > > 
> 

-- 
Sincerely yours,
Mike.
