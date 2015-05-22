Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56085 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756946AbbEVUU4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 22 May 2015 16:20:56 -0400
Message-ID: <555F8F93.7000705@suse.de>
Date: Fri, 22 May 2015 22:20:35 +0200
From: =?windows-1252?Q?Andreas_F=E4rber?= <afaerber@suse.de>
MIME-Version: 1.0
Subject: Re: [PATCH v8 01/16] scripts: link-vmlinux: Don't pass page offset
 to kallsyms if XIP Kernel
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com> <1431158038-3813-2-git-send-email-mcoquelin.stm32@gmail.com> <CALszF6B0=dgSDfLFwDi9YmEzrrNVuYbUnqMu5DmDhhy--emtpw@mail.gmail.com> <555D12F8.4000403@suse.de>
In-Reply-To: <555D12F8.4000403@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="NGubmuQWF8p0L662mvgUTwp27eogPw0JI"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Marek <mmarek@suse.cz>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Stefan Agner <stefan@agner.ch>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Peter Meerwald <pmeerw@pmeerw.net>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>, Linux-Arch <linux-arch@vger.kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, Russell King <linux@arm.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, Lee Jones <lee.jones@linaro.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Antti Palosaari <crope@iki.fi>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, =?windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kamil Lulko <rev13@wp.pl>, Rusty Russell <rusty@rustcorp.com.au>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Nicolae Rosia <nicolae.rosia@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Paul Bolle <pebolle@tiscali.nl>, Peter Hurley <peter@hurleysoftware.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Philipp Zabel <p.zabel@pengutronix.de>, Kumar Gala <galak@codeaurora.org>, Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <20150522202035.wXilaavFPjJNYJLHV2gMk8g_LZr3GJQicKD87exuwG4@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NGubmuQWF8p0L662mvgUTwp27eogPw0JI
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Am 21.05.2015 um 01:04 schrieb Andreas F=E4rber:
> Hi,
>=20
> Am 18.05.2015 um 13:47 schrieb Maxime Coquelin:
>> 2015-05-09 9:53 GMT+02:00 Maxime Coquelin <mcoquelin.stm32@gmail.com>:=

>>> When Kernel is executed in place from ROM, the symbol addresses can b=
e
>>> lower than the page offset.
>>>
>>> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
[...]
> Back then on STM32F4 I debugged that disabling KALLSYMS works around it=
=2E
>=20
> Now on a different XIP target I have confirmed this patch to help show =
a
> stacktrace (my clk driver was missing some CLK_DIVIDER_ALLOW_ZEROs) ...=

> although my earlyprintk serial output still gets stuck further down the=

> stacktrace - probably unrelated.

FTR confirming my suspicion: insufficient power supply. ;)

Andreas

> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: CPU: 0 PID: 0 at drivers/clk/clk-divider.c:126
> divider_recalc_rate+0x2b/0x44()
> [    0.000000] SYS: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
> 4.1.0-rc4-next-20150519+ #23
> [    0.000000] Hardware name: XMC4000 (Device Tree Support)
> [    0.000000] [<0800bd5d>] (unwind_backtrace) from [<0800b0cb>]
> (show_stack+0xb/0xc)
> [    0.000000] [<0800b0cb>] (show_stack) from [<0800e0a5>]
> (warn_slowpath_common+0x55/0x78)
> [    0.000000] [<0800e0a5>] (warn_slowpath_common) from [<0800e103>]
> (warn_slowpath_fmt+0x1b/0x24)
> [    0.000000] [<0800e103>] (warn_slowpath_fmt) from [<080942e3>] (divi=
de
>=20
> But this is definitely an improvement for ARMv7-M debugging,
>=20
> Tested-by: Andreas F=E4rber <afaerber@suse.de>

--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Felix Imend=F6rffer, Jane Smithard, Dilip Upmanyu, Graham Norton; HRB=

21284 (AG N=FCrnberg)


--NGubmuQWF8p0L662mvgUTwp27eogPw0JI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVX4+TAAoJEPou0S0+fgE/61oQAIIlc6qJ4pWt3nX9Yckg+uqF
1BjibhteOVF5/dJIm1lPJTNrwJahTjjiV3Wk0j9bYV8i8UDRwHieOsqJx9adstM/
VSM/fAQr1ex3Fzx6II5q16bKIZ6vHQwrcgDEIK+W32Q5pmEyCa03wF5zalEln6e/
8mOgK/GaVIDy6KQUlzY+s+6yGY4HeYuzvp/b/NtXUJqOUv0KpFKLvjfhNX4TTUcy
W2uGBwnbwmPGBvkMlbm6jHcd04kpjmNr4zP1e4VW4cLaiP4KZ8psbP27raTWfO9V
sBaQuxcD1GrvJIamFHmXo4A0xMZzwYPpPjWtSY6QI8Vcgo5PU6KRMDXpNWClKFAw
0sQ7/Ic/1NNTFM2PcVbrfMEurpgXB+y+8ukrcK9Uc/aRdX1NVowD8ceKGvAiAV7W
QcRbzd0K+IcpJdR9loe2MOJLX4nZxNTKYhm3Gqb2XXjCXKDyr18/3hoba5ZktxEE
7Y7WZLIbT8j2G9w7OBP+xHhGC71Jl723VHirS1oUoZJ7jidd1UfRTissm9/hE/4a
HV7CKO2HqHBUm4FAripxEKDv4j5ucMgPAXE/F5k3UjiC4hQGFMVE1PSmgCQpHTyr
wEpZxGXWvEzY9prjOCEZoaQJ2GnNyRcD+TIYjzT1QdwCneQfwOlW/G3e1lDRp7CM
G8xXS3KNZkfwX4R7bNoG
=blWh
-----END PGP SIGNATURE-----

--NGubmuQWF8p0L662mvgUTwp27eogPw0JI--
