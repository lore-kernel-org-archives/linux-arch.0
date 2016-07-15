From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v3] locking/qrwlock: Let qrwlock has same layout
 regardless of the endian
Date: Fri, 15 Jul 2016 08:41:30 +0800
Message-ID: <20160715004130.GA3427@insomnia>
References: <1466403652-2931-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160713195423.GD30921@twins.programming.kicks-ass.net>
 <578742EA.7060108@linux.vnet.ibm.com>
 <20160714093733.GF30909@twins.programming.kicks-ass.net>
 <20160714094626.GN30927@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:33096 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbcGOAhp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 Jul 2016 20:37:45 -0400
Content-Disposition: inline
In-Reply-To: <20160714094626.GN30927@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, arnd@arndb.de, Waiman.Long@hpe.com


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 14, 2016 at 11:46:26AM +0200, Peter Zijlstra wrote:
> On Thu, Jul 14, 2016 at 11:37:33AM +0200, Peter Zijlstra wrote:
> > static inline u8 *__qspinlock_lock_byte(struct qspinlock *lock)
> > {
> > 	return (u8 *)lock + 3 * IS_BUILTIN(__BIG_ENDIAN);
> > }
>=20
> Bugger, that doesn't actually work. IS_BUILTIN expects the symbol to be
> defined to "1" and __BIG_ENDIAN is not (its "4321").
>=20
>=20

Using IS_BUILTIN(CONFIG_CPU_BIG_ENDIAN) instead? Seems ARM and PPC both
define this properly if the target kernel is a big endian one.

Regards,
Boqun

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXiDE0AAoJEEl56MO1B/q4RKUH/03JWlfXToBThXhoTpMv32qO
95p3yHJWlOwndVJbW1npU9qrXcm4KeUGy7Fbry+LRSNhDu8GoKYDOgvN3Op95NHt
vtKhryhHdJ+CzCrNebNtXbGkA+WmeH7wzzpNwF+pV3mtI2SRwssYXeb5bL730nfA
yPs6uSBzv4BsrXbYWe3ws3JgUbDYGAFl97JOAsSip0Z72UXDGGwHta+/osuk28J/
82fE9ANM1gm+lhrnYD6Yst6z46UFJJiEl90rKvK5QeZNhx1fykgXON6DmB3pyHHD
hhZbwlbRTqEjIz74X0wyZuQ9qZZdEPVnNZsPxKT2L1Ser/+OQfYHk+fYCAiYSQk=
=MvDI
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
