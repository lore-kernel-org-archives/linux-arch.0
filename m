Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:59198 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfKFVqJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Nov 2019 16:46:09 -0500
Date: Wed, 6 Nov 2019 22:37:25 +0100
From: Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH 10/10] errno.h: Provide EFSCORRUPTED for everybody
Message-ID: <20191106213725.GB7020@amd>
References: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
 <20191104014510.102356-11-Valdis.Kletnieks@vt.edu>
 <5c441427-7e65-fcae-3518-eb37cea5f875@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline
In-Reply-To: <5c441427-7e65-fcae-3518-eb37cea5f875@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Cc: Valdis Kletnieks <valdis.kletnieks@vt.edu>, "Darrick J . Wong" <darrick.wong@oracle.com>, Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-xfs@vger.kernel.org, Jan Kara <jack@suse.com>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-arch@vger.kernel.org
Message-ID: <20191106213725.uHUqpDqIVQrfWj-Ez4zjtYlGJKE_19x6BP8x-aC12ck@z>


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > There's currently 6 filesystems that have the same #define. Move it
> > into errno.h so it's defined in just one place.
> >=20
> > Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
> > Acked-by: Darrick J. Wong <darrick.wong@oracle.com>
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Acked-by: Theodore Ts'o <tytso@mit.edu>
>=20
> >  fs/erofs/internal.h              | 2 --
>=20
> >  fs/f2fs/f2fs.h                   | 1 -
>=20
> Acked-by: Chao Yu <yuchao0@huawei.com>

Are we still using EUCLEAN for something else than EFSCORRUPTED? Could
we perhaps change the glibc definiton to "your filesystem is
corrupted" in the long run?

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl3DPRUACgkQMOfwapXb+vIeLACgumqpgUAXyu1qs1LlH4i+wJ+u
sPEAn0YdeU4hDroZD6g3yLDme7o5MHbL
=nCbA
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
