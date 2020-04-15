From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 03/13] task_isolation: add instruction synchronization
 memory barrier
Date: Wed, 15 Apr 2020 13:44:27 +0100
Message-ID: <20200415124427.GB28304@C02TD0UTHF1T.local>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
 <aed12dd15ea2981bc9554cfa8b5e273c1342c756.camel@marvell.com>
 <07c25c246c55012981ec0296eee23e68c719333a.camel@marvell.com>
 <d995795c731d6ecceb36bdf1c1df3d72fefd023d.camel@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:44580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898196AbgDOMof (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Apr 2020 08:44:35 -0400
Content-Disposition: inline
In-Reply-To: <d995795c731d6ecceb36bdf1c1df3d72fefd023d.camel@marvell.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Belits <abelits@marvell.com>
Cc: "frederic@kernel.org" <frederic@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, Prasun Kapoor <pkapoor@marvell.com>, "mingo@kernel.org" <mingo@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "will@kernel.org" <will@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>

On Thu, Apr 09, 2020 at 03:17:40PM +0000, Alex Belits wrote:
> Some architectures implement memory synchronization instructions for
> instruction cache. Make a separate kind of barrier that calls them.

Modifying the instruction caches requries more than an ISB, and the
'IMB' naming implies you're trying to order against memory accesses,
which isn't what ISB (generally) does.

What exactly do you want to use this for?

As-is, I don't think this makes sense as a generic barrier.

Thanks,
Mark.

> 
> Signed-off-by: Alex Belits <abelits@marvell.com>
> ---
>  arch/arm/include/asm/barrier.h   | 2 ++
>  arch/arm64/include/asm/barrier.h | 2 ++
>  include/asm-generic/barrier.h    | 4 ++++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/arch/arm/include/asm/barrier.h b/arch/arm/include/asm/barrier.h
> index 83ae97c049d9..6def62c95937 100644
> --- a/arch/arm/include/asm/barrier.h
> +++ b/arch/arm/include/asm/barrier.h
> @@ -64,12 +64,14 @@ extern void arm_heavy_mb(void);
>  #define mb()		__arm_heavy_mb()
>  #define rmb()		dsb()
>  #define wmb()		__arm_heavy_mb(st)
> +#define imb()		isb()
>  #define dma_rmb()	dmb(osh)
>  #define dma_wmb()	dmb(oshst)
>  #else
>  #define mb()		barrier()
>  #define rmb()		barrier()
>  #define wmb()		barrier()
> +#define imb()		barrier()
>  #define dma_rmb()	barrier()
>  #define dma_wmb()	barrier()
>  #endif
> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> index 7d9cc5ec4971..12a7dbd68bed 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h
> @@ -45,6 +45,8 @@
>  #define rmb()		dsb(ld)
>  #define wmb()		dsb(st)
>  
> +#define imb()		isb()
> +
>  #define dma_rmb()	dmb(oshld)
>  #define dma_wmb()	dmb(oshst)
>  
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index 85b28eb80b11..d5a822fb3e92 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -46,6 +46,10 @@
>  #define dma_wmb()	wmb()
>  #endif
>  
> +#ifndef imb
> +#define imb		barrier()
> +#endif
> +
>  #ifndef read_barrier_depends
>  #define read_barrier_depends()		do { } while (0)
>  #endif
> -- 
> 2.20.1
> 
