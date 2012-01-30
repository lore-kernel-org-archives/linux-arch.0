Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.sf-mail.de ([62.27.20.61]:51147 "EHLO www.sf-tec.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752994Ab2A3ULV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 30 Jan 2012 15:11:21 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Re: [PATCH] fix compile break caused by iomap: make IOPORT/PCI mapping functions conditional
Date: Mon, 30 Jan 2012 21:10:45 +0100
Message-ID: <1539148.qFWsuy2OOI@eto>
In-Reply-To: <1327941647.21193.53.camel@dabdike.int.hansenpartnership.com>
References: <1327941647.21193.53.camel@dabdike.int.hansenpartnership.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1645417.cUTOy9pxfp"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>
Message-ID: <20120130201045.cP4a8-Pj1THXydHgtOp6jgIOiY28g1nGI0z9AISOL3E@z>


--nextPart1645417.cUTOy9pxfp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Montag 30 Januar 2012, 10:40:47 schrieb James Bottomley:
> The problem in
> 
> commit fea80311a939a746533a6d7e7c3183729d6a3faf
> Author: Randy Dunlap <rdunlap@xenotime.net>
> Date:   Sun Jul 24 11:39:14 2011 -0700
> 
>     iomap: make IOPORT/PCI mapping functions conditional
> 
> 
> is that if your architecture supplies pci_iomap/pci_iounmap, it expects
> always to supply them.  Adding empty body defitions in the !CONFIG_PCI
> case, which is what this patch does, breaks the parisc compile because
> the functions become doubly defined.  It took us a while to spot this,
> because we don't actually build !CONFIG_PCI very often (only if someone
> is brave enough to test the snake/asp machines).
> 
> Since the note in the commit log says this is to fix a
> CONFIG_GENERIC_IOMAP issue (which it does because CONFIG_GENERIC_IOMAP
> supplies pci_iounmap only if CONFIG_PCI is set), there should actually
> have been a condition upon this.  This should make sure no other
> architecture's !CONFIG_PCI compile breaks in the same way as parisc.
> 
> The fix had to be updated to take account of the GENERIC_PCI_IOMAP
> separation.

So this means we end up still building the PA-RISC PCI code even if the config 
says no PCI. That doesn't really sound consistent to me. I really would have 
expected that we do not build any non-void PCI code then.

> Reported-by: Rolf Eike Beer <eike@sf-mail.de>

I used the wrong email account when sending out the last patch where you took 
that from, please change that to the address used in this mail.

Eike
--nextPart1645417.cUTOy9pxfp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEABECAAYFAk8m+UwACgkQXKSJPmm5/E7FrgCaA2uVI5Xy5j0ck//kZHPWB9oZ
DT4AnjagwQ8gBcNGVtWV3ECQEKKMF26r
=O17p
-----END PGP SIGNATURE-----

--nextPart1645417.cUTOy9pxfp--

