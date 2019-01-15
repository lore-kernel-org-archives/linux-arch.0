From: Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH] riscv: fixup max_low_pfn with PFN_DOWN.
Date: Wed, 16 Jan 2019 00:10:00 +0800
Message-ID: <20190115161000.GA22705@guoren-Inspiron-7460>
References: <1547280987-7630-1-git-send-email-guoren@kernel.org>
 <20190115153613.GC26443@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190115153613.GC26443@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: palmer@sifive.com, aou@eecs.berkeley.edu, linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>, Mao Han <mao_han@c-sky.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 15, 2019 at 07:36:13AM -0800, Christoph Hellwig wrote:
> On Sat, Jan 12, 2019 at 04:16:27PM +0800, guoren@kernel.org wrote:
> > From: Guo Ren <ren_guo@c-sky.com>
> > 
> > max_low_pfn should be pfn_size not byte_size.
> > 
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > Signed-off-by: Mao Han <mao_han@c-sky.com>
> > Cc: Palmer Dabbelt <palmer@sifive.com>
> > Cc: Albert Ou <aou@eecs.berkeley.edu>
> > ---
> >  arch/riscv/kernel/setup.c | 2 +-
> >  arch/riscv/mm/init.c      | 3 ++-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index fc8006a..5463e67 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -174,7 +174,7 @@ static void __init setup_bootmem(void)
> >  	BUG_ON(mem_size == 0);
> >  
> >  	set_max_mapnr(PFN_DOWN(mem_size));
> > -	max_low_pfn = memblock_end_of_DRAM();
> > +	max_low_pfn = PFN_DOWN(memblock_end_of_DRAM());
> 
> I know it is used just above, but can we please just switch this
> code to use >> PAGE_SHIFT instead of PFN_DOWN, which just horribly
> obsfucates what is going on?
???
#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)

phys_addr_t __init_memblock memblock_end_of_DRAM(void)
{
	int idx = memblock.memory.cnt - 1;

	return (memblock.memory.regions[idx].base + memblock.memory.regions[idx].size);
}

What's the problem? PFN_DOWN() couldn't be used with function call?

> 
> >  
> >  #ifdef CONFIG_BLK_DEV_INITRD
> >  	setup_initrd();
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 1d9bfaf..658ebf6 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -28,7 +28,8 @@ static void __init zone_sizes_init(void)
> >  	unsigned long max_zone_pfns[MAX_NR_ZONES] = { 0, };
> >  
> >  #ifdef CONFIG_ZONE_DMA32
> > -	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(min(4UL * SZ_1G, max_low_pfn));
> > +	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(min(4UL * SZ_1G,
> > +			(unsigned long) PFN_PHYS(max_low_pfn)));
> >  #endif
> 
> Same comment as above here, plus I think we should just use
> memblock_end_of_DRAM directly, e.g. something like:
> 
> static const phys_addr_t max_dma32_addr = 4UL * SZ_1G;
> 
> 	max_zone_pfns[ZONE_DMA32] =
> 		min(memblock_end_of_DRAM(), max_dma32_addr) >> PAGE_SHIFT;
Em... The meaning of PFN_PHYS(max_low_pfn) != memblock_end_of_DRAM() in
32-bit highmem system. Of cause, riscv doesn't support highmem, so I
think memblock_end_of_DRAM() is also OK.

But...

static void __init zone_sizes_init(void)
{
	unsigned long max_zone_pfns[MAX_NR_ZONES] = { 0, };

#ifdef CONFIG_ZONE_DMA32
	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(min(4UL * SZ_1G, max_low_pfn));
#endif
	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;

	free_area_init_nodes(max_zone_pfns);
}

The max_low_pfn also used by ZONE_NORMAL, So shall we need change that?
	max_zone_pfns[ZONE_NORMAL] = PFN_DOWN(memblock_end_of_DRAM());
                                     ^^^^^^^^ also must >> PAGE_SHIFT?

My patch just want to point out that max_low_pfn is PFN not size. In fact
there is no error for running without my patch :P

Best Regards
 Guo Ren
