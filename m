Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from attila.bofh.it ([213.92.8.2]:49512 "EHLO attila.bofh.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142AbZGNKz0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Jul 2009 06:55:26 -0400
Date: Tue, 14 Jul 2009 12:44:41 +0200
Subject: Re: [PATCH] reduce export symbol CRC table size on 64-bit  archs
Message-ID: <20090714104440.GA2113@bongo.bofh.it>
References: <4A4A18780200007800008345@vpn.id2.novell.com> <4A4E671C.2090201@suse.cz> <4A51C71B0200007800008EE2@vpn.id2.novell.com> <200907092044.22108.rusty@rustcorp.com.au> <4A57089B0200007800009C0E@vpn.id2.novell.com> <4A5AEC3C.2060608@suse.cz> <4A5B101E020000780000A284@vpn.id2.novell.com> <1247567372.31188.229.camel@perihelion.bos.jonmasters.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <1247567372.31188.229.camel@perihelion.bos.jonmasters.org>
From: md@Linux.IT (Marco d'Itri)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jon Masters <jonathan@jonmasters.org>
Cc: Jan Beulich <JBeulich@novell.com>, Michal Marek <mmarek@suse.cz>, Ingo Molnar <mingo@elte.hu>, tony.luck@intel.com, Thomas Gleixner <tglx@linutronix.de>, Rusty Russell <rusty@rustcorp.com.au>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, hpa@zytor.com
Message-ID: <20090714104441.IbycIZfeNyrGsshUa9P25Gefp7JAqsQucc2dNlbQAWk@z>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 14, Jon Masters <jonathan@jonmasters.org> wrote:

> Most of the distros can fix that with a dependency on the kernel package
> in the absolute worst case, not that I love that idea, but it happens. I
FYI, Debian cannot do this.

--=20
ciao,
Marco

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpcYZgACgkQFGfw2OHuP7FG3QCgop6K0zGmrfxAysZPMTIBtekN
j2YAoIhEPx0CgeKJoc8aE1ti81wr40Dc
=+0pl
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
