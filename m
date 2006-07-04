Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from witte.sonytel.be ([80.88.33.193]:26030 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S932197AbWGDNJO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2006 09:09:14 -0400
Date: Tue, 4 Jul 2006 15:08:30 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [patch] s390 kconfig cleanup, 2nd version.
In-Reply-To: <200607041442.03913.arnd@arndb.de>
Message-ID: <Pine.LNX.4.62.0607041507350.13355@pademelon.sonytel.be>
References: <1151670404.11575.5.camel@localhost> <200607040115.18194.arnd@arndb.de>
 <20060703233533.GE1605@parisc-linux.org> <200607041442.03913.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-1886418142-1152018510=:13355"
Sender: linux-arch-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Matthew Wilcox <matthew@wil.cx>, schwidefsky@de.ibm.com, Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org, Keir.Fraser@cl.cam.ac.uk, chrisw@sous-sol.org, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-1886418142-1152018510=:13355
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

	Hi Arnd,

On Tue, 4 Jul 2006, Arnd Bergmann wrote:
> On Tuesday 04 July 2006 01:35, Matthew Wilcox wrote:
> > We don't (yet) have a CONFIG_MMIO.  If we were to have one, I would
> > expect it to be akin to SCSI_SYM53C8XX_MMIO, VIA_RHINE_MMIO,
> > SUNDANCE_MMIO and TULIP_MMIO.  ie indicating a preference between PIO
> > and MMIO rather than indicating the availability of MMIO.
> 
> Hmm, maybe my terminology wasn't so good, at least you misunderstood
> what I wanted to express. PIO is more or less a 386ism, so I tend to
> view that as a special case of MMIO. The point with  s390 is that there
> is neither PIO nor MMIO, which really makes it impossible to use most
> of the device drivers, even if you could connect the hardware ;-).

So why aren't readb() and friends in <asm/io.h> empty defines?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
---584337861-1886418142-1152018510=:13355--
