From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: drivers/usb/musb/musb_io.h
Date: Sat, 16 Aug 2008 01:22:39 +0300
Message-ID: <20080815222238.GC25069@frodo>
References: <20080814215200.27f79a59.akpm@linux-foundation.org> <20080815115308.GA24513@flint.arm.linux.org.uk> <20080815123848.GN16231@frodo> <200808151446.45855.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40762 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071AbYHOWWw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 Aug 2008 18:22:52 -0400
Content-Disposition: inline
In-Reply-To: <200808151446.45855.david-b@pacbell.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, Felipe Balbi <felipe.balbi@nokia.com>, Andrew Morton <akpm@linux-foundation.org>, linux-usb@vger.kernel.org, linux-arch@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2008 at 02:46:45PM -0700, David Brownell wrote:
> On Friday 15 August 2008, Felipe Balbi wrote:
> > So I think until we have a better solution we'll need the attached patch
> > to musb_io.h
>=20
> Probably worth adding AVR32 to the list too.  I happened to
> enable musb during avr32 test build; it kablooied there too,
> but behaves given the CONFIG_AVR32 #ifdef.

Good to know, thanks.

Hmm... but how about the other version?

+#ifndef readsl
 static inline void readsl(const void __iomem *addr, void *buf, int len)
        { insl((unsigned long)addr, buf, len); }
+#endif
+#ifndef readsw
 static inline void readsw(const void __iomem *addr, void *buf, int len)
        { insw((unsigned long)addr, buf, len); }
+#endif

I think this would be a bit better since we don't need to keep adding
several archs to the list and prevents anything from breaking...
although those ifdefs look a bit odd.

> The existing #ifdef was sufficient to get a clean x86 build,
> given basic <linux/clk.h> support.  Someone wanting to see this
> driver work on the PCI (FPGA?) incarnation of this IP will
> have to solve that problem too.

Yeah... I have one of those OPTs, was even wondering on starting the pci
bus glue, but I'm too busy with nokia internal stuff for playing around
now :-s

Hope someone ever implement that, would be fun to see :-)

--=20
balbi

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIpgGuQBywH/bNoN4RAhGgAJ9wpaE2Y+FwIxnb13EKIqM/KZ9b/wCgjFxC
QSBdrHNxJd4eiqqzsDx/Ehw=
=KbD8
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
