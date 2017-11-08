From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 12/31] nds32: Device specific operations
Date: Wed, 8 Nov 2017 10:04:43 +0100
Message-ID: <CAK8P3a04p+GUz3ex=t=CVy8ZcVFFZGwJaaPDoyT74bjieiKHVw@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <4e9acf2ec55fb26ddb290ca2d955eeea628e0a77.1510118606.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:45592 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbdKHJEp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Nov 2017 04:04:45 -0500
In-Reply-To: <4e9acf2ec55fb26ddb290ca2d955eeea628e0a77.1510118606.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>

On Wed, Nov 8, 2017 at 6:55 AM, Greentime Hu <green.hu@gmail.com> wrote:

> +
> +#define ioremap(cookie,size)           __ioremap(cookie,size,0,1)
> +#define ioremap_nocache(cookie,size)   __ioremap(cookie,size,0,1)
> +#define iounmap(cookie)                        __iounmap(cookie)

> +#include <asm-generic/io.h>

asm-generic/io.h now provides an ioremap_nocache() helper along with
ioremap_uc/ioremap_wc/ioremap_wt, so I think you can remove the
ioremap_nocache definition here. You might also be able to remove
__ioremap and __iounmap, and only provide ioremap/iounmap, plus
the identity macro 'define ioremap ioremap'

> +void __iomem *__ioremap(unsigned long phys_addr, size_t size,
> +                       unsigned long flags, unsigned long align)

The 'align' argument is unused here, and not used on other architectures
either.

> +{
> +       struct vm_struct *area;
> +       unsigned long addr, offset, last_addr;
> +       pgprot_t prot;
> +
> +       /* Don't allow wraparound or zero size */
> +       last_addr = phys_addr + size - 1;
> +       if (!size || last_addr < phys_addr)
> +               return NULL;
> +
> +       /*
> +        * Mappings have to be page-aligned
> +        */
> +       offset = phys_addr & ~PAGE_MASK;
> +       phys_addr &= PAGE_MASK;
> +       size = PAGE_ALIGN(last_addr + 1) - phys_addr;
> +
> +       /*
> +        * Ok, go for it..
> +        */
> +       area = get_vm_area(size, VM_IOREMAP);

Better use get_vm_area_caller here to have the ioremap areas show up
in a more useful form in /proc/vmallocinfo

Please also have a look at what you can do for memremap().

Since you have no cacheable version of ioremap_wb/wt, it will
return an uncached mapping all the time, which is not ideal.

     Arnd
