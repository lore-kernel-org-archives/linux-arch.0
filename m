From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 14/24] avr32: Use Kbuild logic to provide <asm/types.h>
Date: Mon, 25 Nov 2013 11:03:08 +0100
Message-ID: <CAMuHMdVyFhwpnRm4fwH5XcgDRC0qASd-Gmg15aOYuxSZOHsB9g@mail.gmail.com>
References: <1385369734-24893-1-git-send-email-geert@linux-m68k.org>
	<1385369734-24893-15-git-send-email-geert@linux-m68k.org>
	<20131125090922.GB13358@samfundet.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131125090922.GB13358@samfundet.no>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 25, 2013 at 10:09 AM, Hans-Christian Egtvedt
<egtvedt@samfundet.no> wrote:
> Around Mon 25 Nov 2013 09:55:24 +0100 or thereabout, Geert Uytterhoeven wrote:
>> The extra definition for BITS_PER_LONG is also indirectly provided
>> by <asm-generic/types.h>, via <asm-generic/int-ll64.h> and
>> <asm/bitsperlong.h>
>
> Are you adding a new include/asm-generic/types.h, which will include
> bitsperlong.h ?

Yes, that's [PATCH 24/24].

Currently you get it through the UAPI <asm-generic/types.h>, via
<asm-generic/int-ll64.h> and <asm/bitsperlong.h>.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
