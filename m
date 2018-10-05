From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/5] asm-generic, termios: add alias constants from MIPS
Date: Fri, 5 Oct 2018 09:30:10 +0200
Message-ID: <CAMuHMdWQnT=VBh1=zXTASfR+Z_8913BB4YeFXwz6ShpkSTycBA@mail.gmail.com>
References: <20181004222953.2229-1-hpa@zytor.com> <20181004222953.2229-2-hpa@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004222953.2229-2-hpa@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-arch.vger.kernel.org

Hi Peter,

Thanks for your patch!

On Fri, Oct 5, 2018 at 12:30 AM H. Peter Anvin (Intel) <hpa@zytor.com> wrote:
> Some architectures, in this case MIPS, need a couple of legacy alias
> constants for bits. There really is no reason why we can't define them
> generically for all architectures.

To avoid polluting namespace?
To avoid people using them in a context not specific to MIPS?

> --- a/include/uapi/asm-generic/termbits.h
> +++ b/include/uapi/asm-generic/termbits.h
> @@ -8,7 +8,10 @@ typedef unsigned char  cc_t;
>  typedef unsigned int   speed_t;
>  typedef unsigned int   tcflag_t;
>
> -#define NCCS 19
> +#ifndef NCCS
> +# define NCCS 19
> +#endif
> +
>  struct termios {
>         tcflag_t c_iflag;               /* input mode flags */
>         tcflag_t c_oflag;               /* output mode flags */
> @@ -49,6 +52,7 @@ struct ktermios {
>  #define VTIME 5
>  #define VMIN 6
>  #define VSWTC 7
> +#define VSWTCH VSWTC

I'd at least add a comment /* legacy MIPS */ here.

>  #define VSTART 8
>  #define VSTOP 9
>  #define VSUSP 10
> @@ -173,6 +177,7 @@ struct ktermios {
>  #define ECHONL 0000100
>  #define NOFLSH 0000200
>  #define TOSTOP 0000400
> +#define ITOSTOP TOSTOP

Likewise.

>  #define ECHOCTL        0001000
>  #define ECHOPRT        0002000
>  #define ECHOKE 0004000

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
