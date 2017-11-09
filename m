From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH 28/31] irqchip: Andestech Internal Vector Interrupt
 Controller driver
Date: Thu, 9 Nov 2017 18:10:14 +0800
Message-ID: <CAEbi=3ctf0D-B3CD2HgR5AD8em+moEtB31Qg0PyMEH0V5c1B+w@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <4572b290f40d62876b83328331a17c2343710b20.1510118606.git.green.hu@gmail.com>
 <ddef1bef-4ca7-0f81-0b2b-3a48c69e199a@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <ddef1bef-4ca7-0f81-0b2b-3a48c69e199a@arm.com>
Sender: netdev-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Rick Chen <rick@andestech.com>
List-Id: linux-arch.vger.kernel.org

2017-11-08 22:24 GMT+08:00 Marc Zyngier <marc.zyngier@arm.com>:
> On 08/11/17 05:55, Greentime Hu wrote:
>> From: Greentime Hu <greentime@andestech.com>
>>
>
> Please add a commit message, indicating what this does, and potentially
> a pointer to some documentation (if publicly available).
>

Thans.
I will add proper commit messages in the next version patch.

>> Signed-off-by: Rick Chen <rick@andestech.com>
>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>> ---
>>  drivers/irqchip/Makefile       |    1 +
>>  drivers/irqchip/irq-ativic32.c |  149 ++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 150 insertions(+)
>>  create mode 100644 drivers/irqchip/irq-ativic32.c
>>
>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>> index b842dfd..201ca9f 100644
>> --- a/drivers/irqchip/Makefile
>> +++ b/drivers/irqchip/Makefile
>> @@ -80,3 +80,4 @@ obj-$(CONFIG_ARCH_ASPEED)           += irq-aspeed-vic.o irq-aspeed-i2c-ic.o
>>  obj-$(CONFIG_STM32_EXTI)             += irq-stm32-exti.o
>>  obj-$(CONFIG_QCOM_IRQ_COMBINER)              += qcom-irq-combiner.o
>>  obj-$(CONFIG_IRQ_UNIPHIER_AIDET)     += irq-uniphier-aidet.o
>> +obj-$(CONFIG_NDS32)                  += irq-ativic32.o
>> diff --git a/drivers/irqchip/irq-ativic32.c b/drivers/irqchip/irq-ativic32.c
>> new file mode 100644
>> index 0000000..d3dae59
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-ativic32.c
>> @@ -0,0 +1,149 @@
>> +/*
>> + * Copyright (C) 2005-2017 Andes Technology Corporation
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include <linux/irq.h>
>> +#include <linux/of.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/of_address.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/irqchip.h>
>> +#include <nds32_intrinsic.h>
>> +
>> +static void ativic32_ack_irq(struct irq_data *data)
>> +{
>> +     __nds32__mtsr_dsb(1 << data->hwirq, NDS32_SR_INT_PEND2);
>> +}
>> +
>> +static void ativic32_mask_irq(struct irq_data *data)
>> +{
>> +     unsigned long int_mask2 = __nds32__mfsr(NDS32_SR_INT_MASK2);
>> +     __nds32__mtsr_dsb(int_mask2 & (~(1 << data->hwirq)), NDS32_SR_INT_MASK2);
>> +}
>> +
>> +static void ativic32_mask_ack_irq(struct irq_data *data)
>> +{
>> +     unsigned long int_mask2 = __nds32__mfsr(NDS32_SR_INT_MASK2);
>> +     __nds32__mtsr_dsb(int_mask2 & (~(1 << data->hwirq)), NDS32_SR_INT_MASK2);
>> +     __nds32__mtsr_dsb((1 << data->hwirq), NDS32_SR_INT_PEND2);
>> +
>> +}
>> +
>> +static void ativic32_unmask_irq(struct irq_data *data)
>> +{
>> +     unsigned long int_mask2 = __nds32__mfsr(NDS32_SR_INT_MASK2);
>> +     __nds32__mtsr_dsb(int_mask2 | (1 << data->hwirq), NDS32_SR_INT_MASK2);
>> +}
>> +
>> +static int ativic32_set_type(struct irq_data *data, unsigned int flow_type)
>> +{
>> +     printk(KERN_WARNING "interrupt type is not configurable\n");
>
> If it is not configurable, what is the point of having each interrupt
> carry a trigger type in DT?

Make sense.
We should remove this function and DT trigger type description.

>> +     return 0;
>> +}
>> +
>> +static struct irq_chip ativic32_chip = {
>> +     .name = "ativic32",
>> +     .irq_ack = ativic32_ack_irq,
>> +     .irq_mask = ativic32_mask_irq,
>> +     .irq_mask_ack = ativic32_mask_ack_irq,
>> +     .irq_unmask = ativic32_unmask_irq,
>> +     .irq_set_type = ativic32_set_type,
>> +};
>> +
>> +static unsigned int __initdata nivic_map[6] = { 6, 2, 10, 16, 24, 32 };
>> +
>> +struct irq_domain *root_domain;
>
> Why isn't this static? Is there anything accessing it from outside of
> this driver?

Thanks.
I will check if it is not used outside and add static in the next version patch.

>> +static int ativic32_irq_domain_map(struct irq_domain *id, unsigned int virq,
>> +                               irq_hw_number_t hw)
>> +{
>> +
>> +     unsigned long int_trigger_type;
>> +     int_trigger_type = __nds32__mfsr(NDS32_SR_INT_TRIGGER);
>> +     if (int_trigger_type & (1 << hw))
>> +             irq_set_chip_and_handler(virq, &ativic32_chip, handle_edge_irq);
>> +     else
>> +             irq_set_chip_and_handler(virq, &ativic32_chip, handle_level_irq);
>> +
>> +     return 0;
>> +}
>> +
>> +static struct irq_domain_ops ativic32_ops = {
>> +     .map = ativic32_irq_domain_map,
>> +     .xlate = irq_domain_xlate_onecell
>
> Huh... Your DT binding insist on two cells, and yet...

Thanks.
It is inconsistent. We will fix it in the next version patch.

>> +};
>> +
>> +static int get_intr_src(void)
>> +{
>> +     return ((__nds32__mfsr(NDS32_SR_ITYPE)&ITYPE_mskVECTOR) >> ITYPE_offVECTOR)
>> +             - NDS32_VECTOR_offINTERRUPT;
>> +}
>> +
>> +asmlinkage void asm_do_IRQ(struct pt_regs *regs)
>> +{
>> +     struct pt_regs *old_regs = set_irq_regs(regs);
>> +     int virq;
>> +     int irq = get_intr_src();
>> +
>> +     /*
>> +      * Some hardware gives randomly wrong interrupts.  Rather
>> +      * than crashing, do something sensible.
>> +      */
>> +     if (unlikely(irq >= NR_IRQS)) {
>> +             pr_emerg( "IRQ exceeds NR_IRQS\n");
>> +             BUG();
>
> Given the above comment, I find this hilarious!

Thanks.
We will write more proper comments.

>> +     }
>> +
>> +     irq_enter();
>> +     virq = irq_find_mapping(root_domain, irq);
>> +     generic_handle_irq(virq);
>> +     irq_exit();
>> +     set_irq_regs(old_regs);
>
> Why can't you use handle_domain_irq() directly instead of what looks
> like a copy of it (this is where the comment comes from...)?

Thanks.
We will try to use handle_domain_irq() in the next version patch.

>> +
>> +}
>> +
>> +int __init ativic32_init_irq(struct device_node *node, struct device_node *parent)
>> +{
>> +     unsigned long int_vec_base, nivic, i;
>> +
>> +     if (WARN(parent, "non-root ativic32 are not supported"))
>> +             return -EINVAL;
>> +
>> +     int_vec_base = __nds32__mfsr(NDS32_SR_IVB);
>> +
>> +     if (((int_vec_base & IVB_mskIVIC_VER) >> IVB_offIVIC_VER) == 0) {
>> +             panic("Unable to use NOINTC option to boot on this cpu\n");
>> +     }
>> +
>> +     nivic = (int_vec_base & IVB_mskNIVIC) >> IVB_offNIVIC;
>> +     if (nivic >= (sizeof nivic_map / sizeof nivic_map[0])) {
>> +             panic
>> +                 ("The number of input for IVIC Controller is not supported on this cpu\n");
>
> Irk. Please leave this on a single line... Or better yet, get rid of it
> (see below).

Thanks.
We will fix it in the next version patch.

>> +     }
>> +     nivic = nivic_map[nivic];
>
> If you have multiple configurations, I'd rather they live in DT,
> specially if the IP is easily configurable.

Thanks.
But this is read from HW register. IMHO it will be more readable if we
read this
config from HW and do the relative actions.

>> +
>> +     root_domain = irq_domain_add_linear(node, nivic,
>> +                     &ativic32_ops, NULL);
>> +
>> +     if (!root_domain)
>> +             panic("%s: unable to create IRQ domain\n", node->full_name);
>> +
>> +     for(i = 0; i < nivic; i++)
>> +             irq_create_mapping(root_domain, i);
>
> You shouldn't need this, as the core DT code will populate the interrupt
> on demand.

Thanks.
We will fix it in the next version patch.

>> +
>> +     return 0;
>> +
>> +}
>> +IRQCHIP_DECLARE(ativic32, "andestech,ativic32", ativic32_init_irq);
>>
>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...
