From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 11/35] nds32: Device specific operations
Date: Mon, 27 Nov 2017 15:51:31 +0100
Message-ID: <CAK8P3a3aXU6mkffcZbxrgAJupwZZ9zCDjTKGDBCwP_gEP3=HVw@mail.gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <ab110d0eaa525b07b1790d67bbb020046fb78792.1511785528.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46556 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752599AbdK0Ovd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Nov 2017 09:51:33 -0500
In-Reply-To: <ab110d0eaa525b07b1790d67bbb020046fb78792.1511785528.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Vincent Chen <vincentc@andestech.com>

On Mon, Nov 27, 2017 at 1:27 PM, Greentime Hu <green.hu@gmail.com> wrote:
> From: Greentime Hu <greentime@andestech.com>
>
> This patch introduces ioremap implementations.
>
> Signed-off-by: Vincent Chen <vincentc@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>
> ---
>  arch/nds32/include/asm/io.h |   25 +++++++++++++++
>  arch/nds32/mm/ioremap.c     |   75 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 100 insertions(+)
>  create mode 100644 arch/nds32/include/asm/io.h
>  create mode 100644 arch/nds32/mm/ioremap.c
>
> diff --git a/arch/nds32/include/asm/io.h b/arch/nds32/include/asm/io.h
> new file mode 100644
> index 0000000..b83dea1
> --- /dev/null
> +++ b/arch/nds32/include/asm/io.h
> @@ -0,0 +1,25 @@

> +#ifndef __ASM_NDS32_IO_H
> +#define __ASM_NDS32_IO_H
> +
> +#ifdef __KERNEL__
> +void iounmap(void __iomem * addr);
> +#include <asm-generic/io.h>
> +
> +#endif /* __KERNEL__ */
> +#endif /* __ASM_NDS32_IO_H */

Here, you should define a lot of the I/O accessor functions,
dereferencing a pointer
is generally not enough to guarantee an atomic MMIO operation. You need to
force the access to use the correct size to prevent the compiler from issuing
byte-sized operations when it thinks the pointer might be unaligned, and
there should be barriers that ensure a memory access is synchronized with
a DMA that might be triggered by a writel, or claimed to be completed after
a readl. Please see the risc-v header for this, it has many good explanations.

        Arnd
