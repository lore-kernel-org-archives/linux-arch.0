Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S262129AbULCJnc@vger.kernel.org>
Received: from mtagate2.de.ibm.com ([195.212.29.151]:40673 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262125AbULCJnc
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 3 Dec 2004 04:43:32 -0500
Received: from d12nrmr1507.megacenter.de.ibm.com (d12nrmr1507.megacenter.de.ibm.com [9.149.167.1])
	by mtagate2.de.ibm.com (8.12.10/8.12.10) with ESMTP id iB39hSbP170660
	for <linux-arch@vger.kernel.org>; Fri, 3 Dec 2004 09:43:29 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1507.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id iB39hNG8123056
	for <linux-arch@vger.kernel.org>; Fri, 3 Dec 2004 10:43:23 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.12.11) with ESMTP id iB39hRRG001645
	for <linux-arch@vger.kernel.org>; Fri, 3 Dec 2004 10:43:27 +0100
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: other platforms interested in in-kernel unwinder?
Date: Fri, 3 Dec 2004 10:37:22 +0100
References: <16815.21943.55627.572012@napali.hpl.hp.com>
In-Reply-To: <16815.21943.55627.572012@napali.hpl.hp.com>
MIME-Version: 1.0
Message-Id: <200412031037.22445.arnd@arndb.de>
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_SPDsBzsg0ImUR7c";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
To: davidm@hpl.hp.com
Cc: linux-arch@vger.kernel.org, davidm@napali.hpl.hp.com, Wolfgang Gellerich <gellerich@de.ibm.com>
List-ID: <linux-arch.vger.kernel.org>


--Boundary-02=_SPDsBzsg0ImUR7c
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Dunnersdag 02 Dezember 2004 18:49, David Mosberger wrote:

> So, how does this sound? =A0Any interest from say, x86{-64}, PPC, SPARC,
> or any other arch maintainer?

I think it doesn't make much sense for unwinding s390 kernel stacks,
since they already have reliable back traces trough the backchain
pointers. In particular, those pointers are needed anyway for easy
unwinding by hand when debugging in z/VM.

My limited experience on ppc64 suggests that the situation there
is very similar.

OTOH, I've heard that oprofile is unwinding user stacks to get call
graph information. For that purpose, a kernel unwinder might turn
out very valuable on many architectures, including those that use
a backchain pointer in kernel but not in user space.

	Arnd <><





--Boundary-02=_SPDsBzsg0ImUR7c
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBsDPS5t5GS2LDRf4RAv5dAJ9SpQGAmqDh1ud5jgn3nMdmA86pCACbBgwp
17kDQlJku4ljOuEQCO/lrHk=
=ZcbE
-----END PGP SIGNATURE-----

--Boundary-02=_SPDsBzsg0ImUR7c--
