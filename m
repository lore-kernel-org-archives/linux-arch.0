Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34633 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728950AbeJ2VMk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Oct 2018 17:12:40 -0400
MIME-Version: 1.0
References: <1540613318-23877-1-git-send-email-ren_guo@c-sky.com>
 <CAHk-=whHhzsdgbVwRFB8oGVwnfN551HPQjtvuodf+W5dNHtjuA@mail.gmail.com>
 <CAK8P3a2-wyXxctVtJxniUoeShASMhF-6Z1vyvfBnr6wKJuioAQ@mail.gmail.com>
 <CAMuHMdU6e8vu_Kak2Avzn2WeTkmc-mjagR5tzX8BxgdH_UcYUA@mail.gmail.com> <CAK8P3a1mnNbMA+qRLKkhwwW_+KzkSfeNA5Nn_zVS1z8OWU+uGg@mail.gmail.com>
In-Reply-To: <CAK8P3a1mnNbMA+qRLKkhwwW_+KzkSfeNA5Nn_zVS1z8OWU+uGg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Oct 2018 13:24:00 +0100
Message-ID: <CAMuHMdU-Vm_iwaY7hO54n+NuqRgfEmyBx8+HM6m0XtoqoG+AXw@mail.gmail.com>
Subject: Re: [GIT PULL] C-SKY(csky) Port for Linux 4.20
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, Guo Ren <ren_guo@c-sky.com>, Marc Zyngier <marc.zyngier@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, c-sky_gcc_upstream@c-sky.com, guoren1983@gmail.com, Marta Rybczynska <mrybczyn@kalray.eu>
Message-ID: <20181029122400.7TewkShdIijLnymWLxNo6doTgmocD33PiIv8NDB0vtM@z>

Hi Arnd,

On Mon, Oct 29, 2018 at 12:27 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Oct 29, 2018 at 11:26 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Mon, Oct 29, 2018 at 10:45 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > One more general comment: I think this may well be the last new CPU
> > > architecture we ever add to the kernel. Both nds32 and c-sky are made
> > > by companies that also work on risc-v, and generally speaking risc-v
> > > seems to be killing off any of the minor licensable instruction set projects,
> > > just like ARM has mostly killed off the custom vendor-specific instruction
> > > sets already. If we add another architecture in the future, it may instead
> > > be something like the LLVM bitcode or WebAssembly, who knows?
> >
> > Kalray MPPA?
> >
>
> Ok, I stand corrected. I found the sources at [1], which look like they
> are getting ready for an initial submission.
>
>        Arnd
>
> [1] https://github.com/kalray/linux_coolidge/commits/kalray-v4.19-rc8

Cool, I didn't know they were that close ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
