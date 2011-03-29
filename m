From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: MACH_TYPE undeclared error
Date: Tue, 29 Mar 2011 08:54:57 +0200
Message-ID: <20110329065457.GG30938@pengutronix.de>
References: <AANLkTimSWBx-FTj1WXpOgFXyH6rLSWFNzayLd_yOj7d_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43255 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488Ab1C2Gy7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2011 02:54:59 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimSWBx-FTj1WXpOgFXyH6rLSWFNzayLd_yOj7d_@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Madhavi Manchala <madhavi.linux@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Mar 29, 2011 at 12:01:40PM +0530, Madhavi Manchala wrote:
> Dear All,
>=20
> I have defined a MACHINE_START macro in my board C file as follows.
>=20
> MACHINE_START(S3C2510, "S3C2510")
> 	.init_irq	=3D s3c2510_init_irq,
> 	.timer		=3D &s3c2510_time_init,
> MACHINE_END
>=20
> When I try to compile this C file, I am seeing the following error me=
ssage.
>=20
> arch/arm/mach-s3c2510/s3c2510.c:35:1: error: 'MACH_TYPE_S3C2510'
> undeclared here (not in a function)
you need a line defining S3C2510 in arch/arm/tools/mach-types.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
