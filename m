Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:32834 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbcFORpO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jun 2016 13:45:14 -0400
Date: Wed, 15 Jun 2016 19:45:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH-tip v2 5/6] locking/rwsem: Change RWSEM_WAITING_BIAS
 for better disambiguation
Message-ID: <20160615174508.GU30921@twins.programming.kicks-ass.net>
References: <1465944489-43440-1-git-send-email-Waiman.Long@hpe.com>
 <1465944489-43440-6-git-send-email-Waiman.Long@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1465944489-43440-6-git-send-email-Waiman.Long@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hpe.com>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, Jason Low <jason.low2@hp.com>, Dave Chinner <david@fromorbit.com>, Scott J Norton <scott.norton@hpe.com>, Douglas Hatch <doug.hatch@hpe.com>
Message-ID: <20160615174508.kaBhNYxGwWnQrnKuIFJgcZJ4JfoNQUlWvVFxwnMxaXI@z>

On Tue, Jun 14, 2016 at 06:48:08PM -0400, Waiman Long wrote:
> +++ b/arch/alpha/include/asm/rwsem.h
> @@ -17,9 +17,9 @@
>  #define RWSEM_UNLOCKED_VALUE		0x0000000000000000L
>  #define RWSEM_ACTIVE_BIAS		0x0000000000000001L
>  #define RWSEM_ACTIVE_MASK		0x00000000ffffffffL
> -#define RWSEM_WAITING_BIAS		(-0x0000000100000000L)
> +#define RWSEM_WAITING_BIAS		0xc000000000000000L
>  #define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
> -#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
> +#define RWSEM_ACTIVE_WRITE_BIAS		(-RWSEM_ACTIVE_MASK)

> +++ b/arch/ia64/include/asm/rwsem.h
> @@ -30,9 +30,9 @@
>  #define RWSEM_UNLOCKED_VALUE		__IA64_UL_CONST(0x0000000000000000)
>  #define RWSEM_ACTIVE_BIAS		(1L)
>  #define RWSEM_ACTIVE_MASK		(0xffffffffL)
> -#define RWSEM_WAITING_BIAS		(-0x100000000L)
> +#define RWSEM_WAITING_BIAS		(-(1L << 62))
>  #define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
> -#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
> +#define RWSEM_ACTIVE_WRITE_BIAS		(-RWSEM_ACTIVE_MASK)

> +++ b/arch/s390/include/asm/rwsem.h
> @@ -42,9 +42,9 @@
>  #define RWSEM_UNLOCKED_VALUE	0x0000000000000000L
>  #define RWSEM_ACTIVE_BIAS	0x0000000000000001L
>  #define RWSEM_ACTIVE_MASK	0x00000000ffffffffL
> -#define RWSEM_WAITING_BIAS	(-0x0000000100000000L)
> +#define RWSEM_WAITING_BIAS	0xc000000000000000L
>  #define RWSEM_ACTIVE_READ_BIAS	RWSEM_ACTIVE_BIAS
> -#define RWSEM_ACTIVE_WRITE_BIAS	(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
> +#define RWSEM_ACTIVE_WRITE_BIAS	(-RWSEM_ACTIVE_MASK)

> +++ b/arch/x86/include/asm/rwsem.h
> @@ -41,21 +41,23 @@
>  
>  /*
>   * The bias values and the counter type limits the number of
> - * potential readers/writers to 32767 for 32 bits and 2147483647
> - * for 64 bits.
> + * potential writers to 16383 for 32 bits and 1073741823 for 64 bits.
> + * The combined readers and writers can go up to 65534 for 32-bits and
> + * 4294967294 for 64-bits.
>   */
>  
>  #ifdef CONFIG_X86_64
>  # define RWSEM_ACTIVE_MASK		0xffffffffL
> +# define RWSEM_WAITING_BIAS		(-(1L << 62))
>  #else
>  # define RWSEM_ACTIVE_MASK		0x0000ffffL
> +# define RWSEM_WAITING_BIAS		(-(1L << 30))
>  #endif
>  
>  #define RWSEM_UNLOCKED_VALUE		0x00000000L
>  #define RWSEM_ACTIVE_BIAS		0x00000001L
> -#define RWSEM_WAITING_BIAS		(-RWSEM_ACTIVE_MASK-1)
>  #define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
> -#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
> +#define RWSEM_ACTIVE_WRITE_BIAS		(-RWSEM_ACTIVE_MASK)

> +++ b/include/asm-generic/rwsem.h
> @@ -18,15 +18,16 @@
>   */
>  #ifdef CONFIG_64BIT
>  # define RWSEM_ACTIVE_MASK		0xffffffffL
> +# define RWSEM_WAITING_BIAS		(-(1L << 62))
>  #else
>  # define RWSEM_ACTIVE_MASK		0x0000ffffL
> +# define RWSEM_WAITING_BIAS		(-(1L << 30))
>  #endif
>  
>  #define RWSEM_UNLOCKED_VALUE		0x00000000L
>  #define RWSEM_ACTIVE_BIAS		0x00000001L
> -#define RWSEM_WAITING_BIAS		(-RWSEM_ACTIVE_MASK-1)
>  #define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
> -#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
> +#define RWSEM_ACTIVE_WRITE_BIAS		(-RWSEM_ACTIVE_MASK)

Can't we collapse all that? They all seem very similar.
