From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 11/20] sound, skylake: switch from ioremap_cache to
 memremap
Date: Mon, 19 Oct 2015 16:26:41 +0100
Message-ID: <20151019152641.GC32054@sirena.org.uk>
References: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
 <20151009221635.32203.30755.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:37422 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbbJSP0t (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 19 Oct 2015 11:26:49 -0400
Content-Disposition: inline
In-Reply-To: <20151009221635.32203.30755.stgit@dwillia2-desk3.jf.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Jeeja KP <jeeja.kp@intel.com>, linux-arm-kernel@lists.infradead.org


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 09, 2015 at 06:16:36PM -0400, Dan Williams wrote:
> In preparation for deprecating ioremap_cache() convert its usage in
> skl-nhlt to memremap.

> -void __iomem *skl_nhlt_init(struct device *dev)
> +void *skl_nhlt_init(struct device *dev)

Why are we loosing the annotation here?

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWJQuxAAoJECTWi3JdVIfQJEEH/ibHxOtm6tvC0pERMZsABhG4
x/bm479haC6N7K2ziD+Gox48/tNf8RpVtGFQYLp7ksgd1iOn9Dm1WJPyspJGT8gI
MwBHqC/BTCni6IKumKT1j+JX7zNZxvGC4nNfgrktYz4OAbbyDYS0oVKMEB3hnq/G
9qO/6hsq3e/jWKQSbgmr2Q/7hZwtbl9BgNsWASxPHTRHyY5xftBkbGMuIi7TeTbB
uSeWskfA8HRJwc5HWveZXuFxU5tQRQLXS9p56NWi5MSQBP9CqVC/Helv8jXNpboQ
bJgburydMxVZViYvzIsSP3irf4DXxhReAisvTdyDxSDDxntxi5neh50PrYzlRdA=
=yjCk
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--
