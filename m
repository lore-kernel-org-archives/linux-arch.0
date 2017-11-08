From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 05/31] nds32: MMU definitions
Date: Wed, 8 Nov 2017 09:36:18 +0100
Message-ID: <CAK8P3a0rHbjQw=z1mHoUDWfnzUBH+QE1CFOc4T7-rkOMM-SkLQ@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <e0cf5501a9c31252f9d082ffe191f3e90cd4df6a.1510118606.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e0cf5501a9c31252f9d082ffe191f3e90cd4df6a.1510118606.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 8, 2017 at 6:54 AM, Greentime Hu <green.hu@gmail.com> wrote:

> +/*
> + * The DMA mask corresponding to the maximum bus address allocatable
> + * using GFP_DMA.  The default here places no restriction on DMA
> + * allocations.  This must be the smallest DMA mask in the system,
> + * so a successful GFP_DMA allocation will always satisfy this.
> + */
> +#ifndef ISA_DMA_THRESHOLD
> +#define ISA_DMA_THRESHOLD      (0xffffffffULL)
> +#endif

I see this one only in powerpc, I think it can be removed.

> +
> +/*
> + * Optional device DMA address remapping. Do _not_ use directly!
> + * We should really eliminate virt_to_bus() here - it's deprecated.
> + */
> +#define page_to_dma(dev, page)         ((dma_addr_t)__virt_to_phys((unsigned long)page_address(page)))
> +#define dma_to_virt(dev, addr)         ((void *)__phys_to_virt(addr))
> +#define virt_to_dma(dev, addr)         ((dma_addr_t)__virt_to_phys((unsigned long)(addr)))

This looks like an older comment, I think we have eliminated them from the
mainline kernel in all drivers, so you should remove them here too.

> diff --git a/arch/nds32/include/asm/shmparam.h b/arch/nds32/include/asm/shmparam.h
> new file mode 100644
> index 0000000..5679648
> --- /dev/null
> +++ b/arch/nds32/include/asm/shmparam.h

> +
> +/*
> + * This should be the size of the virtually indexed cache/ways,
> + * whichever is greater since the cache aliases every size/ways
> + * bytes.
> + */
> +#define        SHMLBA  (4 * PAGE_SIZE) /* attach addr a multiple of this */
> +#define        REALSHMLBA      SHMLBA

I don't see REALSHMLBA anywhere in the kernel, do you need it?

For SHMLBA, I think it should be defined as an absolute number, using
the maximum
that you might need for any possible value of PAGE_SIZE. Otherwise user space
has a much harder time figuring out what it should use.

        Arnd
