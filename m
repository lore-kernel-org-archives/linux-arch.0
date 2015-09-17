From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] barriers: introduce smp_mb__release_acquire and update
 documentation
Date: Thu, 17 Sep 2015 09:56:14 +0800
Message-ID: <20150917015614.GA4000@fixme-laptop.cn.ibm.com>
References: <1442333610-16228-1-git-send-email-will.deacon@arm.com>
 <20150916114918.GA12664@fixme-laptop.cn.ibm.com>
 <20150916163813.GP28771@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:33938 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931AbbIQB4j (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Sep 2015 21:56:39 -0400
Content-Disposition: inline
In-Reply-To: <20150916163813.GP28771@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2015 at 05:38:14PM +0100, Will Deacon wrote:
> On Wed, Sep 16, 2015 at 12:49:18PM +0100, Boqun Feng wrote:
> > Hi Will,
>=20
> Hello,
>=20
> > On Tue, Sep 15, 2015 at 05:13:30PM +0100, Will Deacon wrote:
> > > +If necessary, ordering can be enforced by use of an
> > > +smp_mb__release_acquire() barrier:
> > > +
> > > +	*A =3D a;
> > > +	RELEASE M
> > > +	smp_mb__release_acquire();
> >=20
> > Should this barrier be placed after the ACQUIRE? Because we do actually
> > want(?) and allow RELEASE and ACQUIRE operations to reorder in this
> > case, like your following example, right?
>=20
> I think it's a lot simpler to keep it where it is, in all honesty. The
> relaxation for the RELEASE/ACQUIRE access ordering is mainly there to
> allow architectures building those operations out of explicit barriers
> to get away without a definition of smp_mb__release_acquire.
>=20

Fair enough, and plus there is actually no user(even potential user) of
this for now, it may be too early to argue where the barrier should be
put.

Regards,
Boqun


--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV+h26AAoJEEl56MO1B/q4FKsH/2aF83W1AMADgMSN87h7mEPk
pewbz/83gvzp4oq8ZMWWZACBWn7je05XGxkk1h3BHs7el5WHaTDwKsjhmt8LrP8D
P7YlvTDCzsJw9GU9ngGqYcjhtM7FYSqw941ta9czFWPeWRCCY/ZK2TZ/XkzDgsVr
KXTGcMkfa+SJz+G24vIiE6PxGgN3K0p1ySgG7p1oIJMtLv4pp3seebjWyHc7ATGf
tDpV1cscUctcVr4ay2fFWPkgZkQckbugxYRBNjZB2z3veeNKn2oV18aIwChqq5Lu
gt4bLx5iwJUttwQFvqwLI4tETRJpBj10bgBaGGoLJlhSM6jjo2y4ImWO0U8Wv2U=
=Nov9
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
