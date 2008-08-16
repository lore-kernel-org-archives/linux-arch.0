From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: drivers/usb/musb/musb_io.h
Date: Sat, 16 Aug 2008 12:29:16 +0300
Message-ID: <20080816092915.GD25069@frodo>
References: <20080814215200.27f79a59.akpm@linux-foundation.org> <20080815222238.GC25069@frodo> <200808151853.08302.david-b@pacbell.net> <200808151905.32383.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cYtjc4pxslFTELvY"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:38309 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbYHPJ33 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 16 Aug 2008 05:29:29 -0400
Content-Disposition: inline
In-Reply-To: <200808151905.32383.david-b@pacbell.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, Felipe Balbi <felipe.balbi@nokia.com>, Andrew Morton <akpm@linux-foundation.org>, linux-usb@vger.kernel.org, linux-arch@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>


--cYtjc4pxslFTELvY
Content-Type: multipart/mixed; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2008 at 07:05:31PM -0700, David Brownell wrote:
> On Friday 15 August 2008, David Brownell wrote:
> > Someone commented that this is what caused creation of
> > the mmio_insl() family of routines ...
> >=20
> > ... but I notice that at least on ARM (current primary home
> > for this driver!) those calls don't end up using optimized
> > code. Since those optimimzed loops are a *big* win in terms
> > of performance -- using LDM/STM to burst memory acccess to/from
> > registers -- I'd rather not go that way for now.
>=20
> Oh, and worth remembering:  *WHEN* a clean solution for this
> is available, it should be usable in the NAND code.  And surely
> in other places which sometimes need PIO access to a FIFO...
>=20
> I was surprised to see that 16% improvement in read performance
> with an 8-bit NAND device, just by switching from code looking
> like generic mmio_insb() over to __raw_readsb().  Better IMO to
> have the faster code be what the NAND core uses by default, than
> to need to modify every platform's NAND driver to do that.

Sure, I'll have to keep an eye on what's going on include/linux/io.h

Attached is a new patch, added also ppc since they also provide those
read/write calls.

--=20
balbi

--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-musb-io-only-define-read-write-stubs-if-they-re-not.diff"
Content-Transfer-Encoding: quoted-printable

=46rom e6df3ab0b49e5a52c0b0b089d38efba97dd2f870 Mon Sep 17 00:00:00 2001
=46rom: Felipe Balbi <felipe.balbi@nokia.com>
Date: Fri, 15 Aug 2008 10:51:56 +0300
Subject: [PATCH] musb: io: only define read/write stubs if they're not defi=
ned yet

For those archs which don't provide read/write friends we
provide our own implementation so musb driver won't break
compilation.

This is temporary fix until a better solution comes from
upstream. Idealy, <linux/io.h> would provide those calls
if the architecture did not provide them yet. In that case
being possible to remove all those stubs from musb_io.h

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musb_io.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_io.h b/drivers/usb/musb/musb_io.h
index 6bbedae..223f0a5 100644
--- a/drivers/usb/musb/musb_io.h
+++ b/drivers/usb/musb/musb_io.h
@@ -37,7 +37,9 @@
=20
 #include <linux/io.h>
=20
-#ifndef	CONFIG_ARM
+#if !defined(CONFIG_ARM) && !defined(CONFIG_SUPERH) \
+	&& !defined(CONFIG_AVR32) && !defined(CONFIG_PPC32) \
+	&& !defined(CONFIG_PPC64)
 static inline void readsl(const void __iomem *addr, void *buf, int len)
 	{ insl((unsigned long)addr, buf, len); }
 static inline void readsw(const void __iomem *addr, void *buf, int len)
--=20
1.6.0.rc3.10.g5a13c


--tNQTSEo8WG/FKZ8E--

--cYtjc4pxslFTELvY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIpp3rQBywH/bNoN4RArR5AKCOX+dNqSH7/auLbN7ApN3q8v3JFACeIg6+
W32haHlIDcdG75DIOIeACoo=
=HORA
-----END PGP SIGNATURE-----

--cYtjc4pxslFTELvY--
