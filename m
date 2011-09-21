From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 25/57] ata: irq: Remove IRQF_DISABLED
Date: Wed, 21 Sep 2011 12:35:48 +0200
Message-ID: <20110921103548.GD1966@pengutronix.de>
References: <1316597339-29861-1-git-send-email-yong.zhang0@gmail.com>
 <1316597339-29861-26-git-send-email-yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59021 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432Ab1IUKfw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 21 Sep 2011 06:35:52 -0400
Content-Disposition: inline
In-Reply-To: <1316597339-29861-26-git-send-email-yong.zhang0@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yong Zhang <yong.zhang0@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2011 at 05:28:26PM +0800, Yong Zhang wrote:
> Since commit [c58543c8: genirq: Run irq handlers with interrupts disabled=
],
> We run all interrupt handlers with interrupts disabled
> and we even check and yell when an interrupt handler
> returns with interrupts enabled (see commit [b738a50a:
> genirq: Warn when handler enables interrupts]).
>=20
> So now this flag is a NOOP and can be removed.
>=20
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk55vgQACgkQD27XaX1/VRvQ1wCePVi3NYR2/TV6dOmwNrpbzNMf
5DcAoJ9trCs7eHheEmNfoOm8RIhyru2n
=pjxJ
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--
