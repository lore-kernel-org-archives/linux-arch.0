From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 26/31] arm64: Miscellaneous library functions
Date: Wed, 15 Aug 2012 15:21:14 +0000
Message-ID: <201208151521.14663.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <1344966752-16102-27-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1344966752-16102-27-git-send-email-catalin.marinas@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

On Tuesday 14 August 2012, Catalin Marinas wrote:

> +
> +/*
> + * Use compiler builtins for simple inline operations.
> + */
> +static inline unsigned long __ffs(unsigned long word)
> +{
> +	return __builtin_ffsl(word) - 1;
> +}
> +
> +static inline int ffs(int x)
> +{
> +	return __builtin_ffs(x);
> +}
> +
> +static inline unsigned long __fls(unsigned long word)
> +{
> +	return BITS_PER_LONG - 1 - __builtin_clzl(word);
> +}
> +
> +static inline int fls(int x)
> +{
> +	return x ? sizeof(x) * BITS_PER_BYTE - __builtin_clz(x) : 0;
> +}

These are all great, but I think whether to use them or not should
depend on the compiler version rather than the architecture in
general. Do we know a minimum gcc version that supports all of the
above? Then we could put that code into the generic files.

If that's not possible, we could still make the implementation
available for other architectures by moving it to

asm-generic/bitops/builtin-__ffs.h
asm-generic/bitops/builtin-ffs.h
asm-generic/bitops/builtin-__fls.h
asm-generic/bitops/builtin-fls.h

> --- /dev/null
> +++ b/arch/arm64/lib/bitops.c
> @@ -0,0 +1,25 @@
> +/*
> + * Copyright (C) 2012 ARM Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/spinlock.h>
> +#include <linux/atomic.h>
> +
> +#ifdef CONFIG_SMP
> +arch_spinlock_t __atomic_hash[ATOMIC_HASH_SIZE] __lock_aligned = {
> +       [0 ... (ATOMIC_HASH_SIZE-1)]  = __ARCH_SPIN_LOCK_UNLOCKED
> +};
> +#endif

What?

I suppose this is a leftover from an earlier version using the
generic bitops, right?

	Arnd
