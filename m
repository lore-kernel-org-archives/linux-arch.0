Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731576AbfHFHL2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Aug 2019 03:11:28 -0400
MIME-Version: 1.0
References: <1564488945-20149-1-git-send-email-guoren@kernel.org>
 <1564488945-20149-3-git-send-email-guoren@kernel.org> <20190806064933.GA2508@infradead.org>
In-Reply-To: <20190806064933.GA2508@infradead.org>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 6 Aug 2019 15:11:13 +0800
Message-ID: <CAJF2gTR1vCz504X20rBnQkAXGhJ-QbL4pORxnJTRVJqXx2t4uQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] csky/dma: Fixup cache_op failed when cross memory ZONEs
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-csky@vger.kernel.org, feng_shizhu@dahuatech.com, zhang_jian5@dahuatech.com, zheng_xingjian@dahuatech.com, zhu_peng@dahuatech.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190806071113.5ZU4zN9WlCo3rYQJ7QfF1PR9yrrMqW0N7ZRz6QVWSb8@z>

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
