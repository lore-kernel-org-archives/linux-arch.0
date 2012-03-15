From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH 07/38] Disintegrate asm/system.h for Blackfin [ver #3]
Date: Thu, 15 Mar 2012 19:02:23 -0400
Message-ID: <201203151902.25640.vapier@gentoo.org>
References: <20120315205514.28759.58969.stgit@warthog.procyon.org.uk> <20120315205620.28759.65095.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6286657.DrAjxFpHXD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:40673 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030372Ab2COXCZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Mar 2012 19:02:25 -0400
In-Reply-To: <20120315205620.28759.65095.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: uclinux-dist-devel@blackfin.uclinux.org, lliubbo@gmail.com
Cc: David Howells <dhowells@redhat.com>, paul.gortmaker@windriver.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de

--nextPart6286657.DrAjxFpHXD
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Thursday 15 March 2012 16:56:21 David Howells wrote:
> Disintegrate asm/system.h for Blackfin.

i think Bob found an error in this patch.  he'll have to comment though.
-mike

--nextPart6286657.DrAjxFpHXD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPYnUBAAoJEEFjO5/oN/WBkdUP/3dEh6jC4b58DzaRVpPEcMFt
/H8V00XMaWHKfyv7ZWzxQOSm4XOe0/GqMe/3+AYqXvULmNaat3nrPfghnOgi2b84
aDm0ELBXflw9AIxOwpG2aWUEk6AWg6w1oqicYs7wxPisbbcWdB+MjOVQbNpHkspK
DvpJ9O8r9a6WZJJpLVG5K0M4dH+RYzrARaacb+B+1ffsBrPjoChQXQHdGgEnadTb
wUCLX0uhSw1QwpQjHb6AN1lts+Vf+VycrMK7a9miGrGt+ATutwAbTeiLNgpIRywe
Ek8FDwLquWvqJ69dpgiKfUInMlD3kYImddrKM378oCEuLUuW6Bt1pc1hRm9FAFyP
fL2aTWOaHECiYcaOm3oebdJ5wasp1azkxO1AVg3Ng+Pu+N47wVSLN3SedFmca/g3
7r4CVoe8MmvtWeMzEs/MeCB5mrAuGnid7if6Xv3MnQAQvdrCnSdCGmaYlrqKvj0P
NGn3JiBiRDnamjKybgDAzU8fv7eL/i2Et10ex0Py+EnTFXNXODhaQ/2hjIt9HMvS
57IMmrgU19iEprxu/ZC0AdOCzReBmFyk+IqfWNngYYy+zwWpddwaSBb5nq8yEgQk
Dg7UG0IfoJulloeHY2InRDELRAApwuLMBMlMpD/JL6x/5OGUFZN3+sf/yoVsLRxb
tSI0PWamixWrQCkc1i1N
=7xgz
-----END PGP SIGNATURE-----

--nextPart6286657.DrAjxFpHXD--
