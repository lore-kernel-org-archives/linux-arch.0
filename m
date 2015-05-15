Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:65294 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934443AbbEOUFj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 May 2015 16:05:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v8 15/16] ARM: configs: Add STM32 defconfig
Date: Fri, 15 May 2015 22:03:37 +0200
Message-ID: <37337887.OlERAXq6R2@wuerfel>
In-Reply-To: <1431158038-3813-16-git-send-email-mcoquelin.stm32@gmail.com>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com> <1431158038-3813-16-git-send-email-mcoquelin.stm32@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: u.kleine-koenig@pengutronix.de, afaerber@suse.de, geert@linux-m68k.org, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, stefan@agner.ch, pmeerw@pmeerw.net, pebolle@tiscali.nl, peter@hurleysoftware.com, andy.shevchenko@gmail.com, cw00.choi@samsung.com, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, joe@perches.com, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, lee.jones@linaro.org, Daniel Thompson <daniel.thompson@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Nicolae Rosia <nicolae.rosia@gmail.com>, Kamil Lulko <rev13@wp.pl>
Message-ID: <20150515200337.P_PD2BkIt57rPT8h1Ss1F9zh4Dq-qJ815ZyIiaqgSjk@z>

On Saturday 09 May 2015 09:53:57 Maxime Coquelin wrote:
> This patch adds a new config for STM32 MCUs.
> STM32F429 Discovery board boots successfully with this config applied.
> 
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> 

Applied to next/defconfig, thanks!

	Arnd
