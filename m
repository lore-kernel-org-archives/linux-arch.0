Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750762AbdE1DCA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 27 May 2017 23:02:00 -0400
Date: Sun, 28 May 2017 11:00:59 +0800
From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 6/7] clocksource: Rename CLKSRC_OF to TIMER_OF
Message-ID: <20170528030058.GC4528@dragon>
References: <1495879129-28109-1-git-send-email-daniel.lezcano@linaro.org>
 <1495879129-28109-6-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1495879129-28109-6-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." <bcm-kernel-feedback-list@broadcom.com>, Alexander Shiyan <shc_work@mail.ru>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michal Simek <monstr@monstr.eu>, John Crispin <john@phrozen.org>, Ralf Baechle <ralf@linux-mips.org>, Ley Foon Tan <lftan@altera.com>, Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Olof Johansson <olof@lixom.net>, "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" <linux-samsung-soc@vger.kernel.org>, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, "moderated list:NIOS2 ARCHITECTURE" <nios2-dev@lists.rocketboards.org>, "open list:SUPERH" <linux-sh@vger.kernel.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
Message-ID: <20170528030059.ouiv2FDhAuzNvtw0VURdm-18yeX2EX7_HFBB-aPZsoc@z>

On Sat, May 27, 2017 at 11:58:47AM +0200, Daniel Lezcano wrote:
> diff --git a/arch/arm/mach-imx/epit.c b/arch/arm/mach-imx/epit.c
> index fb9a73a..4a4d2e2 100644
> --- a/arch/arm/mach-imx/epit.c
> +++ b/arch/arm/mach-imx/epit.c
> @@ -39,7 +39,7 @@
>  #define EPITCR_OM_TOGGLE		(1 << 22)
>  #define EPITCR_OM_CLEAR			(2 << 22)
>  #define EPITCR_OM_SET			(3 << 22)
> -#define EPITCR_CLKSRC_OFF		(0 << 24)
> +#define EPITCR_TIMER_OFF		(0 << 24)
>  #define EPITCR_CLKSRC_PERIPHERAL	(1 << 24)
>  #define EPITCR_CLKSRC_REF_HIGH		(1 << 24)
>  #define EPITCR_CLKSRC_REF_LOW		(3 << 24)

I do not think this change should be there.

Shawn
