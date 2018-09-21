From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [REVIEW][PATCH 3/9] signal/powerpc: Call _exception_pkey
 directly from bad_key_fault_exception
Date: Fri, 21 Sep 2018 18:27:20 +1000
Message-ID: <20180921182720.33c3f8a9@canb.auug.org.au>
References: <878t3yitze.fsf@xmission.com>
        <20180918175850.4437-3-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qUkmP+t.roKV2=ucn=23vo3"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918175850.4437-3-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
List-Id: linux-arch.vger.kernel.org

--Sig_/qUkmP+t.roKV2=ucn=23vo3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, 18 Sep 2018 19:58:44 +0200 "Eric W. Biederman" <ebiederm@xmission.c=
om> wrote:
>
> This removes the need for other code paths to deal with pkey exceptions.
>=20
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Straight forward expansion.

Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell

--Sig_/qUkmP+t.roKV2=ucn=23vo3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlukq2gACgkQAVBC80lX
0GxTxwgAouidowtsKnuRFonlSwPPyq6/LhjukwRpy5HKd8fqAVfPRLhgusBr3qUG
f34npGhGWwsIcVZWNjJbT4yOHxf04qgdhWMTRkxKpLa3nyT0Z7lpVUKflCGFaZQc
toJivHkVpYNygR5N1lrcwxkEFLKESkQNqYD5k5j6uS5UzXClElC5mshVludpU5ga
5sAdIEBB3fJtMtnOTkimgSRLS6guKXeRYgv8ea7T7QoJ8+VIujlt/sEhS+sLWrsq
MhcjfmyomAyvo2ubmYxn7ycr8JhO2bodd84MSzQLedwCuVOhqOqXURE0q+kagvlT
mRBHVKpaKPHBsADOYYhH+8BmJdUFzg==
=3nK3
-----END PGP SIGNATURE-----

--Sig_/qUkmP+t.roKV2=ucn=23vo3--
