From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/7] bitops: Introduce the for_each_set_port_word macro
Date: Sun, 13 May 2018 18:06:42 +0300
Message-ID: <CAHp75VdBL-K2H9tXAG2wPefCdpv913dbJOvvEkOXE7r=+2+NYQ@mail.gmail.com>
References: <cover.1525785532.git.vilhelm.gray@gmail.com> <c919f6c2ff54a29114bd5e566997f11e5ebf29c3.1525785532.git.vilhelm.gray@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c919f6c2ff54a29114bd5e566997f11e5ebf29c3.1525785532.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

On Tue, May 8, 2018 at 4:26 PM, William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
> This macro iterates for each group of bits (port word) with set bits,
> within a bitmap memory region. For each iteration, "port_word" is set to
> the found port word index, "word_index" is set to the word index of the
> bitmap containing the found port word, and "word_offset" is set to the
> bit offset of the found port word within the respective bitmap word.

Isn't that idea we discussed some time ago?

In any case, part "port" is too specific for a generic function like
this. Please, get rid of it completely. No-one knows what port means
here. Just makes a lot of confusion.

> --- a/lib/find_bit.c
> +++ b/lib/find_bit.c
> @@ -20,6 +20,7 @@
>  #include <linux/bitmap.h>
>  #include <linux/export.h>
>  #include <linux/kernel.h>

> +#include <linux/types.h>

No need. It's included by bitmap.h IIRC.


-- 
With Best Regards,
Andy Shevchenko
