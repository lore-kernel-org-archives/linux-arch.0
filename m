Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33907 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753185AbeGCUFA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jul 2018 16:05:00 -0400
MIME-Version: 1.0
In-Reply-To: <7a1490b307d8e62cebe80ebc03fea6bad8b0f227.1530465326.git.ren_guo@c-sky.com>
References: <cover.1530465325.git.ren_guo@c-sky.com> <7a1490b307d8e62cebe80ebc03fea6bad8b0f227.1530465326.git.ren_guo@c-sky.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 3 Jul 2018 22:04:57 +0200
Message-ID: <CAK8P3a3jqib-GiWcRVo6ds8Q50nZTaRmC3ACW5xJJVJzV6=7NA@mail.gmail.com>
Subject: Re: [PATCH V2 13/19] csky: Library functions
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Message-ID: <20180703200457.8qCnmzJW73e2XtZI4fkoZ4LjTTIWlqOIPHAWzmgOdDQ@z>

On Sun, Jul 1, 2018 at 7:30 PM, Guo Ren <ren_guo@c-sky.com> wrote:
>
> diff --git a/arch/csky/kernel/cskyksyms.c b/arch/csky/kernel/cskyksyms.c
> new file mode 100644
> index 0000000..3f13594
> --- /dev/null
> +++ b/arch/csky/kernel/cskyksyms.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +#include <linux/module.h>
> +#include <linux/uaccess.h>
> +#include <asm/cacheflush.h>
> +
> +/*
> + * Defined in libgcc
> + *
> + * See arch/csky/Makefile:
> + *     -print-libgcc-file-name
> + */
> +extern void __ashldi3 (void);
> +extern void __ashrdi3 (void);
> +extern void __lshrdi3 (void);
> +extern void __muldi3 (void);
> +extern void __ucmpdi2 (void);
> +EXPORT_SYMBOL(__ashldi3);
> +EXPORT_SYMBOL(__ashrdi3);
> +EXPORT_SYMBOL(__lshrdi3);
> +EXPORT_SYMBOL(__muldi3);
> +EXPORT_SYMBOL(__ucmpdi2);

It's better to avoid relying on libgcc here. Please use the
CONFIG_GENERIC_LIB_ASHLDI3/ASHRDI3/LSHRDI3/etc
helpers that we already have in the kernel.

       Arnd
