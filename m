Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:46689 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161077AbXBTXUB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 20 Feb 2007 18:20:01 -0500
Date: Wed, 21 Feb 2007 10:20:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [patch 18/50] add epoll compat code to kernel/compat.c
Message-Id: <20070221102027.52bf703a.sfr@canb.auug.org.au>
In-Reply-To: <200702202159.l1KLxMcC021074@shell0.pdx.osdl.net>
References: <200702202159.l1KLxMcC021074@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__21_Feb_2007_10_20_27_+1100_Op_rO.Jdy.moJE.M"
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org, davidel@xmailserver.org, dwmw2@infradead.org, linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, tony.luck@intel.com
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Wed__21_Feb_2007_10_20_27_+1100_Op_rO.Jdy.moJE.M
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2007 13:57:58 -0800 akpm@linux-foundation.org wrote:
>
> From: Davide Libenzi <davidel@xmailserver.org>
>
> Add epoll compat_ code to kernel/compat.c.  IA64 and ARM-OABI are currently
> using their own version of epoll compat_ code and they could probably wire to
> the new common code.

So did you just ignore the discussion that went on about this patch and
the suggestions made (by me) and accepted by the author?  i.e. why has
this gone to Linus in this form?

Nacked-by: Stephen Rothwell <sfr@canb.auug.org.au>

Whatever that means.
--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__21_Feb_2007_10_20_27_+1100_Op_rO.Jdy.moJE.M
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFF24JAFdBgD/zoJvwRAiCHAKCPT+OuyigyOZq+VZDGhRP/TV5KjACbB0Wy
K71fsiOO4QnpbFbI2Kx6IzU=
=xJVG
-----END PGP SIGNATURE-----

--Signature=_Wed__21_Feb_2007_10_20_27_+1100_Op_rO.Jdy.moJE.M--
