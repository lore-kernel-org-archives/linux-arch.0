From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [RFC PATCH 1/2] Explicitly include linux/major.h where it is
 needed
Date: Tue, 30 Jun 2020 09:12:03 +1000
Message-ID: <20200630091203.55cdd5d9@canb.auug.org.au>
References: <20200617092614.7897ccb2@canb.auug.org.au>
        <20200617092747.0cadb2de@canb.auug.org.au>
        <20200617055843.GB25631@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BCTuQZc6gP7JPm+u0nl1Qal";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bilbo.ozlabs.org ([203.11.71.1]:48215 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbgF2XMH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 29 Jun 2020 19:12:07 -0400
In-Reply-To: <20200617055843.GB25631@kroah.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linux-kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

--Sig_/BCTuQZc6gP7JPm+u0nl1Qal
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
>=20
> They look good to me, I will be glad to take these, but do you still
> want reviews from others for this?  It seems simple enough to me...

I am going to do another round of this patchset splitting out most of
the "safe" removals that can be done anytime so other maintainers can
take them.  Then there will be the left over order dependent changes at
the end.

--=20
Cheers,
Stephen Rothwell

--Sig_/BCTuQZc6gP7JPm+u0nl1Qal
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl76dUMACgkQAVBC80lX
0GwhGQgAhvHebmqV9c+voc8vdC1Luf8C7PWLbdIb6f1iaY+N1bSNKmatpFwTZ1Up
yf4+QbGQUZbKdTwc7VvNADVmLtek6h9aPVEF+hNKSMFPwCiBCOhpMGCSx4bXFRsj
irlLoWruvzaAywFE6Qh8GOYbp+SSnW0T6KGnwfrn965opehsULzWBbBOoWY2euF8
73/adQZJiKUYpTQpvGDKdDBogQRAYs6AFer+7NUxXnH6FN9Zv4wicjMcSpWqss73
apAKvefLfTY0y+HD7JMoui4msRP+oP9AX7szdZQG81Ns7N26Kl6Uz09DsQCxp5mT
s5688o6hb+MACM2k5TVUFdQd+GE74g==
=aVuJ
-----END PGP SIGNATURE-----

--Sig_/BCTuQZc6gP7JPm+u0nl1Qal--
