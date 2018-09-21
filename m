Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:37663 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbeIUOLZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Sep 2018 10:11:25 -0400
Date: Fri, 21 Sep 2018 18:23:36 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [REVIEW][PATCH 2/9] signal/powerpc: Remove pkey parameter from
 __bad_area
Message-ID: <20180921182336.34eb93bb@canb.auug.org.au>
In-Reply-To: <20180918175850.4437-2-ebiederm@xmission.com>
References: <878t3yitze.fsf@xmission.com>
        <20180918175850.4437-2-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+1fvc78zun2mu//N77zcj6u"; protocol="application/pgp-signature"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Message-ID: <20180921082336.clgXdoSjR12sXPg2Ahu8KMZ5OtozgWAOT5lCECzajgM@z>

--Sig_/+1fvc78zun2mu//N77zcj6u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, 18 Sep 2018 19:58:43 +0200 "Eric W. Biederman" <ebiederm@xmission.c=
om> wrote:
>
> There are no callers of __bad_area that pass in a pkey parameter so it ma=
kes
> no sense to take one.
>=20
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Fairly straight forward.

Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell

--Sig_/+1fvc78zun2mu//N77zcj6u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlukqogACgkQAVBC80lX
0Gzg/gf/WX4pu1mmKoOigaEl4I8FeP/UYJwLdW5/Pzh2ZHt3wSwPa83m9llUlgO+
WA0pEchtVOFP8EEWEJz+kjwtM6tKUNKssgtS47svKZv5neMAZCOCgOSmMPM5WU+b
oEhbdgJdeKKZ+4SRk5VhbmfUk6XdEqZ6AWP9i+CM9RdBNbAXHunVQ0o28WUJircl
8bnZNblQ0Zrqd2jbc4tEcSBjmibUA2NLzvLM9Q3LBJP5GVHZo1iFxzNBYGVNbfhP
0xLluK6fhtNg2V28geP2KKbRMDzQDnWRMGjHhJQibiwDpXMvf4rgPgb4fn5CdCz+
4YG4NyhPLvJIj2hSX/KUTYkTgcsn/A==
=h6+X
-----END PGP SIGNATURE-----

--Sig_/+1fvc78zun2mu//N77zcj6u--
