From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 00/11] arm64: Branch Target Identification support
Date: Thu, 27 Feb 2020 13:13:00 +0000
Message-ID: <20200227131300.GB4062@sirena.org.uk>
References: <20200226155714.43937-1-broonie@kernel.org>
 <202002261343.3B2ECE90@keescook>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:50276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729073AbgB0NND (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Feb 2020 08:13:03 -0500
Content-Disposition: inline
In-Reply-To: <202002261343.3B2ECE90@keescook>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H . J . Lu " <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Florian Weimer <fweimer@redhat.com>, Sudak


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2020 at 01:44:59PM -0800, Kees Cook wrote:

> Looks good. I sent a few more Reviewed-bys where I could. Who is
> expected to pick this up? Catalin? Will?

Thanks, I'm expecting it'll go through the arm64 tree.

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5XwFwACgkQJNaLcl1U
h9BVcAf+IT0x9Rm5Qvg7iutzvlk4f961QXDY77LCMmKkuIyjzf2qoM3UKYdN5A+s
XCh02Tc8GwVaSWaipJplvGn2y3aPrb1oLBU8yp2zkFHk3UuDdkrIhwTqmg9EH6qO
HMxhgu7d6bKkjgpIMZe78MrbRRJUCej3S9SHehfJjGHStqjcyN65h4a7GJZUkHkB
8UMKB9ln6VV8BZHBWEZZa875jAojja3k2OzUTrtBmbq7WsuQIsIqjVblRGOIZXNQ
6ok8vsW83J6iRtR6J46oSoIJqkXjfYucnbP7ulIOQDtUMvpS0O/C982bW0mtMvLB
Qy9hBI9hA/mdTTxfXA8PF2WvD3HTHQ==
=r3OK
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
