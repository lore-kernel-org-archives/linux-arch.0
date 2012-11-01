From: Felipe Balbi <balbi@ti.com>
Subject: Re: [balbi-usb:xceiv 3/3] drivers/usb/phy/rcar-phy.c:75:3: error:
 implicit declaration of function 'iowrite32'
Date: Thu, 1 Nov 2012 15:23:42 +0200
Message-ID: <20121101132342.GE12489@arwen.pp.htv.fi>
References: <50924f0a.QuF7xjrp4IUSKMwd%fengguang.wu@intel.com>
 <20121101103339.GD410@arwen.pp.htv.fi>
 <20121101105034.GE410@arwen.pp.htv.fi>
 <20121101130420.GB20982@kroah.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vv4Sf/kQfcwinyKX"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39284 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755325Ab2KAN3m (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 1 Nov 2012 09:29:42 -0400
Content-Disposition: inline
In-Reply-To: <20121101130420.GB20982@kroah.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Felipe Balbi <balbi@ti.com>, linux-arch@vger.kernel.org, kbuild test robot <fengguang.wu@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-usb@vger.kernel.org

--vv4Sf/kQfcwinyKX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 01, 2012 at 06:04:20AM -0700, Greg KH wrote:
> On Thu, Nov 01, 2012 at 12:50:34PM +0200, Felipe Balbi wrote:
> > On Thu, Nov 01, 2012 at 12:33:39PM +0200, Felipe Balbi wrote:
> > > Hi,
> > >=20
> > > On Thu, Nov 01, 2012 at 06:29:30PM +0800, kbuild test robot wrote:
> > > > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git=
 xceiv
> > > > head:   1789e52acc90c87484a109d6349eefe63cabb257
> > > > commit: 1789e52acc90c87484a109d6349eefe63cabb257 [3/3] usb: phy: ad=
d R-Car USB phy driver
> > > > config: make ARCH=3Dcris allyesconfig
> > > >=20
> > > > All error/warnings:
> > > >=20
> > > > drivers/usb/phy/rcar-phy.c: In function 'rcar_usb_phy_init':
> > > > drivers/usb/phy/rcar-phy.c:75:3: error: implicit declaration of fun=
ction 'iowrite32' [-Werror=3Dimplicit-function-declaration]
> > > > drivers/usb/phy/rcar-phy.c:83:4: error: implicit declaration of fun=
ction 'ioread32' [-Werror=3Dimplicit-function-declaration]
> > > > cc1: some warnings being treated as errors
> > >=20
> > > too bad that it compiles fine on x86 and ARM :-(
> > >=20
> > > Kuninori, care to send me a fixup patch ? I guess using writel()/read=
l()
> > > should do it ?!?
> >=20
> > looks like this isn't enough. We have 6 arches which don't provide
> > writel()/readl(), namely blackfin, c6x, openrisc, s390, score, and um.
> >=20
> > Should those arches be fixed instead ? Don't we have a single
> > memory-mapped access set of APIs which are supposed to be provided by
> > all arches ?
> >=20
> > Greg, you've been doing this for much more time then I have. Should all
> > arches provide writeb/w/l/q and readb/w/l/q ??
>=20
> I would think so, but I really don't know.
>=20
> linux-arch people, what do we do about architectures that don't provide
> these functions?  Just disable building the drivers for them, or do we
> fix them somehow?

btw, only alpha and x86 seem to be providing all of those, but if you
look into our documentation, it's said that drivers are supposed to use
write/read{b,w,l,q} for all memory-mapped io. I'd expect all platforms
to provide those even if just to allow compilation of drivers.

--=20
balbi

--vv4Sf/kQfcwinyKX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQknfeAAoJEIaOsuA1yqREzewP/ifXXNi9oD4M9IT4Qh1vg/b3
C+LFknQR6DVeka67BfRYL2iQQAdwfPl0I1D9zoKV+syELo8MZUwWEkPS7cEXiy0E
+UJxyy5J4SSmWMH43geGUav4uMb/7UBKY/9wh91sjYiD0mzNnZVXhDgWxD9fPkmW
AgbTi4M73hwEEtpxBfhrncgY2Nmd7znDzGW/VQyLhNA8bS7gr9KjO/04gKkMexzv
OVkxE0YP52sGAc0kHjdQ7TezWsXS1wSmmVq7+8bjOacNJ7IH63gl8Id+/ltrS3ce
xnJsieFf4nqxSLuyBTtVHd9sa4fgmNSx2S6hwn4ZhMlxbh0pX6AVBiwsTLyF5sbD
cGs7pQzMw8vYHQInev3FkGS8HqbLYnFVraIXHnjoEzfUK1Il5nEdHx2av2Y/hVtY
2figSSn2j19LNHu5axOfBUoncBAhRVaEBxk2qeHQExfxMvtk9/gfDgcL2h7WVCzc
/AnmgAZeig52oNSPYObUDruKffLQR2bxZxQcDn2t2gYvh8Eovpt6RhQ0k93DP5tF
PnAjznLL62SoV22EafxcK7UzQEbji2Vxfn+KS3N88bZNRfkvWGToEsrFGC/JC8Z+
HXZcbfSbL5W/UNFY/Wiz+u7A15Ys5PzCIRWx2HYmyVMo/NblaZ02BW+ff7LqKp4o
rg6LQrVUsSuZYvTbiNQN
=FKju
-----END PGP SIGNATURE-----

--vv4Sf/kQfcwinyKX--
