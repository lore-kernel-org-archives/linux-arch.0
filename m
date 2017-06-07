From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 13/17] RISC-V: Add include subdirectory
Date: Wed, 7 Jun 2017 15:17:27 +0200
Message-ID: <20170607131727.chhlzuu4gysyuqrn@hirez.programming.kicks-ass.net>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-14-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:48784 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbdFGNRx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Jun 2017 09:17:53 -0400
Content-Disposition: inline
In-Reply-To: <20170606230007.19101-14-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net, albert@sifive.com, patches@groups.riscv.org, Will Deacon <will.deacon@arm.com>

On Tue, Jun 06, 2017 at 04:00:03PM -0700, Palmer Dabbelt wrote:
> diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
> new file mode 100644
> index 000000000000..9736f5714e54
> --- /dev/null
> +++ b/arch/riscv/include/asm/spinlock.h
> @@ -0,0 +1,155 @@
> +/*
> + * Copyright (C) 2015 Regents of the University of California
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
> +#ifndef _ASM_RISCV_SPINLOCK_H
> +#define _ASM_RISCV_SPINLOCK_H
> +
> +#include <linux/kernel.h>
> +#include <asm/current.h>
> +
> +/*
> + * Simple spin lock operations.  These provide no fairness guarantees.
> + */

Any reason to use a test-and-set spinlock at all?

> +
> +#define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
> +#define arch_spin_is_locked(x)	((x)->lock != 0)
> +#define arch_spin_unlock_wait(x) \
> +		do { cpu_relax(); } while ((x)->lock)

Hehe, yeah, no ;-) There are ordering constraints on that.

> +
> +static inline void arch_spin_unlock(arch_spinlock_t *lock)
> +{
> +	__asm__ __volatile__ (
> +		"amoswap.w.rl x0, x0, %0"
> +		: "=A" (lock->lock)
> +		:: "memory");
> +}
> +
> +static inline int arch_spin_trylock(arch_spinlock_t *lock)
> +{
> +	int tmp = 1, busy;
> +
> +	__asm__ __volatile__ (
> +		"amoswap.w.aq %0, %2, %1"
> +		: "=r" (busy), "+A" (lock->lock)
> +		: "r" (tmp)
> +		: "memory");
> +
> +	return !busy;
> +}
> +
> +static inline void arch_spin_lock(arch_spinlock_t *lock)
> +{
> +	while (1) {
> +		if (arch_spin_is_locked(lock))
> +			continue;
> +
> +		if (arch_spin_trylock(lock))
> +			break;
> +	}
> +}
