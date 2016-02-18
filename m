From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 5/5] gpio: allow setting ARCH_NR_GPIOS from Kconfig
Date: Fri, 19 Feb 2016 00:23:39 +0100
Message-ID: <CACRpkdaSxhBrSt5qcUUJPcN6nv9Go96TP52cyU_nBZZM0phuPA@mail.gmail.com>
References: <455637086-2794174-1-git-send-email-arnd@arndb.de>
	<1455637261-2920972-1-git-send-email-arnd@arndb.de>
	<1455637261-2920972-5-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:34746 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947286AbcBRXXk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 18 Feb 2016 18:23:40 -0500
Received: by mail-ob0-f181.google.com with SMTP id kf7so8695457obb.1
        for <linux-arch@vger.kernel.org>; Thu, 18 Feb 2016 15:23:40 -0800 (PST)
In-Reply-To: <1455637261-2920972-5-git-send-email-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Bjorn Helgaas <bhelgaas@google.com>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Ralf Baechle <ralf@linux-mips.org>, Linux MIPS <linux-mips@linux-mips.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Tue, Feb 16, 2016 at 4:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The ARM version of asm/gpio.h basically just contains the same definitions
> as the gpiolib version, with the exception of ARCH_NR_GPIOS.
>
> This adds the option for overriding the constant through Kconfig to
> the architecture-independent header, so we can remove the ARM specific
> file later.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied.

Yours,
Linus Walleij
