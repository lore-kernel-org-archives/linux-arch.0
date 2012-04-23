From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] C6X: change main arch kbuild symbol
Date: Mon, 23 Apr 2012 11:33:12 -0400
Message-ID: <201204231133.14411.vapier@gentoo.org>
References: <1335192956-15753-1-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4218661.SvQGrZdYl4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:51303 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752724Ab2DWPbu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 23 Apr 2012 11:31:50 -0400
In-Reply-To: <1335192956-15753-1-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Aurelien Jacquiot <a-jacquiot@ti.com>

--nextPart4218661.SvQGrZdYl4
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

On Monday 23 April 2012 10:55:56 Mark Salter wrote:
> Currently the c6x architecture uses CONFIG_TMS320C6X as the main
> architecture symbol. Most architectures use a more intuitive name
> based on the architecture directory name. There are no current
> users of TMS320C6X so this patch simply changes CONFIG_TMS320C6X
> to the more intuitive CONFIG_C6X.

Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike

--nextPart4218661.SvQGrZdYl4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPlXY6AAoJEEFjO5/oN/WBy0kQAK1cd2/LslpZsdOoyXmqIL8T
jT+vhYNxEA9Za8Bi4tXD+1c+Tic36BfVg1kJjV3tR6Qn6+ThPGfEo7+rqhw+VubS
kgtE8yTYb9vuEVWWA6MIn6c0fRKtUKhR2Y3tCQ44EuKWskA6yksA9FaOYJ71dtvx
SMZ59sFWc7Dr1NOMPp2X7nH/ccFiNJGOBY0LYeXUQuX5HQ6M+Z9/v8cwDdOpJ8d1
5IWd3I5nqeoj/0D0LKl+MwdV3S0/BIe897iuwxnFzOpNdIYXO7ESrnukE93boALc
cv+/3rTLNfXcb/xKHuyHndueJKn2G95sblUrLOpIurvC762O8cueVUeFSrdC0Bq6
Uzsa2tQnROLYFqaHKKnROUza2weVWnWkoknFzZ/SgRqrxm+a/Qao0VhjRF5OwNke
Mn34St0S37Ept1h1uLZFmBJ3vgbZulNB9jmiZQrysq467cAp6dRc8ksVfA96rYbO
gq/5ByzLvmv7cD6QHCFiHYlfUmuJJMwDXyyHoec+WkQZ3DJCCJs4ceM8nYq+NSfG
nVnq4osNXT9i3BopKFSR/vhO+Lu5naz6m6qsGr8Os8Xkws0AyYtu537NKKqQiTFb
IJJrqZqkXACy2la2VgWmFdBpC9sWGc+h3WLfpRMJII2K12NaNULPYDFN3RDd6yGS
1Jyc7QhaihFBHOPbmd7N
=ulnK
-----END PGP SIGNATURE-----

--nextPart4218661.SvQGrZdYl4--
