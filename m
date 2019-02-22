Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbfBVOc0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 09:32:26 -0500
Date: Fri, 22 Feb 2019 14:32:21 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 13/23] arm64: compat: Add vDSO
Message-ID: <20190222143221.GL42419@lakrids.cambridge.arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-14-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222122430.21180-14-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190222143221.DTa_BOUu5wJHNZMMr3QYrsSA2Ei10mRe7-5layoBWRw@z>

On Fri, Feb 22, 2019 at 12:24:20PM +0000, Vincenzo Frascino wrote:
> diff --git a/arch/arm64/include/asm/vdso/compat_barrier.h b/arch/arm64/include/asm/vdso/compat_barrier.h
> new file mode 100644
> index 000000000000..b149761d9661
> --- /dev/null
> +++ b/arch/arm64/include/asm/vdso/compat_barrier.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2018 ARM Limited
> + */
> +#ifndef __COMPAT_BARRIER_H
> +#define __COMPAT_BARRIER_H
> +
> +#include <asm/barrier.h>

I think it would be safer to not include this header, and explicitly
define the AArch32 barriers here in isolation.

> +
> +#if __LINUX_ARM_ARCH__ >= 8
> +#define aarch32_smp_mb()	dmb(ish)
> +#define aarch32_smp_rmb()	dmb(ishld)
> +#define aarch32_smp_wmb()	dmb(ishst)
> +#else
> +#define aarch32_smp_mb()	dmb(ish)
> +#define aarch32_smp_rmb()	aarch32_smp_mb()
> +#define aarch32_smp_wmb()	dmb(ishst)
> +#endif

Can't we just code an AArch32-specific version of dmb() here? AFAICT
that's the only reason we include the native barrier.h.

> +/*
> + * Warning: This code is meant to be used with
> + * ENABLE_COMPAT_VDSO only.
> + */
> +#ifndef ENABLE_COMPAT_VDSO
> +#error This header is meant to be used with ENABLE_COMPAT_VDSO only
> +#endif
> +
> +#undef smp_mb
> +#undef smp_rmb
> +#undef smp_wmb
> +
> +#define smp_mb()	aarch32_smp_mb()
> +#define smp_rmb()	aarch32_smp_rmb()
> +#define smp_wmb()	aarch32_smp_wmb()

This undeffing looks very fragile to me.

[...]

> diff --git a/arch/arm64/kernel/vdso32/.gitignore b/arch/arm64/kernel/vdso32/.gitignore
> new file mode 100644
> index 000000000000..4fea950fa5ed
> --- /dev/null
> +++ b/arch/arm64/kernel/vdso32/.gitignore
> @@ -0,0 +1,2 @@
> +vdso.lds
> +vdso.so.raw
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> new file mode 100644
> index 000000000000..ba57d2ae620f
> --- /dev/null
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -0,0 +1,184 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for vdso32
> +#
> +
> +# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
> +# the inclusion of generic Makefile.
> +ARCH_REL_TYPE_ABS := R_ARM_JUMP_SLOT|R_ARM_GLOB_DAT|R_ARM_ABS32
> +include $(srctree)/lib/vdso/Makefile
> +
> +CC_ARM32 := $(CROSS_COMPILE_ARM32)gcc

To match HOSTCC, it might make sense to call this COMPATCC

... and likewise, CROSS_COMPILE_COMPAT

Thanks,
Mark.
