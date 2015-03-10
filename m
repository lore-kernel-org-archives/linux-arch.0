Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:51464 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbbCJUWM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Mar 2015 16:22:12 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 05/18] reset: Add reset_controller_of_init() function
Date: Tue, 10 Mar 2015 21:19:55 +0100
Message-ID: <6773745.i9mx5zmPP4@wuerfel>
In-Reply-To: <CALszF6BkTOLR+VNkRKfvEBG5ZyaYL+9fZ4EAPVu5b_imCvEQoQ@mail.gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com> <8729383.kvUZDm4dQz@wuerfel> <CALszF6BkTOLR+VNkRKfvEBG5ZyaYL+9fZ4EAPVu5b_imCvEQoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: maxime.ripard@free-electrons.com, Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>, Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Message-ID: <20150310201955.jft22WbyUFPxnpt4of89RzS71hdtwUpNQ7I3KFmUOrg@z>

On Tuesday 10 March 2015 16:28:44 Maxime Coquelin wrote:
> 2015-03-10 16:00 GMT+01:00 Arnd Bergmann <arnd@arndb.de>:
> > On Friday 20 February 2015 19:01:04 Maxime Coquelin wrote:
> >> Some platforms need to initialize the reset controller before the timers.
> >>
> >> This patch introduces a reset_controller_of_init() function that can be
> >> called before the timers intialization.
> >>
> >> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> >>
> >
> > Not sure about this. It seems like the cleanest approach if we get
> > a lot of these, but then again it is probably very rare, and I'd
> > like to avoid adding such infrastructure if it's just for one
> > SoC. Could we add a hack in the machine initialization instead?
> 
> Sun6i also need to initialize the reset controller early. Today, they
> hack the machine initialization.
> With two SoCs having the same need, what should we do?

Good question, I'd like to hear some other opinions on this first.

> > I think ideally this would be done in the boot loader before we
> > even start Linux, but I don't know if that's possible for you.
> 
> From what I understand, the only constraint is to perform it after the
> clock is enabled.
> So this should be possible to do it in the bootloader, but it means
> also adding timers clocks ungating in the bootloader.

Ungating the timer clock input seems like a reasonable thing to
do for the bootloader, I think a lot of platforms rely on this
elsewhere (but enough of them don't, which is why we have the
early clk init).

	Arnd
