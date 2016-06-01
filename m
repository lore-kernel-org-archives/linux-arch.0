From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH -v2 19/33] locking,powerpc: Implement
 atomic{,64}_fetch_{add,sub,and,or,xor}{,_relaxed,_acquire,_release}()
Date: Wed, 1 Jun 2016 14:10:45 +0800
Message-ID: <20160601061045.GB30064@insomnia>
References: <20160531101925.702692792@infradead.org>
 <20160531102642.648971209@infradead.org>
 <20160601031138.GA30064@insomnia>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36255 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbcFAGHK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2016 02:07:10 -0400
Content-Disposition: inline
In-Reply-To: <20160601031138.GA30064@insomnia>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, waiman.long@hpe.com, fweisbec@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, dbueso@suse.de, fengguang.wu@intel.com


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 01, 2016 at 11:11:38AM +0800, Boqun Feng wrote:
> Hi Peter,
>=20
> On Tue, May 31, 2016 at 12:19:44PM +0200, Peter Zijlstra wrote:
> [snip]
> > =20
> > @@ -329,20 +361,53 @@ atomic64_##op##_return_relaxed(long a, a
> >  	return t;							\
> >  }
> > =20
> > +#define ATOMIC64_FETCH_OP_RELAXED(op, asm_op)				\
> > +static inline long							\
> > +atomic64_fetch_##op##_relaxed(long a, atomic64_t *v)			\
> > +{									\
> > +	long res, t;							\
> > +									\
> > +	__asm__ __volatile__(						\
> > +"1:	ldarx	%0,0,%4		# atomic64_fetch_" #op "_relaxed\n"	\
> > +	#asm_op " %1,%3,%0\n"						\
> > +"	stdcx.	%1,0,%4\n"						\
> > +"	bne-	1b\n"							\
> > +	: "=3D&r" (res), "=3D&r" (t), "+m" (v->counter)			\
> > +	: "r" (a), "r" (&v->counter)					\
> > +	: "cc");							\
> > +									\
> > +	return t;							\
>=20
> Looks like I missed this one in v1, it should be
> =09
> 	return res;
>=20
> because the primitives will return the values before modified by the
> operations.
>=20

FWIW, I tested on ppc with ATOMIC64_SELFTEST=3Dy for the following branch:

git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/atom=
ic (afee54ef5b1f2b04)

without this modification, I can hit:

------------[ cut here ]------------
kernel BUG at lib/atomic64_test.c:181!
Oops: Exception in kernel mode, sig: 5 [#1]

with this modification, all the atomic selftests are passed ;-)

Regards,
Boqun

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXTnxhAAoJEEl56MO1B/q4xewH/iFcP7gNw0GleyQwq0+6e3G2
sQP3psaxjWRMXbrpyu8TZmGhrw3e/5oMl4ZyseZ5MQwTFAg0PK+IgNtuO+arU+yP
uyiSjK6RB5DTFOFKPyj/IxEFpcsEFa41cXLtorJqvrY/jRC0B/gn7Te5bYabwjBB
kjwLXNZb5Qftrh2SQ2+1QsEMJLG/AV3Kk4TSmAfCdxBeKhzoGuvxsp6XXenLBGUE
3a+TnmnCsS+WlAy3nWPzn1hx2IN4VugXwAHn3R4mwp+wWMOQnioK1Konbu3b4Zy6
YXnhMADmfl+2nFJh/WBThc2XzdUy2t0PMbJpmQo5VIhwRdKvCpyS3DaVhT3oJ2Y=
=ohO3
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
