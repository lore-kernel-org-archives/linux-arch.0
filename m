Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:53301 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203Ab3AJIhC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Jan 2013 03:37:02 -0500
Date: Thu, 10 Jan 2013 09:36:47 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 1/4] gpiolib: introduce descriptor-based GPIO interface
Message-ID: <20130110083647.GA26256@avionic-0098.adnet.avionic-design.de>
References: <1357629535-26033-1-git-send-email-acourbot@nvidia.com>
 <201301081259.29839.arnd@arndb.de>
 <CAAVeFu+4VbCbj9TaeMm+NMDJ9_M4-j4O0ONF7Yh_un63wS38+Q@mail.gmail.com>
 <201301091035.23206.arnd@arndb.de>
 <20130109104414.GF3931@n2100.arm.linux.org.uk>
 <20130109111055.GG3931@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <20130109111055.GG3931@n2100.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Alexandre Courbot <acourbot@nvidia.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Guenter Roeck <linux@roeck-us.net>
Message-ID: <20130110083647.w_GZyQj2QYRctC5SSTgSKjvPjfqt09iL_JxvwTF3Nzc@z>


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2013 at 11:10:55AM +0000, Russell King - ARM Linux wrote:
[...]
>         err =3D gpio_request(en_vdd_1v05, "EN_VDD_1V05");
>         if (err) {
>                 pr_err("%s: gpio_request failed: %d\n", __func__, err);
>                 return err;
>         }
>=20
>         gpio_direction_output(en_vdd_1v05, 1);
>=20
>         regulator =3D regulator_get(NULL, "vdd_ldo0,vddio_pex_clk");
>         if (IS_ERR_OR_NULL(regulator)) {
>                 pr_err("%s: regulator_get failed: %d\n", __func__,
>                        (int)PTR_ERR(regulator));
>                 goto err_reg;
>         }
> ...
> err_reg:
>         gpio_free(en_vdd_1v05);
>=20
>         return err;
> }
>=20
> So 'err' here is never set.  when IS_ERR_OR_NULL evaluates true.
> Setting 'err' to PTR_ERR(regulator) is not correct because a NULL return
> sets 'err' to zero.

FWIW, this one is fixed in the Tegra PCIe series I posted yesterday.

Thierry

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ7n2fAAoJEN0jrNd/PrOhtWoQAIsub3xEWnrISfzqdxi0DgBM
BLYxCMLkSmhXzNdhhvRKVE/G1O/YaH/vGwR/NsawCEm5/LzCIiqa8qLwUlkcslfV
KpojQmCqR7ajIDC4YhPC4BZHoTbOSZiDWPjEuYnu7cY42lWLlYLpUrIuj1EPpej4
SYAk2giYo+r1j+Ysp5875zCR+RusWLnKe6np+3ZdglFLOS33g4AjI2a9BTDZhEZN
Pe3JLvGbE0r5/5DXicHkHqQ1e+YnqW5M7LoVBSBG+52RQtZN13gzS1AKmi+pLlS6
syA5SJjZyfuAT9PFOE7g67kQDhmwSu6P5Ea+hgeGWOJeDMtdILw9g9BF1P9DgIxp
Rhn0pK2lCIqamGj1i2on5kehxvvuUbZ+A9h4aF1uQ//GLUI609jhHJGuV2qJsJVk
imK8ujvR44foHd50rcag1XJbiVzcnpMJ9hrVX1cqqrCMzmtsNVLYGZsnVCH8G0Yk
4TTAtijQbRJWJq8TC0tt0UzDdQ35PIOa3WJf+bqad1fpVONbqBHpzax5/xbBW9KR
TEW/lfukgEF2Vz+KU5k6cUnonJypGWp+DXuTKBT2BNoacZRuBoy1TwxmDkiNsptm
rckwDHaz5NsmFmziXJwuyvXqcs0tvdeJcdrTdn6LZ05xxJa8inYMUFTjDPv9CXp3
UxWTJMbu2DgYrcw51W9l
=9ho0
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
