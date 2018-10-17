Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39137 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeJQXna (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Oct 2018 19:43:30 -0400
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <1963c845cf9b7aa31547cdfe1f82b1add1ad2504.1539655732.git.ren_guo@c-sky.com>
In-Reply-To: <1963c845cf9b7aa31547cdfe1f82b1add1ad2504.1539655732.git.ren_guo@c-sky.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 17 Oct 2018 17:46:56 +0200
Message-ID: <CAK8P3a1hByh-k8mng8a22C1-tNU0yn1LNvoaCmHp4RpP_GUs4Q@mail.gmail.com>
Subject: Re: [PATCH V9 15/21] csky: Debug and Ptrace GDB
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Miller <davem@davemloft.net>, gregkh <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
Message-ID: <20181017154656.dlHQLL701IA62pC2UVPvM-Nl3V3wy9CcPXYU0PjdiYs@z>

On Tue, Oct 16, 2018 at 5:06 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This patch adds arch ptrace implementation, stack dump and bug.h.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> diff --git a/arch/csky/include/asm/bug.h b/arch/csky/include/asm/bug.h
> new file mode 100644
> index 0000000..bd7b323
> --- /dev/null
> +++ b/arch/csky/include/asm/bug.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +
> +#ifndef __ASM_CSKY_BUG_H
> +#define __ASM_CSKY_BUG_H
> +
> +#include <linux/compiler.h>
> +#include <linux/const.h>
> +#include <linux/types.h>
> +
> +#define BUG()                          \
> +do {                                   \
> +       asm volatile ("bkpt\n");        \
> +       unreachable();                  \
> +} while (0)

Since you have a breakpoint instruction, a nice addition might
be to use that for implementing WARN_ON as well, whenever you
get around to doing that. It's certainly not required for the initial
merge.
