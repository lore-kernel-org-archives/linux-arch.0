Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk1-f194.google.com ([209.85.221.194]:40143 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729343AbeJ2TO2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Oct 2018 15:14:28 -0400
MIME-Version: 1.0
References: <1540613318-23877-1-git-send-email-ren_guo@c-sky.com>
 <CAHk-=whHhzsdgbVwRFB8oGVwnfN551HPQjtvuodf+W5dNHtjuA@mail.gmail.com> <CAK8P3a2-wyXxctVtJxniUoeShASMhF-6Z1vyvfBnr6wKJuioAQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2-wyXxctVtJxniUoeShASMhF-6Z1vyvfBnr6wKJuioAQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Oct 2018 11:26:12 +0100
Message-ID: <CAMuHMdU6e8vu_Kak2Avzn2WeTkmc-mjagR5tzX8BxgdH_UcYUA@mail.gmail.com>
Subject: Re: [GIT PULL] C-SKY(csky) Port for Linux 4.20
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, Guo Ren <ren_guo@c-sky.com>, Marc Zyngier <marc.zyngier@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, c-sky_gcc_upstream@c-sky.com, guoren1983@gmail.com, Marta Rybczynska <mrybczyn@kalray.eu>
Message-ID: <20181029102612.3nunPMHAtoVY2kmDNwQE2hvgfjZSO98_i_6K4TD4yLI@z>

On Mon, Oct 29, 2018 at 10:45 AM Arnd Bergmann <arnd@arndb.de> wrote:
> One more general comment: I think this may well be the last new CPU
> architecture we ever add to the kernel. Both nds32 and c-sky are made
> by companies that also work on risc-v, and generally speaking risc-v
> seems to be killing off any of the minor licensable instruction set projects,
> just like ARM has mostly killed off the custom vendor-specific instruction
> sets already. If we add another architecture in the future, it may instead
> be something like the LLVM bitcode or WebAssembly, who knows?

Kalray MPPA?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
