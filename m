Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:56991 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932328AbbESNBL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 May 2015 09:01:11 -0400
Date: Tue, 19 May 2015 14:00:28 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v8 09/16] clockevents/drivers: Add STM32 Timer driver
Message-ID: <20150519130028.GF2067@n2100.arm.linux.org.uk>
References: <1431158038-3813-10-git-send-email-mcoquelin.stm32@gmail.com>
 <5559E4B0.70506@linaro.org>
 <CALszF6CK7axU0qrWNf38aqrt2R2126ZACn7wx5jNY_1KE+4H+g@mail.gmail.com>
 <555AF143.2060807@linaro.org>
 <CALszF6CwGuKqgbX6gVrya1-_YOgvtrgC7pVqKTNjCRif_o532A@mail.gmail.com>
 <555AFD18.2070009@linaro.org>
 <CALszF6Asfke0-cMQJcEQ8ya+rbPPPhUc6aXTZXQvQ8QF66cwYQ@mail.gmail.com>
 <555B098A.8030202@linaro.org>
 <CALszF6AJ3Zf598wYeUx=iNWHHKT24xUyfagB=+4GocwZ-Fd-0g@mail.gmail.com>
 <alpine.DEB.2.11.1505191455540.4225@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1505191455540.4225@nanos>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Stefan Agner <stefan@agner.ch>, Peter Meerwald <pmeerw@pmeerw.net>, Paul Bolle <pebolle@tiscali.nl>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Joe Perches <joe@perches.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, Nicolae Rosia <nicolae.rosia@gmail.com>, Kamil Lulko <rev13@wp.pl>
Message-ID: <20150519130028.E8gnjKxgOsXCOjnbNP78HLDGD7cKZEG-W5dqRCrkgcQ@z>

On Tue, May 19, 2015 at 02:56:43PM +0200, Thomas Gleixner wrote:
> On Tue, 19 May 2015, Maxime Coquelin wrote:
> > 2015-05-19 11:59 GMT+02:00 Daniel Lezcano <daniel.lezcano@linaro.org>:
> > >> Is the below Kconfig entry fine for you?
> > >>
> > >> config CLKSRC_STM32
> > >>      def_bool y if ARCH_STM32
> > >>      select CLKSRC_MMIO
> > >
> > >
> > > config CLKSRC_STM32
> > >         bool
> > >         select CLKSRC_MMIO
> > >
> > > and in the arch/arm/mach-stm32/Kconfig add select CLKSRC_STM32
> > 
> > Ok, I will send a patch for arch/arm/Kconfig, as Arnd already applied
> > the one intruducing ARCH_STM32.
> 
> Folks, can you please trim your replies. It's a PITA to scroll down
> through several pages to find a single line of content.

Absolutely right.  Too many people do not do this, and it's a waste of
readers time.  Maybe we should start ignoring emails which contain only
quoted mail in the first 50 lines.

Also, cutting the rest of the email below the point which you've finished
replying is good etiquette as well.  I've seen a number of posts where
people have added their signature mid-mail and left a huge chunk of quoted
mail below.  That's just not on either.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
