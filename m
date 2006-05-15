Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from witte.sonytel.be ([80.88.33.193]:8392 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S964982AbWEOTBb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 15 May 2006 15:01:31 -0400
Date: Mon, 15 May 2006 21:00:43 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [patch] s390 kconfig cleanup.
In-Reply-To: <200605151930.32241.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0605152056240.8370@pademelon.sonytel.be>
References: <20060515171645.GA11397@skybase> <200605151930.32241.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-arch@vger.kernel.org, Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, Chris Wright <chrisw@sous-sol.org>
List-ID: <linux-arch.vger.kernel.org>

On Mon, 15 May 2006, Andi Kleen wrote:
> On Monday 15 May 2006 19:16, Martin Schwidefsky wrote:
> > I tried once again to clean up the Kconfig files for s390.
> > We do not use drivers/Kconfig so far because this creates
> > a lot of config options that make absolutely no sense for
> > s390. The hardware for whole families of drivers, e.g.
> > IPMI, TPM, I2C, I2O, ATA, IEEE1394, ISDN, etc, do not exist
> > and very likely will never exist on a s390.

> Checking PCI is a good start and should apply to most menus already.

Most of these should already be OK, or they should have showed up on m68k,
causing a `depends on PCI' patch to have gone out (unless added the last few
months while I got a bit `lazy').

The really annoying ones are those that do not depend on PCI, but on `generic
PC architecture'. And those are not limited to ia32/amd64, but may show up
on other platforms depending on what `off the shelf' component got added to
whatever embedded or other board.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
