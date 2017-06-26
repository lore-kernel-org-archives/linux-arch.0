From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 13/17] RISC-V: Add include subdirectory
Date: Mon, 26 Jun 2017 13:07:06 -0700 (PDT)
Message-ID: <mhng-4802f4bb-e93c-4fc5-bbf5-ec11bde39482@palmer-si-x1c4>
References: <20170607131727.chhlzuu4gysyuqrn@hirez.programming.kicks-ass.net>
Mime-Version: 1.0 (MHng)
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33479 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbdFZUHI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2017 16:07:08 -0400
Received: by mail-pf0-f196.google.com with SMTP id e199so1600623pfh.0
        for <linux-arch@vger.kernel.org>; Mon, 26 Jun 2017 13:07:07 -0700 (PDT)
In-Reply-To: <20170607131727.chhlzuu4gysyuqrn@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, albert@sifive.com, patches@groups.riscv.org, will.deacon@arm.com

On Wed, 07 Jun 2017 06:17:27 PDT (-0700), peterz@infradead.org wrote:
> On Tue, Jun 06, 2017 at 04:00:03PM -0700, Palmer Dabbelt wrote:
>> diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
>> new file mode 100644
>> index 000000000000..9736f5714e54
>> --- /dev/null
>> +++ b/arch/riscv/include/asm/spinlock.h
>> @@ -0,0 +1,155 @@
>> +/*
>> + * Copyright (C) 2015 Regents of the University of California
>> + *
>> + *   This program is free software; you can redistribute it and/or
>> + *   modify it under the terms of the GNU General Public License
>> + *   as published by the Free Software Foundation, version 2.
>> + *
>> + *   This program is distributed in the hope that it will be useful,
>> + *   but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *   GNU General Public License for more details.
>> + */
>> +
>> +#ifndef _ASM_RISCV_SPINLOCK_H
>> +#define _ASM_RISCV_SPINLOCK_H
>> +
>> +#include <linux/kernel.h>
>> +#include <asm/current.h>
>> +
>> +/*
>> + * Simple spin lock operations.  These provide no fairness guarantees.
>> + */
>
> Any reason to use a test-and-set spinlock at all?

Just simplicity.  I looked at the MIPS ticket lock and I think we can implement
that while still maintaining the forward progress constraints on our LR/SC
sequences.  I added a FIXME about it, which I'll try to get around to

  https://github.com/riscv/riscv-linux/commit/a75d28c849e695639b7909ffa88ce571abfb0c76

but I'm going to try and get a v3 patch set out first.

>> +
>> +#define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
>> +#define arch_spin_is_locked(x)	((x)->lock != 0)
>> +#define arch_spin_unlock_wait(x) \
>> +		do { cpu_relax(); } while ((x)->lock)
>
> Hehe, yeah, no ;-) There are ordering constraints on that.

OK.  I copied the ordering guarntees from MIPS here

  https://github.com/riscv/riscv-linux/commit/7d16920452c6bd14c847aade2d51c56d2a1ae457

>> +
>> +static inline void arch_spin_unlock(arch_spinlock_t *lock)
>> +{
>> +	__asm__ __volatile__ (
>> +		"amoswap.w.rl x0, x0, %0"
>> +		: "=A" (lock->lock)
>> +		:: "memory");
>> +}
>> +
>> +static inline int arch_spin_trylock(arch_spinlock_t *lock)
>> +{
>> +	int tmp = 1, busy;
>> +
>> +	__asm__ __volatile__ (
>> +		"amoswap.w.aq %0, %2, %1"
>> +		: "=r" (busy), "+A" (lock->lock)
>> +		: "r" (tmp)
>> +		: "memory");
>> +
>> +	return !busy;
>> +}
>> +
>> +static inline void arch_spin_lock(arch_spinlock_t *lock)
>> +{
>> +	while (1) {
>> +		if (arch_spin_is_locked(lock))
>> +			continue;
>> +
>> +		if (arch_spin_trylock(lock))
>> +			break;
>> +	}
>> +}

Thanks for all the comments!
