Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:33139 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751137AbYHPB7u (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 Aug 2008 21:59:50 -0400
From: David Brownell <david-b@pacbell.net>
Subject: Re: drivers/usb/musb/musb_io.h
Date: Fri, 15 Aug 2008 18:53:07 -0700
References: <20080814215200.27f79a59.akpm@linux-foundation.org> <200808151446.45855.david-b@pacbell.net> <20080815222238.GC25069@frodo>
In-Reply-To: <20080815222238.GC25069@frodo>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-ID: <200808151853.08302.david-b@pacbell.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: me@felipebalbi.com
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Andrew Morton <akpm@linux-foundation.org>, linux-usb@vger.kernel.org, linux-arch@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>
Message-ID: <20080816015307.WFyfHH3577zTmRSVHOEJySlt6cSplXInHT_YAbun_sU@z>

On Friday 15 August 2008, Felipe Balbi wrote:
> Hmm... but how about the other version?
> 
> +#ifndef readsl
>  static inline void readsl(const void __iomem *addr, void *buf, int len)
>         { insl((unsigned long)addr, buf, len); }
> +#endif
> +#ifndef readsw
>  static inline void readsw(const void __iomem *addr, void *buf, int len)
>         { insw((unsigned long)addr, buf, len); }
> +#endif

Any arch defining an inline readsl() etc will break.  And
inlines are the preferred style lately.  :)

Someone commented that this is what caused creation of
the mmio_insl() family of routines ...

... but I notice that at least on ARM (current primary home
for this driver!) those calls don't end up using optimized
code. Since those optimimzed loops are a *big* win in terms
of performance -- using LDM/STM to burst memory acccess to/from
registers -- I'd rather not go that way for now.

- Dave


