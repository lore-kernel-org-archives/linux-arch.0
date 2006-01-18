Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:39084 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161013AbWARVsq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Jan 2006 16:48:46 -0500
Message-ID: <43CEB7A6.1030207@redhat.com>
Date: Wed, 18 Jan 2006 13:48:22 -0800
From: Ulrich Drepper <drepper@redhat.com>
MIME-Version: 1.0
Subject: Re: new syscalls
References: <B8E391BBE9FE384DAA4C5C003888BE6F05737A9F@scsmsx401.amr.corp.intel.com> <20060118133629.1cda96fd.akpm@osdl.org>
In-Reply-To: <20060118133629.1cda96fd.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE86E424A75FFED1F455FEEF1"
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-arch@vger.kernel.org, JANAK DESAI <janak@us.ibm.com>, David Woodhouse <dwmw2@infradead.org>, David Howells <dhowells@redhat.com>, Davide Libenzi <davidel@xmailserver.org>, Christoph Lameter <christoph@lameter.com>
List-ID: <linux-arch.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE86E424A75FFED1F455FEEF1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Andrew Morton wrote:
> That's an excellent point.
>=20
> Guys, architecture maintainers need test suites to verify that the sysc=
alls
> actually work as they wire them up.

glibc has test for all the *at syscalls, pselect.  ppoll and epoll_pwait
will follow as soon as the syscalls are upstream and I can add the
interfaces.  unshare testing is harder, because it likely need
privileges.  Using the tests outside glibc isn't easy because of the
framework for tests we are using.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enigE86E424A75FFED1F455FEEF1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDzrem2ijCOnn/RHQRAqXUAKDOMsjHVgYF27c0abBhW21/ZY+3hwCglUM9
OnfQnnUp6AweU3jNKRdrzuE=
=njLw
-----END PGP SIGNATURE-----

--------------enigE86E424A75FFED1F455FEEF1--
