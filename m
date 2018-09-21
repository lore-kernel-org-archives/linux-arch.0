Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:39621 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbeIUOZ7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Sep 2018 10:25:59 -0400
Date: Fri, 21 Sep 2018 18:38:07 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [REVIEW][PATCH 5/9] signal/powerpc: Factor the common exception
 code into exception_common
Message-ID: <20180921183807.700623bd@canb.auug.org.au>
In-Reply-To: <20180918175850.4437-5-ebiederm@xmission.com>
References: <878t3yitze.fsf@xmission.com>
        <20180918175850.4437-5-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//TK0bzvZq/Kez6spvh++oVH"; protocol="application/pgp-signature"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Message-ID: <20180921083807.mKaBSkN9FLPZ2-hA5NupQ4dtpj2RoiwNML5eSnhT6Gc@z>

--Sig_//TK0bzvZq/Kez6spvh++oVH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, 18 Sep 2018 19:58:46 +0200 "Eric W. Biederman" <ebiederm@xmission.c=
om> wrote:
>
> It is brittle and wrong to populate si_pkey when there was not a pkey
> exception.  The field does not exist for all si_codes and in some
> cases another field exists in the same memory location.
>=20
> So factor out the code that all exceptions handlers must run
> into exception_common, leaving the individual exception handlers
> to generate the signals themselves.
>=20
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Clearly no change in semantics.

Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell

--Sig_//TK0bzvZq/Kez6spvh++oVH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlukre8ACgkQAVBC80lX
0Gwkigf/bA/DSSCczbH5itXP3jjiTRk4KR/N1QmKfnFTXvrspspJjGyXr+88oGeY
rVK+HHbcdXuNQmi2dGL3UYhAcBPqmHb/MVEtblEpi9/zxCCku2evwJqQKryfGaKA
fhskO18ZMSD1aRqrJ61YY7kC/ZqQ+oYGIlpZidTX50Usf6Dl1zXmb9mewggnzX24
94ObFYt7duEt5lW+NII1dCxPZMxZM4T1O79efhgPU3IGP9UEjHYzin6Of/AVjU6R
o34/Oo6S7jBAXBTf8sgo2QEwnEz4xu27NQuFHtkG2/LwBlKrKPw/ngHGQiWbzahX
oOWqoaiphleG4+40GHtmmxCLe8VDwA==
=FL4j
-----END PGP SIGNATURE-----

--Sig_//TK0bzvZq/Kez6spvh++oVH--
