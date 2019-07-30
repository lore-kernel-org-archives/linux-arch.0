From: Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH 1/4] csky: Fixup dma_rmb/wmb synchronization problem
Date: Tue, 30 Jul 2019 23:15:36 +0800
Message-ID: <CAJF2gTR2nY4dour1mMtGTm08KCyGuW4-sMP4L=cGSBP484Z5tw@mail.gmail.com>
References: <1564488945-20149-1-git-send-email-guoren@kernel.org> <CAK8P3a03tXXHQ00QEGg=7p17mmseuJqRhuumWKzS8dCYvXHkBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a03tXXHQ00QEGg=7p17mmseuJqRhuumWKzS8dCYvXHkBg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-csky@vger.kernel.org, feng_shizhu@dahuatech.com, zhang_jian5@dahuatech.com, zheng_xingjian@dahuatech.com, zhu_peng@dahuatech.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

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
>
> I suspect you can drop the '.s' for non-SMP builds. What I don't
> see is whether you might need to add '.i' for dma_wmb() or
> dma_rmb().
>
>        Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
