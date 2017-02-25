From: Stephen Boyd <stephen.boyd@linaro.org>
Subject: Re: [PATCH] asm-generic: Force cast get_user() setting x to 0
Date: Fri, 24 Feb 2017 17:24:52 -0800
Message-ID: <148798589245.16996.9285242756855195986@sboyd-linaro>
References: <20170217165229.17768-1-stephen.boyd@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34468 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbdBYBZB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Feb 2017 20:25:01 -0500
Received: by mail-pg0-f46.google.com with SMTP id 1so18053548pgi.1
        for <linux-arch@vger.kernel.org>; Fri, 24 Feb 2017 17:24:58 -0800 (PST)
In-Reply-To: <20170217165229.17768-1-stephen.boyd@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Quoting Stephen Boyd (2017-02-17 08:52:29)
> If we call get_user() with an __le* or __be* type sparse will
> complain when we assign the result to 0 on the faulting path.
> Let's force cast here so that sparse doesn't complain. This
> mirrors what we do in __get_user() as well.
> =

> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
> =

> I made a similar fix to arm64 headers, and it looks like asm-generic
> would need the same fix.

I suppose we can ignore this. I was using sparse v0.5.0 but it seems
that later versions of sparse don't complain here anymore as Luc has
pointed out.

-Stephen

> =

>  include/asm-generic/uaccess.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
> index cc6bb319e464..6352d61df7eb 100644
> --- a/include/asm-generic/uaccess.h
> +++ b/include/asm-generic/uaccess.h
> @@ -227,7 +227,7 @@ extern int __put_user_bad(void) __attribute__((noretu=
rn));
>         might_fault();                                          \
>         access_ok(VERIFY_READ, __p, sizeof(*ptr)) ?             \
>                 __get_user((x), (__typeof__(*(ptr)) *)__p) :    \
> -               ((x) =3D (__typeof__(*(ptr)))0,-EFAULT);          \
> +               ((x) =3D (__force __typeof__(*(ptr)))0, -EFAULT); \
>  })
>  =

>  #ifndef __get_user_fn
