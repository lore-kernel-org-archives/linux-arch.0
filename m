From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/3] linux/bitmap: Move 2 mask macro to bitops.h
Date: Sun, 22 Nov 2015 21:17:16 +0200
Message-ID: <CAHp75Vcyq48yrswRX_v80fHg_qd0irKxU742nv7JUwS=9QER7g@mail.gmail.com>
References: <1447900314-5727-1-git-send-email-hejianet@gmail.com>
	<1447900314-5727-2-git-send-email-hejianet@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:35179 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbbKVTRQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 22 Nov 2015 14:17:16 -0500
In-Reply-To: <1447900314-5727-2-git-send-email-hejianet@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jia He <hejianet@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Denys Vlasenko <dvlasenk@redhat.com>, Kyungmin Park <kyungmin.park@samsung.com>, Michal Nazarewicz <mina86@mina86.com>, Yury Norov <yury.norov@gmail.com>, Tejun Heo <tj@kernel.org>, Martin Kepplinger <martink@posteo.de>, George Spelvin <linux@horizon.com>, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>

On Thu, Nov 19, 2015 at 4:31 AM, Jia He <hejianet@gmail.com> wrote:
> This patch moves the mask macro to bitops.h and then the new introduced
> api in find_bit.c can use it.

Why API can't use GENMASK() instead?

>
> Signed-off-by: Jia He <hejianet@gmail.com>
> ---
>  include/linux/bitmap.h | 3 ---
>  include/linux/bitops.h | 4 ++++
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 9653fdb..15524f6 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -172,9 +172,6 @@ extern unsigned int bitmap_ord_to_pos(const unsigned long *bitmap, unsigned int
>  extern int bitmap_print_to_pagebuf(bool list, char *buf,
>                                    const unsigned long *maskp, int nmaskbits);
>
> -#define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
> -#define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
> -
>  #define small_const_nbits(nbits) \
>         (__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG)
>
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 2b8ed12..b881028 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -24,6 +24,10 @@
>  #define GENMASK_ULL(h, l) \
>         (((~0ULL) << (l)) & (~0ULL >> (BITS_PER_LONG_LONG - 1 - (h))))
>
> +/* For bitmap ops*/
> +#define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
> +#define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
> +
>  extern unsigned int __sw_hweight8(unsigned int w);
>  extern unsigned int __sw_hweight16(unsigned int w);
>  extern unsigned int __sw_hweight32(unsigned int w);
> --
> 2.5.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
With Best Regards,
Andy Shevchenko
