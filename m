Return-Path: <SRS0=IHIJ=AU=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from ozlabs.org ([203.11.71.1]:57885 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgGIKNh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Jul 2020 06:13:37 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 3/6] powerpc: move spinlock implementation to simple_spinlock
In-Reply-To: <20200706043540.1563616-4-npiggin@gmail.com>
References: <20200706043540.1563616-1-npiggin@gmail.com> <20200706043540.1563616-4-npiggin@gmail.com>
Date: Thu, 09 Jul 2020 20:15:51 +1000
Message-ID: <87a709vvs8.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Anton Blanchard <anton@ozlabs.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20200709101551.LF7t1uYjN6zVdtyOLvtRW4nNQbY-HsirarX_Ok4GV4I@z>

Nicholas Piggin <npiggin@gmail.com> writes:
> To prepare for queued spinlocks. This is a simple rename except to update
> preprocessor guard name and a file reference.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/include/asm/simple_spinlock.h    | 292 ++++++++++++++++++
>  .../include/asm/simple_spinlock_types.h       |  21 ++
>  arch/powerpc/include/asm/spinlock.h           | 285 +----------------
>  arch/powerpc/include/asm/spinlock_types.h     |  12 +-
>  4 files changed, 315 insertions(+), 295 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/simple_spinlock.h
>  create mode 100644 arch/powerpc/include/asm/simple_spinlock_types.h
>
> diff --git a/arch/powerpc/include/asm/simple_spinlock.h b/arch/powerpc/include/asm/simple_spinlock.h
> new file mode 100644
> index 000000000000..e048c041c4a9
> --- /dev/null
> +++ b/arch/powerpc/include/asm/simple_spinlock.h
> @@ -0,0 +1,292 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef __ASM_SIMPLE_SPINLOCK_H
> +#define __ASM_SIMPLE_SPINLOCK_H

_ASM_POWERPC_SIMPLE_SPINLOCK_H

> +#ifdef __KERNEL__

Shouldn't be necessary.

> +/*
> + * Simple spin lock operations.  
> + *
> + * Copyright (C) 2001-2004 Paul Mackerras <paulus@au.ibm.com>, IBM
> + * Copyright (C) 2001 Anton Blanchard <anton@au.ibm.com>, IBM
> + * Copyright (C) 2002 Dave Engebretsen <engebret@us.ibm.com>, IBM
> + *	Rework to support virtual processors
> + *
> + * Type of int is used as a full 64b word is not necessary.
> + *
> + * (the type definitions are in asm/simple_spinlock_types.h)
> + */
> +#include <linux/irqflags.h>
> +#include <asm/paravirt.h>
> +#ifdef CONFIG_PPC64
> +#include <asm/paca.h>
> +#endif

I don't think paca.h needs a CONFIG_PPC64 guard, it contains one. I know
you're just moving the code, but still nice to cleanup slightly along
the way.

cheers
