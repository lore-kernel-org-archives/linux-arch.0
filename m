From: Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH] riscv: fixup max_low_pfn with PFN_DOWN.
Date: Wed, 16 Jan 2019 09:07:38 +0800
Message-ID: <20190116010738.GA4817@guoren-Inspiron-7460>
References: <1547280987-7630-1-git-send-email-guoren@kernel.org>
 <20190115153613.GC26443@infradead.org>
 <20190115161000.GA22705@guoren-Inspiron-7460>
 <20190115161254.GA19081@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190115161254.GA19081@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: palmer@sifive.com, aou@eecs.berkeley.edu, linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>, Mao Han <mao_han@c-sky.com>
List-Id: linux-arch.vger.kernel.org

Hi Christoph,

I use PFN_DOWN() every where as possible and seems it's a habit
problem. So let risc-v maintainer to choose "PFN_DOW()" or
">> PAGE_SHIFT".

Also the same with "end_of_DRAM & max_low_pfn".

Best Regards
 Guo Ren

On Tue, Jan 15, 2019 at 08:12:54AM -0800, Christoph Hellwig wrote:
> On Wed, Jan 16, 2019 at 12:10:00AM +0800, Guo Ren wrote:
> > > >  	set_max_mapnr(PFN_DOWN(mem_size));
> > > > -	max_low_pfn = memblock_end_of_DRAM();
> > > > +	max_low_pfn = PFN_DOWN(memblock_end_of_DRAM());
> > > 
> > > I know it is used just above, but can we please just switch this
> > > code to use >> PAGE_SHIFT instead of PFN_DOWN, which just horribly
> > > obsfucates what is going on?
> > ???
> > #define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
> > 
> > phys_addr_t __init_memblock memblock_end_of_DRAM(void)
> > {
> > 	int idx = memblock.memory.cnt - 1;
> > 
> > 	return (memblock.memory.regions[idx].base + memblock.memory.regions[idx].size);
> > }
> > 
> > What's the problem? PFN_DOWN() couldn't be used with function call?
> 
> PFN_DOWN gives you the correct result.  But I think it actually
> drastically reduces readability over just opencoding it.
> 
> > My patch just want to point out that max_low_pfn is PFN not size. In fact
> > there is no error for running without my patch :P
> 
> No, I think your patch is correct.  I just wonder if we could make
> the code easier to read.
