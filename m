From: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Subject: Re: [x86] BUG()/BUG_ON() macros cannot be disabled
Date: Tue, 25 Sep 2018 14:58:26 +0200
Message-ID: <cb93221b-d4b3-d442-7c8d-97022cfdbe80@tu-dortmund.de>
References: <9516e4b3-f9f2-b150-f019-8b1ef465efb3@tu-dortmund.de>
 <CAK8P3a1sO9HtJPo0S=s3MFK4TN0s_raNTWRTYCYBTGiyHuXg_A@mail.gmail.com>
 <649d3c5c-3d96-0ed3-cd4d-57641f0ee614@tu-dortmund.de>
 <CAK8P3a2to1LbSNizeSHE3vHaCtp5PSrVFAzy5X2mE49x3tPbxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="i7GBXgWhhOXDNszIRg5BZd7zKotn2cReU"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2to1LbSNizeSHE3vHaCtp5PSrVFAzy5X2mE49x3tPbxg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i7GBXgWhhOXDNszIRg5BZd7zKotn2cReU
Content-Type: multipart/mixed; boundary="cJKPIHbMi1BlL6u3FTCAFsNDb9ONDGZSH";
 protected-headers="v1"
From: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <cb93221b-d4b3-d442-7c8d-97022cfdbe80@tu-dortmund.de>
Subject: Re: [x86] BUG()/BUG_ON() macros cannot be disabled
References: <9516e4b3-f9f2-b150-f019-8b1ef465efb3@tu-dortmund.de>
 <CAK8P3a1sO9HtJPo0S=s3MFK4TN0s_raNTWRTYCYBTGiyHuXg_A@mail.gmail.com>
 <649d3c5c-3d96-0ed3-cd4d-57641f0ee614@tu-dortmund.de>
 <CAK8P3a2to1LbSNizeSHE3vHaCtp5PSrVFAzy5X2mE49x3tPbxg@mail.gmail.com>
In-Reply-To: <CAK8P3a2to1LbSNizeSHE3vHaCtp5PSrVFAzy5X2mE49x3tPbxg@mail.gmail.com>

--cJKPIHbMi1BlL6u3FTCAFsNDb9ONDGZSH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 25.09.2018 um 14:20 schrieb Arnd Bergmann:
>=20
> I think it's the most reasonable implementation, otherwise a
> function like
>=20
> int something(void)
> {
>       if (x)
>          return 0;
>      else
>           BUG();
> }
>=20
> will return an uninitialized value.
>=20
> The arch specific implementations usually just contain a trapping
> instruction. With CONFIG_BUG() you get a nice console output
> that indicates where this happened, but without CONFIG_BUG(),
> this is just reported as an invalid instruction (if CONFIG_PRINTK
> is still enabled), killing the current process.
>=20
>        Arnd
>=20
I see. In that case, you should really update the documentation and help
page of CONFIG_BUG. In its current version it is misleading. It can be
understood as 'It disables that macro completely.'.

Although I know what the purpose of BUG()/BUG_ON() is, I would not
consider the above example as valid C code....
Defining BUG as an endless loop to overcome GCC warnings about not
returning a value is a dirty hack for me.

- Alex

--=20
Technische Universit=C3=A4t Dortmund
Alexander Lochmann                PGP key: 0xBC3EF6FD
Otto-Hahn-Str. 16                 phone:  +49.231.7556141
D-44227 Dortmund                  fax:    +49.231.7556116
http://ess.cs.tu-dortmund.de/Staff/al


--cJKPIHbMi1BlL6u3FTCAFsNDb9ONDGZSH--

--i7GBXgWhhOXDNszIRg5BZd7zKotn2cReU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElhZsUHzVP0dbkjCRWT7tBbw+9v0FAluqMPIACgkQWT7tBbw+
9v2ARBAAln1pTyi+L4yWoHlhEAekRa9SaU6BtKiobke2SvtSEgdbrmqpQLTMPiPi
vpOPBg8seQz40tEl1PbcOu0lP0zU8sBemLZN61GreTXrjUzahBLw1Enjsz3wSwR6
rpifHSso1wjNzQaIGV0YhbRCI+94EUZ0ybZvHUtbh9502rHqhc5VP5Pf7xg4iPob
x11Aqt5ZXXNeY8m7wmrspSn8Iux1F7+tQsOC+25UVziCn7Jh6lM/XRDIeUfYHmo6
PvZkA72I2LXnmX3+DqTja8jrYDIYfbL0b299MQPVLL/hYcbOYLeejjwudiJ3cv6E
v5LRei9K8Q1GK68HpRUk6+emKbkoZKhJdnhqzFHNEW4VvFRE6NufRW7hIHky7LXD
JP/TE1u89b8eZxg0nfNJiysliyoNN8O73kKdeiRQuDETkHcT4MJSrkcXy1zljFsR
emqcOloWJ6Lc1V+tWrby/7hEDiuV/qbDL2XejncgPdNKSHI+2cIiDmn8waU51uA7
fgmLkdwhYUjTGIJx6dJLEcJti7pxADkn/hXHNAY7qFXCH/nv5v7lDC4AGvNZxdcV
ezOHxyrZyHH5/lqJy4zZRwc46UEQOpSj+27M0WOy+8EAEg3aOjbePpuWiFJdXLlp
ZTLfnCQCSb6oJ8l481HhMAFImSYOgts3Mofh+tWSs178GN7lils=
=wr1i
-----END PGP SIGNATURE-----

--i7GBXgWhhOXDNszIRg5BZd7zKotn2cReU--
