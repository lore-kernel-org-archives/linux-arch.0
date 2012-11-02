From: Felipe Balbi <balbi@ti.com>
Subject: Re: [balbi-usb:xceiv 3/3] drivers/usb/phy/rcar-phy.c:75:3: error:
 implicit declaration of function 'iowrite32'
Date: Fri, 2 Nov 2012 11:17:03 +0200
Message-ID: <20121102091703.GF17938@arwen.pp.htv.fi>
References: <50924f0a.QuF7xjrp4IUSKMwd%fengguang.wu@intel.com>
 <20121101103339.GD410@arwen.pp.htv.fi>
 <20121101105034.GE410@arwen.pp.htv.fi>
 <20121101130420.GB20982@kroah.com>
 <20121101132342.GE12489@arwen.pp.htv.fi>
 <CAMo8BfLoU0GLpncX7YXy_VvveFnR6f6guPJTLNdtt3SWDK1fcg@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sDKAb4OeUBrWWL6P"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54210 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758917Ab2KBJXG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 2 Nov 2012 05:23:06 -0400
Content-Disposition: inline
In-Reply-To: <CAMo8BfLoU0GLpncX7YXy_VvveFnR6f6guPJTLNdtt3SWDK1fcg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: balbi@ti.com, Greg KH <gregkh@linuxfoundation.org>, linux-arch@vger.kernel.org, kbuild test robot <fengguang.wu@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-usb@vger.kernel.org

--sDKAb4OeUBrWWL6P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 01, 2012 at 04:47:14PM +0300, Max Filippov wrote:
> On Thu, Nov 1, 2012 at 5:23 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Hi,
> >
> > On Thu, Nov 01, 2012 at 06:04:20AM -0700, Greg KH wrote:
> >> On Thu, Nov 01, 2012 at 12:50:34PM +0200, Felipe Balbi wrote:
> >> > On Thu, Nov 01, 2012 at 12:33:39PM +0200, Felipe Balbi wrote:
> >> > > Hi,
> >> > >
> >> > > On Thu, Nov 01, 2012 at 06:29:30PM +0800, kbuild test robot wrote:
> >> > > > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.=
git xceiv
> >> > > > head:   1789e52acc90c87484a109d6349eefe63cabb257
> >> > > > commit: 1789e52acc90c87484a109d6349eefe63cabb257 [3/3] usb: phy:=
 add R-Car USB phy driver
> >> > > > config: make ARCH=3Dcris allyesconfig
> >> > > >
> >> > > > All error/warnings:
> >> > > >
> >> > > > drivers/usb/phy/rcar-phy.c: In function 'rcar_usb_phy_init':
> >> > > > drivers/usb/phy/rcar-phy.c:75:3: error: implicit declaration of =
function 'iowrite32' [-Werror=3Dimplicit-function-declaration]
> >> > > > drivers/usb/phy/rcar-phy.c:83:4: error: implicit declaration of =
function 'ioread32' [-Werror=3Dimplicit-function-declaration]
> >> > > > cc1: some warnings being treated as errors
> >> > >
> >> > > too bad that it compiles fine on x86 and ARM :-(
> >> > >
> >> > > Kuninori, care to send me a fixup patch ? I guess using writel()/r=
eadl()
> >> > > should do it ?!?
> >> >
> >> > looks like this isn't enough. We have 6 arches which don't provide
> >> > writel()/readl(), namely blackfin, c6x, openrisc, s390, score, and u=
m.
> >> >
> >> > Should those arches be fixed instead ? Don't we have a single
> >> > memory-mapped access set of APIs which are supposed to be provided by
> >> > all arches ?
> >> >
> >> > Greg, you've been doing this for much more time then I have. Should =
all
> >> > arches provide writeb/w/l/q and readb/w/l/q ??
> >>
> >> I would think so, but I really don't know.
> >>
> >> linux-arch people, what do we do about architectures that don't provide
> >> these functions?  Just disable building the drivers for them, or do we
> >> fix them somehow?
> >
> > btw, only alpha and x86 seem to be providing all of those, but if you
> > look into our documentation, it's said that drivers are supposed to use
> > write/read{b,w,l,q} for all memory-mapped io. I'd expect all platforms
> > to provide those even if just to allow compilation of drivers.
>=20
> Strange, AFAICS architectures that use asm-generic/io.h (blackfin, openri=
sc,
> score, unicore32 and xtensa) also provide those functions.

hehe, missed that part :-)

--=20
balbi

--sDKAb4OeUBrWWL6P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQk4+PAAoJEIaOsuA1yqREyVgP/RbKecfJJdh6gkigewqqY5Iw
eV3BE7vwvv8EXZ4qnhJ748xZphp8h7DmmYpn+33u8x0TL/rao13EN+28Vos1+xFI
CHVdbVdQ9g4C+Ttg6e5AjFFiSrvNnl+0a7W7sO0SgSaMacEzgDcKvSQHP0T8xM5+
MTIg3hlwcmig/9Gm26XjwaO8w+jijeTKMztux8OfyGSmuPDFOrPq1Dzs6yj3oDJn
gxvl1B54SsrTWWRi94vXqNn2uGB+yPyNs57bsLhhFE2I/1bszf4qE0mDmRdjyHKm
l4jtVkygWLR5D/fmT1gx7pdGj3AZ2OYr0ou8W6V8EjSWI3ex0I5kJtA1zIjKzMDT
bSjCYbkc50uxf0Nb3f5cHD42Kdg7R/Gv/YnPXNV7dSoMoy/dtdEJuSreaNcesTyi
ZMbTOxr+aLkoe4b6vx2+zJI/2oGTytKg0wQ0LY8oXdOBw3SUUxgh+H1J1vyV7kgd
Ga/ZnuijcQuY2xshy71gLzaM/Z9zMFOMfnoHkkiMCL6EqceaTqKZNwSVoGVrGkdj
usrxWoQpFgWvQQnFR/rRH5sGff8ed8COoJcwe5m83lR6Eboiv1jpnG6Z7tQAgfaq
TtOeRoyVb7nFHXh/gIURCeyYC9lXO+h/SImoIkqfgLhis93ceBIktBrxCEOxxucp
iVjo17BHiRd2Jptyt5PH
=iyQE
-----END PGP SIGNATURE-----

--sDKAb4OeUBrWWL6P--
