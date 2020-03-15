From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 18/26] arm64: Introduce asm/vdso/processor.h
Date: Sun, 15 Mar 2020 18:30:09 +0000
Message-ID: <20200315182950.GB32205@mbp>
References: <20200313154345.56760-1-vincenzo.frascino@arm.com>
 <20200313154345.56760-19-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200313154345.56760-19-vincenzo.frascino@arm.com>
Sender: linux-mips-owner@vger.kernel.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, clang-built-linux@googlegroups.com, x86@kernel.org, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Stephen Boyd <sboyd@kernel.org>, Mark Salyzyn <salyzyn@android.com>, Kees Cook <keescook@chromium.org>, Peter Collingbourne <pcc@google.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Andrei Vagin <avagin@openvz.org>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <maz@kernel.org>Mark
List-Id: linux-arch.vger.kernel.org

On Fri, Mar 13, 2020 at 03:43:37PM +0000, Vincenzo Frascino wrote:
> --- /dev/null
> +++ b/arch/arm64/include/asm/vdso/processor.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2020 ARM Ltd.
> + */
> +#ifndef __ASM_VDSO_PROCESSOR_H
> +#define __ASM_VDSO_PROCESSOR_H
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <asm/page-def.h>
> +
> +#ifdef CONFIG_COMPAT
> +#if defined(CONFIG_ARM64_64K_PAGES) && defined(CONFIG_KUSER_HELPERS)
> +/*
> + * With CONFIG_ARM64_64K_PAGES enabled, the last page is occupied
> + * by the compat vectors page.
> + */
> +#define TASK_SIZE_32		UL(0x100000000)
> +#else
> +#define TASK_SIZE_32		(UL(0x100000000) - PAGE_SIZE)
> +#endif /* CONFIG_ARM64_64K_PAGES */
> +#endif /* CONFIG_COMPAT */

Just curious, what's TASK_SIZE_32 used for in the vDSO code? You don't
seem to move TASK_SIZE.

-- 
Catalin
