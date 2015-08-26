From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v5 0/8] Add generic support for relaxed atomics
Date: Wed, 26 Aug 2015 19:35:07 +0800
Message-ID: <20150826113507.GA7922@fixme-laptop.cn.ibm.com>
References: <1438880084-18856-1-git-send-email-will.deacon@arm.com>
 <20150826042834.GA10432@fixme-laptop.cn.ibm.com>
 <20150826104100.GB30466@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36126 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbbHZLfZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2015 07:35:25 -0400
Content-Disposition: inline
In-Reply-To: <20150826104100.GB30466@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Waiman.Long@hp.com" <Waiman.Long@hp.com>, "peterz@infradead.org" <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "mingo@kernel.org" <mingo@kernel.org>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Will,

On Wed, Aug 26, 2015 at 11:41:00AM +0100, Will Deacon wrote:
> Hi Boqun,
>=20
> On Wed, Aug 26, 2015 at 05:28:34AM +0100, Boqun Feng wrote:
> > On Thu, Aug 06, 2015 at 05:54:36PM +0100, Will Deacon wrote:
> > > Will Deacon (8):
> > >   atomics: add acquire/release/relaxed variants of some atomic
> > >     operations
> > >   asm-generic: rework atomic-long.h to avoid bulk code duplication
> > >   asm-generic: add relaxed/acquire/release variants for atomic_long_t
> > >   lockref: remove homebrew cmpxchg64_relaxed macro definition
> > >   locking/qrwlock: implement queue_write_unlock using smp_store_relea=
se
> > >   locking/qrwlock: make use of acquire/release/relaxed atomics
> > >   include/llist: use linux/atomic.h instead of asm/cmpxchg.h
> >=20
> > Should we step further to privatize asm/cmpxchg.h entirely? Keep it only
> > included in arch/*?
> >=20
> > Because after your next patch, in some configurations, asm/cmpxchg.h of
> > ARM only provides the definition of {cmpxchg,xchg}_relaxed, others are
> > built in linux/atomic.h. Further more, other architecture may implement
> > asm/cmpxchg.h similarly in the future. So, IIUC, we actually don't
> > guarantee all cmpxchg(), xchg() and their variants are defined in
> > asm/cmpxchg.h.
> >=20
> > Though current users of asm/cmpxchg.h outside arch/* are fine,
> > because they all happen to have got linux/atomic.h included. But we'd
> > better change the current users and call out that asm/cmpxchg.h is
> > privatized in the document.
> >=20
> > >   ARM: atomics: define our SMP atomics in terms of _relaxed operations
> >=20
> >=20
> > Consider this patch maybe? I did a simple build test on X86.
>=20
> I'm not sure that the addition to Documentation/atomic_ops.txt is really

Well.. I think at least we'd better say "to use {cmp,}xchg, include
linux/atomic.h" somewhere, because these two function families don't
have atomic_ prefix and don't take atomic{,64}_t as a parameter.

> worth it, but either way:
>=20
>   Acked-by: Will Deacon <will.deacon@arm.com>

Thank you!

>=20
> It's probably best to send this as a standalone patch, since the relaxed
> parts are already queued in -tip.

Good point. Will send a standalone patch.

Regards,
Boqun

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV3aRmAAoJEEl56MO1B/q4iQ0H/0/fRBzscQr/9QnpLGcsshu1
4YD2Ox58WCujtu4j2svfe23+3gwBc94NN/0yGFv9HJoA1DB1GplDTb6zYcSjxsPF
zkD1k3IX/ZPTgouPyKDcayRnuXiQhCzyBIZVqsoi4igKEb0H8npVWQbjgrSCcpN0
SFbZU1Q+ji+8HVAx5PH2s7+t7Gmhc24f+nRQjRyNX9MedTHrt1tiyzK+PAjG9jp/
7TtxKrDhiQtnZUMn0Z7gkKh2kJkUGKbhbUBp2L3ONwqjZ67v7oUFjpfdytXf4knd
YcYxFwlRPfrP/RnCnmbFzJBcCqOvyR+HhhFVjOT9I9FhWTmDE/k4znT8M+P5XOo=
=V6DK
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
