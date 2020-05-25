From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] Implement close-on-fork
Date: Mon, 25 May 2020 10:16:26 +0200
Message-ID: <20200525081626.GA16796@amd>
References: <20200515152321.9280-1-nate.karstens@garmin.com>
 <20200515155730.GF16070@bombadil.infradead.org>
 <5b1929aa9f424e689c7f430663891827@garmin.com>
 <1589559950.3653.11.camel@HansenPartnership.com>
 <4964fe0ccdf7495daf4045c195b14ed6@garmin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4964fe0ccdf7495daf4045c195b14ed6@garmin.com>
Sender: linux-parisc-owner@vger.kernel.org
To: "Karstens, Nate" <Nate.Karstens@garmin.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Matthew Wilcox <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, David Laight <David.Laight@aculab.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-paris>
List-Id: linux-arch.vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>=20
> If the feedback from the community is truly and finally that system() sho=
uld not be used in these applications, then is there support for updating t=
he man page to better communicate that?
>=20

Clarifying documenation might be the best way forward. Note you'd have
to do that anyway, since people would not know about O_CLOFORK without
pointers in documentation.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7LftoACgkQMOfwapXb+vJqEACcD+lR3XKYglSp+Req63ZwDi9m
e/8An0k5uMvqkwoEcFAXFS3vLQ/eJejy
=GABB
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
