Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34596 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753052AbdLMMzm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Dec 2017 07:55:42 -0500
Date: Wed, 13 Dec 2017 13:55:40 +0100
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] mmap.2: MAP_FIXED updated documentation
Message-ID: <20171213125540.GA18897@amd>
References: <20171213092550.2774-1-mhocko@kernel.org>
 <20171213093110.3550-1-mhocko@kernel.org>
 <20171213093110.3550-2-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <20171213093110.3550-2-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>, linux-api@vger.kernel.org, Khalid Aziz <khalid.aziz@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Florian Weimer <fweimer@redhat.com>, John Hubbard <jhubbard@nvidia.com>, Matthew Wilcox <willy@infradead.org>, Jann Horn <jannh@google.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Cyril Hrubis <chrubis@suse.cz>, Michal Hocko <mhocko@suse.com>
Message-ID: <20171213125540.aUVZabbjMRzWvRKZfvgcgHpyoY_8xt0DgQYlXk0yjR4@z>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2017-12-13 10:31:10, Michal Hocko wrote:
> From: John Hubbard <jhubbard@nvidia.com>
>=20
>     -- Expand the documentation to discuss the hazards in
>        enough detail to allow avoiding them.
>=20
>     -- Mention the upcoming MAP_FIXED_SAFE flag.

Pretty map everyone agreed MAP_FIXED_SAFE was a bad
name. MAP_FIXED_NOREPLACE (IIRC) was best replacement.

								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAloxI0sACgkQMOfwapXb+vKvXACcDwV3Dm46ZnRcjJU+hkGc5U+o
aDMAnjwaZ9U6SA/erN7azKvIQkRc/oCJ
=kq/9
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
