Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35498 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752714AbdLMNVH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Dec 2017 08:21:07 -0500
Date: Wed, 13 Dec 2017 14:21:05 +0100
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] mmap.2: MAP_FIXED updated documentation
Message-ID: <20171213132105.GA20517@amd>
References: <20171213092550.2774-1-mhocko@kernel.org>
 <20171213093110.3550-1-mhocko@kernel.org>
 <20171213093110.3550-2-mhocko@kernel.org>
 <20171213125540.GA18897@amd>
 <20171213130458.GI25185@dhcp22.suse.cz>
 <20171213130900.GA19932@amd>
 <20171213131640.GJ25185@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20171213131640.GJ25185@dhcp22.suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>, linux-api@vger.kernel.org, Khalid Aziz <khalid.aziz@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Florian Weimer <fweimer@redhat.com>, John Hubbard <jhubbard@nvidia.com>, Matthew Wilcox <willy@infradead.org>, Jann Horn <jannh@google.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20171213132105.i6Yb99I9hmP_jyTCMoPSL_SSD84ORtnarPNbLobDDws@z>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2017-12-13 14:16:40, Michal Hocko wrote:
> On Wed 13-12-17 14:09:00, Pavel Machek wrote:
> > On Wed 2017-12-13 14:04:58, Michal Hocko wrote:
> > > On Wed 13-12-17 13:55:40, Pavel Machek wrote:
> > > > On Wed 2017-12-13 10:31:10, Michal Hocko wrote:
> > > > > From: John Hubbard <jhubbard@nvidia.com>
> > > > >=20
> > > > >     -- Expand the documentation to discuss the hazards in
> > > > >        enough detail to allow avoiding them.
> > > > >=20
> > > > >     -- Mention the upcoming MAP_FIXED_SAFE flag.
> > > >=20
> > > > Pretty map everyone agreed MAP_FIXED_SAFE was a bad
> > > > name. MAP_FIXED_NOREPLACE (IIRC) was best replacement.
> > >=20
> > > Please read http://lkml.kernel.org/r/20171213092550.2774-1-mhocko@ker=
nel.org
> >=20
> > Please fix your patches according to the feedback...
> >=20
> > NACCKED-by: Pavel Machek <pavel@ucw.cz>
>=20
> Good luck pursuing this further then. I am not going to spend time on
> naming bikeheds. I have more pressing stuff to work on.

You selected stupid name for a flag. Everyone and their dog agrees
with that. There's even consensus on better name (and everyone agrees
it is better than .._SAFE). Of course, we could have debate if it is
NOREPLACE or NOREMOVE or ... and that would be bikeshed. This was just
poor naming on your part.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAloxKUEACgkQMOfwapXb+vIaDACglkA+TQweyTN40m07LVKXmmjO
BukAnjMPW+g/zwooUAygb7Qebv4t4P4K
=vJ4y
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
