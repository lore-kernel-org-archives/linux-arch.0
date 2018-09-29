Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:34030 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728501AbeI2XaO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sat, 29 Sep 2018 19:30:14 -0400
Date: Sun, 30 Sep 2018 01:00:31 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V6 10/33] csky: IRQ handling
Message-ID: <20180929170031.GB27796@guoren-Inspiron-7460>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <fbb4e798d1588e9df2da16818932747430068baf.1538058840.git.ren_guo@c-sky.com>
 <20180927154918.GB15985@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927154918.GB15985@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com
Message-ID: <20180929170031.0WZ1NAigkMVUaXSvrMtWlKC8-WmmCAGzgbU2IsUGW9o@z>

On Thu, Sep 27, 2018 at 08:49:18AM -0700, Christoph Hellwig wrote:
> > --- /dev/null
> > +++ b/arch/csky/include/asm/irq.h
> > @@ -0,0 +1,9 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> > +
> > +#ifndef __ASM_CSKY_IRQ_H
> > +#define __ASM_CSKY_IRQ_H
> > +
> > +#include <asm-generic/irq.h>
> > +
> > +#endif /* __ASM_CSKY_IRQ_H */
> 
> Just wire this up using generic-y in the Kbuild file instead of
> creating a wrapper.  (Same for any other header which is a trivial
> asm-generic wrapper).
Ok.
