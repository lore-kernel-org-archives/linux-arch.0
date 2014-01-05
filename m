Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:50641 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992AbaAEKYb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 5 Jan 2014 05:24:31 -0500
Date: Sun, 5 Jan 2014 21:24:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/3] kconfig: consolidate arch-specific seccomp options
Message-ID: <20140105212423.537477040dfc25c98810188e@canb.auug.org.au>
In-Reply-To: <52C8AA3B.5010302@sr71.net>
References: <20140102202014.CA206E9B@viggo.jf.intel.com>
	<20140105023853.dda6c1f9c6f9875159634e69@canb.auug.org.au>
	<52C85B34.6040001@sr71.net>
	<20140105103353.9bf06782c851f8eaec0e0f33@canb.auug.org.au>
	<52C8AA3B.5010302@sr71.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Sun__5_Jan_2014_21_24_23_+1100_dUEqADbsFDXC45Wx"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave@sr71.net>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20140105102423.p7TPLzJb4GLA9NnZnR9nBULRGHG6flmpINbi6d--Hw4@z>

--Signature=_Sun__5_Jan_2014_21_24_23_+1100_dUEqADbsFDXC45Wx
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Sat, 04 Jan 2014 16:41:31 -0800 Dave Hansen <dave@sr71.net> wrote:
>
> On 01/04/2014 03:33 PM, Stephen Rothwell wrote:
> >=20
> > I don't know, but if it has gone then it is worth mentioning in the
> > commit message
>=20
> Maybe like this? ;)
>=20
> > There are 7 architecures with "config SECCOMP".  They all have
> > virtually the same help text except for those referencing the
> > /proc interface which was removed in 2007.
>=20
> I guess I could call it out a _bit_ more clearly that I removed the
> dependency because the code is gone.

Ah, yes, I must have been half asleep :-)

> > ... and you did preserve the dependency in the sparc64 case.
>=20
> Ahh, I did.  I'll remove it.  Thanks!

And that probably confused me as well.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Sun__5_Jan_2014_21_24_23_+1100_dUEqADbsFDXC45Wx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSyTLcAAoJEMDTa8Ir7ZwVRFEQAIdY/PhBc1m0sJ82yrUN3q0V
WYYB0tOvd6vXRTnA6hRcMIHD4JJjmB7AyaU0xhS0pd+ELOpGjJXBJ2habSaGvwpG
Omzi8aXJS8T4t3bhf3jUciam5co3/Bw46MXL7+Wm1IPCAj2JRbtWVPjYc1qZb6qL
6cUn1AVrAn+/lWLHcB0v/RQtXrOTL846KQ3EyfyfwjY7si5RrvmCg9SJnVWmf2Y4
6D7R5NQIJWrHFcn9YYckTSWoAJvCOaV/+sSRZuaI8Cbx/T6q2fD9AR62vqp3fsyI
dc5R7ri2qww6S8rVMjiKN74we0nKLISmuASBzxdqrQtcf9vM4f0XjcFAYZy3llMd
SPSz6sTGSO+42m7Ef8+ihffy5qjd4Oit0Y/ynOHjlWsezmLsoFW03HKaV52eZmCR
jS2l4BATbae6nXj2npCHlC+brn4BPorore3VFRhP3I2vD+Kw/yoQZ0OXoNA8+jFm
/3Ik5hXfSAKGXY4Q3Bkc9/n8ZX5yp+N72jFI/B1/vG7F3jxcGJP4h/6Jahh8w50u
IMvup1QRev0bd1xGe99vhXGq+pI783+nJPf9CUh64sxN5i5bYGB6dPi9EvaPCAWA
QJHqfoWJJ9t3IOTTQeLu2Sm8RIo+3B7E8BcekTf8K37leSUyefegW+IM7QuyA+ej
95AgX9maYjSK+IbNDgJC
=Ux22
-----END PGP SIGNATURE-----

--Signature=_Sun__5_Jan_2014_21_24_23_+1100_dUEqADbsFDXC45Wx--
