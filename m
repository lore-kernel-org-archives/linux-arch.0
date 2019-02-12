Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34529 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbfBLKm5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Feb 2019 05:42:57 -0500
MIME-Version: 1.0
References: <20190211174544.4302-1-will.deacon@arm.com> <20190211174544.4302-3-will.deacon@arm.com>
In-Reply-To: <20190211174544.4302-3-will.deacon@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Feb 2019 11:42:44 +0100
Message-ID: <CAMuHMdWFOvrZ5JwgWnx9ujg3dS-75PnjGRqn-vzGmFi295Sb=A@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: io: Hook up __io_par() for inX() ordering
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, andrew.murray@arm.com, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>
Message-ID: <20190212104244.0e5K_xw_Hn5Eih3r8SnevQfLK1J4e6Obnh_dShi_MW8@z>

Hi Will,

On Mon, Feb 11, 2019 at 9:34 PM Will Deacon <will.deacon@arm.com> wrote:
> Ensure that inX() provides the same ordering guarantees as readX()
> by hooking up __io_par() so that it maps directly to __iormb().
>
> Reported-by: Andrew Murray <andrew.murray@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Thanks for your patch!

> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
> @@ -121,6 +121,7 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
>                      : "memory");                                       \
>  })
>
> +#define __io_par               __iormb

I think it makes sense to make the parameter passing explicit, for
documentation purposes:

    #define __io_par(v)        __iormb(v)

>  #define __iowmb()              wmb()
>
>  #define mmiowb()               do { } while (0)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
