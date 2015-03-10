Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:55708 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbbCJQtH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Mar 2015 12:49:07 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 14/18] ARM: Add STM32 family machine
Date: Tue, 10 Mar 2015 16:10:21 +0100
Message-ID: <2736580.bRymLWnSQl@wuerfel>
In-Reply-To: <1424455277-29983-15-git-send-email-mcoquelin.stm32@gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com> <1424455277-29983-15-git-send-email-mcoquelin.stm32@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, u.kleine-koenig@pengutronix.de, afaerber@suse.de, geert@linux-m68k.org, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20150310151021.VVq89r9oE2HEj_U787Pm4i3_XKr6zDudS2KCOP69A34@z>

On Friday 20 February 2015 19:01:13 Maxime Coquelin wrote:
> +static void __init stm32_timer_init(void)
> +{
> +       of_clk_init(NULL);
> +       reset_controller_of_init();
> +       clocksource_of_init();
> +
> +}

Don't do that. As I said, I'd rather not introduce reset_controller_of_init()
at all, but if we end up doing it, it should be run by default for
any machine that has an empty timer_init callback.

	Arnd
