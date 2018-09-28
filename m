From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V6 10/33] csky: IRQ handling
Date: Fri, 28 Sep 2018 21:09:17 +0800
Message-ID: <20180928130916.GB2082@guoren-Inspiron-7460>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <fbb4e798d1588e9df2da16818932747430068baf.1538058840.git.ren_guo@c-sky.com>
 <20180927154918.GB15985@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180927154918.GB15985@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

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
