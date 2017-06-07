From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 13/17] RISC-V: Add include subdirectory
Date: Wed, 7 Jun 2017 14:42:51 +0200
Message-ID: <20170607124251.ql7e54b4u2g5cqzt@hirez.programming.kicks-ass.net>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-14-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:48614 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751489AbdFGMnE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Jun 2017 08:43:04 -0400
Content-Disposition: inline
In-Reply-To: <20170606230007.19101-14-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net, albert@sifive.com, patches@groups.riscv.org

On Tue, Jun 06, 2017 at 04:00:03PM -0700, Palmer Dabbelt wrote:
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> new file mode 100644
> index 000000000000..c7ee1321ac18
> --- /dev/null
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -0,0 +1,124 @@
> +/*
> + * Copyright (C) 2014 Regents of the University of California
> + *
> + *   This program is free software; you can redistribute it and/or
> + *   modify it under the terms of the GNU General Public License
> + *   as published by the Free Software Foundation, version 2.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *   GNU General Public License for more details.
> + */
> +
> +#ifndef _ASM_RISCV_CMPXCHG_H
> +#define _ASM_RISCV_CMPXCHG_H
> +
> +#include <linux/bug.h>
> +
> +#ifdef CONFIG_ISA_A
> +
> +#include <asm/barrier.h>
> +
> +#define __xchg(new, ptr, size)					\
> +({								\
> +	__typeof__(ptr) __ptr = (ptr);				\
> +	__typeof__(new) __new = (new);				\
> +	__typeof__(*(ptr)) __ret;				\
> +	switch (size) {						\
> +	case 4:							\
> +		__asm__ __volatile__ (				\
> +			"amoswap.w %0, %2, %1"			\
> +			: "=r" (__ret), "+A" (*__ptr)		\
> +			: "r" (__new));				\
> +		break;						\
> +	case 8:							\
> +		__asm__ __volatile__ (				\
> +			"amoswap.d %0, %2, %1"			\
> +			: "=r" (__ret), "+A" (*__ptr)		\
> +			: "r" (__new));				\
> +		break;						\
> +	default:						\
> +		BUILD_BUG();					\
> +	}							\
> +	__ret;							\
> +})
> +
> +#define xchg(ptr, x)    (__xchg((x), (ptr), sizeof(*(ptr))))

our xchg() is fully ordered, and thus you need to use "amoswap.aq.rl"

> +
> +
> +/*
> + * Atomic compare and exchange.  Compare OLD with MEM, if identical,
> + * store NEW in MEM.  Return the initial value in MEM.  Success is
> + * indicated by comparing RETURN with OLD.
> + */
> +#define __cmpxchg(ptr, old, new, size)					\
> +({									\
> +	__typeof__(ptr) __ptr = (ptr);					\
> +	__typeof__(old) __old = (old);					\
> +	__typeof__(new) __new = (new);					\
> +	__typeof__(*(ptr)) __ret;					\
> +	register unsigned int __rc;					\
> +	switch (size) {							\
> +	case 4:								\
> +		__asm__ __volatile__ (					\
> +		"0:"							\
> +			"lr.w %0, %2\n"					\
> +			"bne  %0, %z3, 1f\n"				\
> +			"sc.w %1, %z4, %2\n"				\
> +			"bnez %1, 0b\n"					\
> +		"1:"							\
> +			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
> +			: "rJ" (__old), "rJ" (__new));			\
> +		break;							\
> +	case 8:								\
> +		__asm__ __volatile__ (					\
> +		"0:"							\
> +			"lr.d %0, %2\n"					\
> +			"bne  %0, %z3, 1f\n"				\
> +			"sc.d %1, %z4, %2\n"				\
> +			"bnez %1, 0b\n"					\
> +		"1:"							\
> +			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
> +			: "rJ" (__old), "rJ" (__new));			\
> +		break;							\
> +	default:							\
> +		BUILD_BUG();						\
> +	}								\
> +	__ret;								\
> +})
> +
> +#define __cmpxchg_mb(ptr, old, new, size)			\
> +({								\
> +	__typeof__(*(ptr)) __ret;				\
> +	smp_mb();						\
> +	__ret = __cmpxchg((ptr), (old), (new), (size));		\
> +	smp_mb();						\
> +	__ret;							\
> +})

Your ISA of course, but wouldn't setting the AQ and RL bits on LR/SC be
cheaper than doing two full barriers around the thing?

Note that cmpxchg() doesn't need to provide ordering on failure.

Further note that we have:

	{atomic_,}cmpxchg{_relaxed,_acquire,_release,}()

and recently:

	{atomic_,}try_cmpxchg{_relaxed,_acquire,_release,}()
