From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v8 00/11] arm64: Branch Target Identification support
Date: Mon, 9 Mar 2020 21:05:05 +0000
Message-ID: <20200309210505.GM4101@sirena.org.uk>
References: <20200227174417.23722-1-broonie@kernel.org>
 <20200306102729.GC2503422@arrakis.emea.arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qySB1iFW++5nzUxH"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:57536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgCIVFH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 9 Mar 2020 17:05:07 -0400
Content-Disposition: inline
In-Reply-To: <20200306102729.GC2503422@arrakis.emea.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H . J . Lu " <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Florian Weimer <fweimer@redhat.com>, Sudakshina


--qySB1iFW++5nzUxH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 06, 2020 at 10:27:29AM +0000, Catalin Marinas wrote:
> On Thu, Feb 27, 2020 at 05:44:06PM +0000, Mark Brown wrote:

> > This patch series implements support for ARMv8.5-A Branch Target
> > Identification (BTI), which is a control flow integrity protection
> > feature introduced as part of the ARMv8.5-A extensions.

> Does this series affect uprobes in any way? I.e. can you probe a landing
> pad?

You can't probe a landing pad, uprobes on landing pads will be silently
ignored so the program isn't disrupted, you just don't get the expected
trace from those uprobes.  This isn't new with the BTI support since
the landing pads are generally pointer auth instructions, these already
can't be probed regardless of what's going on with this series.  It's
already on the list to get sorted.

--qySB1iFW++5nzUxH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5mr4AACgkQJNaLcl1U
h9Blwwf8CR8zwN1uUuwJWSzyItw8ZiSf2fLHJ6Smgao/rc/O876dKM+ZZQqzuQ3B
kG8nQyocUyEa7jghPeuTnqveuK4hpSDe/++EG1Ncl+7gMe8pmbTLVfOCYZzs1TPc
3QiBL54YSDsAtYFT/Q+2Q27pv4vP3Xm7vsyhvWHYujG6HuFVt3Oco0Nnh8ipL6Eo
XPOS5rfxJTLe2vcwFfj6Nf03zK+DoS2gU4LAXCjQeXGuwGep9BYzoEQhXk8srTA7
ZJSrDH0XTMYRRmkmHTcppBRfqbKwES2xZYt6GDRWKqG7yvnEcq+v1MFR2Mgw87ZA
eQr2xNhLMxU8o5zqjJiwHMI5S3jMoQ==
=TGul
-----END PGP SIGNATURE-----

--qySB1iFW++5nzUxH--
