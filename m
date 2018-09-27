Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:45342 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeI0WIT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Sep 2018 18:08:19 -0400
Date: Thu, 27 Sep 2018 08:49:18 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V6 10/33] csky: IRQ handling
Message-ID: <20180927154918.GB15985@infradead.org>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <fbb4e798d1588e9df2da16818932747430068baf.1538058840.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbb4e798d1588e9df2da16818932747430068baf.1538058840.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com
Message-ID: <20180927154918.kLLghEvdh0qXTpx2hKHbZqtJOO9t4hqw0jSotkdDuYc@z>

> --- /dev/null
> +++ b/arch/csky/include/asm/irq.h
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +
> +#ifndef __ASM_CSKY_IRQ_H
> +#define __ASM_CSKY_IRQ_H
> +
> +#include <asm-generic/irq.h>
> +
> +#endif /* __ASM_CSKY_IRQ_H */

Just wire this up using generic-y in the Kbuild file instead of
creating a wrapper.  (Same for any other header which is a trivial
asm-generic wrapper).
