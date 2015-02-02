From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC] change non-atomic bitops method
Date: Mon, 2 Feb 2015 20:31:54 +0100
Message-ID: <20150202193154.GC10842@pengutronix.de>
References: <35FD53F367049845BC99AC72306C23D1044A02027E0A@CNBJMBX05.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34182 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbbBBTb6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Feb 2015 14:31:58 -0500
Content-Disposition: inline
In-Reply-To: <35FD53F367049845BC99AC72306C23D1044A02027E0A@CNBJMBX05.corpusers.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Cc: "'arnd@arndb.de'" <arnd@arndb.de>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux@arm.linux.org.uk'" <linux@arm.linux.org.uk>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>

On Mon, Feb 02, 2015 at 11:55:03AM +0800, Wang, Yalin wrote:
> This patch change non-atomic bitops,
> add a if() condition to test it, before set/clear the bit.
> so that we don't need dirty the cache line, if this bit
> have been set or clear. On SMP system, dirty cache line will
> need invalidate other processors cache line, this will have
> some impact on SMP systems.
>=20
> Signed-off-by: Yalin Wang <yalin.wang@sonymobile.com>
> ---
>  include/asm-generic/bitops/non-atomic.h | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/asm-generic/bitops/non-atomic.h b/include/asm-ge=
neric/bitops/non-atomic.h
> index 697cc2b..e4ef18a 100644
> --- a/include/asm-generic/bitops/non-atomic.h
> +++ b/include/asm-generic/bitops/non-atomic.h
> @@ -17,7 +17,9 @@ static inline void __set_bit(int nr, volatile unsig=
ned long *addr)
>  	unsigned long mask =3D BIT_MASK(nr);
>  	unsigned long *p =3D ((unsigned long *)addr) + BIT_WORD(nr);
> =20
> -	*p  |=3D mask;
> +	if ((*p & mask) =3D=3D 0)
> +		*p  |=3D mask;
Care to fix the double space here while touching the code?

I think the more natural check here is:

	if ((~*p & mask) !=3D 0)
		*p |=3D mask;

Might be a matter of taste, but this check is equivalent to

	*p !=3D (*p | mask)

which is what you really want to test for. (Your check only has this
property for values of mask that have a single bit set, which is ok her=
e
of course.)

> +
>  }
> =20
>  static inline void __clear_bit(int nr, volatile unsigned long *addr)
> @@ -25,7 +27,8 @@ static inline void __clear_bit(int nr, volatile uns=
igned long *addr)
>  	unsigned long mask =3D BIT_MASK(nr);
>  	unsigned long *p =3D ((unsigned long *)addr) + BIT_WORD(nr);
> =20
> -	*p &=3D ~mask;
> +	if ((*p & mask) !=3D 0)
> +		*p &=3D ~mask;
This is already fine.

>  }
> =20
>  /**
> @@ -60,7 +63,8 @@ static inline int __test_and_set_bit(int nr, volati=
le unsigned long *addr)
>  	unsigned long *p =3D ((unsigned long *)addr) + BIT_WORD(nr);
>  	unsigned long old =3D *p;
> =20
> -	*p =3D old | mask;
> +	if ((old & mask) =3D=3D 0)
> +		*p =3D old | mask;
Here it would be:

	if ((~old & mask) !=3D 0)
=09
>  	return (old & mask) !=3D 0;
>  }

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
