From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH -v2 19/33] locking,powerpc: Implement
 atomic{,64}_fetch_{add,sub,and,or,xor}{,_relaxed,_acquire,_release}()
Date: Wed, 1 Jun 2016 11:11:38 +0800
Message-ID: <20160601031138.GA30064@insomnia>
References: <20160531101925.702692792@infradead.org>
 <20160531102642.648971209@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160531102642.648971209@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, waiman.long@hpe.com, fweisbec@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, dbueso@suse.de, fengguang.wu@intel.com
List-Id: linux-arch.vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Tue, May 31, 2016 at 12:19:44PM +0200, Peter Zijlstra wrote:
[snip]
> =20
> @@ -329,20 +361,53 @@ atomic64_##op##_return_relaxed(long a, a
>  	return t;							\
>  }
> =20
> +#define ATOMIC64_FETCH_OP_RELAXED(op, asm_op)				\
> +static inline long							\
> +atomic64_fetch_##op##_relaxed(long a, atomic64_t *v)			\
> +{									\
> +	long res, t;							\
> +									\
> +	__asm__ __volatile__(						\
> +"1:	ldarx	%0,0,%4		# atomic64_fetch_" #op "_relaxed\n"	\
> +	#asm_op " %1,%3,%0\n"						\
> +"	stdcx.	%1,0,%4\n"						\
> +"	bne-	1b\n"							\
> +	: "=3D&r" (res), "=3D&r" (t), "+m" (v->counter)			\
> +	: "r" (a), "r" (&v->counter)					\
> +	: "cc");							\
> +									\
> +	return t;							\

Looks like I missed this one in v1, it should be
=09
	return res;

because the primitives will return the values before modified by the
operations.

Regards,
Boqun

> +}
> +

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXTlJmAAoJEEl56MO1B/q4N+4IAIfkzd+3RjCYE/+VPXAvK95i
Xb07cqdRjm9FQSBpedu4xugZ8yzczLjV6yIF1fyN3/ko260M8W2KQWRPPhaWuqK5
mBvYd0VfCxs5eJkShX5p+tUwYRsGrcZcW8H7kRGn4MnHgBWvJvq0zssjr+47mZvl
boiSHlwNRAW23maZCco6HwI0Frl40ur7kydi2nr4Z753mIPGwcAeawjNrtqYfcpI
auCXtjZs4cMPt3xvtOcs2pIyiR+sa8/xFT5xoHlO7LY3DKf0C/pwItAUGteB1J/+
II9/GSWJBtmYILrmOIo+MR2G0+raLcTnPAUfMVeOMS1NnmMpTbcNhu+pdE59dXE=
=5KXh
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
