From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 10/17] irqchip: New RISC-V PLIC Driver
Date: Wed, 7 Jun 2017 09:55:28 +0200
Message-ID: <CAK8P3a3n9oAjkOuS3CkMkMMmKQ8YoKYe2NzZF4yT9aoDLAnUoA@mail.gmail.com>
References: <20170523004107.536-1-palmer@dabbelt.com> <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-11-palmer@dabbelt.com> <CAMuHMdUt3RBL9hagWi+PHrfMoo6ZB1nUctPN0DoJyqmYeH3awQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:35085 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751008AbdFGHz3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Jun 2017 03:55:29 -0400
In-Reply-To: <CAMuHMdUt3RBL9hagWi+PHrfMoo6ZB1nUctPN0DoJyqmYeH3awQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Olof Johansson <olof@lixom.net>, albert@sifive.com, patches@groups.riscv.org, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>

On Wed, Jun 7, 2017 at 9:13 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> +struct plic_enable_context {
>> +       atomic_t mask[32]; // 32-bit * 32-entry
>> +};

You use many '//' style comments in this file, please change them all to '/* */'
for consistency with kernel coding style.

>> +
>> +struct plic_priority {
>> +       u32 prio[MAX_DEVICES];
>> +};
>> +
>> +struct plic_data {
>> +       struct irq_chip         chip;
>> +       struct irq_domain       *domain;
>> +       u32                     ndev;
>> +       void __iomem            *reg;
>> +       int                     handlers;
>> +       struct plic_handler     *handler;
>> +       char                    name[30];
>> +};
>> +
>> +struct plic_handler {
>> +       struct plic_hart_context        *context;
>> +       struct plic_data                *data;
>> +};
>> +
>> +static inline
>> +struct plic_hart_context *plic_hart_context(struct plic_data *data, size_t i)
>> +{
>> +       return (struct plic_hart_context *)((char *)data->reg + HART_BASE + HART_SIZE*i);
>> +}

'data->reg' is an __iomem pointer, so when you build-test this with 'make C=1',
you should get a valid warning from sparse about an address space mismatch.
Please address all the warning from sparse.

>> +static void plic_disable(struct plic_data *data, int i, int hwirq)
>> +{
>> +       struct plic_enable_context *enable = plic_enable_context(data, i);
>> +
>> +       atomic_and(~(1 << (hwirq % 32)), &enable->mask[hwirq / 32]);
>> +}

In particular, you must not do atomic operations on MMIO pointers.
On most architectures these are explicitly disallowed and trap for
a good reason, as the hardware implementation behind atomics tend
to rely on the cache controller, while mmio registers are required
to be uncached.

>> +       iowrite32(1, &priority->prio[d->hwirq]);

I would normally use 'readl' instead of 'iowrite32'. They may be the same
on riscv, but they have slightly different meaning in portable drivers.

       Arnd
