Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:51658 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756023AbaDVN7o (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Apr 2014 09:59:44 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 07/28] nios2: I/O Mapping
Date: Tue, 22 Apr 2014 15:59:37 +0200
References: <1397824031-4892-1-git-send-email-lftan@altera.com> <1397845149-3141-1-git-send-email-lftan@altera.com> <1397845149-3141-3-git-send-email-lftan@altera.com>
In-Reply-To: <1397845149-3141-3-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-ID: <201404221559.37560.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
Message-ID: <20140422135937.ptfAuOgSSOUVw7F7KdPyc-_8AbVsXZMmXA5ANCznJTU@z>

On Friday 18 April 2014, Ley Foon Tan wrote:

> +
> +#include <asm/pgtable-bits.h>
> +
> +#define IO_SPACE_LIMIT 0xffffffff

Please use 0xffff here, this should work for almost any PCI bus.

> +
> +#ifndef CONFIG_CC_OPTIMIZE_FOR_SIZE
> +# define __IO_USE_DUFFS
> +#endif
> +
> +#ifdef __IO_USE_DUFFS
> +
> +/* Use "Duff's Device" to unroll the loops. */
> +#define __IO_OUT_LOOP(a, b, l)				\
> +	do {						\
> +		if (l > 0) {				\
> +			int _n = (l + 7) / 8;		\
> +			switch (l % 8) {		\
> +			case 0:				\
> +				do {			\
> +					*a = *b++;	\

I would recommend just doing all of this in out-of-line implementations
rather than macros and inline functions.

> +
> +/*
> + *	make the short names macros so specific devices
> + *	can override them as required
> + */
> +#define inb(addr)		readb(addr)
> +#define inw(addr)		readw(addr)
> +#define inl(addr)		readl(addr)
> +#define outb(x, addr)		((void) writeb(x, addr))
> +#define outw(x, addr)		((void) writew(x, addr))
> +#define outl(x, addr)		((void) writel(x, addr))

This makes no sense: the legacy PC I/O accessors take a completely
different argument type: I would recommend to make both inline
functions so you can ensure that readl() gets passed an __iomem
pointer, while inl() gets an integer number.

Please see the asm-generic version for an example. You should also
define a non-NULL PCI_IOBASE to which the PCI I/O space gets mapped.

> +#define virt_to_bus virt_to_phys
> +#define bus_to_virt phys_to_virt

Please drop these, and the CONFIG_VIRT_TO_BUS Kconfig option,
and fix all drivers that rely on it.

> +#define ioport_map(port, nr)	ioremap(port, nr)
> +#define ioport_unmap(port)	iounmap(port)

Use this one instead:

#ifdef CONFIG_PCI
static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
{
        return PCI_IOBASE + port;
}

static inline void __iomem *ioport_unmap(void __iomem *)
{
}
#endif

> +/* Macros used for smc91x.c driver */
> +#define readsb(p, d, l)		insb(p, d, l)
> +#define readsw(p, d, l)		insw(p, d, l)
> +#define readsl(p, d, l)		insl(p, d, l)
> +#define writesb(p, d, l)	outsb(p, d, l)
> +#define writesw(p, d, l)	outsw(p, d, l)
> +#define writesl(p, d, l)	outsl(p, d, l)

These should of course not fall back to the PCI I/O space functions.
You can do it the other way round.

	Arnd
