From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/4] m68k/mm: motorola - Add missing initialization of max_pfn
Date: Tue, 17 Nov 2015 20:54:30 +0100
Message-ID: <CAMuHMdUQCpPhFHOBm=xk6NkNaEt9HyB7OH4Rumpx2W5x=Aup1w@mail.gmail.com>
References: <1447585455-19671-1-git-send-email-geert@linux-m68k.org>
	<1447585455-19671-2-git-send-email-geert@linux-m68k.org>
	<564AB03A.80303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <564AB03A.80303@gmail.com>
Sender: linux-m68k-owner@vger.kernel.org
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Greg Ungerer <gerg@uclinux.org>, Sam Creasey <sammy@sammy.net>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi Michael,

On Tue, Nov 17, 2015 at 5:42 AM, Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 16.11.2015 um 00:04 schrieb Geert Uytterhoeven:
>> If max_pfn is not initialized, the various /proc/kpage* files are empty,
>> and selftests/vm/mlock2-tests will fail. max_pfn is also used by the
>> block layer to calculate DMA masks.
>
> What about platforms where the DMA can't address all available physical
> memory?

There are many other checks, using max_low_pfn and/or zone_dma.
I'm not 100% clear on the impact of max_pfn in blk_settings_init().

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
