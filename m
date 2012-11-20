From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 17/40] metag: IRQ handling
Date: Tue, 20 Nov 2012 16:08:08 +0000
Message-ID: <50ABAAE8.6070108@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <1351700061-7203-18-git-send-email-james.hogan@imgtec.com> <201211091412.58733.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:56802 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752572Ab2KTQId (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 20 Nov 2012 11:08:33 -0500
In-Reply-To: <201211091412.58733.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

On 09/11/12 14:12, Arnd Bergmann wrote:
> On Wednesday 31 October 2012, James Hogan wrote:
> 
>> diff --git a/arch/metag/include/asm/irq.h b/arch/metag/include/asm/irq.h
>> new file mode 100644
>> index 0000000..da24886
>> --- /dev/null
>> +++ b/arch/metag/include/asm/irq.h
>> +#ifndef HW_IRQS
>> +#define HW_IRQS  (HWSTATMETA_OFFSET_MAX + HWSTATEXT_OFFSET_MAX + \
>> +		HWSTATEXT2_OFFSET_MAX + HWSTATEXT4_OFFSET_MAX + \
>> +		HWSTATEXT6_OFFSET_MAX)
>> +#endif
>> +
>> +#define META_IRQS 32
>> +
>> +#define NR_IRQS (META_IRQS + HW_IRQS)
> 
> I think you should use sparse IRQs right from the start and avoid
> hardcoding interrupt numbers from the start.

I presume core irq numbers need hard coding (e.g. those required by core
code like cross-hardware-thread irqs and perf counters)? Or would the
recommended way be to have a function which is given the core hw irq
number and converts/maps a virtual irq for it using the irq domain?

>> +/**
>> + * meta_intc_stat_addr() - Get the address of a HWSTATEXT register
>> + * @hw:		Hardware IRQ number (within external trigger block)
>> + *
>> + * Returns:	Address of a HWSTATEXT register containing the status bit for
>> + *		the specified hardware IRQ number
>> + */
>> +static void __iomem *meta_intc_stat_addr(irq_hw_number_t hw)
>> +{
>> +	return (void __iomem *)(HWSTATEXT +
>> +				HWSTAT_STRIDE * meta_intc_bank(hw));
>> +}
> 
> Hardcoding register addresses like this is considered bad style, even for
> an interrupt controller. Better use ioremap to initialize a pointer
> dynamically at boot time.

All these registers are part of the core Meta registers in the non-MMU
region and so are always fixed. I have altered this file to use
metag_in32/metag_out32 instead of readl/writel to make that clearer.

>> +struct irq_chip meta_intc_edge_chip = {
>> +	.irq_startup		= meta_intc_startup_irq,
>> +	.irq_shutdown		= meta_intc_shutdown_irq,
>> +	.irq_ack		= meta_intc_ack_irq,
>> +	.irq_mask		= meta_intc_mask_irq,
>> +	.irq_unmask		= meta_intc_unmask_irq,
>> +	.irq_set_type		= meta_intc_irq_set_type,
>> +	.irq_set_affinity	= meta_intc_set_affinity,
>> +	.flags			= META_INTC_CHIP_FLAGS,
>> +};
>> +
>> +struct irq_chip meta_intc_level_chip = {
>> +	.irq_startup		= meta_intc_startup_irq,
>> +	.irq_shutdown		= meta_intc_shutdown_irq,
>> +	.irq_set_type		= meta_intc_irq_set_type,
>> +	.irq_mask		= meta_intc_mask_irq,
>> +	.irq_unmask		= meta_intc_unmask_irq,
>> +	.irq_set_affinity	= meta_intc_set_affinity,
>> +	.flags			= META_INTC_CHIP_FLAGS,
>> +};
> 
> I would recommend trying to put the external irq_chip code into
> drivers/irqchip, which we are currently establishing. Right now,
> that directory is still a bit dependent on the ARM architecture,
> but IMHO that is an even stronger reason to use it for a new
> architecture, so we can make it arch independent in the process,
> without the fear of breaking existing users. After it works
> on multiple architectures, we can start migrating the others.

I'll look into this.

Thanks
James
