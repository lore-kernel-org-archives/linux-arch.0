From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Removing architectures without upstream gcc support
Date: Sun, 25 Feb 2018 23:50:02 +0100
Message-ID: <20180225225002.GA6078@amd>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <20180222234833.GA3047@roeck-us.net>
 <CAK8P3a3Y2b-DivYz1ZqhFGUqQaiF=5SDB6RFLtCknwY2--09OQ@mail.gmail.com>
 <20180223154316.35b26857@alans-desktop>
 <20180223171019.GA1125@roeck-us.net>
 <20180225202806.735a6870@alans-desktop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180225202806.735a6870@alans-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Al Viro <viro@zeniv.linux.org.uk>, James Hogan <jhogan@kernel.org>, linux-metag@vger.kernel.org, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org, David Howells <dhowells@redhat.com>
List-Id: linux-arch.vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Sun 2018-02-25 20:28:06, Alan Cox wrote:
> > FWIW, alpha and m68k are known boot with qemu (even though m68k
> > generates a warning traceback with the mainline kernel).
>=20
> M68K works - people actively use it. Crazy people true 8). Alpha I
> believe one or two people boot. I just need to track down some discs for
> my Alpha 8)

I guess it would be useful to track who tested what kernel on what
hardware ... and I created a project for
that. Feel free to contribute: https://github.com/pavelmachek/missy --
I'd like to get some data from "big" iron...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqTPZoACgkQMOfwapXb+vLKywCgk2z5SVeKJcYPKZ6cWyThLJMR
OnQAoIPqgq/lzlii0UrakhlWdMkuYyYy
=Tfvd
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
