Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:48042 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731807AbfHFHSu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Aug 2019 03:18:50 -0400
Date: Tue, 6 Aug 2019 00:18:46 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 3/4] csky/dma: Fixup cache_op failed when cross memory
 ZONEs
Message-ID: <20190806071846.GA10032@infradead.org>
References: <1564488945-20149-1-git-send-email-guoren@kernel.org>
 <1564488945-20149-3-git-send-email-guoren@kernel.org>
 <20190806064933.GA2508@infradead.org>
 <CAJF2gTR1vCz504X20rBnQkAXGhJ-QbL4pORxnJTRVJqXx2t4uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTR1vCz504X20rBnQkAXGhJ-QbL4pORxnJTRVJqXx2t4uQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-csky@vger.kernel.org, feng_shizhu@dahuatech.com, zhang_jian5@dahuatech.com, zheng_xingjian@dahuatech.com, zhu_peng@dahuatech.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190806071846.w-VJ9wF42e-nFAYJy-wRJqcKH8H1lC1Khy2ZdWZkumk@z>

On Tue, Aug 06, 2019 at 03:11:13PM +0800, Guo Ren wrote:
> On Tue, Aug 6, 2019 at 2:49 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Tue, Jul 30, 2019 at 08:15:44PM +0800, guoren@kernel.org wrote:
> > > diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
> > > index 80783bb..3f1ff9d 100644
> > > --- a/arch/csky/mm/dma-mapping.c
> > > +++ b/arch/csky/mm/dma-mapping.c
> > > @@ -18,71 +18,52 @@ static int __init atomic_pool_init(void)
> > >  {
> > >       return dma_atomic_pool_init(GFP_KERNEL, pgprot_noncached(PAGE_KERNEL));
> > >  }
> > > -postcore_initcall(atomic_pool_init);
> >
> > Please keep the postcore_initcall next to the function it calls.
> Ok. Change arch_initcall back to postcore_initcall. :)

Well, if you have a good reason to change it please keep the type
init level change, but put it in a separate patch.  But most importantly
don't move the place where is called around.
