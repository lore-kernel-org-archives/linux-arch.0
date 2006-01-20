Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:52914 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161391AbWATAXr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 Jan 2006 19:23:47 -0500
Message-ID: <43D02D85.90100@redhat.com>
Date: Thu, 19 Jan 2006 16:23:33 -0800
From: Ulrich Drepper <drepper@redhat.com>
MIME-Version: 1.0
Subject: Re: new syscalls
References: <B8E391BBE9FE384DAA4C5C003888BE6F05737A9F@scsmsx401.amr.corp.intel.com> <20060118133629.1cda96fd.akpm@osdl.org> <Pine.LNX.4.63.0601181714330.6878@localhost.localdomain> <20060118172802.5155048f.akpm@osdl.org> <Pine.LNX.4.63.0601191347160.6527@localhost.localdomain> <Pine.LNX.4.63.0601191606300.6527@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.63.0601191606300.6527@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7B2CDDC00636E394A86F6C38"
Sender: linux-arch-owner@vger.kernel.org
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Andrew Morton <akpm@osdl.org>, tony.luck@intel.com, linux-arch@vger.kernel.org, janak@us.ibm.com, dwmw2@infradead.org, dhowells@redhat.com, christoph@lameter.com
List-ID: <linux-arch.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7B2CDDC00636E394A86F6C38
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Davide Libenzi wrote:
> There is a problem with the test we have inside the kernel about the
> size of sigset_t, from the kernel (8 bytes on i386) and the glibc one
> (128 bytes):

Not really a problem.  We always pass down _NSIG/8 as the size.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig7B2CDDC00636E394A86F6C38
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFD0C2F2ijCOnn/RHQRAuJlAKC7QtF86foUI1QjY1CIyOAjR/Vi1wCfQPq4
TtJB52YQ7irKdRnws8PAGJU=
=jVqt
-----END PGP SIGNATURE-----

--------------enig7B2CDDC00636E394A86F6C38--
