From: Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH 3/4] csky/dma: Fixup cache_op failed when cross memory ZONEs
Date: Tue, 6 Aug 2019 15:11:13 +0800
Message-ID: <CAJF2gTR1vCz504X20rBnQkAXGhJ-QbL4pORxnJTRVJqXx2t4uQ@mail.gmail.com>
References: <1564488945-20149-1-git-send-email-guoren@kernel.org>
 <1564488945-20149-3-git-send-email-guoren@kernel.org> <20190806064933.GA2508@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190806064933.GA2508@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-csky@vger.kernel.org, feng_shizhu@dahuatech.com, zhang_jian5@dahuatech.com, zheng_xingjian@dahuatech.com, zhu_peng@dahuatech.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Aug 6, 2019 at 2:49 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Jul 30, 2019 at 08:15:44PM +0800, guoren@kernel.org wrote:
> > diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
> > index 80783bb..3f1ff9d 100644
> > --- a/arch/csky/mm/dma-mapping.c
> > +++ b/arch/csky/mm/dma-mapping.c
> > @@ -18,71 +18,52 @@ static int __init atomic_pool_init(void)
> >  {
> >       return dma_atomic_pool_init(GFP_KERNEL, pgprot_noncached(PAGE_KERNEL));
> >  }
> > -postcore_initcall(atomic_pool_init);
>
> Please keep the postcore_initcall next to the function it calls.
Ok. Change arch_initcall back to postcore_initcall. :)

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
