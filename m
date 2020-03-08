From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH 3/3] docs: atomic_ops: Steer readers towards using
 refcount_t for reference counts
Date: Sun, 8 Mar 2020 22:25:49 +0100
Message-ID: <20200308212549.GD2376@latitude>
References: <20200308195618.22768-1-j.neuschaefer@gmx.net>
 <20200308200007.23314-1-j.neuschaefer@gmx.net>
 <7ff7dc4e-d606-e2a1-edce-a0485e948e48@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UFHRwCdBEJvubb2X"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7ff7dc4e-d606-e2a1-edce-a0485e948e48@infradead.org>
Sender: linux-doc-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, linux-doc@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


--UFHRwCdBEJvubb2X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 08, 2020 at 02:07:46PM -0700, Randy Dunlap wrote:
> On 3/8/20 1:00 PM, Jonathan Neusch=C3=A4fer wrote:
[...]
> > +        More recently, reference counts are implement using the
>=20
>                                                implemented

Indeed, good catch.

Thanks,
Jonathan Neusch=C3=A4fer

--UFHRwCdBEJvubb2X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl5lYtYACgkQCDBEmo7z
X9sxeBAAoyLudMLbrFONlymj1JeXx3yBqw9ZfcOD64ryxfRRF2m1ubwkq6vR+prR
YK0WpHHC9iG6gaW6cF0cZtyt+ees8p2KrOgrwVV9Zol8TRQjM9Y2MdOD6YO5+qQn
AzzjKW6kA4F8la6p1YRXO5ZNZMfzZiJ+7/v7nPtsLzTPcU2TJsEgVGsyuLgh3uxd
AyOtCQmzlQseb6F75DL4gz2gujhqp/UReekuSDrRpyeAHNs24z8ImDNm6CvLDGAH
8bWD/XlopYXE50OalKh150cd1p6xlf8XO8fHIuUqhlJfb1caCBxLQy2Hsc13IyWR
seT0BR+CCr219TO0K0fo2MMjK1gICUXpZqGH2q3Jv3Jbb77BDLsnugOyHQ2A7Bbr
pb//s740vURsI3y3D0+GhttA6OuS5LY4RdmcRqcUDWdem5c4mEa//5F6C/d/vcV5
9Wfuz7A7RAZJjW8RzY3d6G44GumNOaRav1CUm3z9Tuy7NHgzUP2KGxshZAT7pbRg
JOUiNzwKjroh7+1qo6QB43p5q0SEt9WoiCNr6TItHRSaMTIKTWmk+t1MnQyJUwik
AcgOcDfcvXhaGMMFHx9uweA9m7q9p6N+b2CD4KesE6PiYS3mU7lEBlTtBRBMZTMP
w5AIXElmYgW3xubTKzsfe3Z8U2vCnEhIs/DWjBVc/36QJTWvhU4=
=kF/P
-----END PGP SIGNATURE-----

--UFHRwCdBEJvubb2X--
