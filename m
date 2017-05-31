Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751405AbdEaIY7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 May 2017 04:24:59 -0400
MIME-Version: 1.0
In-Reply-To: <1495879129-28109-6-git-send-email-daniel.lezcano@linaro.org>
References: <1495879129-28109-1-git-send-email-daniel.lezcano@linaro.org> <1495879129-28109-6-git-send-email-daniel.lezcano@linaro.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 31 May 2017 10:24:57 +0200
Message-ID: <CAJKOXPc54UKCBr_8jqUE+5_YHbwEWOv=YRz0zR-ymaXaiGUHyw@mail.gmail.com>
Subject: Re: [PATCH 6/7] clocksource: Rename CLKSRC_OF to TIMER_OF
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." <bcm-kernel-feedback-list@broadcom.com>, Alexander Shiyan <shc_work@mail.ru>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Kukjin Kim <kgene@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michal Simek <monstr@monstr.eu>, John Crispin <john@phrozen.org>, Ralf Baechle <ralf@linux-mips.org>, Ley Foon Tan <lftan@altera.com>, Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Olof Johansson <olof@lixom.net>, "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" <linux-samsung-soc@vger.kernel.org>, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, "moderated list:NIOS2 ARCHITECTURE" <nios2-dev@lists.rocketboards.org>, "open list:SUPERH" <linux-sh@vger.kernel.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
Message-ID: <20170531082457.z08nnbsi1MJ1cmwVx3N4mp9sRY8__6ki8P12hGz97KU@z>

On Sat, May 27, 2017 at 11:58 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> The config option name is now renamed to 'TIMER_OF' for consistency with
> the CLOCKSOURCE_OF_DECLARE => TIMER_OF_DECLARE change.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/Kconfig                        | 10 +++---
>  arch/arm/mach-bcm/Kconfig               |  2 +-
>  arch/arm/mach-clps711x/Kconfig          |  2 +-
>  arch/arm/mach-imx/epit.c                |  2 +-
>  arch/arm/mach-s3c24xx/Kconfig           |  2 +-
>  arch/arm/mach-s3c64xx/Kconfig           |  2 +-
>  arch/arm64/Kconfig.platforms            |  4 +--
>  arch/h8300/Kconfig                      |  2 +-
>  arch/microblaze/Kconfig                 |  2 +-
>  arch/mips/ralink/Kconfig                |  2 +-
>  arch/nios2/Kconfig                      |  2 +-
>  arch/sh/boards/Kconfig                  |  2 +-
>  drivers/clocksource/Kconfig             | 60 ++++++++++++++++-----------------
>  drivers/clocksource/Makefile            |  2 +-
>  drivers/clocksource/clksrc-probe.c      | 55 ------------------------------
>  drivers/clocksource/clps711x-timer.c    |  2 +-
>  drivers/clocksource/samsung_pwm_timer.c |  2 +-

For s3c24xx, s3c64xx and samsung_pwm_timer:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
