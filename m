From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v5 10/15] serial: stm32-usart: Add STM32 USART Driver
Date: Fri, 03 Apr 2015 13:29:44 -0400
Message-ID: <551ECE08.8040407@hurleysoftware.com>
References: <1428080481-18591-1-git-send-email-mcoquelin.stm32@gmail.com> <1428080481-18591-11-git-send-email-mcoquelin.stm32@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:33682 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbbDCR3y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Apr 2015 13:29:54 -0400
Received: by qcrf4 with SMTP id f4so80661658qcr.0
        for <linux-arch@vger.kernel.org>; Fri, 03 Apr 2015 10:29:53 -0700 (PDT)
In-Reply-To: <1428080481-18591-11-git-send-email-mcoquelin.stm32@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: u.kleine-koenig@pengutronix.de, afaerber@suse.de, geert@linux-m68k.org, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, stefan@agner.ch, pmeerw@pmeerw.net, pebolle@tiscali.nl, andy.shevchenko@gmail.com, cw00.choi@samsung.com, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.>

On 04/03/2015 01:01 PM, Maxime Coquelin wrote:
> This drivers adds support to the STM32 USART controller, which is a
> standard serial driver.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

PS - I saw Rob's comment about 'hw-flow-ctrl' vs 'auto-flow-control'
and I'm ok with either so feel free to and my review comment to a v6
if that's the only change.
