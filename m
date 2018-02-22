Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:39770 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbeBVDUX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Feb 2018 22:20:23 -0500
Date: Thu, 22 Feb 2018 11:23:49 +0800
From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH RFC tools/lkmm 10/12] tools/memory-model: Add a S
 lock-based external-view litmus test
Message-ID: <20180222032349.klcuiq23f52sfop6@tardis>
References: <20180220232405.GA19274@linux.vnet.ibm.com>
 <1519169112-20593-10-git-send-email-paulmck@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="moha4cwfm6mgy6fw"
Content-Disposition: inline
In-Reply-To: <1519169112-20593-10-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>


--moha4cwfm6mgy6fw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2018 at 03:25:10PM -0800, Paul E. McKenney wrote:
> From: Alan Stern <stern@rowland.harvard.edu>
>=20
> This commit adds a litmus test in which P0() and P1() form a lock-based S
> litmus test, with the addition of P2(), which observes P0()'s and P1()'s
> accesses with a full memory barrier but without the lock.  This litmus
> test asks whether writes carried out by two different processes under the
> same lock will be seen in order by a third process not holding that lock.
> The answer to this question is "yes" for all architectures supporting

Hmm.. it this true? Our spin_lock() is RCpc because of PowerPC, so
spin_lock()+spin_unlock() pairs don't provide transitivity, and that's
why we have smp_mb__after_unlock_lock(). Is there something I'm missing?
Or there is an upcomming commit to switch PowerPC's lock implementation?

[Cc ppc maintainers]

Regards,
Boqun

> the Linux kernel, but is "no" according to the current version of LKMM.
>=20
> A patch to LKMM is under development.
>=20
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> ---
>  .../ISA2+pooncelock+pooncelock+pombonce.litmus     | 41 ++++++++++++++++=
++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 tools/memory-model/litmus-tests/ISA2+pooncelock+poonc=
elock+pombonce.litmus
>=20
> diff --git a/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+p=
ombonce.litmus b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock=
+pombonce.litmus
> new file mode 100644
> index 000000000000..7a39a0aaa976
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce=
=2Elitmus
> @@ -0,0 +1,41 @@
> +C ISA2+pooncelock+pooncelock+pombonce.litmus
> +
> +(*
> + * Result: Sometimes
> + *
> + * This test shows that the ordering provided by a lock-protected S
> + * litmus test (P0() and P1()) are not visible to external process P2().
> + * This is likely to change soon.
> + *)
> +
> +{}
> +
> +P0(int *x, int *y, spinlock_t *mylock)
> +{
> +	spin_lock(mylock);
> +	WRITE_ONCE(*x, 1);
> +	WRITE_ONCE(*y, 1);
> +	spin_unlock(mylock);
> +}
> +
> +P1(int *y, int *z, spinlock_t *mylock)
> +{
> +	int r0;
> +
> +	spin_lock(mylock);
> +	r0 =3D READ_ONCE(*y);
> +	WRITE_ONCE(*z, 1);
> +	spin_unlock(mylock);
> +}
> +
> +P2(int *x, int *z)
> +{
> +	int r1;
> +	int r2;
> +
> +	r2 =3D READ_ONCE(*z);
> +	smp_mb();
> +	r1 =3D READ_ONCE(*x);
> +}
> +
> +exists (1:r0=3D1 /\ 2:r2=3D1 /\ 2:r1=3D0)
> --=20
> 2.5.2
>=20

--moha4cwfm6mgy6fw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqON8AACgkQSXnow7UH
+rhSrAf/efYzBmXqtbH/dZMeFgADgDdOVHAndf3gf30/zUhAMSspI4ZAgx/R+GC3
fcsOaq7YYWOEepRpBjgASgjb2pXp/J483ZDGAekeZv2/9ADFngrJCu7gtGTMVG8o
vAB7hKM+A4Pkn9SwADBVKXWdb6NpevfltLh8VX8Y/brrvdk3tjWPTLC34qElku8w
e+4ZGOHDorjPmkCC6U7KoukBxWvG7KqdRg4P/D5azs18CHvJI7myDcDxt9WsRyC0
u9IOTbj+QcX8/wewRYISwEFHbHA0ZVR1WcqEnmne0+IINfSyzhqyJc0V4VbWzR7d
US877KQnFyAZAYoFQFDyp74qnQVYtQ==
=zahK
-----END PGP SIGNATURE-----

--moha4cwfm6mgy6fw--
