Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:36893 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757985AbdLRLTr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Dec 2017 06:19:47 -0500
MIME-Version: 1.0
In-Reply-To: <9663cb7c21011cdb4f278c1fad081d1df296daa8.1513577007.git.green.hu@gmail.com>
References: <cover.1513577007.git.green.hu@gmail.com> <9663cb7c21011cdb4f278c1fad081d1df296daa8.1513577007.git.green.hu@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Dec 2017 12:19:46 +0100
Message-ID: <CAK8P3a2Yas3rWdx_qYx48PECundOzRSKOsqkJnUTzGW86OjJVg@mail.gmail.com>
Subject: Re: [PATCH v4 16/36] nds32: System calls handling
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, ren_guo@c-sky.com, Philippe Ombredanne <pombredanne@nexb.com>, Vincent Chen <vincentc@andestech.com>
Message-ID: <20171218111946.XM0Qsx39Q8TRRHJ_tNUFaeJvfPX_vA3PA8pDJJFFS2Q@z>

On Mon, Dec 18, 2017 at 7:46 AM, Greentime Hu <green.hu@gmail.com> wrote:


> new file mode 100644
> index 0000000..90da745
> --- /dev/null
> +++ b/arch/nds32/include/uapi/asm/unistd.h
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2005-2017 Andes Technology Corporation
> +
> +#define __ARCH_WANT_SYNC_FILE_RANGE2
> +
> +/* Use the standard ABI for syscalls */
> +#include <asm-generic/unistd.h>
> +
> +/* Additional NDS32 specific syscalls. */
> +#define __NR_cacheflush                (__NR_arch_specific_syscall)
> +#define __NR__llseek             __NR_llseek
> +__SYSCALL(__NR_cacheflush, sys_cacheflush)

I'm still confused by __NR__llseek here, why do you need that one?

> +SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
> +              unsigned long, prot, unsigned long, flags,
> +              unsigned long, fd, unsigned long, pgoff)
> +{
> +       if (pgoff & (~PAGE_MASK >> 12))
> +               return -EINVAL;
> +
> +       return sys_mmap_pgoff(addr, len, prot, flags, fd,
> +                             pgoff >> (PAGE_SHIFT - 12));
> +}
> +
> +SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
> +              unsigned long, prot, unsigned long, flags,
> +              unsigned long, fd, unsigned long, pgoff)
> +{
> +       if (unlikely(pgoff & ~PAGE_MASK))
> +               return -EINVAL;
> +
> +       return sys_mmap_pgoff(addr, len, prot, flags, fd,
> +                             pgoff >> PAGE_SHIFT);
> +}

And I don't see why you define sys_mmap() in addition to sys_mmap2().

The rest of the syscall handling looks good now.

         Arnd
