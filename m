From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v4 25/36] nds32: Miscellaneous header files
Date: Mon, 18 Dec 2017 12:13:39 +0100
Message-ID: <CAK8P3a1EOD3WB=c4JybBD5bazhVJ5reuegyA1Hyoj-nPHpsW6g@mail.gmail.com>
References: <cover.1513577007.git.green.hu@gmail.com> <a5dc2090640500d88aa3af2f6fe9e4c73f0634f2.1513577007.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <a5dc2090640500d88aa3af2f6fe9e4c73f0634f2.1513577007.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Greentime <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Networking <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, ren_guo-Y+KPrCd2zL4AvxtiuMwx3w@public.gmane.org, Philip
List-Id: linux-arch.vger.kernel.org

On Mon, Dec 18, 2017 at 7:46 AM, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
>
> This patch introduces some miscellaneous header files.

> +static inline void __delay(unsigned long loops)
> +{
> +       __asm__ __volatile__(".align 2\n"
> +                            "1:\n"
> +                            "\taddi\t%0, %0, -1\n"
> +                            "\tbgtz\t%0, 1b\n"
> +                            :"=r"(loops)
> +                            :"0"(loops));
> +}
> +
> +static inline void __udelay(unsigned long usecs, unsigned long lpj)
> +{
> +       usecs *= (unsigned long)(((0x8000000000000000ULL / (500000 / HZ)) +
> +                                 0x80000000ULL) >> 32);
> +       usecs = (unsigned long)(((unsigned long long)usecs * lpj) >> 32);
> +       __delay(usecs);
> +}

Do you have a reliable clocksource that you can read here instead of doing the
loop? It's generally preferred to have an accurate delay if at all possible, the
delay loop calibration is only for those architectures that don't have any
way to observe how much time has passed accurately.

       Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
