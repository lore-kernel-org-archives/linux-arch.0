From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] asm-generic: {get,put}_user ptr argument evaluate only 1 time
Date: Thu, 16 Jul 2015 08:40:31 +0200
Message-ID: <CAMuHMdX05U3b6sqzc+cJFO9fnGfewTrwoOiXm-fA_V4GmjBKHg@mail.gmail.com>
References: <1437023722-7432-1-git-send-email-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437023722-7432-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi Sato-san,

On Thu, Jul 16, 2015 at 7:15 AM, Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Current implemantation ptr argument evaluate 2 times.
> It'll be an unexpected result.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> ---
>  include/asm-generic/uaccess.h | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
> index 72d8803..1b813fb 100644
> --- a/include/asm-generic/uaccess.h
> +++ b/include/asm-generic/uaccess.h
> @@ -163,9 +163,10 @@ static inline __must_check long __copy_to_user(void __user *to,
>
>  #define put_user(x, ptr)                                       \
>  ({                                                             \
> +       __typeof__((ptr)) __p = (ptr);                          \
>         might_fault();                                          \
> -       access_ok(VERIFY_WRITE, ptr, sizeof(*ptr)) ?            \
> -               __put_user(x, ptr) :                            \
> +       access_ok(VERIFY_WRITE, __p, sizeof(*__p)) ?            \
> +               __put_user(x, __p) :                            \

For safety, you may want to change "x" to "(x") while at it.

>                 -EFAULT;                                        \
>  })
>
> @@ -225,9 +226,10 @@ extern int __put_user_bad(void) __attribute__((noreturn));
>
>  #define get_user(x, ptr)                                       \
>  ({                                                             \
> +       __typeof__((ptr)) __p = (ptr);                          \
>         might_fault();                                          \
> -       access_ok(VERIFY_READ, ptr, sizeof(*ptr)) ?             \
> -               __get_user(x, ptr) :                            \
> +       access_ok(VERIFY_READ, __p, sizeof(*__p)) ?             \
> +               __get_user(x, __p) :                            \

Likewise.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
