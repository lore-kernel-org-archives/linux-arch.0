Return-Path: <SRS0=Pd00=3D=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58536 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgANR3E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jan 2020 12:29:04 -0500
Date: Tue, 14 Jan 2020 17:28:45 +0000
From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 02/12] ELF: Add ELF program property parsing support
Message-ID: <20200114172845.GF3897@sirena.org.uk>
References: <20191211154206.46260-1-broonie@kernel.org>
 <20191211154206.46260-3-broonie@kernel.org>
 <20200114163402.GH30444@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="656hIAUFSU7Oh46B"
Content-Disposition: inline
In-Reply-To: <20200114163402.GH30444@arrakis.emea.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Florian Weimer <fweimer@redhat.com>, Sudakshina Das <sudi.das@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>
Message-ID: <20200114172845.zJpmPosUEKr1IggGZ0_ylqPM2d-hl2p7sHukPTOIQ2I@z>


--656hIAUFSU7Oh46B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 14, 2020 at 04:34:03PM +0000, Catalin Marinas wrote:

> The logic looks fine to me but I'm not sure the choice of returning -EIO
> is suitable in most cases. I think apart from kernel_read() returning an
> error, there rest look like malformed ELF notes, so rather -ENOEXEC.

Sure, I don't have strong opinions either way.

--656hIAUFSU7Oh46B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4d+koACgkQJNaLcl1U
h9BzOAf/ZW4b8JHQ9qlWZwLXs7dElEQgCxM18zekE7pOdxU3oF7g7qLspavQhRB9
6VwtDC7KE1ohuOMkwPE5HFSzlOW5WyGKodH8581UTigsQ3vp5Y4OKdIwNYCmvI0O
OaPHa1Us+qy5w2fwhYFGQpJaKBAo52VFWFb1eS65cv/A1RVktrwfF0/5CUKQlOvT
eUsZAkU1zgYf5BTaFmLlhrKlfbfOZE7U3nSMfRpM9k0uHS8TkV4gJY8Krs2/IKWG
1ePbKRpoEnul7u915WZxspdgU8UI556Y1gmiJEO1RyMOWH56mWwEgHrQc/8MxLpG
AoSckdNGC+G7zG4pARh7eWJDwYq3GA==
=w1Xx
-----END PGP SIGNATURE-----

--656hIAUFSU7Oh46B--
