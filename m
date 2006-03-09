Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout0.freenet.de ([194.97.50.131]:45505 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S932096AbWCILoR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2006 06:44:17 -0500
From: Michael Buesch <mbuesch@freenet.de>
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
Date: Thu, 9 Mar 2006 12:44:09 +0100
References: <Pine.LNX.4.64.0603081115300.32577@g5.osdl.org> <Pine.LNX.4.64.0603081716400.32577@g5.osdl.org> <17423.42185.78767.837295@cargo.ozlabs.ibm.com>
In-Reply-To: <17423.42185.78767.837295@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1961345.meoHJZIQSV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603091244.09621.mbuesch@freenet.de>
Sender: linux-arch-owner@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, Alan Cox <alan@redhat.com>, linuxppc64-dev@ozlabs.org
List-ID: <linux-arch.vger.kernel.org>

--nextPart1961345.meoHJZIQSV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 09 March 2006 04:45, you wrote:
> ... then I can remove the sync from write*, which would be nice, and
> make mmiowb() be a sync.  I wonder how long we're going to spend
> chasing driver bugs after that, though. :)

Can you do a patch, which does the change, so people can actually
test their drivers?

=2D-=20
Greetings Michael.

--nextPart1961345.meoHJZIQSV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEEBUJlb09HEdWDKgRAk/pAJ9pjsBhZ81hSzSg1kUCfW9QUcvCAgCfVm+/
/2Z+9pH/To4hM1H6OJoPUf8=
=FH+3
-----END PGP SIGNATURE-----

--nextPart1961345.meoHJZIQSV--
