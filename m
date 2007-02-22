Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:50061 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751387AbXBVEkL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 21 Feb 2007 23:40:11 -0500
Date: Thu, 22 Feb 2007 15:39:52 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH]add epoll compat code to fsl/compat.c
Message-Id: <20070222153952.1f1b5c15.sfr@canb.auug.org.au>
In-Reply-To: <20070221.190702.88477592.davem@davemloft.net>
References: <Pine.LNX.4.64.0702211234410.4043@woody.linux-foundation.org>
	<Pine.LNX.4.64.0702211259440.16904@alien.or.mcafeemobile.com>
	<Pine.LNX.4.64.0702211313560.4043@woody.linux-foundation.org>
	<20070221.190702.88477592.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__22_Feb_2007_15_39_52_+1100_taOOCtUba=PyirzF"
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: torvalds@linux-foundation.org, davidel@xmailserver.org, akpm@linux-foundation.org, dwmw2@infradead.org, linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, tony.luck@intel.com, ralf@linux-mips.org
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Thu__22_Feb_2007_15_39_52_+1100_taOOCtUba=PyirzF
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2007 19:07:02 -0800 (PST) David Miller <davem@davemloft.net> wrote:
>
> Nevertheless, I am to understand that in this case we're talking about
> a "u64" object, and that (and the structure it is in) will be aligned
> on an 8-byte boundary on both sparc32 and sparc64, so maybe there is
> no problem here?

Yes, I am pretty sure that the only architecture that would need this is
IA64 where the u64 is 4 byte aligned in 32 bit mode and 8 byte aligned in
64 bit mode.  x86_64 declared the structure packed in 64 bit (so
presumably doesn't have a problem with unaligned u64 accesses).  All the
other 32 bit equivalent architectures align u64s on 8 byte boundaries (I
think).

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__22_Feb_2007_15_39_52_+1100_taOOCtUba=PyirzF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFF3R6kFdBgD/zoJvwRAo2tAJ4oaZ17YIhiaXFJ3YqD2cyLoHBJEACggxaK
pFDKkJehAx2R9DJETu3Ksf4=
=I0cc
-----END PGP SIGNATURE-----

--Signature=_Thu__22_Feb_2007_15_39_52_+1100_taOOCtUba=PyirzF--
