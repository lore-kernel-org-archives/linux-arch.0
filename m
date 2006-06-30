Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from witte.sonytel.be ([80.88.33.193]:37008 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S932700AbWF3OPz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 Jun 2006 10:15:55 -0400
Date: Fri, 30 Jun 2006 16:15:08 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [patch] s390 kconfig cleanup, 2nd version.
In-Reply-To: <200606301605.53258.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0606301608170.12536@pademelon.sonytel.be>
References: <1151670404.11575.5.camel@localhost> <200606301509.16981.ak@suse.de>
 <1151674086.11575.24.camel@localhost> <200606301605.53258.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: schwidefsky@de.ibm.com, linux-arch@vger.kernel.org, Keir.Fraser@cl.cam.ac.uk, chrisw@sous-sol.org, matthew@wil.cx, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Fri, 30 Jun 2006, Andi Kleen wrote:
> On Friday 30 June 2006 15:28, Martin Schwidefsky wrote:
> > None of them seems appropriate. The things the patch deactives for s390
> > are vastly different (ATA/IDE, Parallel port, Plug and Play, I2C, I2O
> > and so on). You will end up adding a lot of new config options. 
> 
> ATA/IDE, parallel port, PNP could be PC_STYLE_HARDWARE. 

INPUT, LEDs, GRAPHICS, SOUND could depend on USER_INTERACTION?

So basically, an s390 is a (virtual) box with only s390-specific drivers, and
the only possible generic user interaction is through the network?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
