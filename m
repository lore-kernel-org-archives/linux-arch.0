From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] asm-generic/dma-mapping-broken.h: Provide dma_alloc_attrs()/dma_free_attrs()
Date: Sat, 22 Dec 2012 13:51:32 +0100
Message-ID: <CAMuHMdXhi_dA9Q04YoQ9yDRrJRpH8mNsLgU88oCdhAgcsQLpyg@mail.gmail.com>
References: <1355679527-1207-1-git-send-email-geert@linux-m68k.org>
	<1355679527-1207-2-git-send-email-geert@linux-m68k.org>
	<201212171612.44126.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <201212171612.44126.arnd@arndb.de>
Sender: linux-m68k-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi Arnd,

On Mon, Dec 17, 2012 at 5:12 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sunday 16 December 2012, Geert Uytterhoeven wrote:
>> Since commit 0049fb2603b7afb1080776ee691dfa5a3d282357 ("OMAPFB: use
>> dma_alloc_attrs to allocate memory") we have one non-arch user of
>> dma_{alloc,free}_attrs().
>>
>> Hence provide these functions, as wrappers around
>> dma_{alloc,free}_coherent().
>>
>> Note that most architectures do it the other way around. But as these are
>> dummy functions, we don't care.
>>
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> ---
>>  include/asm-generic/dma-mapping-broken.h |   16 ++++++++++++++++
>>  1 files changed, 16 insertions(+), 0 deletions(-)
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

> Maybe you can put this one in your m68k tree along with your other
> patch.

Will do.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
