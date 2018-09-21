Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:47417 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389444AbeIUOpj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Sep 2018 10:45:39 -0400
Date: Fri, 21 Sep 2018 18:57:44 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [REVIEW][PATCH 8/9] signal/powerpc: Simplify _exception_pkey by
 using force_sig_pkuerr
Message-ID: <20180921185744.51105b5b@canb.auug.org.au>
In-Reply-To: <20180918175850.4437-8-ebiederm@xmission.com>
References: <878t3yitze.fsf@xmission.com>
        <20180918175850.4437-8-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Gp=gBr.0=l/9DCnD9GI=IhE"; protocol="application/pgp-signature"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Message-ID: <20180921085744.U2Laz5u-bMhnN2eDJv-Xt68JZEcVJ0_X8qtuMZcvatk@z>

--Sig_/Gp=gBr.0=l/9DCnD9GI=IhE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, 18 Sep 2018 19:58:49 +0200 "Eric W. Biederman" <ebiederm@xmission.c=
om> wrote:
>
> Call force_sig_pkuerr directly instead of rolling it by hand
> in _exception_pkey.
>=20
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

You can ignore the question in the previous email :-)

Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell

--Sig_/Gp=gBr.0=l/9DCnD9GI=IhE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluksogACgkQAVBC80lX
0Gy4mQf+OPyQPqnPYWv5mYEDXVfxZFJ5tFOjH/wU9rR4UcLXjdvcoM6fd9htStNm
S0BrF3IKqznDiTJDPm1AjvTitmaWWDcqQCQ5Y1P+wyVoGu2anESHU2auUVlIm7oU
6u/ztIKtPs19NZenAvXmJ5xQywFZgidXib8n490pofHUpk9Z4nZstvRJ1XjPL+r4
J0Ys5/jbBqEdpZXMnKU+GParLzErpH4rFbtQdHHrsPyQRVNTDkkIrAkef8PBmG1U
Xupe75sArPFbzh+Bx/CbkBMv+FCYIPxMtZN/RCT5p91rUCykwkAGoN11hyA4kJTB
rte0fsqNUdFW0Fhu+OuG6yB4+ZJ+VQ==
=rcVF
-----END PGP SIGNATURE-----

--Sig_/Gp=gBr.0=l/9DCnD9GI=IhE--
