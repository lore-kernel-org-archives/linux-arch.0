From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/3] lib: Introduce 2 find bit api: all_is_bit_{one,zero}
Date: Fri, 20 Nov 2015 09:52:29 +0100
Message-ID: <CAMuHMdXd4BC7mqmKU-qA3KpVUVS1gPRw8OTu0Mi=aEUJxcd+KA@mail.gmail.com>
References: <1447900314-5727-1-git-send-email-hejianet@gmail.com>
	<1447900314-5727-3-git-send-email-hejianet@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447900314-5727-3-git-send-email-hejianet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jia He <hejianet@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Denys Vlasenko <dvlasenk@redhat.com>, Kyungmin Park <kyungmin.park@samsung.com>, Michal Nazarewicz <mina86@mina86.com>, Yury Norov <yury.norov@gmail.com>, Tejun Heo <tj@kernel.org>, Martin Kepplinger <martink@posteo.de>, George Spelvin <linux@horizon.com>, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 19, 2015 at 3:31 AM, Jia He <hejianet@gmail.com> wrote:
> --- a/lib/find_bit.c
> +++ b/lib/find_bit.c
> @@ -131,6 +131,56 @@ unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
>  EXPORT_SYMBOL(find_last_bit);
>  #endif
>
> +#ifndef all_bit_is_zero
> +/*
> + * return val: 1 means all bit is zero
> + */
> +unsigned int all_bit_is_zero(const unsigned long *addr, unsigned size)
> +{
> +       unsigned long idx;
> +       unsigned long mask = size;
> +
> +       if (unlikely(size == 0))
> +               return 1;
> +
> +       if (size > BITS_PER_LONG) {
> +               for (idx = 0; idx * BITS_PER_LONG < size; idx++)

Please move the multiplication (yes, a shift) out of the loop. Not all CPUs
have barrel shifters.

> +                       if (addr[idx])
> +                               return 0;
> +
> +               mask = size - (idx - 1) * BITS_PER_LONG;
> +       }
> +
> +       return !(*addr & BITMAP_LAST_WORD_MASK(mask));
> +}
> +EXPORT_SYMBOL(all_bit_is_zero);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
