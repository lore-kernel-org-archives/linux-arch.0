From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 17/40] metag: IRQ handling
Date: Fri, 9 Nov 2012 14:12:58 +0000
Message-ID: <201211091412.58733.arnd@arndb.de>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <1351700061-7203-18-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:50586 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405Ab2KIONF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Nov 2012 09:13:05 -0500
In-Reply-To: <1351700061-7203-18-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org

On Wednesday 31 October 2012, James Hogan wrote:

> diff --git a/arch/metag/include/asm/irq.h b/arch/metag/include/asm/irq.h
> new file mode 100644
> index 0000000..da24886
> --- /dev/null
> +++ b/arch/metag/include/asm/irq.h
> +#ifndef HW_IRQS
> +#define HW_IRQS  (HWSTATMETA_OFFSET_MAX + HWSTATEXT_OFFSET_MAX + \
> +		HWSTATEXT2_OFFSET_MAX + HWSTATEXT4_OFFSET_MAX + \
> +		HWSTATEXT6_OFFSET_MAX)
> +#endif
> +
> +#define META_IRQS 32
> +
> +#define NR_IRQS (META_IRQS + HW_IRQS)

I think you should use sparse IRQs right from the start and avoid
hardcoding interrupt numbers from the start.

> +/**
> + * meta_intc_stat_addr() - Get the address of a HWSTATEXT register
> + * @hw:		Hardware IRQ number (within external trigger block)
> + *
> + * Returns:	Address of a HWSTATEXT register containing the status bit for
> + *		the specified hardware IRQ number
> + */
> +static void __iomem *meta_intc_stat_addr(irq_hw_number_t hw)
> +{
> +	return (void __iomem *)(HWSTATEXT +
> +				HWSTAT_STRIDE * meta_intc_bank(hw));
> +}

Hardcoding register addresses like this is considered bad style, even for
an interrupt controller. Better use ioremap to initialize a pointer
dynamically at boot time.

> +struct irq_chip meta_intc_edge_chip = {
> +	.irq_startup		= meta_intc_startup_irq,
> +	.irq_shutdown		= meta_intc_shutdown_irq,
> +	.irq_ack		= meta_intc_ack_irq,
> +	.irq_mask		= meta_intc_mask_irq,
> +	.irq_unmask		= meta_intc_unmask_irq,
> +	.irq_set_type		= meta_intc_irq_set_type,
> +	.irq_set_affinity	= meta_intc_set_affinity,
> +	.flags			= META_INTC_CHIP_FLAGS,
> +};
> +
> +struct irq_chip meta_intc_level_chip = {
> +	.irq_startup		= meta_intc_startup_irq,
> +	.irq_shutdown		= meta_intc_shutdown_irq,
> +	.irq_set_type		= meta_intc_irq_set_type,
> +	.irq_mask		= meta_intc_mask_irq,
> +	.irq_unmask		= meta_intc_unmask_irq,
> +	.irq_set_affinity	= meta_intc_set_affinity,
> +	.flags			= META_INTC_CHIP_FLAGS,
> +};

I would recommend trying to put the external irq_chip code into
drivers/irqchip, which we are currently establishing. Right now,
that directory is still a bit dependent on the ARM architecture,
but IMHO that is an even stronger reason to use it for a new
architecture, so we can make it arch independent in the process,
without the fear of breaking existing users. After it works
on multiple architectures, we can start migrating the others.

	Arnd
