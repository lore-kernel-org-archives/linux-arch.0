From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 18/31] nds32: Library functions
Date: Wed, 8 Nov 2017 10:45:28 +0100
Message-ID: <CAK8P3a06XTz2C5R_SS5ibZq2caAJ15+5y2vZ-Tn4DP9zQGoEzg@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <ea57a25c0aceab45d36951fed44cfbecfe1540b8.1510118606.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:50787 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751634AbdKHJp3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Nov 2017 04:45:29 -0500
In-Reply-To: <ea57a25c0aceab45d36951fed44cfbecfe1540b8.1510118606.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>

On Wed, Nov 8, 2017 at 6:55 AM, Greentime Hu <green.hu@gmail.com> wrote:

> +#define get_user(x,p)                                                  \
> +       ({                                                              \
> +               const register typeof(*(p)) __user *__p asm("$r0") = (p);\
> +               register unsigned long __r2 asm("$r2");                 \
> +               register int __e asm("$r0");                            \
> +               switch (sizeof(*(__p))) {                               \
> +               case 1:                                                 \
> +                       __get_user_x(__r2, __p, __e, 1, "$lp");         \
> +                       break;                                          \
> +               case 2:                                                 \
> +                       __get_user_x(__r2, __p, __e, 2, "$lp");         \
> +                       break;                                          \
> +               case 4:                                                 \
> +                       __get_user_x(__r2, __p, __e, 4, "$lp");         \
> +                       break;                                          \
> +               case 8:                                                 \
> +                       __get_user_x(__r2, __p, __e, 8, "$r3", "$lp");  \
> +                       break;                                          \
> +               default: __e = __get_user_bad(); break;                 \
> +               }                                                       \
> +               x = (typeof(*(p))) __r2;        \
> +               __e;                                                    \
> +       })

Something looks odd here: __get_user_bad above looks like it is meant
to provide a link-time error

> +__get_user_bad_8:
> +       move    $r3, #0
> +__get_user_bad:
> +       move    $r2, #0
> +       move    $r0, #-EFAULT
> +       ret
> +

but here you actually have a symbol with that name, it gets turned
into a runtime error. I think the first one needs to get renamed to
actually work as expected and force the link error in built-in code
(it works in modules ins __get_user_bad is not exported).

> +
> +__put_user_bad:
> +       move    $r0, #-EFAULT
> +       ret
> +

same here.

      Arnd
