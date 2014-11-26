From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 1/2] asm-generic: io: Add exec versions of ioremap
Date: Wed, 26 Nov 2014 22:32:47 +0100
Message-ID: <2060921.TrTof4X6qj@wuerfel>
References: <cover.1417029918.git.d-gerlach@ti.com> <cb5e9dd7bd71b13551cd3f32f28feb405ea9fcdd.1417029918.git.d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cb5e9dd7bd71b13551cd3f32f28feb405ea9fcdd.1417029918.git.d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, Russ Dill <russ.dill@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawn.guo@freescale.com>, Tony Lindgren <tony@atomide.com>, Anson.Huang@freescale.com, Russ Dill <Russ.Dill@ti.com>
List-Id: linux-arch.vger.kernel.org

On Wednesday 26 November 2014 15:14:00 Dave Gerlach wrote:
> @@ -66,6 +66,11 @@ extern void ioport_unmap(void __iomem *);
>  #define ioremap_wc ioremap_nocache
>  #endif
>  
> +#ifndef ARCH_HAS_IOREMAP_EXEC
> +#define ioremap_exec ioremap
> +#define ioremap_exec_nocache ioremap_nocache
> +#endif
> +
>  #ifdef CONFIG_PCI
>  /* Destroy a virtual mapping cookie for a PCI BAR (memory or IO) */
>  struct pci_dev;
> 

ioremap and ioremap_nocache are the same, and there is no
architecture-independent interface to map an MMIO range as
cached because a lot of architectures can't do that.

Also, I think there are architectures that cannot execute
from uncached memory, so I think adding this as a generic
API is not a good idea.

	Arnd
