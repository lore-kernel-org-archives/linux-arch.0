Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 10 Aug 2005 15:46:22 +0300
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] consolidate sys_ptrace
Message-ID: <20050810124621.GA19792@linux-sh.org>
References: <20050810080057.GA5295@lst.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <20050810080057.GA5295@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 10, 2005 at 10:00:57AM +0200, Christoph Hellwig wrote:
> Some architectures have a too different ptrace so we have to exclude
> them: alpha, ia64, m32r, parisc, sparc, sparc64.  They continue to
> keep their implementations.  For sh64 I had to add a sh64_ptrace wrapper
> because it does some initialization on the first call.  For um I removed
> an ifdefed SUBARCH_PTRACE_SPECIAL block, but SUBARCH_PTRACE_SPECIAL
> isn't defined anywhere in the tree.

Looks ok for sh and sh64.

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFC+fcd1K+teJFxZ9wRAg1xAJ9k5uS/vh8ITtpwKmNYuqmI386YhQCfcKTm
DyTSGh23rKySeUjm1GWcnAo=
=vvli
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
