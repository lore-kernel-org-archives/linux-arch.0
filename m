Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:45067 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389022AbeIUOyh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Sep 2018 10:54:37 -0400
Date: Fri, 21 Sep 2018 19:06:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [REVIEW][PATCH 0/9] signal/powerpc: siginfo cleanups
Message-ID: <20180921190639.36c4bcf8@canb.auug.org.au>
In-Reply-To: <878t3yitze.fsf@xmission.com>
References: <878t3yitze.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/L83Adti=lF2bierENe4AgKL"; protocol="application/pgp-signature"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Message-ID: <20180921090639.K3P_WR6p5ahEwHxmy1JsBqwg5cDIqHaAmc5CAt9nAx0@z>

--Sig_/L83Adti=lF2bierENe4AgKL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, 18 Sep 2018 19:41:09 +0200 ebiederm@xmission.com (Eric W. Biederman=
) wrote:
>
> Folks please review and double check me.  I think I have kept these
> changes simple and obviously correct but I am human and mess up
> sometimes.

Its always good to see a nicely set out patch series like this.

--=20
Cheers,
Stephen Rothwell

--Sig_/L83Adti=lF2bierENe4AgKL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluktJ8ACgkQAVBC80lX
0GzDLQgAjiA+cJSVkM6LtgzOLLTCs4Co5C770JYclf8Z1UezSfK0DvVUbyEL1FZs
ric3KQQVU5qyNzMM3qJX+UJjQUlFMumsFcbp9eRV4Uavyanvv0JQgnbYo/L/u9Fc
E+pjhUK3qSPF0tJs4nC+szglI+DMIvGFl64Y7RN2/CFev1w61uEvOanZgdkVlA4W
ArjpONz2GSebGRcKE6fJghjqLwQMGFe9pU9umSSLZSv9XuX1hINYGaTN6zqy8f+Q
1pgc4YvMgvNXcAPEoTM2B3fUPkDgw+F7WKMYVjX4nLsV1z9qE4BWli99UHGC6aTp
AWJ64EKghrxlKCDpEjKm9Iq7BhDiCw==
=Kblr
-----END PGP SIGNATURE-----

--Sig_/L83Adti=lF2bierENe4AgKL--
