From: David Brownell <david-b@pacbell.net>
Subject: Re: drivers/usb/musb/musb_io.h
Date: Fri, 15 Aug 2008 19:05:31 -0700
Message-ID: <200808151905.32383.david-b@pacbell.net>
References: <20080814215200.27f79a59.akpm@linux-foundation.org> <20080815222238.GC25069@frodo> <200808151853.08302.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:22943 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750928AbYHPCFe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 Aug 2008 22:05:34 -0400
In-Reply-To: <200808151853.08302.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: me@felipebalbi.com
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Andrew Morton <akpm@linux-foundation.org>, linux-usb@vger.kernel.org, linux-arch@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

On Friday 15 August 2008, David Brownell wrote:
> Someone commented that this is what caused creation of
> the mmio_insl() family of routines ...
> 
> ... but I notice that at least on ARM (current primary home
> for this driver!) those calls don't end up using optimized
> code. Since those optimimzed loops are a *big* win in terms
> of performance -- using LDM/STM to burst memory acccess to/from
> registers -- I'd rather not go that way for now.

Oh, and worth remembering:  *WHEN* a clean solution for this
is available, it should be usable in the NAND code.  And surely
in other places which sometimes need PIO access to a FIFO...

I was surprised to see that 16% improvement in read performance
with an 8-bit NAND device, just by switching from code looking
like generic mmio_insb() over to __raw_readsb().  Better IMO to
have the faster code be what the NAND core uses by default, than
to need to modify every platform's NAND driver to do that.

- Dave
