Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:54401 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755930AbXEQE4S (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 May 2007 00:56:18 -0400
Subject: Re: [PATCH 1/2] Use a weak symbol for the empty version of
	pcibios_add_platform_entries()
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
In-Reply-To: <1178589787.623400.604851478076.qpush@cradle>
References: <1178589787.623400.604851478076.qpush@cradle>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LL4oUwICx7vTYOicqa0+"
Date: Thu, 17 May 2007 14:56:16 +1000
Message-Id: <1179377776.4142.11.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
To: Greg Kroah-Hartman <greg@kroah.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


--=-LL4oUwICx7vTYOicqa0+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-05-08 at 12:03 +1000, Michael Ellerman wrote:
> Use a weak empty definition of pcibios_add_platform_entries() to avoid ha=
ving
> an empty definition on every arch.

Hi Greg,

I don't see this one in your tree yet. Let me know if you want me to
resend etc.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-LL4oUwICx7vTYOicqa0+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGS+BwdSjSd0sB4dIRAjLoAKDJKbYV4aqDvOutq9D8QwrDC1Q4hgCfSzlI
9vdMzouhmpY6uTNJ5QdofGU=
=uVp/
-----END PGP SIGNATURE-----

--=-LL4oUwICx7vTYOicqa0+--

