Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37062 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751935AbeBZN6V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Feb 2018 08:58:21 -0500
MIME-Version: 1.0
In-Reply-To: <20171208160640.13125-1-thomas.petazzoni@free-electrons.com>
References: <20171208160640.13125-1-thomas.petazzoni@free-electrons.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2018 14:58:20 +0100
Message-ID: <CAMuHMdWXXTJm8jmhusKdNziAFuiComxHcdb9jCa_Q5xCotRu_w@mail.gmail.com>
Subject: Re: [PATCH] drivers/sh: clk: drop "const" qualifier in I/O read wrappers
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>

On Fri, Dec 8, 2017 at 5:06 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> The r8/r16/r32 wrappers around ioread8/ioread16/ioread32 take "const
> void __iomem *" pointers, but ioread8/ioread16/ioread32 as defined in
> <asm-generic/iomap.h> don't take const pointers. This causes a warning
> when building cpg.c:
>
>   CC      net/ipv4/inet_fragment.o
> drivers/sh/clk/cpg.c: In function =E2=80=98r8=E2=80=99:
> drivers/sh/clk/cpg.c:41:17: warning: passing argument 1 of =E2=80=98iorea=
d8=E2=80=99 discards =E2=80=98const=E2=80=99 qualifier from pointer target =
type [-Wdiscarded-qualifiers]
>   return ioread8(addr);
>                  ^~~~
> In file included from arch/sh/include/asm/io.h:21:0,
>                  from include/linux/io.h:25,
>                  from drivers/sh/clk/cpg.c:14:
> include/asm-generic/iomap.h:29:21: note: expected =E2=80=98void *=E2=80=
=99 but argument is of type =E2=80=98const void *=E2=80=99
>  extern unsigned int ioread8(void __iomem *);
>                      ^~~~~~~
> drivers/sh/clk/cpg.c: In function =E2=80=98r16=E2=80=99:
> drivers/sh/clk/cpg.c:46:18: warning: passing argument 1 of =E2=80=98iorea=
d16=E2=80=99 discards =E2=80=98const=E2=80=99 qualifier from pointer target=
 type [-Wdiscarded-qualifiers]
>   return ioread16(addr);
>                   ^~~~
> In file included from arch/sh/include/asm/io.h:21:0,
>                  from include/linux/io.h:25,
>                  from drivers/sh/clk/cpg.c:14:
> include/asm-generic/iomap.h:30:21: note: expected =E2=80=98void *=E2=80=
=99 but argument is of type =E2=80=98const void *=E2=80=99
>  extern unsigned int ioread16(void __iomem *);
>                      ^~~~~~~~
> drivers/sh/clk/cpg.c: In function =E2=80=98r32=E2=80=99:
> drivers/sh/clk/cpg.c:51:18: warning: passing argument 1 of =E2=80=98iorea=
d32=E2=80=99 discards =E2=80=98const=E2=80=99 qualifier from pointer target=
 type [-Wdiscarded-qualifiers]
>   return ioread32(addr);
>                   ^~~~
> In file included from arch/sh/include/asm/io.h:21:0,
>                  from include/linux/io.h:25,
>                  from drivers/sh/clk/cpg.c:14:
> include/asm-generic/iomap.h:32:21: note: expected =E2=80=98void *=E2=80=
=99 but argument is of type =E2=80=98const void *=E2=80=99
>  extern unsigned int ioread32(void __iomem *);
>
> To fix this, we simply drop the const qualifiers in the definitions of
> r8/r16/r32. Changing the prototypes of ioread8/ioread16/ioread32 would
> be a much bigger adventure.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Hmm: io.h and iomap.h seem to disagree:

include/asm-generic/io.h:static inline u8 ioread8(const volatile void
__iomem *addr)
include/asm-generic/iomap.h:extern unsigned int ioread8(void __iomem *);

> ---
>  drivers/sh/clk/cpg.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/sh/clk/cpg.c b/drivers/sh/clk/cpg.c
> index 7442bc130055..87de622a0767 100644
> --- a/drivers/sh/clk/cpg.c
> +++ b/drivers/sh/clk/cpg.c
> @@ -36,17 +36,17 @@ static void sh_clk_write(int value, struct clk *clk)
>                 iowrite32(value, clk->mapped_reg);
>  }
>
> -static unsigned int r8(const void __iomem *addr)
> +static unsigned int r8(void __iomem *addr)
>  {
>         return ioread8(addr);
>  }
>
> -static unsigned int r16(const void __iomem *addr)
> +static unsigned int r16(void __iomem *addr)
>  {
>         return ioread16(addr);
>  }
>
> -static unsigned int r32(const void __iomem *addr)
> +static unsigned int r32(void __iomem *addr)
>  {
>         return ioread32(addr);
>  }
> @@ -55,7 +55,7 @@ static int sh_clk_mstp_enable(struct clk *clk)
>  {
>         sh_clk_write(sh_clk_read(clk) & ~(1 << clk->enable_bit), clk);
>         if (clk->status_reg) {
> -               unsigned int (*read)(const void __iomem *addr);
> +               unsigned int (*read)(void __iomem *addr);
>                 int i;
>                 void __iomem *mapped_status =3D (phys_addr_t)clk->status_=
reg -
>                         (phys_addr_t)clk->enable_reg + clk->mapped_reg;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
