Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:34605 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388909AbeIUOIs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Sep 2018 10:08:48 -0400
Date: Fri, 21 Sep 2018 18:20:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [REVIEW][PATCH 1/9] signal/powerpc: Use force_sig_mceerr as
 appropriate
Message-ID: <20180921182016.45039844@canb.auug.org.au>
In-Reply-To: <20180918175850.4437-1-ebiederm@xmission.com>
References: <878t3yitze.fsf@xmission.com>
        <20180918175850.4437-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/hFzliqTZXG32fC_.thNh2X2"; protocol="application/pgp-signature"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Message-ID: <20180921082016.fWD_Yw6I7-EAIGpprzL8sKWlNiKuvvNcLceCVivhsYs@z>

--Sig_/hFzliqTZXG32fC_.thNh2X2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, 18 Sep 2018 19:58:42 +0200 "Eric W. Biederman" <ebiederm@xmission.c=
om> wrote:
>
> In do_sigbus isolate the mceerr signaling code and call
> force_sig_mceerr instead of falling through to the force_sig_info that
> works for all of the other signals.
>=20
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Looks good to me.  I was going to mention further cleanup, but I see
you do that in a later patch.

Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell

--Sig_/hFzliqTZXG32fC_.thNh2X2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlukqcEACgkQAVBC80lX
0GzsOAf9FbPsGUfwnqkVUOxlUsK16JCBbL0AaAeq1SnTh0/e/N81AmfhDql5BEzx
67TeRWxlO1dRUBa4LcMQDMCR/73vskgBgamUiwW3+3Im6gBpCFZLjtXbsVOdtzrH
be/TNU+tCitFphIwFJRXGLS29bLqdKHHpbCaNXdQ6ndA9tiXgp7k6EdsCRvLddpj
JJRVMaDtn61fJrazuuU6kzLU+XQuPhWU/Vk2VM6n9HaYfojys6iJcb6VA2tGO6BS
Zn/+5AKDloz2TXHD5hPyk3t3uTxZ/gIfXEi67TqvqcIz6nTeM2mvejPH02PPQFqg
r389zGrHSMpokgtlwKIwO2UEqL0sAQ==
=hAFB
-----END PGP SIGNATURE-----

--Sig_/hFzliqTZXG32fC_.thNh2X2--
