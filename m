From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] locking/qspinlock: Use atomic_sub_return_release in
 queued_spin_unlock
Date: Tue, 14 Jun 2016 13:52:53 +0800
Message-ID: <20160614055253.GA20090@insomnia>
References: <1464943094-3129-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160613194523.GA2094@linux-80c1.suse>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:35099 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbcFNFtd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jun 2016 01:49:33 -0400
Content-Disposition: inline
In-Reply-To: <20160613194523.GA2094@linux-80c1.suse>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, peterz@infradead.org, waiman.long@hp.com


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 13, 2016 at 12:45:23PM -0700, Davidlohr Bueso wrote:
> On Fri, 03 Jun 2016, Pan Xinhui wrote:
>=20
> > The existing version uses a heavy barrier while only release semantics
> > is required. So use atomic_sub_return_release instead.
> >=20
> > Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
>=20
> I just noticed this change in -tip and, while I know that saving a barrier
> in core spinlock paths is perhaps a worthy exception, I cannot help but
> wonder if this is the begging of the end for smp__{before,after}_atomic().

This is surely a good direction I think, that is using _acquire and
_release primitives to replace those barriers. However, I think we
should do this carefully, because the _acquire and _release primitives
are RCpc because they are on PPC, IOW, a ACQUIRE and RELEASE pair is not
a full barrier nor provides global transivity. I'm worried about there
are some users depending on the full-barrier semantics, which means we
must audit each use carefully before we make the change.

Besides, if we want to do the conversion, we'd better have _acquire and
_release variants for non-value-returning atomic operations.

I remember you were working on those variants. How is that going?

Regards,
Boqun

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXX5utAAoJEEl56MO1B/q4PCoH/1pehDqf4U2h5oIQA83jtYdP
/t0iMtRDiH4Xg48Y+c6zD7PDB77kyR9W2UcJvFb3jt7LTQFjCchq9pjhQbtAjOMJ
DIe3mpkSo3q6nuG75I9OkpSwd+7PvZfgBsOJnW8m3ft9B8EX/pLfZsf6cjH2CW5p
NK6/5vdi9/cp5mWVebm+awKeqRbh2/MJ6tpokw02cEZLvtsARAy9FF2M0TaU8ucP
IzbSyBidiTtymSYFQUfth1khTnbilpuZo505xXwcqNNSbMN6lIc1Xw56xdTgOfP9
PsZSwYFCUyXWjOK9YHwYD6Rz6fkh1ZE1V6eXZXvScjqFvuvn4Eodt0p3galMFr0=
=JCe6
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
