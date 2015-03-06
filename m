Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:42924 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448AbbCFJDJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 6 Mar 2015 04:03:09 -0500
Received: by oiav1 with SMTP id v1so16579399oia.9
        for <linux-arch@vger.kernel.org>; Fri, 06 Mar 2015 01:03:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1423763164-5606-15-git-send-email-mcoquelin.stm32@gmail.com>
References: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
	<1423763164-5606-15-git-send-email-mcoquelin.stm32@gmail.com>
Date: Fri, 6 Mar 2015 10:03:08 +0100
Message-ID: <CACRpkdaM0BwMcq77MO=0-dVaqwobD5Pt+11j7ZZ4c3yKM=AkeA@mail.gmail.com>
Subject: Re: [PATCH 14/14] MAINTAINERS: Add entry for STM32 MCUs
From: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-api@vger.kernel.org
Message-ID: <20150306090308.tLo0kSjVcgfg-upMQRelLAa618g4GTe7F_hzxM6x1nc@z>

On Thu, Feb 12, 2015 at 6:46 PM, Maxime Coquelin
<mcoquelin.stm32@gmail.com> wrote:

> Add a MAINTAINER entry covering all STM32 machine and drivers files.
>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

(...)
> +F:     drivers/clocksource/arm_system_timer.c

Is that all? And that is not even a STM32 specific driver.

Yours,
Linus Walleij
