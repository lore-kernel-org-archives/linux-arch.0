From: Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCH v5 2/6] linux/bug.h: correct formatting of block comment
Date: Thu, 25 May 2017 15:58:58 +0200
Message-ID: <xa1td1axhwbh.fsf@mina86.com>
References: <20170525120316.24473-1-abbotti@mev.co.uk> <20170525120316.24473-3-abbotti@mev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37990 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbdEYN7I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2017 09:59:08 -0400
Received: by mail-wm0-f46.google.com with SMTP id e127so106401651wmg.1
        for <linux-arch@vger.kernel.org>; Thu, 25 May 2017 06:59:07 -0700 (PDT)
In-Reply-To: <20170525120316.24473-3-abbotti@mev.co.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Alexander Potapenko <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Ian Abbott <abbotti@mev.co.uk>, Jakub Kicinski <jakub.kicinski@netronome.com>, Johannes Berg <johannes.berg@intel.com>, Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Steven Rostedt <rostedt@goodmis.org>

On Thu, May 25 2017, Ian Abbott wrote:
> Correct these checkpatch.pl warnings:
>
> |WARNING: Block comments use * on subsequent lines
> |#34: FILE: include/linux/bug.h:34:
> |+/* Force a compilation error if condition is true, but also produce a
> |+   result (of value 0 and type size_t), so the expression can be used
>
> |WARNING: Block comments use a trailing */ on a separate line
> |#36: FILE: include/linux/bug.h:36:
> |+   aren't permitted). */
>
> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Acked-by: Michal Nazarewicz <mina86@mina86.com>

> ---
> v5: Actually, there was no v1 thru v4.  I called this v5 to match the
> series.
> ---
>  include/linux/bug.h | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/bug.h b/include/linux/bug.h
> index 687b557fc5eb..ca24007e2dc3 100644
> --- a/include/linux/bug.h
> +++ b/include/linux/bug.h
> @@ -30,10 +30,12 @@ struct pt_regs;
>  #define BUILD_BUG_ON_NOT_POWER_OF_2(n)			\
>  	BUILD_BUG_ON((n) =3D=3D 0 || (((n) & ((n) - 1)) !=3D 0))
>=20=20
> -/* Force a compilation error if condition is true, but also produce a
> -   result (of value 0 and type size_t), so the expression can be used
> -   e.g. in a structure initializer (or where-ever else comma expressions
> -   aren't permitted). */
> +/*
> + * Force a compilation error if condition is true, but also produce a
> + * result (of value 0 and type size_t), so the expression can be used
> + * e.g. in a structure initializer (or where-ever else comma expressions
> + * aren't permitted).
> + */
>  #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
>  #define BUILD_BUG_ON_NULL(e) ((void *)sizeof(struct { int:-!!(e); }))

--=20
Best regards
=E3=83=9F=E3=83=8F=E3=82=A6 =E2=80=9C=F0=9D=93=B6=F0=9D=93=B2=F0=9D=93=B7=
=F0=9D=93=AA86=E2=80=9D =E3=83=8A=E3=82=B6=E3=83=AC=E3=83=B4=E3=82=A4=E3=83=
=84
=C2=ABIf at first you don=E2=80=99t succeed, give up skydiving=C2=BB
