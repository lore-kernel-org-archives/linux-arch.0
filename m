From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Thu, 4 Jan 2018 22:48:09 +0100
Message-ID: <20180104214809.GB18699@amd>
References: <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
 <20180104010754.22ca6a74@alans-desktop>
 <alpine.LRH.2.00.1801040221070.27010@gjva.wvxbf.pm>
 <20180104014100.3786e686@alans-desktop>
 <nycvar.YFH.7.76.1801040243300.11852@cbobk.fhfr.pm>
 <20180104193936.GB10427@amd>
 <20180104203246.5ff65328@alans-desktop>
 <nycvar.YFH.7.76.1801042137560.11852@cbobk.fhfr.pm>
 <20180104212359.0b520868@alans-desktop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47123 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbeADVsL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Jan 2018 16:48:11 -0500
Content-Disposition: inline
In-Reply-To: <20180104212359.0b520868@alans-desktop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Jiri Kosina <jikos@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-01-04 21:23:59, Alan Cox wrote:
> On Thu, 4 Jan 2018 21:39:24 +0100 (CET)
> Jiri Kosina <jikos@kernel.org> wrote:
>=20
> > On Thu, 4 Jan 2018, Alan Cox wrote:
> >=20
> > > You never go from one user process to another except via the kernel. =
We
> > > have no hardware scheduling going on. That means that if the kernel
> > > and/or CPU imposes the correct speculation barriers you can't attack
> > > anyone but yourself. =20
> >=20
> > So how does this work on HT with the shared BTB? There is no context=20
> > switch (and hence no IBPB) happening between the threads sharing it.
> >=20
>=20
> If you are paranoid in that case you either need to schedule things that
> trust each other together or disable the speculation while that situation
> occurs. However the kernel is always in the position to make that
> decision.

Actually... I'm not paranoid but would like to run flightgear on one
core (smt cpu #0), with smt cpu#1 being idle, while running
compilations on second core (smt cpus #2 and #3).

Is there easy way to do that?
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpOoRkACgkQMOfwapXb+vJbtQCfa+hZh65GyyHcY2AkRMt8QT/t
uRIAnAnZYhAYR0Myd35supYa7hjpYnJd
=R9tF
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
