From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] clkdev: Add default clkdev.h
Date: Mon, 14 May 2012 20:09:28 +0100
Message-ID: <20120514190928.GJ25668@opensource.wolfsonmicro.com>
References: <1337005167-22628-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <201205141903.04121.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NqSa+Xr3J/G6Hhls"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:54818 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757600Ab2ENTJc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 14 May 2012 15:09:32 -0400
Content-Disposition: inline
In-Reply-To: <201205141903.04121.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--NqSa+Xr3J/G6Hhls
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 14, 2012 at 07:03:03PM +0000, Arnd Bergmann wrote:

> I'm not completely sure about this part. It should work just fine, but
> we haven't done this for any of the other asm/* headers. If we decide
> to list generic header files  in Kconfig.asm that automatically get
> added to architectures, I would prefer doing it with a nicer syntax so
> we can do it for a lot of the other header files too. For now, I'd
> prefer to just add the file manually to the asm/Kbuild files in the
> architectures where it makes sense (e.g. all but s390).

The problem with that is the general pain that seems to come from trying
to get all the architecture maintainers to apply patches like this (lots
of them are OK but many do great /dev/null impressions) and it's pushing
the problem back onto the wrong people.  It seems less work to go put
something ugly in and then hopefully some Kbuild expert will get annoyed
and fix things rather than we get stuck with the status quo.

--NqSa+Xr3J/G6Hhls
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPsVhaAAoJEBus8iNuMP3doSUP/jnAdfFouQwB7MuRa+kI/EYB
MYhLA0YJ1iFHsoeO7Afybmmnsr+ZBK6+jUdBd91QmOPnFvRwqlZaKRaQkKUf+M7J
9HKWpYKLKqwmVEpLDzW9e7hhu7a3WW+DEs7zHdfKrVx9IpXFLhOqW9IBClZkbgb8
qZyFxptxCtV6a4J/nHRGymIiwzQPKtuaa6izY7rV+NTbo88Kwn3lAej93cNwZDvx
msjmIsbakIXy6CcmwD03302edAQV2GJK1sxGdAX1c3AS9tC7te9gC/dk0HOus7uB
VNebWgDS9w60Z30pya3ZyVQm3nip/6sh+f/Z9BIQi76s6h+yKmTbf8BBg2QXC8Gl
8XD7afxZnt2P5fh/2aRTLKGOOKDJD8yu7gwk6oxDAVWiZMMtkRiuYqNVQ1ayG+2F
vEn4wAs+lZ2VYYrQND3Z8luSV2kRbEu/zNCkz1mwowifSliTgl9kWJhczcBPeIND
5IOnGQFCVCDpU7j0T5J4PjOd9qv2KtYRhAP88skuB8hON7qD5b9pUftLD4KixiJX
dBwVVe8QzGyq9GuvwF/bmWlANO2Y4n1sdEX54YUMnC6n/2rwz51WqHrKlAl/BhQt
JWMY0NztvcsgX4eFrl6qpsJK+8203Cbj4f4FMEcMOqppO6j2eGWVVj9MRWmi1D2a
egGTRMK0xyck/uln8d+j
=sqkD
-----END PGP SIGNATURE-----

--NqSa+Xr3J/G6Hhls--
