From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] C-SKY(csky) Port for Linux 4.20
Date: Mon, 29 Oct 2018 12:27:01 +0100
Message-ID: <CAK8P3a1mnNbMA+qRLKkhwwW_+KzkSfeNA5Nn_zVS1z8OWU+uGg@mail.gmail.com>
References: <1540613318-23877-1-git-send-email-ren_guo@c-sky.com>
 <CAHk-=whHhzsdgbVwRFB8oGVwnfN551HPQjtvuodf+W5dNHtjuA@mail.gmail.com>
 <CAK8P3a2-wyXxctVtJxniUoeShASMhF-6Z1vyvfBnr6wKJuioAQ@mail.gmail.com> <CAMuHMdU6e8vu_Kak2Avzn2WeTkmc-mjagR5tzX8BxgdH_UcYUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdU6e8vu_Kak2Avzn2WeTkmc-mjagR5tzX8BxgdH_UcYUA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Guo Ren <ren_guo@c-sky.com>, Marc Zyngier <marc.zyngier@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, c-sky_gcc_upstream@c-sky.com, guoren1983@gmail.com, mrybczyn@kalray.eu
List-Id: linux-arch.vger.kernel.org

On Mon, Oct 29, 2018 at 11:26 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> On Mon, Oct 29, 2018 at 10:45 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > One more general comment: I think this may well be the last new CPU
> > architecture we ever add to the kernel. Both nds32 and c-sky are made
> > by companies that also work on risc-v, and generally speaking risc-v
> > seems to be killing off any of the minor licensable instruction set projects,
> > just like ARM has mostly killed off the custom vendor-specific instruction
> > sets already. If we add another architecture in the future, it may instead
> > be something like the LLVM bitcode or WebAssembly, who knows?
>
> Kalray MPPA?
>

Ok, I stand corrected. I found the sources at [1], which look like they
are getting ready for an initial submission.

       Arnd

[1] https://github.com/kalray/linux_coolidge/commits/kalray-v4.19-rc8
