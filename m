From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [GIT PULL tools] Linux kernel memory model
Date: Fri, 2 Feb 2018 12:46:03 +0800
Message-ID: <20180202044603.i2z3q25jeftbct5c@tardis>
References: <20180125093440.GA875@linux.vnet.ibm.com>
 <20180129065724.ybrdsabvktq7fbqg@gmail.com>
 <20180129095449.GT3741@linux.vnet.ibm.com>
 <20180131090006.onaopgyqthppoysi@gmail.com>
 <20180201011728.GL3741@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hxzmqihrdkbwwur2"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:43427 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbeBBEnB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Feb 2018 23:43:01 -0500
Content-Disposition: inline
In-Reply-To: <20180201011728.GL3741@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, will.deacon@arm.com, peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com, elena.reshetova@intel.com, mhocko@suse.com, akiyks@gmail.com, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Linus Torvalds <torvalds@linux-foundation.org>


--hxzmqihrdkbwwur2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2018 at 05:17:28PM -0800, Paul E. McKenney wrote:
[...]
> > - A long term question: have you considered and would it make sense to =
generate a
> >   memory-barriers.txt like file directly into Documentation/locking/, u=
sing the
> >   formal description? That way any changes/extensions/fixes to the mode=
l could be
> >   tracked on a high level, without readers having to understand the for=
mal
> >   representation.
>=20
> I hadn't considered this at all, actually.  ;-)
>=20
> The sections of memory-barriers.txt dealing with MMIO ordering would need
> to stay hand-generated, but they are a very small fraction of the total.
> The herd7 tool is capable of generating cool diagrams sort of like
> this one: https://static.lwn.net/images/2017/mm-model/rmo-acyclic.png,
> which might replace at least some of the hand-generated ASCII-art
> diagrams.
>=20

Which reminds me, one thing we could start with is to try to convert all
the examples with litmus tests. Has this been done somewhere (e.g. in
your litmus github repo)? If not, I can try if you think that's a good
idea.

Regards,
Boqun

> Although I do confess harboring some skepticism about being able to
> generated high-quality text, there is no denying that it would be
> valuable to be able to do so.
>=20
> > In any case, the base commit is certainly nice and clean and I've pulle=
d it into=20
> > tip:locking/core for a v4.17 merge.
>=20
> Very good!
>=20
> > I believe these additional improvements (to the extent you agree with d=
oing them!)=20
> > could/should be done as add-on commits on top of this existing commit.
>=20
> Sounds good!
>=20
> Would you prefer a pull request or a patch series for these?
>=20
> 							Thanx, Paul
>=20

--hxzmqihrdkbwwur2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlpz7QgACgkQSXnow7UH
+rgRLQf+LTeuFTeKP7AbS36x2B/vyKxi2rzUFeoM2bPBLNZmiW80YpnerEoExADu
FVMtGVV1dGKmUhkQoQ4ZnOaIrLd8D22NfLKXlzFkQ34EcIl5BtkzpLXQZoIpeAUT
K+d64s+saWRhq4G+bOngWACQDMkrvWmsagSnGpI0Hb/AWyDNTF+Xqbw9rIWvOf+6
+B6CV3kiTm6E/5ymS25JsAc0pvi3gbS+7gbN54398j30WmBWGZ7Yl/H58YLn1/pt
gIw0jYsIsvxcuaEEpMY+0WIlqwzqIK17Nr/uOfrNet/0gF8/GFhZGnGYCv5o3DWI
wgfCG5moGho84HjDwj6NJXdK9iUJDg==
=Fp9Y
-----END PGP SIGNATURE-----

--hxzmqihrdkbwwur2--
