From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCHv2 09/14] Unicore32: adapt for dma_map_ops changes
Date: Wed, 28 Mar 2012 08:10:20 +0200
Message-ID: <00ac01cd0ca9$7508f4e0$5f1adea0$%szyprowski@samsung.com>
References: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
 <1332855768-32583-10-git-send-email-m.szyprowski@samsung.com>
 <4F7275FE.8000100@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <owner-linux-mm@kvack.org>
In-reply-to: <4F7275FE.8000100@mprc.pku.edu.cn>
Content-language: pl
Sender: owner-linux-mm@kvack.org
To: 'Guan Xuetao' <gxt@mprc.pku.edu.cn>
Cc: linux-kernel@vger.kernel.org, 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Andrew Morton' <akpm@linux-foundation.org>, 'Arnd Bergmann' <arnd@arndb.de>, 'Stephen Rothwell' <sfr@canb.auug.org.au>, 'FUJITA Tomonori' <fujita.tomonori@lab.ntt.co.jp>, microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org, x86@kernel.org, linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org, discuss@x86-64.org, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linaro-mm-sig@lists.linaro.org, 'Jonathan Corbet' <corbet@lwn.net>, 'Kyungmin Park' <kyungmin.park@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, 'Kevin Cernekee' <cernekee@gmail.com>, 'Dezhong Diao' <dediao@cisco.com>, 'Richard Kuo' <rkuo@codeau>
List-Id: linux-arch.vger.kernel.org

Hello,

On Wednesday, March 28, 2012 4:23 AM Guan Xuetao wrote:

> On 03/27/2012 09:42 PM, Marek Szyprowski wrote:
> > diff --git a/arch/unicore32/mm/dma-swiotlb.c b/arch/unicore32/mm/dma-swiotlb.c
> > index bfa9fbb..4cf5f0c 100644
> > --- a/arch/unicore32/mm/dma-swiotlb.c
> > +++ b/arch/unicore32/mm/dma-swiotlb.c
> > @@ -17,9 +17,23 @@
> >
> >   #include<asm/dma.h>
> >
> > +static void *unicore_swiotlb_alloc_coherent(struct device *dev, size_t size,
> > +					    dma_addr_t *dma_handle, gfp_t flags,
> > +					    struct dma_attrs *attrs)
> > +{
> > +	return swiotlb_alloc_coherent(dev, size, dma_handle, flags);
> > +}
> > +
> > +static void unicode_swiotlb_free_coherent(struct device *dev, size_t size,
> The bit is ok for me. Only a typo here, please change unicode to unicore.

Ups, I'm sorry for that typo. I've fixed it on my git tree:

http://git.linaro.org/gitweb?p=people/mszyprowski/linux-dma-mapping.git;a=commitdiff;h=bbe43c05b0653
9c09f89e07bcaf61ea0fca8d67f

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
