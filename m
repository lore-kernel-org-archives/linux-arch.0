Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 5 Apr 2005 18:02:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] consolidate shmat usage
Message-Id: <20050405180241.47856c63.sfr@canb.auug.org.au>
In-Reply-To: <27271.1111575268@redhat.com>
References: <20050323174810.17df4440.sfr@canb.auug.org.au>
	<20050323150123.1a78e9c4.sfr@canb.auug.org.au>
	<27271.1111575268@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__5_Apr_2005_18_02_41_+1000_aQQB6T=O3AezpMB2"
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Tue__5_Apr_2005_18_02_41_+1000_aQQB6T=O3AezpMB2
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Mar 2005 10:54:28 +0000 David Howells <dhowells@redhat.com> wrot=
e:
>
> Looks okay to me; but the #ifdef haters are going to hate your guts and i=
nsist
> that the sys_shmat and sys_shmatcall functions you added go in their own =
files
> and get conditionally included by the Makefile.

I am one of those, but couldn't be bothered.  I have removed the ifdefs in
the new version so everyone gets both these (very small) syscall stubs.

New version following.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__5_Apr_2005_18_02_41_+1000_aQQB6T=O3AezpMB2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCUkYh4CJfqux9a+8RAjvAAJkBLc+1i4Jy+GuVCo1akLV0j1/cSwCfVO52
aHNjNbX3G3rH+JfQATkLeVk=
=+4g3
-----END PGP SIGNATURE-----

--Signature=_Tue__5_Apr_2005_18_02_41_+1000_aQQB6T=O3AezpMB2--
