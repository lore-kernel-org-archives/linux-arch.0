Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:34196 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753370AbXJDDyG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 3 Oct 2007 23:54:06 -0400
Date: Thu, 4 Oct 2007 13:53:31 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: + f_dupfd_cloexec-implementation.patch added to -mm tree
Message-Id: <20071004135331.2ef6f33a.sfr@canb.auug.org.au>
In-Reply-To: <200710032039.l93KdeQ3007574@imap1.linux-foundation.org>
References: <200710032039.l93KdeQ3007574@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__4_Oct_2007_13_53_31_+1000_CVqk/qkw0I+e1wp7"
Sender: linux-arch-owner@vger.kernel.org
To: drepper@redhat.com
Cc: akpm@linux-foundation.org, hch@lst.de, kyle@mcmartin.ca, linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Thu__4_Oct_2007_13_53_31_+1000_CVqk/qkw0I+e1wp7
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 03 Oct 2007 13:39:39 -0700 akpm@linux-foundation.org wrote:
>
>=20
> diff -puN include/asm-generic/fcntl.h~f_dupfd_cloexec-implementation incl=
ude/asm-generic/fcntl.h
> --- a/include/asm-generic/fcntl.h~f_dupfd_cloexec-implementation
> +++ a/include/asm-generic/fcntl.h
> @@ -73,6 +73,9 @@
>  #define F_SETSIG	10	/* for sockets. */
>  #define F_GETSIG	11	/* for sockets. */
>  #endif
> +#ifndef F_DUPFD_CLOEXEC
> +#define F_DUPFD_CLOEXEC	12
> +#endif

Why not put

#define F_DUPFD_CLOEXEC		(F_LINUX_SPECIFIC_BASE + 6)

in include/linux/fcntl.h?  That way it will be the same for all
architectures and won't clash with any of them.

F_LINUX_SPECIFIC_BASE is probably badly named.  It was meant to be a
value that was greater than any of the F_ constants for all architestures
so that we could define new F_ constants Linux wide.

Of course, then you would not need f_dupfd_cloexec-implementation-fix.patch
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__4_Oct_2007_13_53_31_+1000_CVqk/qkw0I+e1wp7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHBGPGTgG2atn1QN8RAqp0AJ49QqKVN6mtq4wVxDLYKQqGDZx0swCdHTjF
f+KFanr4mjN30cxlBBQ/sxg=
=q6DN
-----END PGP SIGNATURE-----

--Signature=_Thu__4_Oct_2007_13_53_31_+1000_CVqk/qkw0I+e1wp7--
