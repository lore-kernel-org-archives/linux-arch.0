From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v4 16/36] nds32: System calls handling
Date: Mon, 18 Dec 2017 12:19:46 +0100
Message-ID: <CAK8P3a2Yas3rWdx_qYx48PECundOzRSKOsqkJnUTzGW86OjJVg@mail.gmail.com>
References: <cover.1513577007.git.green.hu@gmail.com> <9663cb7c21011cdb4f278c1fad081d1df296daa8.1513577007.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9663cb7c21011cdb4f278c1fad081d1df296daa8.1513577007.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Greentime <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Networking <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, ren_guo-Y+KPrCd2zL4AvxtiuMwx3w@public.gmane.org, Philip
List-Id: linux-arch.vger.kernel.org

On Mon, Dec 18, 2017 at 7:46 AM, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:


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
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
