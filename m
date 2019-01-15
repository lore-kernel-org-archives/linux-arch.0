From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] riscv: fixup max_low_pfn with PFN_DOWN.
Date: Tue, 15 Jan 2019 07:36:13 -0800
Message-ID: <20190115153613.GC26443@infradead.org>
References: <1547280987-7630-1-git-send-email-guoren@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1547280987-7630-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: guoren@kernel.org
Cc: palmer@sifive.com, aou@eecs.berkeley.edu, linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>, Mao Han <mao_han@c-sky.com>
List-Id: linux-arch.vger.kernel.org

On Sat, Jan 12, 2019 at 04:16:27PM +0800, guoren@kernel.org wrote:
> From: Guo Ren <ren_guo@c-sky.com>
> 
> max_low_pfn should be pfn_size not byte_size.
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Signed-off-by: Mao Han <mao_han@c-sky.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> ---
>  arch/riscv/kernel/setup.c | 2 +-
>  arch/riscv/mm/init.c      | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index fc8006a..5463e67 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -174,7 +174,7 @@ static void __init setup_bootmem(void)
>  	BUG_ON(mem_size == 0);
>  
>  	set_max_mapnr(PFN_DOWN(mem_size));
> -	max_low_pfn = memblock_end_of_DRAM();
> +	max_low_pfn = PFN_DOWN(memblock_end_of_DRAM());

I know it is used just above, but can we please just switch this
code to use >> PAGE_SHIFT instead of PFN_DOWN, which just horribly
obsfucates what is going on?

>  
>  #ifdef CONFIG_BLK_DEV_INITRD
>  	setup_initrd();
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 1d9bfaf..658ebf6 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -28,7 +28,8 @@ static void __init zone_sizes_init(void)
>  	unsigned long max_zone_pfns[MAX_NR_ZONES] = { 0, };
>  
>  #ifdef CONFIG_ZONE_DMA32
> -	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(min(4UL * SZ_1G, max_low_pfn));
> +	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(min(4UL * SZ_1G,
> +			(unsigned long) PFN_PHYS(max_low_pfn)));
>  #endif

Same comment as above here, plus I think we should just use
memblock_end_of_DRAM directly, e.g. something like:

static const phys_addr_t max_dma32_addr = 4UL * SZ_1G;

	max_zone_pfns[ZONE_DMA32] =
		min(memblock_end_of_DRAM(), max_dma32_addr) >> PAGE_SHIFT;
