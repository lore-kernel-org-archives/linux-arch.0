Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:47057 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfG1CIt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Jul 2019 22:08:49 -0400
Date: Sun, 28 Jul 2019 10:08:37 +0800
From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] docs/lkmm: Correct ->prop example with additional rfe
 link
Message-ID: <20190728020837.GA26905@tardis>
References: <20190728000031.112364-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20190728000031.112364-1-joel@joelfernandes.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <andrea.parri@amarulasolutions.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>
Message-ID: <20190728020837.tsqC7Af3zn99pRxz8i9eNNywWt2SlBbayjHvsym68a0@z>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Joel,

On Sat, Jul 27, 2019 at 08:00:31PM -0400, Joel Fernandes (Google) wrote:
> This lkmm example should describe an additional rfe link between P1's
> store to y and P2's load of y, which should be critical to establishing
> the ordering resulting in the ->prop ordering on P0. IOW, there are 2 rfe
> links, not one.
>=20
> Correct these in the docs to make the ->prop ordering in P0 more clear.
>=20
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  tools/memory-model/Documentation/explanation.txt | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/mem=
ory-model/Documentation/explanation.txt
> index 68caa9a976d0..6c0dfaac7f04 100644
> --- a/tools/memory-model/Documentation/explanation.txt
> +++ b/tools/memory-model/Documentation/explanation.txt
> @@ -1302,8 +1302,8 @@ followed by an arbitrary number of cumul-fence link=
s, ending with an
>  rfe link.  You can concoct more exotic examples, containing more than
>  one fence, although this quickly leads to diminishing returns in terms
>  of complexity.  For instance, here's an example containing a coe link
> -followed by two fences and an rfe link, utilizing the fact that
> -release fences are A-cumulative:
> +followed by a fence, an rfe link, another fence and and a final rfe link,
> +utilizing the fact that release fences are A-cumulative:
> =20

This part looks good to me.

>  	int x, y, z;
> =20
> @@ -1334,11 +1334,13 @@ If x =3D 2, r0 =3D 1, and r2 =3D 1 after this cod=
e runs then there is a prop
>  link from P0's store to its load.  This is because P0's store gets
>  overwritten by P1's store since x =3D 2 at the end (a coe link), the
>  smp_wmb() ensures that P1's store to x propagates to P2 before the
> -store to y does (the first fence), the store to y propagates to P2
> -before P2's load and store execute, P2's smp_store_release()
> -guarantees that the stores to x and y both propagate to P0 before the
> -store to z does (the second fence), and P0's load executes after the
> -store to z has propagated to P0 (an rfe link).
> +store to y does (the first fence), P2's store to y happens before P2's
> +load of y (rfe link), P2's smp_store_release() ensures that P2's load
> +of y executes before P2's store of z (second fence), which also would
> +imply that stores to x and y happen before the smp_store_release(), which

I think it's more accurate to say:

"imply that stores to x and y progagates to P2 before the
smp_store_release()"

, because by definition the propagation ordering that
smp_store_release() guarantees only works with stores that already
propagated to the CPU executing it, not the stores that execute/happen
before.

With that, feel free to add:

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> +means that P2's smp_store_release() will propagate stores to x and y to =
all
> +CPUs before the store to z does (A-cumulative property of this fence).
> +Finally P0's load executes after store to z has propagated to P0 (rfe li=
nk).
> =20
>  In summary, the fact that the hb relation links memory access events
>  in the order they execute means that it must not have cycles.  This
> --=20
> 2.22.0.709.g102302147b-goog
>=20

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAl09A6IACgkQSXnow7UH
+rg+7wf/XFideg6QZVgKL4rs10Ddm7DiVW1wbUEX1GGvlpvp6PUCReS6iTa6tDdY
3B6r1N+JWNVZMHSwiZp75bGhAow5isYI092NeLo1OGdsiBrr0qUFirAtQlm8G7Tn
L2xr75R7Z+vgz2KBDKZoLXz951hs4Qe02wwmMOPgCwyu0iz+crQwnNclrOjs9/Xx
blTx8UK3ektrGHZnDvYfGaZnrTzdsgj+Ji9TL0cloYviTh6Niluyo4R/G4UREbzX
5OfaKiz2THfl4FnyvvyZpHkNOfgIdPomVaaqAw0GgZ4N7HBg0VCLLlAdrFUF09rW
mTvI6Qr/Mm9ZLM7XvVHM4jTmUy9+FA==
=IRgM
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
