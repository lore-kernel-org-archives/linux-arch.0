From: James Hogan <jhogan@kernel.org>
Subject: Re: [PATCH v3 1/3] alpha: Use OPTIMIZE_INLINING instead of
 asm/compiler.h
Date: Mon, 7 May 2018 09:42:41 +0100
Message-ID: <20180507084240.GA26491@jamesdev>
References: <cover.ebc99f68d5063a817328b9184d747f539800cff0.1523959603.git-series.jhogan@kernel.org>
 <a20761a842efe590da08e835ecc5690a4cf50213.1523959603.git-series.jhogan@kernel.org>
 <CAEdQ38HfabRWgfLTStuZDOz0yjnfMNRc5beRdVcQhFfMi1SFKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEdQ38HfabRWgfLTStuZDOz0yjnfMNRc5beRdVcQhFfMi1SFKg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Turner <mattst88@gmail.com>
Cc: linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha <linux-alpha@vger.kernel.org>, linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 06, 2018 at 12:33:21PM -0700, Matt Turner wrote:
> On Tue, Apr 17, 2018 at 3:11 AM, James Hogan <jhogan@kernel.org> wrote:
> > Use CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING and CONFIG_OPTIMIZE_INLINING
> > instead of undefining the inline macros in the alpha specific
> > asm/compiler.h. This is to allow asm/compiler.h to become a general
> > header that can be used for overriding linux/compiler*.h.
> >
> > A build of alpha's defconfig on GCC 7.3 before and after this series
> > (i.e. this commit and "compiler.h: Allow arch-specific overrides" which
> > includes asm/compiler.h from linux/compiler_types.h) results in the
> > following size differences, which appear harmless to me:
> >
> > $ ./scripts/bloat-o-meter vmlinux.1 vmlinux.2
> > add/remove: 1/1 grow/shrink: 3/0 up/down: 264/-348 (-84)
> > Function                                     old     new   delta
> > cap_bprm_set_creds                          1496    1664    +168
> > cap_issubset                                   -      68     +68
> > flex_array_put                               328     344     +16
> > cap_capset                                   488     500     +12
> > nonroot_raised_pE.constprop                  348       -    -348
> > Total: Before=3D5823709, After=3D5823625, chg -0.00%
> >
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: James Hogan <jhogan@kernel.org>
> > Cc: Richard Henderson <rth@twiddle.net>
> > Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> > Cc: Matt Turner <mattst88@gmail.com>
> > Cc: linux-alpha@vger.kernel.org
>=20
> Looks fine to me.
>=20
> Acked-by: Matt Turner <mattst88@gmail.com>

Thanks

>=20
> Should I take it through the alpha tree?

I'll take all 3 through the MIPS tree if thats okay with you, as its a
prerequisite to allowing MIPS to override stuff in linux/compiler-gcc.h
using asm/compiler.h, which is needed to fix build breakage in 4.17.

Thanks
James

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvARdwAKCRA1zuSGKxAj
8lBgAQCP2oPVxlMnAfCr0Yo39Uxm60KcRkh2IaN7I4Yy70sTUgD/WjirGCDfJ2kX
nBSvzFt0+SEPc8JfmbIC+plydOz0LQ4=
=XudF
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
