Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S262457AbULCXDl@vger.kernel.org>
Received: from natnoddy.rzone.de ([81.169.145.166]:58568 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S262504AbULCXDl
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 3 Dec 2004 18:03:41 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: other platforms interested in in-kernel unwinder?
Date: Fri, 3 Dec 2004 23:56:18 +0100
References: <16815.21943.55627.572012@napali.hpl.hp.com> <200412031037.22445.arnd@arndb.de> <16816.54808.503077.473990@napali.hpl.hp.com>
In-Reply-To: <16816.54808.503077.473990@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_V8OsBndkqvrFR3z";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200412032356.21537.arnd@arndb.de>
To: davidm@hpl.hp.com
Cc: linux-arch@vger.kernel.org, davidm@napali.hpl.hp.com, Wolfgang Gellerich <gellerich@de.ibm.com>
List-ID: <linux-arch.vger.kernel.org>


--Boundary-02=_V8OsBndkqvrFR3z
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Freedag 03 Dezember 2004 22:09, David Mosberger wrote:

> On s390, do you get just the frame-chain or do the frames contain
> enough information to figure out which callee-saved registers where
> saved?

IIRC, compilers up to gcc 3.4 store all callee-saved registers in a fixed
offset, while with gcc-4.0 and the patched gcc-3.4 used in fedora core 3
only the back chain pointer and the return address can be read directly
without looking at the code or dwarf2 data.

 Arnd <><

--Boundary-02=_V8OsBndkqvrFR3z
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBsO8V5t5GS2LDRf4RAkUgAJ9M9AjSKBhnZy0Gb70MUpy6OIGCFACdFHuq
1FepPXaW33U6N5y3NNXuXyg=
=fl5t
-----END PGP SIGNATURE-----

--Boundary-02=_V8OsBndkqvrFR3z--
