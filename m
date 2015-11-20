From: Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCH 2/3] lib: Introduce 2 find bit api: all_is_bit_{one,zero}
Date: Fri, 20 Nov 2015 14:57:03 +0100
Message-ID: <xa1tziy893kg.fsf@mina86.com>
References: <1447900314-5727-1-git-send-email-hejianet@gmail.com> <1447900314-5727-3-git-send-email-hejianet@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447900314-5727-3-git-send-email-hejianet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Denys Vlasenko <dvlasenk@redhat.com>, Kyungmin Park <kyungmin.park@samsung.com>, Yury Norov <yury.norov@gmail.com>, Tejun Heo <tj@kernel.org>, Martin Kepplinger <martink@posteo.de>, George Spelvin <linux@horizon.com>, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jia He <hejianet@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 19 2015, Jia He wrote:
> This patch introduces 2 lightweight bit api.
> all_bit_is_zero return 1 if the bit string is all zero.
> The addr is the start address, the size is the bit size of the bit st=
ring.
> all_bit_is_one is the opposite.
>
> Signed-off-by: Jia He <hejianet@gmail.com>
> ---
>  lib/find_bit.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++=
++
>  1 file changed, 50 insertions(+)
>
> diff --git a/lib/find_bit.c b/lib/find_bit.c
> index 18072ea..1d56d8d 100644
> --- a/lib/find_bit.c
> +++ b/lib/find_bit.c
> @@ -131,6 +131,56 @@ unsigned long find_last_bit(const unsigned long =
*addr, unsigned long size)
>  EXPORT_SYMBOL(find_last_bit);
>  #endif
> =20
> +#ifndef all_bit_is_zero
> +/*
> + * return val: 1 means all bit is zero
> + */
> +unsigned int all_bit_is_zero(const unsigned long *addr, unsigned
> size)

Why does it return unsigned int, not bool?

> +{
> +	unsigned long idx;
> +	unsigned long mask =3D size;
> +
> +	if (unlikely(size =3D=3D 0))
> +		return 1;
> +
> +	if (size > BITS_PER_LONG) {
> +		for (idx =3D 0; idx * BITS_PER_LONG < size; idx++)
> +			if (addr[idx])
> +				return 0;
> +
> +		mask =3D size - (idx - 1) * BITS_PER_LONG;

Uh?

> +	}
> +
> +	return !(*addr & BITMAP_LAST_WORD_MASK(mask));

BITMAP_LAST_WORD_MASK takes size not mask.

> +}

The whole implementation seems weird, this seems much better to me:

unsigned int all_bit_is_zero(const unsigned long *addr, unsigned size)
{
	for (; size > BITS_PER_LONG; size -=3D BITS_PER_LONG, ++addr)
		if (*addr)
			return 0;
	return !size || !(*addr & BITMAP_LAST_WORD_MASK(size));
}

But to be honest I=E2=80=99m not entirely sure this is worth the effort=
=2E
find_next_bit and find_next_zero_bit may do a little bit more work but
some architectures have specialised optimised versions which will be
lost if all_bit_is_zero and all_bit_is_one are introduced.

> +EXPORT_SYMBOL(all_bit_is_zero);
> +#endif
> +
> +#ifndef all_bit_is_one
> +/*
> + * return val: 1 means all bit is one
> + */
> +unsigned int all_bit_is_one(const unsigned long *addr, unsigned size=
)
> +{
> +	unsigned long idx;
> +	unsigned long mask =3D size;
> +
> +	if (unlikely(size =3D=3D 0))
> +		return 1;
> +
> +	if (size > BITS_PER_LONG) {
> +		for (idx =3D 0; idx * BITS_PER_LONG < size; idx++)
> +			if (~addr[idx])
> +				return 0;
> +
> +		mask =3D size - (idx - 1) * BITS_PER_LONG;
> +	}
> +
> +	return !(~(*addr) & BITMAP_LAST_WORD_MASK(mask));
> +}
> +EXPORT_SYMBOL(all_bit_is_one);
> +#endif
> +
>  #ifdef __BIG_ENDIAN
> =20
>  /* include/linux/byteorder does not support "unsigned long" type */
> --=20
> 2.5.0
>

--=20
Best regards,                                            _     _
=2Eo. | Liege of Serenely Enlightened Majesty of         o' \,=3D./ `o
=2E.o | Computer Science,  =E3=83=9F=E3=83=8F=E3=82=A6 =E2=80=9Cmina86=E2=
=80=9D =E3=83=8A=E3=82=B6=E3=83=AC=E3=83=B4=E3=82=A4=E3=83=84  (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>-----ooO--(_)--Ooo--
