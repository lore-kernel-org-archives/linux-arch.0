Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268100AbUJSJc5@vger.kernel.org>
Received: from witte.sonytel.be ([80.88.33.193]:45247 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266585AbUJSJc5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Oct 2004 05:32:57 -0400
Date: Tue, 19 Oct 2004 11:32:44 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
Subject: Re: All archs: NO_IRQ definition
In-Reply-To: <1098178059.13633.1071.camel@hades.cambridge.redhat.com>
Message-ID: <Pine.GSO.4.61.0410191130430.13789@waterleaf.sonytel.be>
References: <1098169077.11400.51.camel@gaston>
 <20041019092238.GK16153@parcelfarce.linux.theplanet.co.uk>
 <1098178059.13633.1071.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: David Woodhouse <dwmw2@infradead.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, 19 Oct 2004, David Woodhouse wrote:
> On Tue, 2004-10-19 at 10:22 +0100, Matthew Wilcox wrote:
> > On Tue, Oct 19, 2004 at 04:57:57PM +1000, Benjamin Herrenschmidt wrote:
> > > parisc
> > 
> > -1 for parisc, please.
> 
> And also for every arch where there isn't an overriding reason for it
> _not_ to be -1. If either zero or -1 works, use -1. We'll get better
> coverage of random driver authors doing 'if (!irq)' that way. 
> 
> So your question becomes: anyone whose architecture can't cope with
> NO_IRQ being -1, please shout now before we break it.
> 
> > BTW, we could just force everyone to add it themselves by merging this
> > patch:
> 
> Do it.

m68k starts counting interrupt numbers from 1 (probably we mimiced the ia32
port too closely in the early nineties :-), so you can use either 0 or -1.

Let's use -1.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
