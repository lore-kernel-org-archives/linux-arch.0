Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267650AbUJTPMg@vger.kernel.org>
Received: from natnoddy.rzone.de ([81.169.145.166]:63376 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S268285AbUJTPJx
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Oct 2004 11:09:53 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: 4level page tables architecture porting
Date: Wed, 20 Oct 2004 17:05:56 +0200
References: <20041020131340.GA5282@mschwid3.boeblingen.de.ibm.com> <20041020143949.GB32257@wotan.suse.de>
In-Reply-To: <20041020143949.GB32257@wotan.suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_Y7ndBWGfkC6ZIPd";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200410201706.00435.arnd@arndb.de>
To: Andi Kleen <ak@suse.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


--Boundary-02=_Y7ndBWGfkC6ZIPd
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Middeweken 20 Oktober 2004 16:39, Andi Kleen  wrote:
> BTW
> The motivation for really large address space spaces is actually not really
> to use that much memory, but just to be able to mmap extremly large
> files. The original reason I started this was because some users wanted
> to mmap 300GB files and it didn't work because the shared
> libraries were in the way. So if you consider that it may be worth
> enlarging it at some point anyways.

Doesn't that mean spending another page for each running process? I would
rather like to see a way to use a dynamic page table layout, where 32 bit
tasks always use only two level page tables, while 64 bit tasks start
with two or three levels and then go to four or five levels when users
map files that don't fit in.

Which architectures are actually capable of doing this? It's probably
not worth spending much work on that if it's an s390 only thing.

> I assume S390s have typically  more storage than x86-64 machines ;-)

The physical machine, yes. However, virtual machines running s390 linux
are often a lot smaller than an average PC.

	Arnd <><

--Boundary-02=_Y7ndBWGfkC6ZIPd
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBdn7Y5t5GS2LDRf4RAp2UAJ4sudw2HU3i/+R+Qjh9EkHuxPvM+wCfYpQF
0a47/2EEYtVKk+WutqEdiS8=
=+5sk
-----END PGP SIGNATURE-----

--Boundary-02=_Y7ndBWGfkC6ZIPd--
