From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] clkdev: Add default clkdev.h
Date: Tue, 10 Jul 2012 18:22:23 +0100
Message-ID: <20120710172223.GM10022@opensource.wolfsonmicro.com>
References: <1341252250-26476-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20120703114844.GJ29030@opensource.wolfsonmicro.com>
 <20120703220512.e03805948e31cfa90778d6c2@canb.auug.org.au>
 <201207031339.34369.arnd@arndb.de>
 <20120703134729.GP29030@opensource.wolfsonmicro.com>
 <20120709222332.GA16202@gmail.com>
 <20120709233022.GO16319@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7vAdt9JsdkkzRPKN"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:51355 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752719Ab2GJRWZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 10 Jul 2012 13:22:25 -0400
Content-Disposition: inline
In-Reply-To: <20120709233022.GO16319@n2100.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Mike Turquette <mturquette@ti.com>, Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Michal Marek <mmarek@suse.cz>


--7vAdt9JsdkkzRPKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 10, 2012 at 12:30:22AM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 09, 2012 at 03:23:32PM -0700, Mike Turquette wrote:

> > Russell owns clkdev so I'd prefer he take this patch.

> Note that I'm not going to be taking any further patches for at least
> the next 16 days (as I'm away), and I'm not going to even guarantee
> that I'll pick up on anything on the mailing lists during that period.

Oh dear, that's a bit sad - given that the merge window may well open
it'll mean we'll end up with at least one additional release where we
can't get the clock API available as standard :(

--7vAdt9JsdkkzRPKN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP/GS7AAoJEBus8iNuMP3dBR0QAJn8ZWVn7q5rW5JsAtRkKUea
BEfHbgwKkv8SkdAOz90U1NBikylrVgLYziO6/Z3GabxcV1MbUwMtnGCPvQ5XZxku
WIDM2+pv99aCHi4+Y1qHU2cEK15FyhHB6hlzd+Gj6Mti3C5+lhqzesIc9C6Fd3lK
KUwJjpmebcNhax5nsK7+zY3f8t6tNsbMxaN3ooLjc5v35ey/Hf0tv9C6Qqn6XJBz
dSUv1292dFgtBRxLvawy5itPRQZNYVBZ/Z8MsTMB/L9a/uNg2pfvcJbk3FoBBPTh
hvraYoEVNOCIKcje1TKN0bKLV7VYWNml2uOuKIpgDNiRhDgAnBeJzahJCK/jaJD1
P6JHuW/CQDNCKhMCS2htpmWSGU2enOkhkfNd0yNR+6fXqYlCW4YujJvwzcbgpwk9
Lp9GmSJDDqkArtNJHaaiYroQKWkXM+G9iqpgNyztV57Ph/b2DPZAnGat2Jm6Lyox
EIjCEZdr8q+4htPOCw2TaHP+VwD7hhqwe/iQJ0Ehtw5Pt0dbHbIIi6lrxivLgH/A
PK/qKcOMT3pcHb2dSOPYLKsZVyXc0qzqemDTtSSqlQYkWsCPwGaLg9lX5nea9ko/
e/9UMCnh0V08ZGzJmLpsHGLH58c/+usmRtNImHtrHgPLlRjzIWwmLQt8Fi6Nxoyo
36IvecXjyp0enb6AkQMf
=/RX2
-----END PGP SIGNATURE-----

--7vAdt9JsdkkzRPKN--
