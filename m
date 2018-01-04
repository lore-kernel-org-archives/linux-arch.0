From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Thu, 4 Jan 2018 21:56:54 +0100
Message-ID: <20180104205654.GE10427@amd>
References: <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
 <20180104010754.22ca6a74@alans-desktop>
 <alpine.LRH.2.00.1801040221070.27010@gjva.wvxbf.pm>
 <CAPcyv4ic=X3nMz7deg9NMyvj994+SM9XYoP0u7WvgKaAFSGAYw@mail.gmail.com>
 <CA+55aFx7eJqRA8EWwSCrC+Lr1ZjUvRXSuhrxo+af_Dx3YWKbOQ@mail.gmail.com>
 <1515035438.20588.4.camel@intel.com>
 <87vagiusj1.fsf@xmission.com>
 <CAPcyv4hOtk3QsCWOhECs7=UCh-iO+TKSJvRmqVq+Xhjx9OTiew@mail.gmail.com>
 <87wp0xu12k.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ryJZkp9/svQ58syV"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87wp0xu12k.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dan Williams <dan.j.williams@intel.com>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "alan@linux.intel.com" <alan@linux.intel.com>, "Reshetova, Elena" <elena.reshetova@intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "gnomes@lxorguk.ukuu.org.uk" <gnomes@lxorguk.ukuu.org.uk>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jikos@kernel.org" <jikos@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org


--ryJZkp9/svQ58syV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> > It falls there so that the cpu only issues reads with known good 'index=
' values.
> >
> >> I suspect it would be better to have those barriers in the tun/tap
> >> interfaces where userspace can inject packets and thus time them.  Then
> >> the code could still speculate and go fast for remote packets.
> >>
> >> Or does the speculation stomping have to be immediately at the place
> >> where we use data from userspace to perform a table lookup?
> >
> > The speculation stomping barrier has to be between where we validate
> > the input and when we may speculate on invalid input.
>=20
> So a serializing instruction at the kernel/user boundary (like say
> loading cr3) is not enough?  That would seem to break any chance of a
> controlled timing.

Timing attack is not as straightforward as this.

You can assume cache snooping from second CPU _while_ kernel is
executing. Yes, that will mean timing, but....

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ryJZkp9/svQ58syV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpOlRYACgkQMOfwapXb+vLb6wCfWYgmH4BO9HC99ipYpXHfO5kv
X9sAoLAEQQmL1/ovZVnhlAtm+IlQa5Rl
=09LP
-----END PGP SIGNATURE-----

--ryJZkp9/svQ58syV--
