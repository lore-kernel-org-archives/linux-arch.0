From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 10/17] irqchip: New RISC-V PLIC Driver
Date: Fri, 23 Jun 2017 17:45:21 -0700 (PDT)
Message-ID: <mhng-2d0d0abd-bd5a-49dd-ba5b-9dc8a253d559@palmer-si-x1c4>
References: <CAK8P3a3n9oAjkOuS3CkMkMMmKQ8YoKYe2NzZF4yT9aoDLAnUoA@mail.gmail.com>
Mime-Version: 1.0 (MHng)
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34369 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754126AbdFXApX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Jun 2017 20:45:23 -0400
Received: by mail-pg0-f65.google.com with SMTP id j186so7944122pge.1
        for <linux-arch@vger.kernel.org>; Fri, 23 Jun 2017 17:45:23 -0700 (PDT)
In-Reply-To: <CAK8P3a3n9oAjkOuS3CkMkMMmKQ8YoKYe2NzZF4yT9aoDLAnUoA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: geert@linux-m68k.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, albert@sifive.com, patches@groups.riscv.org, tglx@linutronix.de, jason@lakedaemon.net, Marc.Zyngier@arm.com

On Wed, 07 Jun 2017 00:55:28 PDT (-0700), Arnd Bergmann wrote:
> On Wed, Jun 7, 2017 at 9:13 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>> +struct plic_enable_context {
>>> +       atomic_t mask[32]; // 32-bit * 32-entry
>>> +};
>
> You use many '//' style comments in this file, please change them all to '/* */'
> for consistency with kernel coding style.

OK, I fixed them here and in all our other files that had them.

>>> +
>>> +struct plic_priority {
>>> +       u32 prio[MAX_DEVICES];
>>> +};
>>> +
>>> +struct plic_data {
>>> +       struct irq_chip         chip;
>>> +       struct irq_domain       *domain;
>>> +       u32                     ndev;
>>> +       void __iomem            *reg;
>>> +       int                     handlers;
>>> +       struct plic_handler     *handler;
>>> +       char                    name[30];
>>> +};
>>> +
>>> +struct plic_handler {
>>> +       struct plic_hart_context        *context;
>>> +       struct plic_data                *data;
>>> +};
>>> +
>>> +static inline
>>> +struct plic_hart_context *plic_hart_context(struct plic_data *data, size_t i)
>>> +{
>>> +       return (struct plic_hart_context *)((char *)data->reg + HART_BASE + HART_SIZE*i);
>>> +}
>
> 'data->reg' is an __iomem pointer, so when you build-test this with 'make C=1',
> you should get a valid warning from sparse about an address space mismatch.
> Please address all the warning from sparse.

I didn't know about sparse.  I'll run it on our port and fix everything.

>>> +static void plic_disable(struct plic_data *data, int i, int hwirq)
>>> +{
>>> +       struct plic_enable_context *enable = plic_enable_context(data, i);
>>> +
>>> +       atomic_and(~(1 << (hwirq % 32)), &enable->mask[hwirq / 32]);
>>> +}
>
> In particular, you must not do atomic operations on MMIO pointers.
> On most architectures these are explicitly disallowed and trap for
> a good reason, as the hardware implementation behind atomics tend
> to rely on the cache controller, while mmio registers are required
> to be uncached.

Sorry about that: the SiFive bus actually supports AMOs natively out to the
every device, even without caches, bit the RISC-V spec allows regions
to be marked as not supporting AMOs.  Sometimes a few SiFive-isms sneak in from
before the supervisor spec was written in this particular manner.  I've
converted this to a spinlock instead.

  https://github.com/riscv/riscv-linux/commit/79b26ca800663399ea7d9dead73f3715deee1a99


>>> +       iowrite32(1, &priority->prio[d->hwirq]);
>
> I would normally use 'readl' instead of 'iowrite32'. They may be the same
> on riscv, but they have slightly different meaning in portable drivers.

I assume you meant writel?  If so, that makes sense

  https://github.com/riscv/riscv-linux/commit/45c968f1f068c35e0a5c8c90ba0776e7bdb6db78
