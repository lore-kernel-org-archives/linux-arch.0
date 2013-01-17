From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/4] gpio: introduce descriptor-based interface
Date: Thu, 17 Jan 2013 12:15:24 +0100
Message-ID: <CACRpkda6dqAj+DzrMCnKET7Z9PtuW0+k9ea3YDL8Z1D=oFVRpQ@mail.gmail.com>
References: <1357629535-26033-1-git-send-email-acourbot@nvidia.com>
	<201301091046.13020.arnd@arndb.de>
	<2270940.DTxEYMZtED@percival>
	<201301101008.45091.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201301101008.45091.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Ungerer <gerg@snapgear.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alex Courbot <acourbot@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, Guenter Roeck <linux@roeck-us.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Jan 10, 2013 at 11:08 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> I've tried to find platforms that don't yet use GPIOLIB and fortunately
> there are very few left:
>
> I found two that provide the generic gpio interfaces when gpiolib
> is disabled, but use gpiolib otherwise for the same hardware,
> arch/m68k/include/asm/mcfgpio.h and arch/blackfin/include/asm/gpio.h.
> I would assume that we can simply remove the non-gpiolib shortcut
> here at cost of a small overhead.

Geert/Greg: interested in looking into this issue?

The GPIO maintainers want to get rid of non-gpiolib platforms.

Yours,
Linus Walleij
