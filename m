From: Felipe Balbi <balbi@ti.com>
Subject: Re: [balbi-usb:xceiv 3/3] drivers/usb/phy/rcar-phy.c:75:3: error:
 implicit declaration of function 'iowrite32'
Date: Fri, 2 Nov 2012 11:16:20 +0200
Message-ID: <20121102091620.GE17938@arwen.pp.htv.fi>
References: <20121101130420.GB20982@kroah.com>
 <20121101132342.GE12489@arwen.pp.htv.fi>
 <87k3u5h296.fsf@nemi.mork.no>
 <20121101.110658.149879582446959580.davem@davemloft.net>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ILuaRSyQpoVaJ1HG"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54185 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756600Ab2KBJW3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 2 Nov 2012 05:22:29 -0400
Content-Disposition: inline
In-Reply-To: <20121101.110658.149879582446959580.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: bjorn@mork.no, balbi@ti.com, gregkh@linuxfoundation.org, linux-arch@vger.kernel.org, fengguang.wu@intel.com, kuninori.morimoto.gx@renesas.com, linux-usb@vger.kernel.org

--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 01, 2012 at 11:06:58AM -0400, David Miller wrote:
> From: Bj=F8rn Mork <bjorn@mork.no>
> Date: Thu, 01 Nov 2012 14:38:29 +0100
>=20
> > Felipe Balbi <balbi@ti.com> writes:
> >=20
> >> btw, only alpha and x86 seem to be providing all of those, but if you
> >> look into our documentation, it's said that drivers are supposed to use
> >> write/read{b,w,l,q} for all memory-mapped io. I'd expect all platforms
> >> to provide those even if just to allow compilation of drivers.
> >=20
> > Only if HAS_IOMEM is true, I believe.
>=20
> This is correct.

fair enough, then we can depend on HAS_IOMEM.

Another question, if HAS_IOMEM is true, is the arch expected to provide
*all* accessor methods ? And the last one: if the arch provides
read/write{b,w,l,q}, should it be selecting HAS_IOMEM ??

cheers, thanks

--=20
balbi

--ILuaRSyQpoVaJ1HG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQk49kAAoJEIaOsuA1yqREO8IP/1U04PmVjt4iDtJpmrWXQJTx
9GLziK7b4sgC2+fyF9AZG5eTdrDDUVBcnmmvmrUUD5oyg9w1+kbnfizkXx42+Wpw
l9drJjKN6F2CUJT62oIhJVMGDmD/n+5o7p/nIFOmF0Db7yOtlh/8oZLzlEFK0CwV
uXkTpg+LozF8JgcCO2KnmsYhHxO2HA4Y1akqlwMQZVyTrxsswok0IuwiXoxtBMJy
sd+p3ftLP3By2XT6CvESji39s1eDpYftNEsRWOn1G2nWFFFKVg0vcDUigaZifc0L
KRTzyQ4FOuegIrntV4GnpF9+kT7U+xKXahMp21Pt+Lc+dQPXuBHbs5vWmwxn3Gs/
FUVjLuMTRbPkdc3KCcylvhADYDRs0BRK6FdBn+5FRoFGqhiv+kcpsQGqLd4VsSpq
PVKkd0ClNqkFUE0nUj/KocIuHfTV2K7cGg6ZbCggs8+pMunR7Ee78NjscX3gpyvC
xkKx9YfzFGQaRyJEN+2SP9IkaIH8KQEJj+ygaepGCTL9Pkh+sKul+h1pC4PDqz9E
St824DrZqiJNU8xTcozXtZEfIlZtzhm9vAgMQ77hZtW+dp4Ur7CXrghwSEdxzkEU
e4HdFOT/++LEqeGee2I+Snz0smLbzo4NdeeXOdR/ABoAWraLVqF7RWDO/FM2lxbN
qKC6Q51+g8ovphlGpo1L
=ROcK
-----END PGP SIGNATURE-----

--ILuaRSyQpoVaJ1HG--
