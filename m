Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:52658 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951AbaEOJtd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 15 May 2014 05:49:33 -0400
MIME-Version: 1.0
In-Reply-To: <5373D8CE.6090003@nod.at>
References: <1400093999-18703-1-git-send-email-richard@nod.at>
	<1400093999-18703-14-git-send-email-richard@nod.at>
	<CAMuHMdUddNc3Suq25JU7UC+YdWQHmk0nCRzCEbqmKg1+a+=FXw@mail.gmail.com>
	<5373C36E.3020900@nod.at>
	<CAMuHMdVWp8-aByVf+7M=8HEXXJRJBbZLdfj1v0rgDU-UEQM=8Q@mail.gmail.com>
	<5373D8CE.6090003@nod.at>
Date: Thu, 15 May 2014 11:49:32 +0200
Message-ID: <CAMuHMdUQfa1E1aJWKU-UN+5WyVZ7LTcQDu+cTr4crjnH69+JMg@mail.gmail.com>
Subject: Re: [PATCH 13/27] m68k: Use common bits from generic tlb.h
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>
Message-ID: <20140515094932.X-eOFHIE-mhgTvO2MBquY97WIVGChCQx3FOrt_WFPJ4@z>

Hi Richard,

On Wed, May 14, 2014 at 10:57 PM, Richard Weinberger <richard@nod.at> wrote:
>> On Wed, May 14, 2014 at 9:26 PM, Richard Weinberger <richard@nod.at> wrote:
>>>> But why this sudden #ifdef checks?
>>>
>>> They are needed because in pgalloc.h you have:
>>> #ifdef CONFIG_MMU
>>> #include <asm/virtconvert.h>
>>> #if defined(CONFIG_COLDFIRE)
>>> #include <asm/mcf_pgalloc.h>
>>> #elif defined(CONFIG_SUN3)
>>> #include <asm/sun3_pgalloc.h>
>>> #else
>>> #include <asm/motorola_pgalloc.h>
>>> #endif
>>>
>>> And only asm/motorola_pgalloc.h have __pte/pmd_free_tlb as static inline functions.
>>> Therefore we need to define them such that the generic tlb.h versions will not clash
>>> with yours.
>>
>> Thanks for the clarification!
>
> One problem which arises here is that me need to make sure that pgalloc.h is included before
> tlb.h. Which kind of sucks.

Indeed.

arch/m68k/include/asm/mmu_context.h includes pgalloc.h, but not tlb.h.
Didn't check whether it gets it indirectly.

> I'll move __pte/pmd_free_tlb from *_pgalloc.h into tlb.h to prevent this issue.
>
> Are you fine with that?

As long as it compiles, I'm happy ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
