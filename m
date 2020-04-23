Return-Path: <SRS0=ftPA=6H=kvack.org=owner-linux-mm@kernel.org>
Date: Thu, 23 Apr 2020 09:18:46 +0300
From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 18/21] mm: rename free_area_init_node() to
 free_area_init_memoryless_node()
Message-ID: <20200423061846.GG14260@kernel.org>
References: <20200412194859.12663-1-rppt@kernel.org>
 <20200412194859.12663-19-rppt@kernel.org>
 <20200423031454.GB4247@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423031454.GB4247@MiWiFi-R3L-srv>
Sender: owner-linux-mm@kvack.org
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Brian Cain <bcain@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, Hoan Tran <Hoan@os.amperecomputing.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jonathan Corbet <corbet@lwn.net>, Ley Foon Tan <ley.foon.tan@intel.com>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@kernel.org>, Michal Simek <monstr@monstr.eu>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>, Richard Weinberger <richard@nod.at>, Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Tony Luck <tony.luck@intel.com>, Vineet Gupta <vgupta@synopsys.com>, x86@kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200423061846.yP5nV2brCGnxxeGIMLoNPB4DVr7IVMqF9wu2aDRxEjU@z>

On Thu, Apr 23, 2020 at 11:14:54AM +0800, Baoquan He wrote:
> On 04/12/20 at 10:48pm, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The free_area_init_node() is only used by x86 to initialize a memory-less
> > nodes.
> > Make its name reflect this and drop all the function parameters except node
> > ID as they are anyway zero.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  arch/x86/mm/numa.c | 5 +----
> >  include/linux/mm.h | 9 +++------
> >  mm/page_alloc.c    | 7 ++-----
> >  3 files changed, 6 insertions(+), 15 deletions(-)
> > 
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > index fe024b2ac796..8ee952038c80 100644
> > --- a/arch/x86/mm/numa.c
> > +++ b/arch/x86/mm/numa.c
> > @@ -737,12 +737,9 @@ void __init x86_numa_init(void)
> >  
> >  static void __init init_memory_less_node(int nid)
> >  {
> > -	unsigned long zones_size[MAX_NR_ZONES] = {0};
> > -	unsigned long zholes_size[MAX_NR_ZONES] = {0};
> > -
> >  	/* Allocate and initialize node data. Memory-less node is now online.*/
> >  	alloc_node_data(nid);
> > -	free_area_init_node(nid, zones_size, 0, zholes_size);
> > +	free_area_init_memoryless_node(nid);
> >  
> >  	/*
> >  	 * All zonelists will be built later in start_kernel() after per cpu
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 1c2ecb42e043..27660f6cf26e 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2272,8 +2272,7 @@ static inline spinlock_t *pud_lock(struct mm_struct *mm, pud_t *pud)
> >  }
> >  
> >  extern void __init pagecache_init(void);
> > -extern void __init free_area_init_node(int nid, unsigned long * zones_size,
> > -		unsigned long zone_start_pfn, unsigned long *zholes_size);
> > +extern void __init free_area_init_memoryless_node(int nid);
> >  extern void free_initmem(void);
> >  
> >  /*
> > @@ -2345,10 +2344,8 @@ static inline unsigned long get_num_physpages(void)
> >  
> >  /*
> >   * Using memblock node mappings, an architecture may initialise its
> > - * zones, allocate the backing mem_map and account for memory holes in a more
> > - * architecture independent manner. This is a substitute for creating the
> > - * zone_sizes[] and zholes_size[] arrays and passing them to
> > - * free_area_init_node()
> > + * zones, allocate the backing mem_map and account for memory holes in an
> > + * architecture independent manner.
> >   *
> >   * An architecture is expected to register range of page frames backed by
> >   * physical memory with memblock_add[_node]() before calling
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 376434c7a78b..e46232ec4849 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -6979,12 +6979,9 @@ static void __init __free_area_init_node(int nid, unsigned long *zones_size,
> >  	free_area_init_core(pgdat);
> >  }
> >  
> > -void __init free_area_init_node(int nid, unsigned long *zones_size,
> > -				unsigned long node_start_pfn,
> > -				unsigned long *zholes_size)
> > +void __init free_area_init_memoryless_node(int nid)
> >  {
> > -	__free_area_init_node(nid, zones_size, node_start_pfn, zholes_size,
> > -			      true);
> > +	__free_area_init_node(nid, NULL, 0, NULL, false);
> 
> Can we move free_area_init_memoryless_node() definition into 
> arch/x86/mm/numa.c since there's only one caller there?
> 
> And I am also wondering if adding a wrapper
> free_area_init_memoryless_node() is necessary if it's only called the
> function free_area_init_node().

Yeah, I think this patch can be entirely dropped and the next one could
be slightly updated :)
Thanks!

> >  }
> >  
> >  #if !defined(CONFIG_FLAT_NODE_MEM_MAP) -- 
> > 2.25.1
> > 
> 

-- 
Sincerely yours,
Mike.
