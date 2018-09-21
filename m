Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:41221 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388909AbeIUOgM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Sep 2018 10:36:12 -0400
Date: Fri, 21 Sep 2018 18:48:19 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [REVIEW][PATCH 6/9] signal/powerpc: Call force_sig_fault from
 _exception
Message-ID: <20180921184819.31e97d4a@canb.auug.org.au>
In-Reply-To: <20180918175850.4437-6-ebiederm@xmission.com>
References: <878t3yitze.fsf@xmission.com>
        <20180918175850.4437-6-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//oavHTfsofletcttCN6o5i3"; protocol="application/pgp-signature"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Message-ID: <20180921084819.FCaY1GRO21vey_8ow5U2FATehUyqhmMWlDKtQypbJq4@z>

--Sig_//oavHTfsofletcttCN6o5i3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, 18 Sep 2018 19:58:47 +0200 "Eric W. Biederman" <ebiederm@xmission.c=
om> wrote:
>
> The callers of _exception don't need the pkey exception logic because
> they are not processing a pkey exception.  So just call exception_common
> directly and then call force_sig_fault to generate the appropriate siginfo
> and deliver the appropriate signal.
>=20
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Looks right to me.

Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell

--Sig_//oavHTfsofletcttCN6o5i3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluksFMACgkQAVBC80lX
0GyYsAf+OiYQG3ODygJsePBryYHacWy/HSB4up16a8tiS+Z7tUtZ2qvt1ws0pDt5
6m6Zezu956UM4xpHzbfyTkghJa0cWJkf330zzqNKEkfkIio9R2DMCW0ZQrM/U0Kf
lBz4rX5O9y1yKKf1fjSW3TmpyGoE+J0XWt2LHvP25uulsc3Yz8j0HP1W6NV49DSM
s2rxt3N2SFOIw/9yCxZGNhjBeT06hnTqlaLIbJtYxRrmc9ZNmz672SrMfC2AbG4M
bxuip5jj84XaKAAdOEeAtvESJoD0kDgaRNMx8tqomhkxWt5Vy3AO626jzs20OpG2
eJUo8DhIdxrx1I27p5xpI3/D8bHWhA==
=mCgH
-----END PGP SIGNATURE-----

--Sig_//oavHTfsofletcttCN6o5i3--
