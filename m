From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Thu, 4 Jan 2018 20:26:49 +0100
Message-ID: <20180104192648.GA10427@amd>
References: <20180103223827.39601-1-mark.rutland@arm.com>
 <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
 <20180104010754.22ca6a74@alans-desktop>
 <CAPcyv4ge14OPyfoQvXHLyXwqX7cjWvm4DouUOc=WrNo1Lr9Qyw@mail.gmail.com>
 <alpine.DEB.2.20.1801040728140.2148@hadrien>
 <CAPcyv4gLcC7vsxLUCEJdEvDRf4AhgF0x1fpTEcH7AOe=kuNfoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPcyv4gLcC7vsxLUCEJdEvDRf4AhgF0x1fpTEcH7AOe=kuNfoQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-arch.vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> > What remains to be seen is if there are other patterns that affect
> >> > different processors.
> >> >
> >> > In the longer term the compiler itself needs to know what is and isn=
't
> >> > safe (ie you need to be able to write things like
> >> >
> >> > void foo(tainted __user int *x)
> >> >
> >> > and have the compiler figure out what level of speculation it can do=
 and
> >> > (on processors with those features like IA64) when it can and can't =
do
> >> > various kinds of non-trapping loads.
> >> >
> >>
> >> It would be great if coccinelle and/or smatch could be taught to catch
> >> some of these case at least as a first pass "please audit this code
> >> block" type of notification.
> >>
> >
> > What should one be looking for.  Do you have a typical example?
> >
>=20
> See "Exploiting Conditional Branch Misprediction" from the paper [1].
>=20
> The typical example is an attacker controlled index used to trigger a
> dependent read near a branch. Where an example of "near" from the
> paper is "up to 188 simple instructions inserted in the source code
> between the =E2=80=98if=E2=80=99 statement and the line accessing array..=
=2E".
>=20
> if (attacker_controlled_index < bound)
>      val =3D array[attacker_controlled_index];
> else
>     return error;
>=20
> ...when the cpu speculates that the 'index < bound' branch is taken it
> reads index and uses that value to read array[index]. The result of an
> 'array' relative read is potentially observable in the cache.

You still need

	(void) array2[val];

after that to get something observable, right?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpOf/gACgkQMOfwapXb+vKUyACcDb5n6C009TeXz8Jx0xywDG+/
qowAnR3otDZD619thkpd2jUaL0yAHwNs
=wRl0
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
