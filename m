From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC] dma-mapping: fix dma_common_mmap() for ARC
Date: Sun, 30 Oct 2016 12:14:47 +0000
Message-ID: <20161030121447.2lku7etlqqbsfr2i@localhost>
References: <1477509764-18370-1-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1477509764-18370-1-git-send-email-abrodkin@synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: linux-arch@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 26, 2016 at 10:22:44PM +0300, Alexey Brodkin wrote:
> ------------------------>8-----------------------
> arc_dma_alloc()
>   ioremap_nocache() AKA ioremap()
>     ioremap_prot()
>       get_vm_area() + ioremap_page_range() on obtained vaddr
> ------------------------>8-----------------------
> 
> As a result we get TLB entry of the following kind:
> ------------------------>8-----------------------
>     vaddr = 0x7200_0000
>     paddr = 0x8200_0000
>     flags = _uncached_
> ------------------------>8-----------------------
> 
> Kerenl thinks frame buffer is located @ 0x7200_0000 and uses it
> perfectly fine.
> 
> But here comes a time for user-space application to request frame buffer
> to be mapped for it. That happens easily with the following call path:
> ------------------------>8-----------------------
> fb_mmap()
>   drm_fb_cma_mmap()
>     dma_mmap_writecombine() AKA dma_mmap_wc()
>       dma_mmap_attrs()
>         dma_common_mmap() since we don't [yet] have dma_map_ops.mmap()
>                           for ARC
> ------------------------>8-----------------------
> 
> And in dma_common_mmap() we first calculate pfn of what we think is
> "physical page" and then do remap_pfn_range() to that "physical page".
> 
> Here we're getting to the interesting thing - how pfn is calculated.
> As of now this is done as simple as:
> ------------------------>8-----------------------
>     pfn = page_to_pfn(virt_to_page(cpu_addr));
> ------------------------>8-----------------------

The virt_to_page() function here only works for addresses in the kernel
linear map. In your case, the DMA buffer is mapped out of the ioremap
space, so the cpu_addr you pass in here would return the incorrect pfn
(as you've already noticed).

> Simplest fix for ARC is to use dma_addr instead because it matches
> real physical memory address and so mapping for user-space we're
> getting then is this:
> ------------------------>8-----------------------
>     vaddr = 0x0200_0000
>     paddr = 0x8200_0000
>     flags = _uncached_
> ------------------------>8-----------------------
> And it works perfectly fine.

But it breaks the other architectures where dma_addr is actually closer
to the phys_addr than the kernel linear map.

> diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
> index 8f8b68c80986..16307eed453f 100644
> --- a/drivers/base/dma-mapping.c
> +++ b/drivers/base/dma-mapping.c
> @@ -252,7 +252,7 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
>  #if defined(CONFIG_MMU) && !defined(CONFIG_ARCH_NO_COHERENT_DMA_MMAP)
>  	unsigned long user_count = vma_pages(vma);
>  	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -	unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
> +	unsigned long pfn = page_to_pfn(virt_to_page(dma_addr));

As I said above, this is incorrect. I would suggest that you implement
an arc specific mmap operation. We do this for arm64 using
remap_pfn_range; see __swiotlb_mmap under arch/arm64/mm/dma-mapping.c
where the pfn is calculated using an arm64-specific dma_to_phys()
function.

-- 
Catalin
