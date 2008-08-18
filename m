From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: drivers/usb/musb/musb_io.h
Date: Mon, 18 Aug 2008 08:40:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0808180839500.27466@anakin>
References: <20080814215200.27f79a59.akpm@linux-foundation.org>
 <20080815073750.GG16231@frodo> <20080815074318.GH16231@frodo>
 <20080815010227.121e5e4b.akpm@linux-foundation.org> <20080815081154.GJ16231@frodo>
 <20080815013148.b9dfc7ad.akpm@linux-foundation.org> <20080815085247.GK16231@frodo>
 <20080815021131.dfab416a.akpm@linux-foundation.org>
 <20080815115308.GA24513@flint.arm.linux.org.uk> <20080815123848.GN16231@frodo>
 <20080815131708.GO16231@frodo>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from monty.telenet-ops.be ([195.130.132.56]:50988 "EHLO
	monty.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbYHRGkr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 18 Aug 2008 02:40:47 -0400
In-Reply-To: <20080815131708.GO16231@frodo>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Felipe Balbi <me@felipebalbi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>, linux-usb@vger.kernel.org, linux-arch@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

On Fri, 15 Aug 2008, Felipe Balbi wrote:
> On Fri, Aug 15, 2008 at 03:38:49PM +0300, Felipe Balbi wrote:
> +#ifndef writesl
>  static inline void writesl(const void __iomem *addr, const void *buf, int len)
>  	{ outsl((unsigned long)addr, buf, len); }
> +#endif
> +#ifndef writesw
>  static inline void writesw(const void __iomem *addr, const void *buf, int len)
>  	{ outsw((unsigned long)addr, buf, len); }
> +#endif
> +#ifndef writesb
>  static inline void writesb(const void __iomem *addr, const void *buf, int len)
>  	{ outsb((unsigned long)addr, buf, len); }
> -
>  #endif

... which may cause silent memory corruption when somebody enables this
driver on a platform where the above routines don't do what they should
do?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
