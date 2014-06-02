From: "Chanho Min" <chanho.min@lge.com>
Subject: RE: [PATCH] arm: dma-mapping: fix potential build error under !CMA
Date: Mon, 2 Jun 2014 11:45:25 +0900
Message-ID: <33752.1200337962$1401677191@news.gmane.org>
References: <1401673528-19077-1-git-send-email-chanho.min@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1401673528-19077-1-git-send-email-chanho.min@lge.com>
Content-Language: ko
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: 'Russell King' <linux@arm.linux.org.uk>, 'Michal Nazarewicz' <mina86@mina86.com>, 'Marek Szyprowski' <m.szyprowski@samsung.com>
Cc: linux-arch@vger.kernel.org, 'HyoJun Im' <hyojun.im@lge.com>, linux-kernel@vger.kernel.org, 'Gioh Kim' <gioh.kim@lge.com>, 'Joonsoo Kim' <iamjoonsoo.kim@lge.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Please ignore this patch. It was fixed on v3.15.
Sorry for the noise.

Chanho
> From: Chanho Min [mailto:chanho.min@lge.com]
> Sent: Monday, June 02, 2014 10:45 AM
> To: Russell King; Michal Nazarewicz; Marek Szyprowski
> Cc: Gioh Kim; Joonsoo Kim; HyoJun Im; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; linux-arch@vger.kernel.org; Chanho Min
> Subject: [PATCH] arm: dma-mapping: fix potential build error under !CMA
> 
> This patch fixes build error under !CONFIG_CMA. dev_get_cma_area can be used
> when CMA is disabled when the bellow patch is appied.
> 
> "arm: dma-mapping: add checking cma area initialized"
> https://lkml.org/lkml/2014/5/22/35
> 
> arch/arm/mm/dma-mapping.c: In function 'atomic_pool_init':
> arch/arm/mm/dma-mapping.c:361:2: error: implicit declaration of function
>  'dev_get_cma_area' [-Werror=implicit-function-declaration]
> 
> Signed-off-by: Chanho Min <chanho.min@lge.com>
> ---
>  arch/arm/include/asm/dma-contiguous.h |    2 +-
>  include/asm-generic/dma-contiguous.h  |   13 +++++++++++--
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/include/asm/dma-contiguous.h b/arch/arm/include/asm/dma-contiguous.h
> index 3ed37b4..56c17bc 100644
> --- a/arch/arm/include/asm/dma-contiguous.h
> +++ b/arch/arm/include/asm/dma-contiguous.h
> @@ -2,11 +2,11 @@
>  #define ASMARM_DMA_CONTIGUOUS_H
> 
>  #ifdef __KERNEL__
> -#ifdef CONFIG_CMA
> 
>  #include <linux/types.h>
>  #include <asm-generic/dma-contiguous.h>
> 
> +#ifdef CONFIG_CMA
>  void dma_contiguous_early_fixup(phys_addr_t base, unsigned long size);
> 
>  #endif
> diff --git a/include/asm-generic/dma-contiguous.h b/include/asm-generic/dma-contiguous.h
> index 294b1e7..3d48460 100644
> --- a/include/asm-generic/dma-contiguous.h
> +++ b/include/asm-generic/dma-contiguous.h
> @@ -2,11 +2,11 @@
>  #define ASM_DMA_CONTIGUOUS_H
> 
>  #ifdef __KERNEL__
> -#ifdef CONFIG_CMA
> 
>  #include <linux/device.h>
>  #include <linux/dma-contiguous.h>
> 
> +#ifdef CONFIG_CMA
>  static inline struct cma *dev_get_cma_area(struct device *dev)
>  {
>  	if (dev && dev->cma_area)
> @@ -22,7 +22,16 @@ static inline void dev_set_cma_area(struct device *dev, struct cma *cma)
>  		dma_contiguous_default_area = cma;
>  }
> 
> -#endif
> +#else
> +static inline struct cma *dev_get_cma_area(struct device *dev)
> +{
> +	return NULL;
> +}
> +
> +static inline void dev_set_cma_area(struct device *dev, struct cma *cma)
> +{
> +}
>  #endif
> 
>  #endif
> +#endif
> --
> 1.7.9.5
