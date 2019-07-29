Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40102 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfG2Fu6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jul 2019 01:50:58 -0400
Date: Mon, 29 Jul 2019 13:50:44 +0800
From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v2] lkmm/docs: Correct ->prop example with additional rfe
 link
Message-ID: <20190729055044.GC26905@tardis>
References: <20190728031303.164545-1-joel@joelfernandes.org>
 <Pine.LNX.4.44L0.1907281027160.6532-100000@netrider.rowland.org>
 <20190728151959.GA82871@google.com>
 <20190728152806.GB26905@tardis>
 <20190728153544.GA87531@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline
In-Reply-To: <20190728153544.GA87531@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org, kernel-team@android.com, Akira Yokosawa <akiyks@gmail.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@kernel.org>, Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>
Message-ID: <20190729055044.NzQKB2hOp4484w6nBgx1yyMswsQsevsMK4TCNBo-7TY@z>


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2019 at 11:35:44AM -0400, Joel Fernandes wrote:
[...]
> > > > > +load of y (rfe link), P2's smp_store_release() ensures that P2's=
 load
> > > > > +of y executes before P2's store to z (second fence), which impli=
es that
> > > > > +that stores to x and y propagate to P2 before the smp_store_rele=
ase(), which
> > > > > +means that P2's smp_store_release() will propagate stores to x a=
nd y to all
> > > > > +CPUs before the store to z propagates (A-cumulative property of =
this fence).
> > > > > +Finally P0's load of z executes after P2's store to z has propag=
ated to
> > > > > +P0 (rfe link).
> > > >=20
> > > > Again, a better change would be simply to replace the two instances=
 of
> > > > "fence" in the original text with "cumul-fence".
> > >=20
> > > Ok that's fine. But I still feel the rfe is not a part of the cumul-f=
ence.
> > > The fences have nothing to do with the rfe. Or, I am missing somethin=
g quite
> > > badly.
> > >=20
> > > Boqun, did you understand what Alan is saying?
> > >=20
> >=20
> > I think 'cumul-fence' that Alan mentioned is not a fence, but a
> > relation, which could be the result of combining a rfe relation and a
> > A-cumulative fence relation. Please see the section "PROPAGATION ORDER
> > RELATION: cumul-fence" or the definition of cumul-fence in
> > linux-kernel.cat.
> >=20
> > Did I get you right, Alan? If so, your suggestion is indeed a better
> > change.
>=20
> To be frank, I don't think it is better if that's what Alan meant. It is
> better to be explicit about the ->rfe so that the reader walking through =
the
> example can clearly see the ordering and make sense of it.
>=20
> Just saying 'cumul-fence' and then hoping the reader sees the light is qu=
ite
> a big assumption and makes the document less readable.
>=20

After a bit more rereading of the document, I still think Alan's way is
better ;-)

Please consider the context of paragraph, this is an explanation of an
example, which is about the previous sentence:

	The formal definition of the prop relation involves a coe or
	fre link, followed by an arbitrary number of cumul-fence links,
	ending with an rfe link.

, so using "cumul-fence" actually matches the definition of ->prop.

For the ease of readers, I can think of two ways:

1.	Add a backwards reference to cumul-fence section here, right
	before using its name.

2.	Use "->cumul-fence" notation rather than "cumul-fence" here,
	i.e. add an arrow "->" before the name to call it out that name
	"cumul-fence" here stands for links/relations rather than a
	fence/barrier. Maybe it's better to convert all references to=20
	links/relations to the "->" notations in the whole doc.

Thoughts?

Regards,
Boqun

> I mean the fact that you are asking Alan for clarification, means that it=
 is
> not that obvious ;)
>=20
> thanks,
>=20
>  - Joel
>=20
>=20

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAl0+iTEACgkQSXnow7UH
+rihvwgApbJd9fPoi9lU3i7ntWzOi9gwzzrLdhw0fYQjT8dF9yg0JxkXOh7uSGUJ
l9rUTipvGtCX/uKqwIotoZ0YDe5zss4MVwu+YJQ7OcDIKdP8rHqiPdwE1qN00dDP
Mx2jrt+ESYqAYoekCDXHdLZa5LW80CNWveegFnCtcUxt5H+agGO0Q5lj5SPgIyJm
ZmAxFlXpUzrdFGI//LN37+Dlo181pqMTfFiqIPW7g/rmO4Rbqp4w46GA+gkZTq93
1Hx8+N4WyUKxf3tW8ySY5J2Yw8j7upWOs5d8hTaUzoBqM8D1yf9Zq+34axPFBMKl
ZrHlzvBVFOF9gpU0f6F3oUETLJZs7g==
=jDmd
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
