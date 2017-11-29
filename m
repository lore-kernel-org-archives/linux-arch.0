From: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 27/35] irqchip: Andestech Internal Vector Interrupt
 Controller driver
Date: Wed, 29 Nov 2017 23:23:34 +0800
Message-ID: <CAEbi=3eXP1cfNDhu9YjZbjPghgxm9xmEtjEBO=KVOnWZyPqVbw@mail.gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <e82831165cd9e45a7d03af9c870560a6384e1603.1511785528.git.green.hu@gmail.com>
 <c7447c93-9905-2840-e2d8-01837b9fdecd@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c7447c93-9905-2840-e2d8-01837b9fdecd-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Cc: Greentime <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, netdev <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rick Chen <rick-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

Hi, Marc:

2017-11-28 17:37 GMT+08:00 Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>:
> On 27/11/17 12:28, Greentime Hu wrote:
>> +static void ativic32_ack_irq(struct irq_data *data)
>> +{
>> +     __nds32__mtsr_dsb(1 << data->hwirq, NDS32_SR_INT_PEND2);
>
> Consider writing (1 << data->hwirq) as BIT(data->hwirq).

Thanks for this suggestion. I will modify it in the next version patch.

>> +}
>> +
>> +static void ativic32_mask_irq(struct irq_data *data)
>> +{
>> +     unsigned long int_mask2 = __nds32__mfsr(NDS32_SR_INT_MASK2);
>> +     __nds32__mtsr_dsb(int_mask2 & (~(1 << data->hwirq)), NDS32_SR_INT_MASK2);
>
> Same here.

Thanks for this suggestion. I will modify it in the next version patch.

>> +}
>> +
>> +static void ativic32_mask_ack_irq(struct irq_data *data)
>> +{
>> +     unsigned long int_mask2 = __nds32__mfsr(NDS32_SR_INT_MASK2);
>> +     __nds32__mtsr_dsb(int_mask2 & (~(1 << data->hwirq)), NDS32_SR_INT_MASK2);
>> +     __nds32__mtsr_dsb((1 << data->hwirq), NDS32_SR_INT_PEND2);
>
> This is effectively MASK+ACK, so you're better off just writing it as
> such. And since there is no advantage in your implementation in having
> MASK_ACK over MASK+ACK, I suggest you remove this function completely,
> and rely on the core code which will call them in sequence.

I think mask_ack is still better than mask + ack because we don't need
to do two function call.
We can save a prologue and a epilogue. It will benefit interrupt latency.

>> +
>> +}
>> +
>> +static void ativic32_unmask_irq(struct irq_data *data)
>> +{
>> +     unsigned long int_mask2 = __nds32__mfsr(NDS32_SR_INT_MASK2);
>> +     __nds32__mtsr_dsb(int_mask2 | (1 << data->hwirq), NDS32_SR_INT_MASK2);
>
> Same BIT() here.
>
Thanks for this suggestion. I will modify it in the next version patch.

>> +}
>> +
>> +static struct irq_chip ativic32_chip = {
>> +     .name = "ativic32",
>> +     .irq_ack = ativic32_ack_irq,
>> +     .irq_mask = ativic32_mask_irq,
>> +     .irq_mask_ack = ativic32_mask_ack_irq,
>> +     .irq_unmask = ativic32_unmask_irq,
>> +};
>> +
>> +static unsigned int __initdata nivic_map[6] = { 6, 2, 10, 16, 24, 32 };
>> +
>> +static struct irq_domain *root_domain;
>> +static int ativic32_irq_domain_map(struct irq_domain *id, unsigned int virq,
>> +                               irq_hw_number_t hw)
>> +{
>> +
>> +     unsigned long int_trigger_type;
>> +     int_trigger_type = __nds32__mfsr(NDS32_SR_INT_TRIGGER);
>> +     if (int_trigger_type & (1 << hw))
>
> And here.
>
Thanks for this suggestion. I will modify it in the next version patch.

>> +             irq_set_chip_and_handler(virq, &ativic32_chip, handle_edge_irq);
>> +     else
>> +             irq_set_chip_and_handler(virq, &ativic32_chip, handle_level_irq);
>
> Since you do not express the trigger in DT, you need to tell the core
> about it by calling irqd_set_trigger_type() with the right setting.
>

Since the comments say so, I will add ativic32_set_type() for irq_set_type()
in the next version patch.

/*
 * Must only be called inside irq_chip.irq_set_type() functions.
 */
static inline void irqd_set_trigger_type(struct irq_data *d, u32 type)
{
        __irqd_to_state(d) &= ~IRQD_TRIGGER_MASK;
        __irqd_to_state(d) |= type & IRQD_TRIGGER_MASK;
}

It will be like this.
static int ativic32_set_type(struct irq_data *data, unsigned int flow_type)
{
        irqd_set_trigger_type(data, flow_type);
        return IRQ_SET_MASK_OK;
}

>> +
>> +     return 0;
>> +}
>> +
>> +static struct irq_domain_ops ativic32_ops = {
>> +     .map = ativic32_irq_domain_map,
>> +     .xlate = irq_domain_xlate_onecell
>> +};
>> +
>> +static int get_intr_src(void)
>
> I'm not sure "int" is the best return type here. I suspect something
> unsigned would be preferable, or even the irq_hw_number_t type.

Thanks for this suggestion. I will modify it in the next version patch.

>> +{
>> +     return ((__nds32__mfsr(NDS32_SR_ITYPE)&ITYPE_mskVECTOR) >> ITYPE_offVECTOR)
>
> Spaces around '&'.
>
Thanks for this suggestion. I will modify it in the next version patch.

>> +             - NDS32_VECTOR_offINTERRUPT;
>> +}
>> +
>> +asmlinkage void asm_do_IRQ(struct pt_regs *regs)
>> +{
>> +     int hwirq = get_intr_src();
>
> irq_hw_number_t.
>
Thanks for this suggestion. I will modify it in the next version patch.

>> +     handle_domain_irq(root_domain, hwirq, regs);
>> +}
>> +
>> +int __init ativic32_init_irq(struct device_node *node, struct device_node *parent)
>> +{
>> +     unsigned long int_vec_base, nivic;
>> +
>> +     if (WARN(parent, "non-root ativic32 are not supported"))
>> +             return -EINVAL;
>> +
>> +     int_vec_base = __nds32__mfsr(NDS32_SR_IVB);
>> +
>> +     if (((int_vec_base & IVB_mskIVIC_VER) >> IVB_offIVIC_VER) == 0)
>> +             panic("Unable to use atcivic32 for this cpu.\n");
>> +
>> +     nivic = (int_vec_base & IVB_mskNIVIC) >> IVB_offNIVIC;
>> +     if (nivic >= (sizeof nivic_map / sizeof nivic_map[0]))
>
> This should be:
>         if (nivic >= ARRAY_SIZE(NIVIC_MAP))
>
Thanks for this suggestion. I will modify it in the next version patch.

>> +             panic("The number of input for ativic32 is not supported.\n");
>> +
>> +     nivic = nivic_map[nivic];
>
> I'd rather you use another variable (nr_ints?).
>
Thanks for this suggestion. I will modify it in the next version patch.

>> +
>> +     root_domain = irq_domain_add_linear(node, nivic,
>> +                     &ativic32_ops, NULL);
>> +
>> +     if (!root_domain)
>> +             panic("%s: unable to create IRQ domain\n", node->full_name);
>> +
>> +     return 0;
>> +}
>> +IRQCHIP_DECLARE(ativic32, "andestech,ativic32", ativic32_init_irq);
>>
>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
