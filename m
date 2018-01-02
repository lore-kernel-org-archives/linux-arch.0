From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] m32r: fix readl/writel prototypes
Date: Tue, 2 Jan 2018 15:20:59 +0100
Message-ID: <CAMuHMdWKDaN8Wc0Szt-2-20TSE8f564b5fRfSuM9_e7FNr0+LA@mail.gmail.com>
References: <20180102105653.1645748-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34289 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751667AbeABOVB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Jan 2018 09:21:01 -0500
In-Reply-To: <20180102105653.1645748-1-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Arnd,

On Tue, Jan 2, 2018 at 11:56 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> All other architectures use 'unsigned int' as the data in readl/write,
> but m32r uses 'unsigned long', leading to lots of harmless build warnings
> like:
>
> drivers/mmc/host/dw_mmc.c: In function 'dw_mci_regs_show':
> drivers/mmc/host/dw_mmc.c:168:31: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'long unsigned int' [-Wformat=]
>   seq_printf(s, "STATUS:\t0x%08x\n", mci_readl(host, STATUS));

Thanks for fixing this!

BTW, I started fixing this a while ago, too, but of course I dived too deep
into arch/m32r/platforms/*/io.c (there are plenty of more type inconsistencies
with asm-generic/io.h!), and gave up after ca. 500 lines of changes ;-)

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

With the below fixed:

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/m32r/include/asm/io.h
> +++ b/arch/m32r/include/asm/io.h
> @@ -108,9 +108,9 @@ static inline unsigned short _readw(unsigned long addr)
>         return *(volatile unsigned short __force *)addr;
>  }
>
> -static inline unsigned long _readl(unsigned long addr)
> +static inline unsigned int _readl(unsigned long addr)
>  {
> -       return *(volatile unsigned long __force *)addr;
> +       return *(volatile unsigned int __force *)addr;
>  }
>
>  static inline void _writeb(unsigned char b, unsigned long addr)
> @@ -123,9 +123,9 @@ static inline void _writew(unsigned short w, unsigned long addr)
>         *(volatile unsigned short __force *)addr = w;
>  }
>
> -static inline void _writel(unsigned long l, unsigned long addr)
> +static inline void _writel(unsigned long l, unsigned int addr)

Don't you want to change the type of "l" instead of the type of "addr"?

>  {
> -       *(volatile unsigned long __force *)addr = l;
> +       *(volatile unsigned int __force *)addr = l;
>  }

Gr{oetje,eeting}s,

                        Geert
