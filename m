From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V6 03/33] csky: Kernel booting
Date: Sun, 30 Sep 2018 01:09:10 +0800
Message-ID: <20180929170909.GG27796@guoren-Inspiron-7460>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <d46b38db96f8b39c38d40170e1842a0dc5ba0671.1538058840.git.ren_guo@c-sky.com>
 <20180928161305.GB19827@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180928161305.GB19827@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

On Fri, Sep 28, 2018 at 09:13:05AM -0700, Christoph Hellwig wrote:
> > +phys_addr_t __init_memblock memblock_end_of_REG0(void)
> > +{
> > +	return (memblock.memory.regions[0].base + memblock.memory.regions[0].size);
> > +}
> 
> No need for the braces.
Ok.

> > +	if (memblock.memory.cnt > 1) {
> > +		zone_size[ZONE_NORMAL]  = PFN_DOWN(memblock_start_of_REG1())
								- min_low_pfn;
> > +		zhole_size[ZONE_NORMAL] = PFN_DOWN(memblock_start_of_REG1())
								- max_low_pfn;
> 
> Please brake lines after 80 characters.
Ok.
> 
> > +	pr_info("C-SKY: https://github.com/c-sky/csky-linux\n");
> 
> I don't think this belongs into the kernel log.
Ok, remove it.

Best Regards
 Guo Ren
