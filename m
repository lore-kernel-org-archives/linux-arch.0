Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 10 Mar 2005 15:35:34 +0200
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: no-arch-specific-mem_map-init
Message-ID: <20050310133534.GD32607@linux-sh.org>
References: <20050309225833.6d80fc42.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
In-Reply-To: <20050309225833.6d80fc42.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
List-ID: <linux-arch.vger.kernel.org>


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 09, 2005 at 10:58:33PM -0800, Andrew Morton wrote:
> From: Dave Hansen <haveblue@us.ibm.com>
>=20
> So, I had to make sure to initialize the global mem_map[] before calling
> into free_area_init_node().  Then, I realized how many architectures do
> this on their own, and have comments like this:
>=20
>         /* XXX: MRB-remove - this doesn't seem sane, should this be done =
somewhere else ?*/
>         mem_map =3D NODE_DATA(0)->node_mem_map;
>=20
I don't see any problems with this patch either. At least it works fine
for sh64 as well (and sh, where this comment originated).

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCME0m1K+teJFxZ9wRAh6MAJ9VqAlV9McjPMva+lArzdiEXlAavACeIWyg
vLyZzQvCj8lV7G+hLueUKV4=
=wsFx
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
