From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 6/7] clocksource: Rename CLKSRC_OF to TIMER_OF
Date: Wed, 31 May 2017 10:24:57 +0200
Message-ID: <CAJKOXPc54UKCBr_8jqUE+5_YHbwEWOv=YRz0zR-ymaXaiGUHyw@mail.gmail.com>
References: <1495879129-28109-1-git-send-email-daniel.lezcano@linaro.org> <1495879129-28109-6-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1495879129-28109-6-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." <bcm-kernel-feedback-list@broadcom.com>, Alexander Shiyan <shc_work@mail.ru>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Kukjin Kim <kgene@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michal Simek <monstr@monstr.eu>, John Crispin <john@phrozen.org>
List-Id: linux-arch.vger.kernel.org

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
