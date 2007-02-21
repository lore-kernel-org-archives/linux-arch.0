Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:59156 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932237AbXBUBFe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 20 Feb 2007 20:05:34 -0500
Date: Wed, 21 Feb 2007 12:05:58 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [patch 18/50] add epoll compat code to kernel/compat.c
Message-Id: <20070221120558.8429382b.sfr@canb.auug.org.au>
In-Reply-To: <20070221120145.419a03ee.sfr@canb.auug.org.au>
References: <200702202159.l1KLxMcC021074@shell0.pdx.osdl.net>
	<20070221102027.52bf703a.sfr@canb.auug.org.au>
	<Pine.LNX.4.64.0702201530250.2498@alien.or.mcafeemobile.com>
	<20070221120145.419a03ee.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__21_Feb_2007_12_05_58_+1100_iJJvW.+skj./Rlk1"
Sender: linux-arch-owner@vger.kernel.org
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, tony.luck@intel.com, ralf@linux-mips.org
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Wed__21_Feb_2007_12_05_58_+1100_iJJvW.+skj./Rlk1
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2007 12:01:45 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Add epoll compat_ code to kernel/compat.c.  IA64 and ARM-OABI are
                            ^^^^^^^^^^^^^^^
Should be fs/compat.c, of course :-(

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__21_Feb_2007_12_05_58_+1100_iJJvW.+skj./Rlk1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFF25sAFdBgD/zoJvwRAh5xAJ48eTrTVfzxrUNVayi8Muu1Rd4BZgCeIizr
HGzIwr7spWeqyLQAeTwLppc=
=eiFA
-----END PGP SIGNATURE-----

--Signature=_Wed__21_Feb_2007_12_05_58_+1100_iJJvW.+skj./Rlk1--
