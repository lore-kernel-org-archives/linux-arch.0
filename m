From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Thu, 4 Jan 2018 20:39:36 +0100
Message-ID: <20180104193936.GB10427@amd>
References: <20180103223827.39601-1-mark.rutland@arm.com>
 <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
 <20180104010754.22ca6a74@alans-desktop>
 <alpine.LRH.2.00.1801040221070.27010@gjva.wvxbf.pm>
 <20180104014100.3786e686@alans-desktop>
 <nycvar.YFH.7.76.1801040243300.11852@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43359 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752990AbeADTji (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Jan 2018 14:39:38 -0500
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1801040243300.11852@cbobk.fhfr.pm>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-01-04 02:47:51, Jiri Kosina wrote:
> On Thu, 4 Jan 2018, Alan Cox wrote:
>=20
> > > If the CPU speculation can cause these kinds of side-effects, it just=
 must=20
> > > not happen, full stop.=20
> >=20
> > At which point your performance will resemble that of a 2012 atom
> > processor at best.
>=20
> You know what? I'd be completely fine with that, if it's traded for "my=
=20
> ssh and internet banking keys are JUST MINE, ok?" :)

Agreed.

For kernel, we may be able to annonate "tainted" pointers. But then
there's quite a lot of code in userspace... What will need to be
modified? Just JITs? Setuid programs?

And we can get part of the performance back by adding more of
SMT... AFAICT.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpOgvgACgkQMOfwapXb+vLs8wCeNCqQ52wuZy5nshtG9HJIy3+f
72cAoI7FDRFnuGsF1ZJKmmpXFBxraDQc
=O+ly
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
