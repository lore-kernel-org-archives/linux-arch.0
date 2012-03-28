From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCHv2 01/14] common: dma-mapping: introduce alloc_attrs and
 free_attrs methods
Date: Wed, 28 Mar 2012 16:38:40 +0200
Message-ID: <016001cd0cf0$7807bdb0$68173910$%szyprowski@samsung.com>
References: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
 <1332855768-32583-2-git-send-email-m.szyprowski@samsung.com>
 <4F72F603.2000803@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <owner-linux-mm@kvack.org>
In-reply-to: <4F72F603.2000803@mvista.com>
Content-language: pl
Sender: owner-linux-mm@kvack.org
To: 'Sergei Shtylyov' <sshtylyov@mvista.com>
Cc: linux-kernel@vger.kernel.org, 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Andrew Morton' <akpm@linux-foundation.org>, 'Arnd Bergmann' <arnd@arndb.de>, 'Stephen Rothwell' <sfr@canb.auug.org.au>, 'FUJITA Tomonori' <fujita.tomonori@lab.ntt.co.jp>, microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org, x86@kernel.org, linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org, discuss@x86-64.org, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linaro-mm-sig@lists.linaro.org, 'Jonathan Corbet' <corbet@lwn.net>, 'Kyungmin Park' <kyungmin.park@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, 'Kevin Cernekee' <cernekee@gmail.com>, 'Dezhong Diao' <dediao@cisco.com>, 'Richard Kuo' <rkuo@codeau>
List-Id: linux-arch.vger.kernel.org

Hi Sergei,

On Wednesday, March 28, 2012 1:29 PM Sergei Shtylyov wrote:

> On 27-03-2012 17:42, Marek Szyprowski wrote:
> 
> > Introduce new generic alloc and free methods with attributes argument.
> 
>     The method names don't match the ones in the subject.

Right, I will reword the subject to "common: dma-mapping: introduce generic alloc()
and free() methods".

> > Existing alloc_coherent and free_coherent can be implemented on top of the
> > new calls with NULL attributes argument. Later also dma_alloc_non_coherent
> > can be implemented using DMA_ATTR_NONCOHERENT attribute as well as
> > dma_alloc_writecombine with separate DMA_ATTR_WRITECOMBINE attribute.
> 
> > This way the drivers will get more generic, platform independent way of
> > allocating dma buffers with specific parameters.
> 
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> > Reviewed-by: David Gibson <david@gibson.dropbear.ud.au>
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 

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
