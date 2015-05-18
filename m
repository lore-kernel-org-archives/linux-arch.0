Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33992 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbbERLrI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 18 May 2015 07:47:08 -0400
MIME-Version: 1.0
In-Reply-To: <1431158038-3813-2-git-send-email-mcoquelin.stm32@gmail.com>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
	<1431158038-3813-2-git-send-email-mcoquelin.stm32@gmail.com>
Date: Mon, 18 May 2015 13:47:06 +0200
Message-ID: <CALszF6B0=dgSDfLFwDi9YmEzrrNVuYbUnqMu5DmDhhy--emtpw@mail.gmail.com>
Subject: Re: [PATCH v8 01/16] scripts: link-vmlinux: Don't pass page offset to
 kallsyms if XIP Kernel
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Marek <mmarek@suse.cz>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Rob Herring <robh+dt@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Jonathan Corbet <corbet@lwn.net>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Stefan Agner <stefan@agner.ch>, Lee Jones <lee.jones@linaro.org>, Joe Perches <joe@perches.com>, Russell King <linux@arm.linux.org.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Paul Bolle <pebolle@tiscali.nl>, Peter Hurley <peter@hurleysoftware.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Daniel Thompson <daniel.thompson@linaro.org>, "David S. Miller" <davem@davemloft.net>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Peter Meerwald <pmeerw@pmeerw.net>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Nicolae Rosia <nicolae.rosia@gmail.com>, Kamil Lulko <rev13@wp.pl>
Message-ID: <20150518114706.jeZZ-Mj3OkC4kQSPQRQ_ucRtlIXm0kztfrswYczLXkI@z>

Hi Michal,

2015-05-09 9:53 GMT+02:00 Maxime Coquelin <mcoquelin.stm32@gmail.com>:
> When Kernel is executed in place from ROM, the symbol addresses can be
> lower than the page offset.
>
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> ---
>  scripts/link-vmlinux.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 86a4fe7..b055d9d 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -82,7 +82,7 @@ kallsyms()
>                 kallsymopt="${kallsymopt} --all-symbols"
>         fi
>
> -       if [ -n "${CONFIG_ARM}" ] && [ -n "${CONFIG_PAGE_OFFSET}" ]; then
> +       if [ -n "${CONFIG_ARM}" ] && [ -z "${CONFIG_XIP_KERNEL}" ] && [ -n "${CONFIG_PAGE_OFFSET}" ]; then
>                 kallsymopt="${kallsymopt} --page-offset=$CONFIG_PAGE_OFFSET"
>         fi
>
> --
> 1.9.1
>

The get_maintainer.pl does not explicitly provide your name as
maintainer for this file.
But looking at MAINTAINERS file, I think you are the one for it.

Do you confirm?
If this is the case and you agree with the patch, could you consider
taking it for v4.2?

Thanks in advance,
Maxime
