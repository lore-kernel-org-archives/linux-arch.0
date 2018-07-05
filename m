Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:33226 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753397AbeGERlE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Jul 2018 13:41:04 -0400
Date: Thu, 5 Jul 2018 19:40:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V2 06/19] csky: Cache and TLB routines
Message-ID: <20180705174025.GD2530@hirez.programming.kicks-ass.net>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <a2c153fa2e585e4ba54a339f13442881553ab6a4.1530465326.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2c153fa2e585e4ba54a339f13442881553ab6a4.1530465326.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com, Will Deacon <will.deacon@arm.com>
Message-ID: <20180705174025.lPtOvPMTwgmNtJNgkQWzosUt4jIWhQT9pryvDf7kH3E@z>

On Mon, Jul 02, 2018 at 01:30:09AM +0800, Guo Ren wrote:
> diff --git a/arch/csky/include/asm/barrier.h b/arch/csky/include/asm/barrier.h
> new file mode 100644
> index 0000000..7254527
> --- /dev/null
> +++ b/arch/csky/include/asm/barrier.h
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +#ifndef __ASM_CSKY_BARRIER_H
> +#define __ASM_CSKY_BARRIER_H
> +
> +#ifndef __ASSEMBLY__
> +
> +#define nop()	asm volatile ("nop")
> +
> +#ifdef CONFIG_SMP
> +#define mb()	asm volatile ("sync.is":::"memory")
> +#else
> +#define mb()	asm volatile ("sync":::"memory")
> +#endif

This is very suspect, please elaborate.

What I would've expected is:

#define mb() asm volatile ("sync" ::: "memory")

#ifdef CONFIG_SMP
#define __smp_mb() asm volatile ("sync.is" ::: "memory")
#endif

Is that in fact what you meant?

Do you have a reference to your architecture manual and memory model
description somewhere?


> +
> +#include <asm-generic/barrier.h>
> +
> +#endif /* __ASSEMBLY__ */
> +#endif /* __ASM_CSKY_BARRIER_H */
