From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] clkdev: Add default clkdev.h
Date: Tue, 3 Jul 2012 13:33:22 +0100
Message-ID: <20120703123322.GK29030@opensource.wolfsonmicro.com>
References: <1341252250-26476-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20120703120059.f153bd696269528be2baa1bc@canb.auug.org.au>
 <20120703101209.GH29030@opensource.wolfsonmicro.com>
 <201207031116.05876.arnd@arndb.de>
 <20120703114844.GJ29030@opensource.wolfsonmicro.com>
 <20120703220512.e03805948e31cfa90778d6c2@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="g4MvFqI7wmANiPDo"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:44562 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751177Ab2GCMdZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jul 2012 08:33:25 -0400
Content-Disposition: inline
In-Reply-To: <20120703220512.e03805948e31cfa90778d6c2@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, mturquette@ti.com, Russell King <linux@arm.linux.org.uk>, linux-kbuild@vger.kernel.org, Michal Marek <mmarek@suse.cz>


--g4MvFqI7wmANiPDo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 03, 2012 at 10:05:12PM +1000, Stephen Rothwell wrote:
> On Tue, 3 Jul 2012 12:48:44 +0100 Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > The reason I'm doing this is that the lack of a widely available clock
> > API is a considerable pain point for a lot of the stuff I work on and
> > this is the major blocker to just enabling the default implementation on
> > architectures that don't support it already which would be a big step
> > forwards.

> Agreed.  Please submit this patch and we can concentrate on this other
> stuff later.

Perhaps if you give me a couple of hours...

--g4MvFqI7wmANiPDo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP8uXUAAoJEBus8iNuMP3dHMIP/RsZ6zEvJ/kYuLYFXaaS2okT
vEDmutyOpJDT9uByK0Trde6J/9OPICpV+clyyCIrWuk7OSHug80FtB8op13Y1e12
c8x2CPjrZBEasU1I0iMBbdERDaCmWBlEihHQxi9Bc2bmTRv6IBTPr+8vCdLZogLB
m97jjwzFFvm8wrQaYogPoBzvvTMc0C026U41bwPUATzYIEEQbuLOdUKHTANA4zVZ
70r6cIIEtpNgxEIjbTzbWLHZFdKmBrLvSg62AGSSg2E4VeBAEGyNvrEcOmJSqGEL
+0zwSK1lAqb5iKlMXNi6HK5sUW6YcV6FMAAK49mLtF4pw0sFKnpUp6RpwF1LmhG/
omGgBG70JmRyCHOrKu7flofPwfOSquLIhlQWX4M84anJBU6NJJrQClaLGVzU1K2z
YLfEnlURYK0rTc5jNVdLcKbCO/FZ6EJmLiXmMzGVBmysb5CTUquDOy5Wpf5b1Kak
XV4Rwd6WtmA0Wa3OUbEc+16T/uNYDUkxLtM1pENNwcJsJzoPa00kxye2Y8hBmeon
CLmsWxDhYKsD0jbmGVD9goZhEs3uoiIQtGGi1y97E4gVKb+uBwTiUTogcQ3FjPam
6AOMo/+/FMmKTMihFdtgGD/6t5A2AX3Z64wjuO2Pek0Nk1uywUxRT784oK4lHsvi
00tgb17LPW//KpDVOOzU
=p6CO
-----END PGP SIGNATURE-----

--g4MvFqI7wmANiPDo--
