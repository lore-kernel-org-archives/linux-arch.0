From: Guan Xuetao <gxt@mprc.pku.edu.cn>
Subject: Re: [PATCHv2 09/14] Unicore32: adapt for dma_map_ops changes
Date: Wed, 28 Mar 2012 10:22:54 +0800
Message-ID: <4F7275FE.8000100@mprc.pku.edu.cn>
References: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com> <1332855768-32583-10-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1332855768-32583-10-git-send-email-m.szyprowski@samsung.com>
Sender: owner-linux-mm@kvack.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell <sfr@canb.auug.org.au>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org, x86@kernel.org, linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org, discuss@x86-64.org, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linaro-mm-sig@lists.linaro.org, Jonathan Corbet <corbet@lwn.net>, Kyungmin Park <kyungmin.park@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Kevin
List-Id: linux-arch.vger.kernel.org

On 03/27/2012 09:42 PM, Marek Szyprowski wrote:
> diff --git a/arch/unicore32/mm/dma-swiotlb.c b/arch/unicore32/mm/dma-swiotlb.c
> index bfa9fbb..4cf5f0c 100644
> --- a/arch/unicore32/mm/dma-swiotlb.c
> +++ b/arch/unicore32/mm/dma-swiotlb.c
> @@ -17,9 +17,23 @@
>
>   #include<asm/dma.h>
>
> +static void *unicore_swiotlb_alloc_coherent(struct device *dev, size_t size,
> +					    dma_addr_t *dma_handle, gfp_t flags,
> +					    struct dma_attrs *attrs)
> +{
> +	return swiotlb_alloc_coherent(dev, size, dma_handle, flags);
> +}
> +
> +static void unicode_swiotlb_free_coherent(struct device *dev, size_t size,
The bit is ok for me. Only a typo here, please change unicode to unicore.

Thanks and Regards.

Guan Xuetao

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
