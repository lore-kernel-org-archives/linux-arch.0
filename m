From: Wei Liu <wei.liu-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 21/29] mm: remove the pgprot argument to __vmalloc
Date: Tue, 14 Apr 2020 16:13:44 +0100
Message-ID: <20200414151344.zgt2pnq7cjq2bgv6@debian>
References: <20200414131348.444715-1-hch@lst.de>
 <20200414131348.444715-22-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200414131348.444715-22-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Sender: "iommu" <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: linux-hyperv-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Michael Kelley <mikelley-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, "K. Y. Srinivasan" <kys-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Sumit Semwal <sumit.semwal-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Liu <wei.liu-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Hemminger <sthemmin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Gao Xiang <xiang-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Laura Abbott <labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Nitin Gupta <ngupta-KNmc09w0p+Ednm+yROfE0A@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Haiyang Zhang <haiyangz-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, bpf-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Minchan Kim <minchan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Andrew Morton <akpm>
List-Id: linux-arch.vger.kernel.org

On Tue, Apr 14, 2020 at 03:13:40PM +0200, Christoph Hellwig wrote:
> The pgprot argument to __vmalloc is always PROT_KERNEL now, so remove
> it.
> 
> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> Reviewed-by: Michael Kelley <mikelley-0li6OtcxBFHby3iVrkZq2A@public.gmane.org> [hyperv]
> Acked-by: Gao Xiang <xiang-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [erofs]
> Acked-by: Peter Zijlstra (Intel) <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> ---
>  arch/x86/hyperv/hv_init.c              |  3 +--
[...]
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 5a4b363ba67b..a3d689dfc745 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -95,8 +95,7 @@ static int hv_cpu_init(unsigned int cpu)
>  	 * not be stopped in the case of CPU offlining and the VM will hang.
>  	 */
>  	if (!*hvp) {
> -		*hvp = __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO,
> -				 PAGE_KERNEL);
> +		*hvp = __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
>  	}

Acked-by: Wei Liu <wei.liu-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
