From: Konrad Rzeszutek Wilk <konrad-Gq0aWv8utHQdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 05/22] x86: rename swiotlb_dma_ops
Date: Fri, 12 Jan 2018 08:25:34 -0500
Message-ID: <20180112132534.GE26900@localhost.localdomain>
References: <20180110080932.14157-1-hch@lst.de>
	<20180110080932.14157-6-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180110080932.14157-6-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 10, 2018 at 09:09:15AM +0100, Christoph Hellwig wrote:
> We'll need that name for a generic implementation soon.
> 
> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/x86/kernel/pci-swiotlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
> index 9d3e35c33d94..0d77603c2f50 100644
> --- a/arch/x86/kernel/pci-swiotlb.c
> +++ b/arch/x86/kernel/pci-swiotlb.c
> @@ -48,7 +48,7 @@ void x86_swiotlb_free_coherent(struct device *dev, size_t size,
>  		dma_generic_free_coherent(dev, size, vaddr, dma_addr, attrs);
>  }
>  
> -static const struct dma_map_ops swiotlb_dma_ops = {
> +static const struct dma_map_ops x86_swiotlb_dma_ops = {
>  	.mapping_error = swiotlb_dma_mapping_error,
>  	.alloc = x86_swiotlb_alloc_coherent,
>  	.free = x86_swiotlb_free_coherent,
> @@ -112,7 +112,7 @@ void __init pci_swiotlb_init(void)
>  {
>  	if (swiotlb) {
>  		swiotlb_init(0);
> -		dma_ops = &swiotlb_dma_ops;
> +		dma_ops = &x86_swiotlb_dma_ops;
>  	}
>  }
>  
> -- 
> 2.14.2
> 
