From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 27/35] irqchip: Andestech Internal Vector Interrupt
 Controller driver
Date: Tue, 28 Nov 2017 09:37:21 +0000
Message-ID: <c7447c93-9905-2840-e2d8-01837b9fdecd@arm.com>
References: <cover.1511785528.git.green.hu@gmail.com>
 <e82831165cd9e45a7d03af9c870560a6384e1603.1511785528.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e82831165cd9e45a7d03af9c870560a6384e1603.1511785528.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-GB
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Rick Chen <rick-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On 27/11/17 12:28, Greentime Hu wrote:
> From: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
> 
> This patch adds the Andestech Internal Vector Interrupt Controller
> driver. You can find the spec here. Ch4.9 of AndeStar SPA V3 Manual.
> http://www.andestech.com/product.php?cls=9
> 
> Signed-off-by: Rick Chen <rick-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
> Signed-off-by: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
> ---
>  drivers/irqchip/Makefile       |    1 +
>  drivers/irqchip/irq-ativic32.c |  119 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 120 insertions(+)
>  create mode 100644 drivers/irqchip/irq-ativic32.c
> 
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index b842dfd..201ca9f 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -80,3 +80,4 @@ obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o
>  obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
>  obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
>  obj-$(CONFIG_IRQ_UNIPHIER_AIDET)	+= irq-uniphier-aidet.o
> +obj-$(CONFIG_NDS32)			+= irq-ativic32.o
> diff --git a/drivers/irqchip/irq-ativic32.c b/drivers/irqchip/irq-ativic32.c
> new file mode 100644
> index 0000000..c4d6f86
> --- /dev/null
> +++ b/drivers/irqchip/irq-ativic32.c
> @@ -0,0 +1,119 @@
> +/*
> + * Copyright (C) 2005-2017 Andes Technology Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/irq.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_address.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqdomain.h>
> +#include <linux/irqchip.h>
> +#include <nds32_intrinsic.h>
> +
> +static void ativic32_ack_irq(struct irq_data *data)
> +{
> +	__nds32__mtsr_dsb(1 << data->hwirq, NDS32_SR_INT_PEND2);

Consider writing (1 << data->hwirq) as BIT(data->hwirq).

> +}
> +
> +static void ativic32_mask_irq(struct irq_data *data)
> +{
> +	unsigned long int_mask2 = __nds32__mfsr(NDS32_SR_INT_MASK2);
> +	__nds32__mtsr_dsb(int_mask2 & (~(1 << data->hwirq)), NDS32_SR_INT_MASK2);

Same here.

> +}
> +
> +static void ativic32_mask_ack_irq(struct irq_data *data)
> +{
> +	unsigned long int_mask2 = __nds32__mfsr(NDS32_SR_INT_MASK2);
> +	__nds32__mtsr_dsb(int_mask2 & (~(1 << data->hwirq)), NDS32_SR_INT_MASK2);
> +	__nds32__mtsr_dsb((1 << data->hwirq), NDS32_SR_INT_PEND2);

This is effectively MASK+ACK, so you're better off just writing it as
such. And since there is no advantage in your implementation in having
MASK_ACK over MASK+ACK, I suggest you remove this function completely,
and rely on the core code which will call them in sequence.

> +
> +}
> +
> +static void ativic32_unmask_irq(struct irq_data *data)
> +{
> +	unsigned long int_mask2 = __nds32__mfsr(NDS32_SR_INT_MASK2);
> +	__nds32__mtsr_dsb(int_mask2 | (1 << data->hwirq), NDS32_SR_INT_MASK2);

Same BIT() here.

> +}
> +
> +static struct irq_chip ativic32_chip = {
> +	.name = "ativic32",
> +	.irq_ack = ativic32_ack_irq,
> +	.irq_mask = ativic32_mask_irq,
> +	.irq_mask_ack = ativic32_mask_ack_irq,
> +	.irq_unmask = ativic32_unmask_irq,
> +};
> +
> +static unsigned int __initdata nivic_map[6] = { 6, 2, 10, 16, 24, 32 };
> +
> +static struct irq_domain *root_domain;
> +static int ativic32_irq_domain_map(struct irq_domain *id, unsigned int virq,
> +				  irq_hw_number_t hw)
> +{
> +
> +	unsigned long int_trigger_type;
> +	int_trigger_type = __nds32__mfsr(NDS32_SR_INT_TRIGGER);
> +	if (int_trigger_type & (1 << hw))

And here.

> +		irq_set_chip_and_handler(virq, &ativic32_chip, handle_edge_irq);
> +	else
> +		irq_set_chip_and_handler(virq, &ativic32_chip, handle_level_irq);

Since you do not express the trigger in DT, you need to tell the core
about it by calling irqd_set_trigger_type() with the right setting.

> +
> +	return 0;
> +}
> +
> +static struct irq_domain_ops ativic32_ops = {
> +	.map = ativic32_irq_domain_map,
> +	.xlate = irq_domain_xlate_onecell
> +};
> +
> +static int get_intr_src(void)

I'm not sure "int" is the best return type here. I suspect something
unsigned would be preferable, or even the irq_hw_number_t type.
> +{
> +	return ((__nds32__mfsr(NDS32_SR_ITYPE)&ITYPE_mskVECTOR) >> ITYPE_offVECTOR)

Spaces around '&'.

> +		- NDS32_VECTOR_offINTERRUPT;
> +}
> +
> +asmlinkage void asm_do_IRQ(struct pt_regs *regs)
> +{
> +	int hwirq = get_intr_src();

irq_hw_number_t.

> +	handle_domain_irq(root_domain, hwirq, regs);
> +}
> +
> +int __init ativic32_init_irq(struct device_node *node, struct device_node *parent)
> +{
> +	unsigned long int_vec_base, nivic;
> +
> +	if (WARN(parent, "non-root ativic32 are not supported"))
> +		return -EINVAL;
> +
> +	int_vec_base = __nds32__mfsr(NDS32_SR_IVB);
> +
> +	if (((int_vec_base & IVB_mskIVIC_VER) >> IVB_offIVIC_VER) == 0)
> +		panic("Unable to use atcivic32 for this cpu.\n");
> +
> +	nivic = (int_vec_base & IVB_mskNIVIC) >> IVB_offNIVIC;
> +	if (nivic >= (sizeof nivic_map / sizeof nivic_map[0]))

This should be:
	if (nivic >= ARRAY_SIZE(NIVIC_MAP))

> +		panic("The number of input for ativic32 is not supported.\n");
> +
> +	nivic = nivic_map[nivic];

I'd rather you use another variable (nr_ints?).

> +
> +	root_domain = irq_domain_add_linear(node, nivic,
> +			&ativic32_ops, NULL);
> +
> +	if (!root_domain)
> +		panic("%s: unable to create IRQ domain\n", node->full_name);
> +
> +	return 0;
> +}
> +IRQCHIP_DECLARE(ativic32, "andestech,ativic32", ativic32_init_irq);
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
