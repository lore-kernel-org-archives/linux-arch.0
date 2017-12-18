From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH v3 07/33] nds32: MMU initialization
Date: Mon, 18 Dec 2017 17:08:48 +0800
Message-ID: <20171218090848.GA5823@gary-OptiPlex-3050>
References: <cover.1512723245.git.green.hu@gmail.com>
 <0964714c3dcac46ac700085717b0f414b7978112.1512723245.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0964714c3dcac46ac700085717b0f414b7978112.1512723245.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

Hi Greentime,

On Fri, Dec 08, 2017 at 05:11:50PM +0800, Greentime Hu wrote:
[...]
> 
> diff --git a/arch/nds32/mm/highmem.c b/arch/nds32/mm/highmem.c
[...]
> +void *kmap(struct page *page)
> +{
> +	unsigned long vaddr;
> +	might_sleep();
> +	if (!PageHighMem(page))
> +		return page_address(page);
> +	vaddr = (unsigned long)kmap_high(page);
Here should invalid the cpu_mmu_tlb's entry, Or invalid it in the
set_pte().

eg:
vaddr0 = kmap(page0)
*vaddr0 = val0 //It will cause tlb-miss, and hard-refill to MMU-tlb
kunmap(page0)
vaddr1 = kmap(page1) // Mostly vaddr1 = vaddr0
val = vaddr1; //No tlb-miss and it will get page0's val not page1, because
		last expired vaddr0's entry is left in CPU-MMU-tlb.

Best Regards
 Guo Ren
