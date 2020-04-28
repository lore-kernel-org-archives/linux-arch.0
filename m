From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v10 00/13] arm64: Branch Target Identification support
Date: Tue, 28 Apr 2020 16:12:05 +0100
Message-ID: <20200428151205.GH5677@sirena.org.uk>
References: <20200316165055.31179-1-broonie@kernel.org>
 <20200422154436.GJ4898@sirena.org.uk>
 <20200422162954.GF3585@gaia>
 <20200428132804.GF6791@willie-the-truck>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bg2esWel0ueIH/G/"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200428132804.GF6791@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H . J . Lu " <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Florian Weimer <fweimer@redhat.com>S
List-Id: linux-arch.vger.kernel.org


--Bg2esWel0ueIH/G/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 28, 2020 at 02:28:05PM +0100, Will Deacon wrote:

> I'm happy either way, but it would be nice to base other BTI patches on
> top of this branch. Mark -- is it easier for you to refresh the series
> against v5.7-rc3, or leave it like it is? Please just let me know either
> way.

It's probably easier for me if you just use the existing branch, I've
already got a branch based on a merge down.

--Bg2esWel0ueIH/G/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6oR8QACgkQJNaLcl1U
h9DRUQf/dlpsgh2tPKIHik+DY7EQMgJJUmD7ZJRWxntS4/wM6bMOxOT617T0Cljr
ERZBQ8cyC6N3d2HdeY1TyjMenKaCWrMVps1bPjuZqZYMEGEBXWi3TwoW8hPojTw4
l3lh7Z5Eg3da+YBS1sOzymIlfcPg7JRA7f7Z9KtbSs1srWTTetHurhtK59xD9l0p
B6QNwoJBKybECHjkIsNK8xOc03nY4vmXcrbHLWs0POF8gJRVaLLrJxgozJ6q4Nj7
9VEgiQWIkvLH7daFvPPyagp1WWdrxt6noTK2hkNvB5q46VxasUOoybeKB7IX6/jb
Sj4vxb1g49Kcf1pjRwRSz1rGe/E0Dw==
=09DA
-----END PGP SIGNATURE-----

--Bg2esWel0ueIH/G/--
