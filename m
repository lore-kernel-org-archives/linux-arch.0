Return-Path: <SRS0=8toe=6G=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgDVPoj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Apr 2020 11:44:39 -0400
Date: Wed, 22 Apr 2020 16:44:36 +0100
From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v10 00/13] arm64: Branch Target Identification support
Message-ID: <20200422154436.GJ4898@sirena.org.uk>
References: <20200316165055.31179-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="I/5syFLg1Ed7r+1G"
Content-Disposition: inline
In-Reply-To: <20200316165055.31179-1-broonie@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H . J . Lu " <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Florian Weimer <fweimer@redhat.com>, Sudakshina Das <sudi.das@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <20200422154436.xuh3cr14E4hy66rbDKbKDY2NppTFg6NDp-_LIcx0axk@z>


--I/5syFLg1Ed7r+1G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 16, 2020 at 04:50:42PM +0000, Mark Brown wrote:
> This patch series implements support for ARMv8.5-A Branch Target
> Identification (BTI), which is a control flow integrity protection
> feature introduced as part of the ARMv8.5-A extensions.

I've not resent this since the branch is still sitting in the arm64 tree
but it's also not in -next at the minute - is there anything you're
waiting for from my end here?

--I/5syFLg1Ed7r+1G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6gZmMACgkQJNaLcl1U
h9AYVQf/ajN/x5F2wiYIKFjzo2+jXBlUnF9FczZVVrXFDW2YeidwJw/eKCefOPQY
5HHDihIrHZBRdOrdnQ7UE8UIfQZMI8oOguL84O4O6IwCnwTZpEOuNhYHjCS1qMUI
nAHZjSGlSnKBp4MwttY/LRRomyGW74ukfnOU91v91LR6Aakw31PUIQZ8EDOT84jC
0hMnIjzmaA9LzLQRrMMQqSLi5FdLg4ps9NEb4zVklz94U/mzf4l+GzZczg6eJI1S
JUz9EwBdrJIwPCRdBoHCQbrVCuiCbvDjhobVK0tKRycjOFvWXh0nDWRWFwfZiD68
dpJmkHE2POaVhBEWnwhUJ57489SMCA==
=z9OW
-----END PGP SIGNATURE-----

--I/5syFLg1Ed7r+1G--
