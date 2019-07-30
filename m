Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41004 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfG3N3z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Jul 2019 09:29:55 -0400
MIME-Version: 1.0
References: <1564488945-20149-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1564488945-20149-1-git-send-email-guoren@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 30 Jul 2019 15:29:38 +0200
Message-ID: <CAK8P3a03tXXHQ00QEGg=7p17mmseuJqRhuumWKzS8dCYvXHkBg@mail.gmail.com>
Subject: Re: [PATCH 1/4] csky: Fixup dma_rmb/wmb synchronization problem
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-csky@vger.kernel.org, feng_shizhu@dahuatech.com, zhang_jian5@dahuatech.com, zheng_xingjian@dahuatech.com, zhu_peng@dahuatech.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190730132938.Pn0UZd0xL5ZkJHucs--R_xAAMAo8-XEj6bitWOUVpx4@z>

On Tue, Jul 30, 2019 at 2:15 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <ren_guo@c-sky.com>
>
> If arch didn't define dma_r/wmb(), linux will use w/rmb instead. Csky
> use bar.xxx to implement mb() and that will cause problem when sync data
> with dma device, becasue bar.xxx couldn't guarantee bus transactions
> finished at outside bus level. We must use sync.s instead of bar.xxx for
> dma data synchronization and it will guarantee retirement after getting
> the bus bresponse.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>

This change looks good to me, but I think your regular barriers
(mb, rmb, wmb) are still wrong: These are meant to be the superset
of dma_{r,w}mb and smp_{,r,w}mb, and synchronize
against both SMP and DMA interactions.

I suspect you can drop the '.s' for non-SMP builds. What I don't
see is whether you might need to add '.i' for dma_wmb() or
dma_rmb().

       Arnd
