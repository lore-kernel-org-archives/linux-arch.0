From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 3/8] parisc: implement dma_mmap_coherent()
Date: Fri, 10 Jul 2009 15:11:29 +0000
Message-ID: <1247238689.3936.16.camel@mulgrave.site>
References: <s5hprc8n0od.wl%tiwai@suse.de>  <s5hljmwn0iw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <s5hljmwn0iw.wl%tiwai@suse.de>
Sender: linux-parisc-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-arch@vger.kernel.org, Gerhard Pircher <gerhard_pircher@gmx.net>, Parisc List <linux-parisc@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, 2009-07-10 at 15:13 +0200, Takashi Iwai wrote:
> A lazy version of dma_mmap_coherent() implementation for PA-RISC.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  arch/parisc/include/asm/dma-mapping.h |   13 +++++++++++++
>  arch/parisc/kernel/pci-dma.c          |   16 ++++++++++++++++
>  drivers/parisc/ccio-dma.c             |    1 +
>  drivers/parisc/iommu-helpers.h        |   16 ++++++++++++++++
>  drivers/parisc/sba_iommu.c            |    1 +
>  5 files changed, 47 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/parisc/include/asm/dma-mapping.h b/arch/parisc/include/asm/dma-mapping.h
> index da69433..b5f810e 100644
> --- a/arch/parisc/include/asm/dma-mapping.h
> +++ b/arch/parisc/include/asm/dma-mapping.h
> @@ -19,6 +19,9 @@ struct hppa_dma_ops {
>  	void (*dma_sync_single_for_device)(struct device *dev, dma_addr_t iova, unsigned long offset, size_t size, enum dma_data_direction direction);
>  	void (*dma_sync_sg_for_cpu)(struct device *dev, struct scatterlist *sg, int nelems, enum dma_data_direction direction);
>  	void (*dma_sync_sg_for_device)(struct device *dev, struct scatterlist *sg, int nelems, enum dma_data_direction direction);
> +	int (*mmap_coherent)(struct device *dev, struct vm_area_struct *vma,
> +			     void *cpu_addr, dma_addr_t handle, size_t size);
> +
>  };
>  
>  /*
> @@ -204,6 +207,16 @@ dma_cache_sync(struct device *dev, void *vaddr, size_t size,
>  		flush_kernel_dcache_range((unsigned long)vaddr, size);
>  }
>  
> +#define ARCH_HAS_DMA_MMAP_COHERENT
> +static inline int
> +dma_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
> +		  void *cpu_addr, dma_addr_t handle, size_t size)
> +{
> +	if (!hppa_dma_ops->mmap_coherent)
> +		return -ENXIO;
> +	return hppa_dma_ops->mmap_coherent(dev, vma, cpu_addr, handle, size);
> +}
> +
>  static inline void *
>  parisc_walk_tree(struct device *dev)
>  {
> diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
> index c07f618..e8c68e3 100644
> --- a/arch/parisc/kernel/pci-dma.c
> +++ b/arch/parisc/kernel/pci-dma.c
> @@ -539,6 +539,20 @@ static void pa11_dma_sync_sg_for_device(struct device *dev, struct scatterlist *
>  		flush_kernel_dcache_range(sg_virt_addr(sglist), sglist->length);
>  }
>  
> +static int pa11_dma_mmap_coherent(struct device *dev,
> +				  struct vm_area_struct *vma,
> +				  void *cpu_addr, dma_addr_t handle,
> +				  size_t size)
> +{
> +	struct page *pg;
> +	pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE;
> +	cpu_addr = __va(handle);
> +	pg = virt_to_page(cpu_addr);
> +	return remap_pfn_range(vma, vma->vm_start,
> +			       page_to_pfn(pg) + vma->vm_pgoff,
> +			       size, vma->vm_page_prot);
> +}
> +
>  struct hppa_dma_ops pcxl_dma_ops = {
>  	.dma_supported =	pa11_dma_supported,
>  	.alloc_consistent =	pa11_dma_alloc_consistent,
> @@ -552,6 +566,7 @@ struct hppa_dma_ops pcxl_dma_ops = {
>  	.dma_sync_single_for_device = pa11_dma_sync_single_for_device,
>  	.dma_sync_sg_for_cpu = pa11_dma_sync_sg_for_cpu,
>  	.dma_sync_sg_for_device = pa11_dma_sync_sg_for_device,
> +	.mmap_coherent =	pa11_dma_mmap_coherent,
>  };
>  
>  static void *fail_alloc_consistent(struct device *dev, size_t size,
> @@ -592,4 +607,5 @@ struct hppa_dma_ops pcx_dma_ops = {
>  	.dma_sync_single_for_device =	pa11_dma_sync_single_for_device,
>  	.dma_sync_sg_for_cpu =		pa11_dma_sync_sg_for_cpu,
>  	.dma_sync_sg_for_device =	pa11_dma_sync_sg_for_device,
> +	.mmap_coherent =	pa11_dma_mmap_coherent,
>  };
> diff --git a/drivers/parisc/ccio-dma.c b/drivers/parisc/ccio-dma.c
> index 0f0e0b9..0dd67ae 100644
> --- a/drivers/parisc/ccio-dma.c
> +++ b/drivers/parisc/ccio-dma.c
> @@ -1016,6 +1016,7 @@ static struct hppa_dma_ops ccio_ops = {
>  	.dma_sync_single_for_device =	NULL,	/* NOP for U2/Uturn */
>  	.dma_sync_sg_for_cpu =		NULL,	/* ditto */
>  	.dma_sync_sg_for_device =		NULL,	/* ditto */
> +	.mmap_coherent =	iommu_dma_mmap_coherent,
>  };
>  
>  #ifdef CONFIG_PROC_FS
> diff --git a/drivers/parisc/iommu-helpers.h b/drivers/parisc/iommu-helpers.h
> index a9c46cc..9f86f3f 100644
> --- a/drivers/parisc/iommu-helpers.h
> +++ b/drivers/parisc/iommu-helpers.h
> @@ -174,3 +174,19 @@ iommu_coalesce_chunks(struct ioc *ioc, struct device *dev,
>  	return n_mappings;
>  }
>  
> +/* dma_mmap_coherent callback function */
> +/* Note that this is no inline function -- this function is eventually
> + * included in ccio_ops in both ccio-dma.c and sba_iommu.c
> + */
> +static int iommu_dma_mmap_coherent(struct device *dev,
> +				   struct vm_area_struct *vma,
> +				   void *cpu_addr, dma_addr_t handle,
> +				   size_t size)
> +{
> +	struct page *pg;
> +	pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE;
> +	pg = virt_to_page(cpu_addr);
> +	return remap_pfn_range(vma, vma->vm_start,
> +			       page_to_pfn(pg) + vma->vm_pgoff,
> +			       size, vma->vm_page_prot);
> +}
> diff --git a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
> index 123d8fe..8ccb3e4 100644
> --- a/drivers/parisc/sba_iommu.c
> +++ b/drivers/parisc/sba_iommu.c
> @@ -1070,6 +1070,7 @@ static struct hppa_dma_ops sba_ops = {
>  	.dma_sync_single_for_device =	NULL,
>  	.dma_sync_sg_for_cpu =		NULL,
>  	.dma_sync_sg_for_device =	NULL,
> +	.mmap_coherent =	iommu_dma_mmap_coherent,
>  };

This isn't the right thing to do on parisc.  The only case that will
actually work is the small subset of pa11 systems where the only way we
can manufacture coherent memory is to turn the cache off.  One more
thing: even on pa11 you have to flush the cache lines before you make a
page uncached otherwise you can get coherency problems.

For pa20 systems, we have a cache flushing system on bus writes.  What
your patch does is turn off caching over the user page only.  This would
leave us with a cache over the kernel page, so any write the kernel
makes would need flushing before it's visible to the user, which isn't
how the kernel operates with coherent memory.

The only way to fix the above is either to make the user virtual address
congruent with the kernel one (VI congruence in parisc is steps of 4MB)
so they share the same cache (in which case they don't need the uncached
bit).  Or to make the coherent memory uncached when it's first
allocated ... this is a performance hit.

The design of coherent memory was for memory based device mailboxes
managed by the kernel ... trying to give userspace coherent access to
the same mailbox is problematic because it gives a direct way for the
process to interfere with a device function ... shouldn't whatever
you're trying to do be better accomplished by using an API to control
the device and keeping the coherent mailbox fully in the kernel address
space?

James


