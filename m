From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [patch 3/5] x86: lockless get_user_pages_fast
Date: Mon, 2 Jun 2008 21:28:33 +1000
Message-ID: <20080602212833.226146bc.sfr@canb.auug.org.au>
References: <20080529122050.823438000@nick.local0.net>
	<20080529122602.330656000@nick.local0.net>
	<1212081659.6308.10.camel@norville.austin.ibm.com>
	<20080602101530.GA7206@wotan.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__2_Jun_2008_21_28_33_+1000_hCbsJcHGNAOhqeTo"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:57720 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062AbYFBL2n (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 2 Jun 2008 07:28:43 -0400
In-Reply-To: <20080602101530.GA7206@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Dave Kleikamp <shaggy@linux.vnet.ibm.com>, akpm@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, apw@shadowen.org

--Signature=_Mon__2_Jun_2008_21_28_33_+1000_hCbsJcHGNAOhqeTo
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nick,

On Mon, 2 Jun 2008 12:15:30 +0200 Nick Piggin <npiggin@suse.de> wrote:
>
> BTW. I do plan to ask Linus to merge this as soon as 2.6.27 opens.
> Hope nobody objects (or if they do please speak up before then)

Any chance of getting this into linux-next then to see if it
conflicts with/kills anything else?

If this is posted/reviewed/tested enough to be "finished" then put it in
a tree (or quilt series) and submit it.

Thanks.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__2_Jun_2008_21_28_33_+1000_hCbsJcHGNAOhqeTo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIQ9lnTgG2atn1QN8RAg7CAKCEKcOJpX1uK8RkF3oLiJCUfWk7zgCfULmb
B+nLWK6EL2EbSX+XNGkzegw=
=SG28
-----END PGP SIGNATURE-----

--Signature=_Mon__2_Jun_2008_21_28_33_+1000_hCbsJcHGNAOhqeTo--
