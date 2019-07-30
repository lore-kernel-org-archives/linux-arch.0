Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731021AbfG3P2n (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 30 Jul 2019 11:28:43 -0400
MIME-Version: 1.0
References: <1564488945-20149-1-git-send-email-guoren@kernel.org> <CAK8P3a03tXXHQ00QEGg=7p17mmseuJqRhuumWKzS8dCYvXHkBg@mail.gmail.com>
In-Reply-To: <CAK8P3a03tXXHQ00QEGg=7p17mmseuJqRhuumWKzS8dCYvXHkBg@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 30 Jul 2019 23:28:28 +0800
Message-ID: <CAJF2gTStGrrELOr-Dga98ueNQuSG5WBcYgzAPp_W_RjWnsGXgg@mail.gmail.com>
Subject: Re: [PATCH 1/4] csky: Fixup dma_rmb/wmb synchronization problem
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-csky@vger.kernel.org, feng_shizhu@dahuatech.com, zhang_jian5@dahuatech.com, zheng_xingjian@dahuatech.com, zhu_peng@dahuatech.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190730152828.VTMF8QZEHfLtq2SyTkumc0D7EDZhtrCgykbpK8M7Ioo@z>

Thx Arnd,

On Tue, Jul 30, 2019 at 9:29 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jul 30, 2019 at 2:15 PM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <ren_guo@c-sky.com>
> >
> > If arch didn't define dma_r/wmb(), linux will use w/rmb instead. Csky
> > use bar.xxx to implement mb() and that will cause problem when sync data
> > with dma device, becasue bar.xxx couldn't guarantee bus transactions
> > finished at outside bus level. We must use sync.s instead of bar.xxx for
> > dma data synchronization and it will guarantee retirement after getting
> > the bus bresponse.
> >
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
>
> This change looks good to me, but I think your regular barriers
> (mb, rmb, wmb) are still wrong: These are meant to be the superset
> of dma_{r,w}mb and smp_{,r,w}mb, and synchronize
> against both SMP and DMA interactions.
Wow, thanks for correction, yes! mb, rmb, wmb is the superset of dma
and smp, and I should use sync.s for mb.

I check the arm64, it use dsb for mb and dmb for smp_mb and dma_mb.

I also check the drivers, you are right , a lot of them use mb() to
sync mem data with device.

>
> I suspect you can drop the '.s' for non-SMP builds. What I don't
> see is whether you might need to add '.i' for dma_wmb() or
> dma_rmb().
It's no need for sky, when there is non-SMP, the cpu is in reset mode,
and sync.s is equal to sync in efficient.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
