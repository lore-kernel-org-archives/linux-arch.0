From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 4/5] clk: sunxi: Use CLK_IS_CRITICAL flag for critical
 clks
Date: Thu, 4 Jan 2018 14:13:32 +0100
Message-ID: <20180104131332.rhzyuigd2gfivq7k@flea.lan>
References: <20180103013516.18844-1-sboyd@codeaurora.org>
 <20180103013516.18844-5-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="etinat53jc4ove2b"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:45851 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbeADNNe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Jan 2018 08:13:34 -0500
Content-Disposition: inline
In-Reply-To: <20180103013516.18844-5-sboyd@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arch@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>


--etinat53jc4ove2b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2018 at 05:35:15PM -0800, Stephen Boyd wrote:
> We'd like to privatize __clk_get(), but the sunxi clk driver is
> calling this function to keep a reference held on the clk and
> call clk_prepare_enable() on it. We support this design in the
> clk core now with the CLK_IS_CRITICAL flag, so let's just use
> that instead.
>=20
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--etinat53jc4ove2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlpOKHwACgkQ0rTAlCFN
r3QDCA//SmCXHtbuMQfMJWmbDbKCx+5LEax6Fq4LsTRHOF4DO7ako/6erlnbZHtX
PEFXesLyaegqn5eJKX4cNn7bM0+ar1LP4m27q+lCbkk8QdAWJnCSMqPUmy+ab/Xa
Ao7HwCrnrPEi51oVzJOvIGBVVaH4gYk6XcufmSWmCk1bynPi/Pl4x09fO5LXNbto
uQlaE+P3gYXb2UD4XM+HZVyCXROQrw3YF02m2O1vIBYf6fWXVQVki9e27qHxCTP0
JDmUZ/eGX1zSeGgNSot3iClnBT0+Rz6QSw3+pSkCYR0B7XI91xJ91Ev2RqyQWB1F
SkSGIquu4WET1JYacjqDIyhSqxfytpglLzWyUCkeNWEFMtL6gh1BEiNekVaonrem
murJxA6TlFRE8txpY/CEBufkmQ/jH2mCkrBH7WVVHnejBPtrnESSZSI42JLjofEy
B6ypUFgjXKpk7b05eN1c5LVAWScb/FzpvwEGxGfHSIrm1KfHtAv93jd6Fnp47wA8
BeckKghEJiHjwEne+7BXusT3mDkCtmtrxXHA+Fe6TZEgbu51Paq4f3Uuipx4sAtK
YD/+7P2llXHCsY3Q3372j9NrG7MnzeWLJ9A+ahBmBHO95q3fZQg4SY5gZQmW5azL
Nc0paUf7Y/NBxgt3gku3hi47TRT5fU9pFBoIfk+htgUR0CbLo5I=
=BvUP
-----END PGP SIGNATURE-----

--etinat53jc4ove2b--
