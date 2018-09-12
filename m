Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39581 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeILT1K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Sep 2018 15:27:10 -0400
MIME-Version: 1.0
References: <cover.1536757532.git.ren_guo@c-sky.com> <abb46d366b513b814f7af234d560306a818b7324.1536757532.git.ren_guo@c-sky.com>
In-Reply-To: <abb46d366b513b814f7af234d560306a818b7324.1536757532.git.ren_guo@c-sky.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 12 Sep 2018 16:22:10 +0200
Message-ID: <CAK8P3a13wWsFX2DR4LD0L4rZV0k3zszSyOX1_kPquJKaTt7StQ@mail.gmail.com>
Subject: Re: [PATCH V3 17/27] csky: Misc headers
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, DTML <devicetree@vger.kernel.org>, andrea.parri@amarulasolutions.com, Peter Zijlstra <peterz@infradead.org>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Message-ID: <20180912142210.HjwGMtWGVeYKtZT3kX9k8_t_fg0aHxC8JFA3aBU0qfg@z>

On Wed, Sep 12, 2018 at 3:25 PM Guo Ren <ren_guo@c-sky.com> wrote:
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> diff --git a/arch/csky/boot/dts/qemu.dts b/arch/csky/boot/dts/qemu.dts
> new file mode 100644
> index 0000000..c6643b1
> --- /dev/null
> +++ b/arch/csky/boot/dts/qemu.dts
> @@ -0,0 +1,77 @@

Did you consider renaming the file as I suggested? I think that would help
in the long run when you get new qemu versions that have a different set
of devices and that may provide their own dtbs.

> diff --git a/arch/csky/include/asm/compat.h b/arch/csky/include/asm/compat.h
> new file mode 100644
> index 0000000..59f9297
> --- /dev/null
> +++ b/arch/csky/include/asm/compat.h
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +
> +#ifndef __ASM_CSKY_COMPAT_H
> +#define __ASM_CSKY_COMPAT_H
> +
> +#ifdef CONFIG_COMPAT
> +#define COMPAT_UTS_MACHINE "csky\0\0"
> +#endif
> +
> +#endif /* __ASM_CSKY_COMPAT_H */

Just noticed this one. I assume there won't be a csky64 architecture,
so you can probably just delete this header.

         Arnd
