From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] clkdev: Add default clkdev.h
Date: Tue, 3 Jul 2012 11:12:09 +0100
Message-ID: <20120703101209.GH29030@opensource.wolfsonmicro.com>
References: <1341252250-26476-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20120703120059.f153bd696269528be2baa1bc@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MP5ln1Rcf9Bvi+ZW"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:55532 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751642Ab2GCKML (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jul 2012 06:12:11 -0400
Content-Disposition: inline
In-Reply-To: <20120703120059.f153bd696269528be2baa1bc@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, mturquette@ti.com, Russell King <linux@arm.linux.org.uk>


--MP5ln1Rcf9Bvi+ZW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 03, 2012 at 12:00:59PM +1000, Stephen Rothwell wrote:
> On Mon,  2 Jul 2012 19:04:10 +0100 Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > +#define __clk_get(clk)	({ 1; })
> > +#define __clk_put(clk)	do { } while (0)

> So why not:

> struct clk;

> static inline int __clk_get(struct clk *clk) { return 1; }
> static inline void __clk_put(struct clk *clk) ( )

No idea, I'm just taking the existing default header and making it more
generally available.

--MP5ln1Rcf9Bvi+ZW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP8sVyAAoJEBus8iNuMP3dO+EP/1/NvhnEeMpxZCPmJVpwNK3q
5MQl++aCYr31u6xZSO4XMipUYTT+Iqn8tp8UwpRpFeFCEOAcEOfFeJ2e7KyZyeV3
XtsxcoTHkAyvqm9dtMVcZ2bm3vwIe5EQ28JxQ4h7FSuPfrdJIjGDXMOoSCIZjXBS
DYJYGB00jBoHbgDt5yCWhXL0WK7uHum1o86choTUlrVpZv0CEi2Xr0NVLVgxRhKc
fkhI3h7HK5Qi/9B4lB1JfJ2lLc+UNR0+Hgp22/LPafi3IAcYH46RN0U5AKMoGEcJ
HSJ6VkB7YwDt8du0kMGJWn888xGk448WtXFgtsSAyBIsYy2gjmY0VbpmQ00YkF7R
uj3H7X4ovILc8jUM7i8fdS1UOAGQweW9RUZ9eDqv52IU8WiyFjDRD2DevQTfPAvP
7hlWKMIFOpeUE/rOEy76iqA78kwPeKe9x7e9FOZVcWgbxNExoIpGmbjd3u2zw9cR
QdW/iQbpURVvgVHc2B3c3rEp+p40okIQbd12ZJw3M3woTlJ4qtsBFoHvzwAUfup8
rhFcJvYNxrKFycld1qOuNuXh43IRkZhJ4m46x0q26EE8J1xfwpJoyHdVqbwnHiJs
7hnryRMAsbAai+xguORksSizpMwcoNF02WEFdtjBEisNbBn9eMR/LNXz77gOQDKb
XeE2R0GTrhoVulGf7jKb
=ZXyK
-----END PGP SIGNATURE-----

--MP5ln1Rcf9Bvi+ZW--
