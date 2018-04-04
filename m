From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [GIT PULL] arch: remove obsolete architecture ports
Date: Wed, 4 Apr 2018 10:01:42 +0200
Message-ID: <20180404080142.GC9342@amd>
References: <CAK8P3a0q70FYtBaCcsBPejVULgsbJPwUG7QmrkU9NJpr7oTzpQ@mail.gmail.com>
 <CA+55aFzmQ9specaytsjEb=iNm-NHE5kxMSy_H_jKvqZa4-Fomw@mail.gmail.com>
 <CAK8P3a2pdmLOHb2wkPVvqLDo71Rf3hLVfhG7vsMzaPD-DMEzSg@mail.gmail.com>
 <CAMuHMdVZg8BL7D2eB-FnDbJabU3sfda6nOnaCdJj-3OC-+KP0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UFHRwCdBEJvubb2X"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdVZg8BL7D2eB-FnDbJabU3sfda6nOnaCdJj-3OC-+KP0g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, James Hogan <jhogan@kernel.org>, David Howells <dhowells@redhat.com>, "moderated list:PANASONIC MN10300..." <linux-am33-list@redhat.com>, Hirokazu Takata <takata@linux-m32r.org>, Lennox Wu <lennox.wu@gmail.com>, Aaron Wu <Aaron.Wu@analog.com>, Bryan Wu <cooloney@gmail.com>, Chris Metcalf <chris.d.metcalf@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>
List-Id: linux-arch.vger.kernel.org


--UFHRwCdBEJvubb2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-04-03 11:18:15, Geert Uytterhoeven wrote:
> On Mon, Apr 2, 2018 at 9:54 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Apr 2, 2018 at 8:57 PM, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > Regarding a possible revert, that would indeed involve reverting
> > multiple patches for most architectures, plus parts of at least these
> > three:
> >
> >   Documentation: arch-support: remove obsolete architectures
> >   treewide: simplify Kconfig dependencies for removed archs
> >   ktest: remove obsolete architectures
> >
> > For those, I went the other way, and removed all architectures at
> > once to simplify my work and to avoid touching the same files up
> > to eight times with interdependent patches (which couldn't
> > be reverted without conflicts either).
> >
> > There are a couple of driver removal patches that got picked up
> > into subsystem trees instead of this tree, so a full revert would also
> > involve finding other drivers, but if you prefer to have the patches
> > completely split up by arch, I could rework the series that way.
>=20
> In reality, a resurrection may not be implemented as a pure revert, but as
> the addition of a new architecture, implemented using modern features (DT,
> CCF, ...).

By insisting on new features instead of pure revert + incremental
updates, you pretty much make sure resurection will not be possible
:-(.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UFHRwCdBEJvubb2X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrEhmYACgkQMOfwapXb+vKWKACdFSdjPnYHqBYoogKNbLV6gu66
znIAn1yoUxRUhPZkbsUDtB7rZqLNIBhI
=Sq8X
-----END PGP SIGNATURE-----

--UFHRwCdBEJvubb2X--
