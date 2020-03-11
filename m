From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v8 00/11] arm64: Branch Target Identification support
Date: Wed, 11 Mar 2020 19:15:19 +0000
Message-ID: <20200311191519.GK5411@sirena.org.uk>
References: <20200227174417.23722-1-broonie@kernel.org>
 <562edd23-9d86-800e-aae3-e54c92601929@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mGCtrYeZ202LI9ZG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <562edd23-9d86-800e-aae3-e54c92601929@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H . J . Lu" <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Florian Weimer <fweimer@redhat.com>, Sudakshina Das <sudi.>
List-Id: linux-arch.vger.kernel.org


--mGCtrYeZ202LI9ZG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2020 at 05:35:39PM -0800, Richard Henderson wrote:
> On 2/27/20 9:44 AM, Mark Brown wrote:
> >  * Binutils trunk supports the new ELF note, but this wasn't in a release
> >    the last time I posted this series.  (The situation _might_ have changed
> >    in the meantime...)

> I believe this support is in binutils 2.32.

It looks like it's actually 2.33 but either way it's in a release,
thanks for prompting me to check.  I've updated this for v9.

--mGCtrYeZ202LI9ZG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5pOMYACgkQJNaLcl1U
h9AOkgf/SY/gSI7QW/Lbe29z6/u9w1lrepP1itRV8ICgiWASwxjzBxEUDfHMgTsV
Ng7Lx+w79lkeoWKj1id3jmu9SXG8pAmKiBpnc/iGNpkUs1evKFp2XyaqMLl5w1mO
DaNzX4HwWOKK6mjLXS1ferTsYgP0h0SnrJpODS/3HbvD6Txoi8b/m+XvAqiKrJi9
UiPK06ESXjNibgAx2JUDWtuKumjSFWEEGXDx2q6lCI06ZEvBIdkSK5aB0yJwYJqc
k60lhGcyCoMK6T9zNOCutbhZbQpGMlr+GInkEjkuuf/xo6SLfmuZx5hiFJHAumim
NrgBSedG1UXpaC5rINKAgEc2IacPkQ==
=4P3c
-----END PGP SIGNATURE-----

--mGCtrYeZ202LI9ZG--
