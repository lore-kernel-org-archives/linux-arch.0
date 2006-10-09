Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:30634 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1751048AbWJIKcg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Oct 2006 06:32:36 -0400
Date: Mon, 9 Oct 2006 20:32:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in
 the kernel [try #4]
Message-Id: <20061009203235.57e4c20a.sfr@canb.auug.org.au>
In-Reply-To: <EE65413A-0E34-40DA-9037-72423C18CD0C@mac.com>
References: <Pine.LNX.4.61.0610062250090.30417@yvahk01.tjqt.qr>
	<20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com>
	<Pine.LNX.4.61.0610062232210.30417@yvahk01.tjqt.qr>
	<20061006203919.GS2563@parisc-linux.org>
	<5267.1160381168@redhat.com>
	<Pine.LNX.4.61.0610091032470.24127@yvahk01.tjqt.qr>
	<EE65413A-0E34-40DA-9037-72423C18CD0C@mac.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__9_Oct_2006_20_32_35_+1000_O2BmMAwhoOfS2OC."
Sender: linux-arch-owner@vger.kernel.org
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, David Howells <dhowells@redhat.com>, Matthew Wilcox <matthew@wil.cx>, torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Mon__9_Oct_2006_20_32_35_+1000_O2BmMAwhoOfS2OC.
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 9 Oct 2006 05:51:14 -0400 Kyle Moffett <mrmacman_g4@mac.com> wrote:
>
> It might be possible to clean up the types.h files a bit with
> something like the following in linux/types.h (nearly identical code
> is found in all of the asm-*/types.h files):

Even better might be to put this in asm-generic/types.h and include
that from wherever is sensible.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__9_Oct_2006_20_32_35_+1000_O2BmMAwhoOfS2OC.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFKiVDFdBgD/zoJvwRAvAlAJ47hcWab4ZzALlh73EsBAAYd+JpfQCfYoUj
LYn9h7Ys0jzgM/eGH+eFD7I=
=+gZT
-----END PGP SIGNATURE-----

--Signature=_Mon__9_Oct_2006_20_32_35_+1000_O2BmMAwhoOfS2OC.--
