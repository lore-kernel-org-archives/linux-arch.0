From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 10/17] irqchip: New RISC-V PLIC Driver
Date: Sun, 25 Jun 2017 13:49:28 -0700 (PDT)
Message-ID: <mhng-e905dce4-0c11-48b3-baee-91938590de40@palmer-si-x1c4>
References: <34ebb0fd-8d8b-3ec7-ecf1-f296e878bd5d@arm.com>
Mime-Version: 1.0 (MHng)
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33036 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbdFYUta (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Jun 2017 16:49:30 -0400
Received: by mail-pf0-f194.google.com with SMTP id e199so4782370pfh.0
        for <linux-arch@vger.kernel.org>; Sun, 25 Jun 2017 13:49:30 -0700 (PDT)
In-Reply-To: <34ebb0fd-8d8b-3ec7-ecf1-f296e878bd5d@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: marc.zyngier@arm.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, albert@sifive.com, patches@groups.riscv.org, will.deacon@arm.com, peterz@infradead.org

On Wed, 07 Jun 2017 03:52:10 PDT (-0700), marc.zyngier@arm.com wrote:
> Hi Palmer,
>
> On 07/06/17 00:00, Palmer Dabbelt wrote:
>> This patch adds a driver for the Platform Level Interrupt Controller
>> (PLIC) specified as part of the RISC-V supervisor level ISA manual.
>> The PLIC connocts global interrupt sources to the local interrupt
>> controller on each hart.  A PLIC is present on all RISC-V systems.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
>> ---
>>  drivers/irqchip/Kconfig          |  12 ++
>>  drivers/irqchip/Makefile         |   1 +
>>  drivers/irqchip/irq-riscv-plic.c | 253 +++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 266 insertions(+)
>>  create mode 100644 drivers/irqchip/irq-riscv-plic.c
>>
>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>> index 478f8ace2664..2906d63934ef 100644
>> --- a/drivers/irqchip/Kconfig
>> +++ b/drivers/irqchip/Kconfig
>> @@ -301,3 +301,15 @@ config QCOM_IRQ_COMBINER
>>  	help
>>  	  Say yes here to add support for the IRQ combiner devices embedded
>>  	  in Qualcomm Technologies chips.
>> +
>> +config RISCV_PLIC
>> +        bool "Platform-Level Interrupt Controller"
>> +	depends on RISCV
>> +        default y
>> +        help
>> +	   This enables support for the PLIC chip found in standard RISC-V
>> +	   systems. The PLIC is the top-most interrupt controller found in
>
> nit: this seems to slightly contradict what is being said in patch #8,
> where the HLIC is the top-level interrupt controller.

Sorry, I guess that was a bit confusing: by "top-level interrupt controller
found in the system" I meant the stuff outside the core complex -- in other
words, all the devices.  How does this sound instead?

    This enables support for the PLIC chip found in standard RISC-V
    systems.  The PLIC controls devices interrupts and connects them to
    each core's local interrupt controller.  Aside from timer and
    software interrupts, all other interrupt sources (MSI, GPIO, etc)
    are subordinate to the PLIC.

https://github.com/riscv/riscv-linux/commit/2395b17a36c3cf5aabd9b019e1f8fc7efe67e9a0

>> +	   the system, connected directly to the core complex. All other
>> +	   interrupt sources (MSI, GPIO, etc) are subordinate to the PLIC.
>> +
>> +	   If you don't know what to do here, say Y.
>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>> index b64c59b838a0..bed94cc89146 100644
>> --- a/drivers/irqchip/Makefile
>> +++ b/drivers/irqchip/Makefile
>> @@ -76,3 +76,4 @@ obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
>>  obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o
>>  obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
>>  obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
>> +obj-$(CONFIG_RISCV_PLIC)		+= irq-riscv-plic.o
>> diff --git a/drivers/irqchip/irq-riscv-plic.c b/drivers/irqchip/irq-riscv-plic.c
>> new file mode 100644
>> index 000000000000..906c8a62a911
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-riscv-plic.c
>> @@ -0,0 +1,253 @@
>> +/*
>> + * Copyright (C) 2017 SiFive
>> + *
>> + *   This program is free software; you can redistribute it and/or
>> + *   modify it under the terms of the GNU General Public License
>> + *   as published by the Free Software Foundation, version 2.
>> + *
>> + *   This program is distributed in the hope that it will be useful,
>> + *   but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *   GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/irq.h>
>> +#include <linux/irqchip.h>
>> +#include <linux/irqchip/chained_irq.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/platform_device.h>
>> +
>> +/* From the RISC-V Privlidged Spec v1.10:
>> + *
>> + * Global interrupt sources are assigned small unsigned integer identifiers,
>> + * beginning at the value 1.  An interrupt ID of 0 is reserved to mean “no
>> + * interrupt”.  Interrupt identifiers are also used to break ties when two or
>> + * more interrupt sources have the same assigned priority. Smaller values of
>> + * interrupt ID take precedence over larger values of interrupt ID.
>> + *
>> + * It's not defined what the largest device ID is, so we're just fixing
>> + * MAX_DEVICES right here (which is named oddly, as there will never be a
>> + * device 0).
>> + */
>> +#define MAX_DEVICES	1024
>> +#define MAX_CONTEXTS	15872
>
> If those are HW properties, they should probably come from the device
> tree instead of being hardcoded here.

Sorry, this is a bit confusing: the RISC-V supervisor spec (which is what this
comment was about) doesn't actually specify much about the PLIC, while this
driver is for the concrete 'riscv,plic0' device (which is SiFive's PLIC
implementation, and will be part of the platform specification).  Maybe this is
a better comment?

 * While the RISC-V supervisor spec doesn't define the maximum number of
 * devices supported by the PLIC, the largest number supported by devices
 * marked as 'riscv,plic0' (which is the only device type this driver supports,
 * and is the only extant PLIC as of now) is 1024.  As mentioned above, device
 * 0 is defined to be non-existant so this device really only supports 1023
 * devices.

https://github.com/riscv/riscv-linux/commit/ef43982522f84874be3dfba24f5acb57ad0d9186

>> +
>> +#define PRIORITY_BASE	0
>> +#define ENABLE_BASE	0x2000
>> +#define ENABLE_SIZE	0x80
>> +#define HART_BASE	0x200000
>> +#define HART_SIZE	0x1000
>> +
>> +struct plic_hart_context {
>> +	u32 threshold;
>> +	u32 claim;
>> +};
>
> Representing HW layout as a C structure is not something we usually do
> in the kernel. It relies on the ABI (which may change over time), and
> makes it harder to quickly distinguish what is a SW concept from what's
> not. It also leads to some of the mistakes below...

OK, makes sense.  I went ahead and removed

>> +
>> +struct plic_enable_context {
>> +	atomic_t mask[32]; // 32-bit * 32-entry
>
> /* */ comments please, placed above the field.
>
>> +};
>> +
>> +struct plic_priority {
>> +	u32 prio[MAX_DEVICES];
>> +};
>> +
>> +struct plic_data {
>> +	struct irq_chip		chip;
>> +	struct irq_domain	*domain;
>> +	u32			ndev;
>> +	void __iomem		*reg;
>> +	int			handlers;
>> +	struct plic_handler	*handler;
>> +	char			name[30];
>
> Why 30? #define?
>
>> +};
>> +
>> +struct plic_handler {
>> +	struct plic_hart_context	*context;
>> +	struct plic_data		*data;
>> +};
>> +
>> +static inline
>> +struct plic_hart_context *plic_hart_context(struct plic_data *data, size_t i)
>
> What is 'i' here?
>
>> +{
>> +	return (struct plic_hart_context *)((char *)data->reg + HART_BASE + HART_SIZE*i);
>
> This looks dodgy on a number of levels:
> - the various levels of casts are useless
> - what you return is still an __iomem
>
> Sparse would certainly shout at you if you ran it on this file.
>
> Same comment for the two functions below.
>
>> +}
>> +
>> +static inline
>> +struct plic_enable_context *plic_enable_context(struct plic_data *data, size_t i)
>> +{
>> +	return (struct plic_enable_context *)((char *)data->reg + ENABLE_BASE + ENABLE_SIZE*i);
>> +}
>> +
>> +static inline
>> +struct plic_priority *plic_priority(struct plic_data *data)
>> +{
>> +	return (struct plic_priority *)((char *)data->reg + PRIORITY_BASE);
>> +}
>> +
>> +static void plic_disable(struct plic_data *data, int i, int hwirq)
>> +{
>> +	struct plic_enable_context *enable = plic_enable_context(data, i);
>> +
>> +	atomic_and(~(1 << (hwirq % 32)), &enable->mask[hwirq / 32]);
>
> This is still a device access, right? What does it mean to use the
> atomic primitives on that? What are you racing against? I thought the
> various context were private to an execution context...
>
> Adding Will and PeterZ to the CC list because they will probably have
> their own views on this...
>
>> +}
>> +
>> +static void plic_enable(struct plic_data *data, int i, int hwirq)
>> +{
>> +	struct plic_enable_context *enable = plic_enable_context(data, i);
>> +
>> +	atomic_or((1 << (hwirq % 32)), &enable->mask[hwirq / 32]);
>> +}
>> +
>> +// There is no need to mask/unmask PLIC interrupts
>> +// They are "masked" by reading claim and "unmasked" when writing it back.
>
> Hmmm. What you describe here is the FastEOI flow.
>
>> +static void plic_irq_mask(struct irq_data *d) { }
>> +static void plic_irq_unmask(struct irq_data *d) { }
>> +
>> +static void plic_irq_enable(struct irq_data *d)
>> +{
>> +	struct plic_data *data = irq_data_get_irq_chip_data(d);
>> +	struct plic_priority *priority = plic_priority(data);
>> +	int i;
>> +
>> +	iowrite32(1, &priority->prio[d->hwirq]);
>
> Using iowrite is only meaningful if your architecture has an actual I/O
> address space that is distinct from the "normal" address space. Using
> the write{b,w,l}{_relaxed} accessors would make more sense if you're not
> in that case.
>
>> +	for (i = 0; i < data->handlers; ++i)
>> +		if (data->handler[i].context)
>> +			plic_enable(data, i, d->hwirq);
>> +}
>> +
>> +static void plic_irq_disable(struct irq_data *d)
>> +{
>> +	struct plic_data *data = irq_data_get_irq_chip_data(d);
>> +	struct plic_priority *priority = plic_priority(data);
>> +	int i;
>> +
>> +	iowrite32(0, &priority->prio[d->hwirq]);
>> +	for (i = 0; i < data->handlers; ++i)
>> +		if (data->handler[i].context)
>> +			plic_disable(data, i, d->hwirq);
>> +}
>> +
>> +static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
>> +			      irq_hw_number_t hwirq)
>> +{
>> +	struct plic_data *data = d->host_data;
>> +
>> +	irq_set_chip_and_handler(irq, &data->chip, handle_simple_irq);
>> +	irq_set_chip_data(irq, data);
>> +	irq_set_noprobe(irq);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct irq_domain_ops plic_irqdomain_ops = {
>> +	.map	= plic_irqdomain_map,
>> +	.xlate	= irq_domain_xlate_onecell,
>> +};
>> +
>> +static void plic_chained_handle_irq(struct irq_desc *desc)
>> +{
>> +	struct plic_handler *handler = irq_desc_get_handler_data(desc);
>> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>> +	struct irq_domain *domain = handler->data->domain;
>> +	u32 what;
>> +
>> +	chained_irq_enter(chip, desc);
>> +
>> +	while ((what = ioread32(&handler->context->claim))) {
>> +		int irq = irq_find_mapping(domain, what);
>> +
>> +		if (irq > 0)
>> +			generic_handle_irq(irq);
>> +		else
>> +			handle_bad_irq(desc);
>> +		iowrite32(what, &handler->context->claim);
>
> So this is your EOI. It should be represented as such, instead of
> abusing the handle_simple_irq flow.

OK, I think that makes sense.  From my understanding of this, when using the
FastEOI flow we'll get a callback to our irq_eoi at the end of handling the IRQ
via generic_handle_irq.  If I've understood everything correctly then I think
this should do it

  https://github.com/riscv/riscv-linux/commit/c2cf592609eb927e3eef60876ca78f73538af69a

Note that I haven't tested it yet, so I probably managed to screw something up...

The one thing I'm still confused about is: what is the difference between
masking an IRQ and disabling an IRQ, and are our empty mask/unmask functions
obsolete in the FastEOI flow?

>> +	}
>> +
>> +	chained_irq_exit(chip, desc);
>> +}
>> +
>> +static int plic_init(struct device_node *node, struct device_node *parent)
>> +{
>> +	struct plic_data *data;
>> +	struct resource resource;
>> +	int i, ok = 0;
>> +
>> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
>> +	if (WARN_ON(!data))
>> +		return -ENOMEM;
>> +
>> +	data->reg = of_iomap(node, 0);
>> +	if (WARN_ON(!data->reg))
>> +		return -EIO;
>> +
>> +	of_property_read_u32(node, "riscv,ndev", &data->ndev);
>> +	if (WARN_ON(!data->ndev))
>> +		return -EINVAL;
>> +
>> +	data->handlers = of_irq_count(node);
>> +	if (WARN_ON(!data->handlers))
>> +		return -EINVAL;
>> +
>> +	data->handler =
>> +		kcalloc(data->handlers, sizeof(*data->handler), GFP_KERNEL);
>> +	if (WARN_ON(!data->handler))
>> +		return -ENOMEM;
>> +
>> +	data->domain = irq_domain_add_linear(node, data->ndev+1, &plic_irqdomain_ops, data);
>> +	if (WARN_ON(!data->domain))
>> +		return -ENOMEM;
>
> Memory leak of data->handler and data, data->reg is still mapped...

Sorry, I should have caught that earlier.  I think this should fix it

  https://github.com/riscv/riscv-linux/commit/ce8fdac83558c1e2cfd759b9a090a6f4657e2951

>> +
>> +	of_address_to_resource(node, 0, &resource);
>> +	snprintf(data->name, sizeof(data->name),
>> +		 "riscv,plic0,%llx", resource.start);
>> +	data->chip.name = data->name;
>> +	data->chip.irq_mask = plic_irq_mask;
>> +	data->chip.irq_unmask = plic_irq_unmask;
>> +	data->chip.irq_enable = plic_irq_enable;
>> +	data->chip.irq_disable = plic_irq_disable;
>> +
>> +	for (i = 0; i < data->handlers; ++i) {
>> +		struct plic_handler *handler = &data->handler[i];
>> +		struct of_phandle_args parent;
>> +		int parent_irq, hwirq;
>> +
>> +		if (of_irq_parse_one(node, i, &parent))
>> +			continue;
>> +		// skip context holes
>> +		if (parent.args[0] == -1)
>> +			continue;
>> +
>> +		// skip any contexts that lead to inactive harts
>> +		if (of_device_is_compatible(parent.np, "riscv,cpu-intc") &&
>> +		    parent.np->parent &&
>> +		    riscv_of_processor_hart(parent.np->parent) < 0)
>> +			continue;
>> +
>> +		parent_irq = irq_create_of_mapping(&parent);
>> +		if (!parent_irq)
>> +			continue;
>> +
>> +		handler->context = plic_hart_context(data, i);
>> +		handler->data = data;
>> +		// hwirq prio must be > this to trigger an interrupt
>> +		iowrite32(0, &handler->context->threshold);
>> +
>> +		for (hwirq = 1; hwirq <= data->ndev; ++hwirq)
>> +			plic_disable(data, i, hwirq);
>> +		irq_set_chained_handler_and_data(parent_irq, plic_chained_handle_irq, handler);
>> +		++ok;
>> +	}
>> +
>> +	printk(KERN_INFO "%s: mapped %d interrupts to %d/%d handlers\n",
>> +	       data->name, data->ndev, ok, data->handlers);
>> +	WARN_ON(!ok);
>> +	return 0;
>> +}
>> +
>> +IRQCHIP_DECLARE(plic0, "riscv,plic0", plic_init);
>>
>
> In the future, please CC me (as well as Thomas Gleixner and Jason
> Cooper) on all the interrupt-controller related patches.

OK.  We'd just been keeping the RISC-V port all as one big patch set in order
to simplify our lives (for example, this v2 is the first time we had anything
outside of arch/riscv).  The big feedback has been that's the wrong way to do
it, so I'm going to start splitting everything up to try to get things to the
correct parties.

Once I get a chance to test all this I'll go and submit a patch set with our
IRQ drivers.

Thanks for reviewing our patches!
