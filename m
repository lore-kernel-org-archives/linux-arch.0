From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH/RFC 00/16] compat: convert to COMPAT_SYSCALL_DEFINE
Date: Mon, 17 Mar 2014 17:02:41 +1100
Message-ID: <20140317170241.9197da46cdc87f6c3df6b517@canb.auug.org.au>
References: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
	<20140312194526.GA3755@osiris>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Mon__17_Mar_2014_17_02_41_+1100_QkHRoQ5ZfZGGV6xA"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:52732 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756290AbaCQGCx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 17 Mar 2014 02:02:53 -0400
In-Reply-To: <20140312194526.GA3755@osiris>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-next@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, "H. Peter Anvin" <hpa@linux.intel.com>, Mark Brown <broonie@kernel.org>

--Signature=_Mon__17_Mar_2014_17_02_41_+1100_QkHRoQ5ZfZGGV6xA
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Heiko,

On Wed, 12 Mar 2014 20:45:26 +0100 Heiko Carstens <heiko.carstens@de.ibm.co=
m> wrote:
>
> since nobody objected to the compat changes I described below, could you
> please add the tree
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git compat
>=20
> to linux-next?

Mark added this the other day and I will add it to my tree from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgment of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
	Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

Legal Stuff:
By participating in linux-next, your subsystem tree contributions are
public and will be included in the linux-next trees.  You may be sent
e-mail messages indicating errors or other issues when the
patches/commits from your subsystem tree are merged and tested in
linux-next.  These messages may also be cross-posted to the linux-next
mailing list, the linux-kernel mailing list, etc.  The linux-next tree
project and IBM (my employer) make no warranties regarding the linux-next
project, the testing procedures, the results, the e-mails, etc.  If you
don't agree to these ground rules, let me know and I'll remove your tree
from participation in linux-next.

--Signature=_Mon__17_Mar_2014_17_02_41_+1100_QkHRoQ5ZfZGGV6xA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTJpAFAAoJEMDTa8Ir7ZwVJBkP/0+3aiTt+VRWhBTOrQERfq/Y
jYHiYgJcW0OxBB0C2zovFCeN19QHaSSCAA21bEyMtT4rmUNZYozcb6RCsGSTHHCC
ZycBrmO/v+RLv1/MC1r81p3onpRIVqBOyzMuJM0TNwjlesPfTh4TKgyj/UrXwiId
XrZv6Jfjt8jBXXY0fbQR+RqNM2IG9IeXjeNxUKS2XrzK4tGxBkes/H2Mgz4UaGwV
by+Q/H+8N+7MBUV7kNwsEfOgJF1GxsynJb7hRl/2p6Yf/z/KmXPDOUkA1ad9aMt9
1s3k7dNCrXAQRHE+ubvDu3DD8eq5fNyIwz92cEXi6kFvY+AM3yzqRj8EbXAcvB++
Ng+mZL+c9nYvsvJope6X7p8AoaAp/5k2wM8uP/2fsez61HjWnTZZVAvwLz8ShnSi
F3kgmS7S5qA0b3F/mtTmoRS9RuP7+VTNcwWZ+xmkmUkuddaImptDCL3KXs2OfP28
W5Denq3z+B17OyK9dsqS7ToYCHGhTmAVweZ9DNNPuorFXgJurZA1a7WIDtBHEWkD
dtYG3Q5+q7JNTOTcv5n5siiGhMzneooSbj0fjjzZ2oiw/T+AM3EEADILYjlHyGrm
IY5ELsR5MR5m4SS7beDZPus9QyNrelMYq6nCaRmqqrwAsieP1XPp6poyzTJ7Ojex
g70OcWYwSNI7Vya/phQY
=iBdP
-----END PGP SIGNATURE-----

--Signature=_Mon__17_Mar_2014_17_02_41_+1100_QkHRoQ5ZfZGGV6xA--
