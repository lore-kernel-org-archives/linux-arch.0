From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 12/29] nios2: Interrupt handling
Date: Thu, 17 Jul 2014 11:24:07 +0200
Message-ID: <7476152.ZcIrSvABEg@wuerfel>
References: <1405413956-2772-1-git-send-email-lftan@altera.com> <5170097.X9RFbxSEnp@wuerfel> <CAFiDJ5_dTKXSVPtr20uDU32=v_jb3NKUDHGw4OFjW6DuvoZyeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAFiDJ5_dTKXSVPtr20uDU32=v_jb3NKUDHGw4OFjW6DuvoZyeA@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ley Foon Tan <lftan@altera.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>
List-Id: linux-arch.vger.kernel.org

On Thursday 17 July 2014 14:15:44 Ley Foon Tan wrote:
> On Tue, Jul 15, 2014 at 5:27 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 15 July 2014 16:45:39 Ley Foon Tan wrote:
> >> +#ifndef _ASM_NIOS2_IRQ_H
> >> +#define _ASM_NIOS2_IRQ_H
> >> +
> >> +#define NIOS2_CPU_NR_IRQS    32
> >> +/* Reserve 32 additional interrupts for GPIO IRQs */
> >> +#define NR_IRQS                      (NIOS2_CPU_NR_IRQS + 32)
> >
> > Is this intentional? I would expect that you use SPARSE_IRQ
> > instead and not define NR_IRQS.
> Okay, will change to use SPARSE_IRQ.
> >
> >> +#ifndef NO_IRQ
> >> +#define NO_IRQ                       (-1)
> >> +#endif
> >
> > New architectures should no longer define NO_IRQ. Please fix all users
> > you encounter instead.
> Okay.
> 
> >
> >> diff --git a/arch/nios2/kernel/irq.c b/arch/nios2/kernel/irq.c
> >> new file mode 100644
> >> index 0000000..8770d50
> >> --- /dev/null
> >> +++ b/arch/nios2/kernel/irq.c
> >> +#include <linux/init.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/of.h>
> >
> > Maybe move this into drivers/irqchip/? Probably doesn't matter either way,
> > your choice.
> Will keep it here.
> BTW, this interrupt controller is part of Nios2 cpu architecture.
> Should we move to drivers/irqchip/ if that's the case? Any example of
> arch doing this?

A lot of interrupt controllers can be used on multiple architectures,
and a lot of architectures have a wide variety of interrupt controllers
that can be used, so moving them all into drivers/irqchip is the generally
preferred choice.

If your driver can't work on anything other than nios2 (e.g. because it
uses special CPU instructions rather than MMIO access) or the CPU core
always comes with this irqchip and doesn't have a way to use a different
one, there is no problem leaving it in the arch code.

	Arnd
