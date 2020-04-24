From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH 1/6] bitops: Introduce the the for_each_set_clump macro
Date: Fri, 24 Apr 2020 12:42:00 -0400
Message-ID: <20200424163904.GA7742@icarus>
References: <20200424122521.GA5552@syed>
 <20200424141037.ersebbfe7xls37be@wunner.de>
 <CACG_h5prcXVdk6ecn2WoT1jas3K6UF+KCrxAM9u4_ZLSyPKCEA@mail.gmail.com>
 <20200424150058.xadjxaga3csh3br6@wunner.de>
 <20200424150828.GA5034@icarus>
 <20200424163410.GD185537@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200424163410.GD185537@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Syed Nayyar Waris <syednwaris@gmail.com>, akpm@linux-foundation.org, arnd@arndb.de, Linus Walleij <linus.walleij@linaro.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2020 at 07:34:10PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 24, 2020 at 11:09:26AM -0400, William Breathitt Gray wrote:
> > On Fri, Apr 24, 2020 at 05:00:58PM +0200, Lukas Wunner wrote:
> > > On Fri, Apr 24, 2020 at 08:22:38PM +0530, Syed Nayyar Waris wrote:
> > > > On Fri, Apr 24, 2020 at 7:40 PM Lukas Wunner <lukas@wunner.de> wrot=
e:
> > > > > On Fri, Apr 24, 2020 at 05:55:21PM +0530, Syed Nayyar Waris wrote:
>=20
> ...
>=20
> > > > So, this function preserves the behaviour of earlier
> > > > bitmap_set_value8() function and also adds extra functionality to
> > > > that.
> > >=20
> > > Please leave drivers as is which use exclusively 8-bit accesses,
> > > e.g. gpio-max3191x.c and gpio-74x164.c.  I'm fearing a performance
> > > regression if your new generic variant is used.  They work perfectly
> > > fine the way they are and I don't see any benefit this series may have
> > > for them.
> > >=20
> > > If there are other drivers which benefit from the flexibility of your
> > > generic variant then I'm not opposed to changing those.
>=20
> > We can leave of course bitmap_set_value8 alone, but for 8-bit values the
> > difference in latency I suspect is primarily due to the conditional test
> > for the word boundaries. This latency is surely overshadowed by the I/O
> > latency of the GPIO drivers, so I don't think there's much harm in
> > changing those to use the generic function when the bottleneck will not
> > be due to the bitmap_set_value/bitmap_get_value operations.
>=20
> Okay, how many new (non-8-bit) users this will target?
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

Within this patchset the only non-8-bit users are gpio-thunderx and
gpio-xilinix. The gpio-xilinx has configurable port widths so in some
instances it can behave like the 8-bit users, but not always.

If you want to keep the existing for_each_set_clump8 and related
functions, ignore [PATCH 3/6] and [PATCH 4/6]. That should allow this
patchset to be just an introduction of the new generic functions without
affecting the existing 8-bit users.

William Breathitt Gray

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl6jFtgACgkQhvpINdm7
VJJDLQ//dC8JJyJuTyByjULnK5tnjcifhON861BfrOYqbQu20etmMZFIFYkAnre4
7fBxjh7tSk05AecOKxEG6va+XybbFoDuMEVftcIJ/FGf69Gw4ml6lD2PPP/HFiJJ
jh0BnBIwP1B+gbJYtGnW5aFWZWPYkBRbSmN4QEn5TQ5x06mCCxdlSIAh2jPpnlZD
9P67mVq1m59i8/ZcEG2YD8oNwK6WVYB0wYvbO42ixVAJfAmfjD4o0/V+8Lt2K4Gs
sPEVpwJMfxBbLJDYFaQh+CY+32Acujkfo+CwqorKgMghNciLrrH3jwfGPv1vUvL4
/7v26sjRraruBlHMAakvzeV2o5BCyIaUxEX/zXMm7OgLOes7unLpFtrf1PkDBEP0
H/QUQUWomI5Qq2HTjFzMl2zj2ohVQjFdMpLyFZpssgpbOjdO3DXWuLqDMs5Amzp3
4ATQvbwdNwHRMoZp1fs1aCcE0UGXDKH+lc4+yLH0tmVHX+uC0x91D0Pdl2epR+k6
JD86YfHcN9TAG1x35KiA2V3F/2MaPwydqjaGLi7TaGYxjFEV+kLWcT1qjhUrVlCL
ifgrvaI1TfPpYDi0CgsxQFiD6NXGH8CUIK3Y9fB8vMn/qSwuSCCGQSeDfsVRTk9k
YHS7FpJYHJ81HVj3N3UI7XoM+wCvkgrp5X3bVeePTbykiA8EruQ=
=6E0z
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
