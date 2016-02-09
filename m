From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: linux-next: Tree for Feb 9
Date: Tue, 9 Feb 2016 14:48:26 +0100
Message-ID: <CAMuHMdWLk10EovfQdyVodpw98_MiNOgGBxpVO-WPXShdvff94g@mail.gmail.com>
References: <20160209164104.4ecaa0ce@canb.auug.org.au>
	<20160209073428.GA24863@sudip-pc>
	<20160209120032.GB19840@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:38845 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbcBINs0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Feb 2016 08:48:26 -0500
In-Reply-To: <20160209120032.GB19840@leverpostej>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Jeremy Linton <jeremy.linton@arm.com>, Linux-Arch <linux-arch@vger.kernel.org>, Laura Abbott <labbott@fedoraproject.org>

On Tue, Feb 9, 2016 at 1:00 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Feb 09, 2016 at 01:04:28PM +0530, Sudip Mukherjee wrote:
>> On Tue, Feb 09, 2016 at 04:41:04PM +1100, Stephen Rothwell wrote:
>> > Changes since 20160208:
>>
>> tilepro, tilegx, mips defconfig build fails with the error:
>> ../include/asm-generic/fixmap.h: In function '__set_fixmap_offset':
>> ../include/asm-generic/fixmap.h:77:2: error: implicit declaration of
>> function '__set_fixmap' [-Werror=implicit-function-declaration]
>>
>> caused by:
>> commit ac4c0ac73485 ("asm-generic: make __set_fixmap_offset a static inline")
>>
>> Reverting the commit fixes the issue.
>
> Sorry about this.
>
> Is seems any arch without its own __set_fixmap may be adversely
> affected.
>
> I can't easily stub __set_fixmap as it's not implemented as a macro.

But you can add a forward declaration?

BTW, it seems the following drivers rely on <asm/fixmap.h>, which is
not available on all architectures:
    drivers/firewire/init_ohci1394_dma.c:#include <asm/fixmap.h>
    drivers/tty/serial/earlycon.c:#include <asm/fixmap.h>
    drivers/usb/early/ehci-dbgp.c:#include <asm/fixmap.h>

> I think we can stick with a macro and remove 'addr', by returning the
> result of the expression directly. As fix_to_virt gave us an unsigned
> long I think the types should line up (i.e. the result will be at least
> unsigned long wide).
>
> Arnd, would you be happy with the below patch instead?

> --- a/include/asm-generic/fixmap.h
> +++ b/include/asm-generic/fixmap.h
> @@ -72,10 +72,8 @@ static inline unsigned long virt_to_fix(const unsigned long vaddr)
>  /* Return a pointer with offset calculated */
>  #define __set_fixmap_offset(idx, phys, flags)                \
>  ({                                                           \
> -       unsigned long addr;                                   \
>         __set_fixmap(idx, phys, flags);                       \

Missing parentheses:

    __set_fixmap((idx), (phys), (flags));

> -       addr = fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1)); \
> -       addr;                                                 \
> +       fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1));        \
>  })

"idx" and "phys" are evaluated multiple times, which can lead to subtle bugs.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
