From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 27/35] irqchip: Andestech Internal Vector Interrupt Controller driver
Date: Thu, 30 Nov 2017 10:57:24 +0000
Message-ID: <86vahs2fvv.fsf@unassigned-hostname.unassigned-domain>
References: <cover.1511785528.git.green.hu@gmail.com>
        <e82831165cd9e45a7d03af9c870560a6384e1603.1511785528.git.green.hu@gmail.com>
        <c7447c93-9905-2840-e2d8-01837b9fdecd@arm.com>
        <CAEbi=3eXP1cfNDhu9YjZbjPghgxm9xmEtjEBO=KVOnWZyPqVbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEbi=3eXP1cfNDhu9YjZbjPghgxm9xmEtjEBO=KVOnWZyPqVbw@mail.gmail.com>
        (Greentime Hu's message of "Wed, 29 Nov 2017 23:23:34 +0800")
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Rick Chen <rick@andestech.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 29 2017 at 11:23:34 pm GMT, Greentime Hu <green.hu@gmail.com> wrote:

Hi Greentime,

>>> +}
>>> +
>>> +static void ativic32_mask_ack_irq(struct irq_data *data)
>>> +{
>>> +     unsigned long int_mask2 = __nds32__mfsr(NDS32_SR_INT_MASK2);
>>> + __nds32__mtsr_dsb(int_mask2 & (~(1 << data->hwirq)),
>>> NDS32_SR_INT_MASK2);
>>> +     __nds32__mtsr_dsb((1 << data->hwirq), NDS32_SR_INT_PEND2);
>>
>> This is effectively MASK+ACK, so you're better off just writing it as
>> such. And since there is no advantage in your implementation in having
>> MASK_ACK over MASK+ACK, I suggest you remove this function completely,
>> and rely on the core code which will call them in sequence.
>
> I think mask_ack is still better than mask + ack because we don't need
> to do two function call.
> We can save a prologue and a epilogue. It will benefit interrupt latency.

Can you actually measure this? Your CPU would have to be extremely slow
if you could see the impact of an extra function call on interrupt
latency. From a maintenance perspective, this isn't very nice (it is
effectively code duplication).

I suggest you start with the simplest version of the code, and provide
an optimisation once you can measurably demonstrate that mask_ack is
better.

[...]

>>> + irq_set_chip_and_handler(virq, &ativic32_chip, handle_edge_irq);
>>> +     else
>>> + irq_set_chip_and_handler(virq, &ativic32_chip, handle_level_irq);
>>
>> Since you do not express the trigger in DT, you need to tell the core
>> about it by calling irqd_set_trigger_type() with the right setting.
>>
>
> Since the comments say so, I will add ativic32_set_type() for irq_set_type()
> in the next version patch.
>
> /*
>  * Must only be called inside irq_chip.irq_set_type() functions.
>  */
> static inline void irqd_set_trigger_type(struct irq_data *d, u32 type)
> {
>         __irqd_to_state(d) &= ~IRQD_TRIGGER_MASK;
>         __irqd_to_state(d) |= type & IRQD_TRIGGER_MASK;
> }
>
> It will be like this.
> static int ativic32_set_type(struct irq_data *data, unsigned int flow_type)
> {
>         irqd_set_trigger_type(data, flow_type);
>         return IRQ_SET_MASK_OK;
> }

This feels wrong. Your interrupt controller doesn't seem to support the
trigger being changed, so irq_set_type would be a bit pointless. A
driver trying to set a level trigger on an edge interrupt would succeed,
and that is as bad as it gets. All you need is to expose the capability
of the HW when you register the flow handler instead of adding a rather
misleading callback.

Thanks,

	M.
-- 
Jazz is not dead, it just smell funny.
