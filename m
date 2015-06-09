From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 20/28] ARCv2: barriers
Date: Tue, 9 Jun 2015 14:40:08 +0200
Message-ID: <20150609124008.GA3644@twins.programming.kicks-ass.net>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
 <1433850508-26317-21-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433850508-26317-21-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, arc-linux-dev@synopsys.com
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 09, 2015 at 05:18:20PM +0530, Vineet Gupta wrote:

A description of how your hardware works; or a reference to the platform
documentation would not go amiss.

> +++ b/arch/arc/include/asm/barrier.h
> @@ -0,0 +1,48 @@
> +/*
> + * Copyright (C) 2014-15 Synopsys, Inc. (www.synopsys.com)
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __ASM_BARRIER_H
> +#define __ASM_BARRIER_H
> +
> +#ifdef CONFIG_SMP
> +
> +#ifdef CONFIG_ISA_ARCV2
> +
> +/*
> + * DMB:
> + *   - Ensures that selected memory operation issued before it will complete
> + *     before any subsequent memory operation of same type
> + */
> +#define smp_mb()	asm volatile("dmb 3\n" : : : "memory")
> +#define smp_rmb()	asm volatile("dmb 1\n" : : : "memory")
> +#define smp_wmb()	asm volatile("dmb 2\n" : : : "memory")
> +
> +/*
> + * DSYNC:
> + *   - Waits for completion of all outstanding memory operations before any new
> + *     operations can begin
> + *   - Includes implicit memory operations such as cache/TLB/BPU maintenance ops
> + *   - Lighter version of SYNC as it doesn't wait for non-memory operations
> + */
> +#define mb()		asm volatile("dsync\n" : : : "memory")

So mb() is supposed to order against things like DMA memory ops, is DMA
part of point 1 or 3, if 3, this is not a suitable instruction.

> +#else	/* CONFIG_ISA_ARCOMPACT */
> +
> +/* SYNC:
> + *   - Waits for completion of all outstanding memory transactions AND all
> + *     previous instructions to reture
> + */
> +#define mb()		asm volatile("sync\n" : : : "memory")
> +
> +#endif	/* CONFIG_ISA_ARCV2 */
