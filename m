Return-Path: <SRS0=13L8=5I=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from foss.arm.com ([217.140.110.172]:51124 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbgCWPcb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Mar 2020 11:32:31 -0400
Date: Mon, 23 Mar 2020 15:32:28 +0000
From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v10 00/13] arm64: Branch Target Identification support
Message-ID: <20200323153228.GE4948@sirena.org.uk>
References: <20200316165055.31179-1-broonie@kernel.org>
 <20200320173945.GC27072@arm.com>
 <20200323122143.GB4892@mbp>
 <20200323132412.GD4948@sirena.org.uk>
 <20200323135722.GA3959@C02TD0UTHF1T.local>
 <20200323143954.GC4892@mbp>
 <20200323145546.GB3959@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2hMgfIw2X+zgXrFs"
Content-Disposition: inline
In-Reply-To: <20200323145546.GB3959@C02TD0UTHF1T.local>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Will Deacon <will@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, "H . J . Lu " <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Florian Weimer <fweimer@redhat.com>, Sudakshina Das <sudi.das@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <20200323153228.Qs9c_Rbae1pCurOXEtIF9h3FXIhT5RdMimhT6ivR7Jc@z>


--2hMgfIw2X+zgXrFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 23, 2020 at 02:55:46PM +0000, Mark Rutland wrote:
> On Mon, Mar 23, 2020 at 02:39:55PM +0000, Catalin Marinas wrote:

> > So this means that the interpreter will have to mprotect(PROT_BTI) the
> > text section of the primary executable.

> Yes, but after fixing up any relocations in that section it's going to
> have to call mprotect() on it anyhow (e.g. in order to make it
> read-only), and in doing so would throw away BTI unless it was BTI
> aware.

Ah, of course - I forgot that's not a read/modify/write cycle.  I'll
send the comment version.

> > That's a valid point. If we have an old dynamic linker and the kernel
> > enabled BTI automatically for the main executable, could things go wrong
> > (e.g. does the PLT need to be BTI-aware)?

> I believe that a PLT in an unguarded page needs no special treatment. A
> PLT within a guarded page needs to be built specially for BTI.

Unguarded stuff is unaffected.

--2hMgfIw2X+zgXrFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl541osACgkQJNaLcl1U
h9A4pAf+IvJV9iWwP6vJKgT868+5ZjhSjiVsOKwt0PqgVzwOcV5HIX7k7mlf91GM
k1Fn/ZsPWecmng93bj0iUlMtnBCoxTyE4F20odXx1vgUhscr6RjCvtPkGlLEgYEz
0Cs6mB6NDjJxcTJDxB54HIXhlP4lL3Jo++u+yRS2/0lLHba08FUu7/gJYjh7TTCV
n9kw50W8boGR1DgRe51u0Yn08RqNt2Boe/tauY2huT9H5zgbM2d40jv7qVcdTffJ
PWeuF23KN9w9E/burfR4MrA8JtLgZHrnjt5cuSXuogtP28D1UcfgaKfr8JSDPT6P
VjN8hBGRZhte6hqR58+ZsNUrKDDLIw==
=1CsH
-----END PGP SIGNATURE-----

--2hMgfIw2X+zgXrFs--
