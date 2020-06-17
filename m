From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [RFC PATCH 1/2] Explicitly include linux/major.h where it is
 needed
Date: Wed, 17 Jun 2020 16:18:10 +1000
Message-ID: <20200617161810.256ff93f@canb.auug.org.au>
References: <20200617092614.7897ccb2@canb.auug.org.au>
        <20200617092747.0cadb2de@canb.auug.org.au>
        <20200617055843.GB25631@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SR24Am7bJk6gmzp1XI0YNUE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200617055843.GB25631@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linux-kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

--Sig_/SR24Am7bJk6gmzp1XI0YNUE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Wed, 17 Jun 2020 07:58:43 +0200 Greg KH <gregkh@linuxfoundation.org> wro=
te:
>
> On Wed, Jun 17, 2020 at 09:27:47AM +1000, Stephen Rothwell wrote:
> > This is in preparation for removing the include of major.h where it is
> > not needed.
> >=20
> > These files were found using
> >=20
> > 	grep -E -L '[<"](uapi/)?linux/major\.h' $(git grep -l -w -f /tmp/xx)
> >=20
> > where /tmp/xx contains all the symbols defined in major.h.  There were
> > a couple of files in that list that did not need the include since the
> > references are in comments.
> >=20
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au> =20
>=20
> Any reason this had an RFC, but patch 2/2 did not?

I forgot :-)  I added RFC just to hopefully get some attention as this
is just the start of a long slow use of my "spare" time.

> They look good to me, I will be glad to take these, but do you still
> want reviews from others for this?  It seems simple enough to me...

Yeah, well, we all know the simplest patches usually cause the most pain :-)

However, I have been fairly careful and it is an easy include file to
work with.  And I have done my usual build checks, so the linux-next
maintainer won't complain about build problems :-)

I would like to hear from Arnd, at least, as I don't want to step on
his toes (he is having a larger look at our include files).
--=20
Cheers,
Stephen Rothwell

--Sig_/SR24Am7bJk6gmzp1XI0YNUE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7ptaIACgkQAVBC80lX
0GzKewf8D3i2VcdXPYbwXP1LbIeTDCjjxRMksxmNwVqp+V+AnAGCrFNYjpXQ0XLG
0gS30xMjpcoGedPZ7TlbKO2u8Gyz5VgUgicU+JXaDbCzkgcxtFEdIZCmkeWg9527
WzQZzxpBeEscgR3FvLylhGKrYbdfQT14dQsbnRQhlm+wHANvZdAC1mpmUPjeS7vn
IbG/sr4xzvnHiup3Vy2j0oqgroHqmqCHKUMKaJEdfFBQSHjWsvfvOBFwAiATow3o
eq9imn6UvaSEHU/VFKLNHhYtQKt3a4liB9ScnxlFXFyyYgRx/0ZziBcU6ffHqubd
in7WwTgUBtvePKUxSDd2tctZFT8VlQ==
=YfaS
-----END PGP SIGNATURE-----

--Sig_/SR24Am7bJk6gmzp1XI0YNUE--
