Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:58444 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbbCJPBo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Mar 2015 11:01:44 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 05/18] reset: Add reset_controller_of_init() function
Date: Tue, 10 Mar 2015 16:00:44 +0100
Message-ID: <8729383.kvUZDm4dQz@wuerfel>
In-Reply-To: <1424455277-29983-6-git-send-email-mcoquelin.stm32@gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com> <1424455277-29983-6-git-send-email-mcoquelin.stm32@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: u.kleine-koenig@pengutronix.de, afaerber@suse.de, geert@linux-m68k.org, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20150310150044.CFtQlS-lUQzhHv-3dx1nFRZBlfAazt1ojJfc8qmCRuE@z>

On Friday 20 February 2015 19:01:04 Maxime Coquelin wrote:
> Some platforms need to initialize the reset controller before the timers.
> 
> This patch introduces a reset_controller_of_init() function that can be
> called before the timers intialization.
> 
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> 

Not sure about this. It seems like the cleanest approach if we get
a lot of these, but then again it is probably very rare, and I'd
like to avoid adding such infrastructure if it's just for one
SoC. Could we add a hack in the machine initialization instead?

I think ideally this would be done in the boot loader before we
even start Linux, but I don't know if that's possible for you.

	Arnd
