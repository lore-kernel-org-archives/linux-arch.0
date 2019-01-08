From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] arch: unexport asm/shmparam.h for all architectures
Date: Tue, 8 Jan 2019 08:56:52 +0100
Message-ID: <CAMuHMdU_wUjk=nw9QtWaNGzgb3cCUiKLZpPy+bmcn4qw6zbccw@mail.gmail.com>
References: <1546904307-11124-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546904307-11124-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Simek <monstr@monstr.eu>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, Guan Xuetao <gxt@pku.edu.cn>, Linux-Arch <linux-arch@vger.kernel.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, Arnd Bergmann <arnd@arndb.de>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, linux-riscv@lists.infradead.org, Greentime Hu <green.hu@gmail.com>, linux-c6x-dev@linux-c6x.org, Guo Ren <guoren@kernel.org>, Stafford Horne <shorne@gmail.com>, Palmer Dabbelt <palmer@sifive.com>, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, linux-m68k
List-Id: linux-arch.vger.kernel.org

Hi Yamada-san,

On Tue, Jan 8, 2019 at 12:41 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Most architectures do not export shmparam.h to user-space.
>
>   $ find arch -name shmparam.h  | sort
>   arch/alpha/include/asm/shmparam.h
>   arch/arc/include/asm/shmparam.h
>   arch/arm64/include/asm/shmparam.h
>   arch/arm/include/asm/shmparam.h
>   arch/csky/include/asm/shmparam.h
>   arch/ia64/include/asm/shmparam.h
>   arch/mips/include/asm/shmparam.h
>   arch/nds32/include/asm/shmparam.h
>   arch/nios2/include/asm/shmparam.h
>   arch/parisc/include/asm/shmparam.h
>   arch/powerpc/include/asm/shmparam.h
>   arch/s390/include/asm/shmparam.h
>   arch/sh/include/asm/shmparam.h
>   arch/sparc/include/asm/shmparam.h
>   arch/x86/include/asm/shmparam.h
>   arch/xtensa/include/asm/shmparam.h
>
> Strangely, some users of the asm-generic wrapper export shmparam.h
>
>   $ git grep 'generic-y += shmparam.h'
>   arch/c6x/include/uapi/asm/Kbuild:generic-y += shmparam.h
>   arch/h8300/include/uapi/asm/Kbuild:generic-y += shmparam.h
>   arch/hexagon/include/uapi/asm/Kbuild:generic-y += shmparam.h
>   arch/m68k/include/uapi/asm/Kbuild:generic-y += shmparam.h
>   arch/microblaze/include/uapi/asm/Kbuild:generic-y += shmparam.h
>   arch/openrisc/include/uapi/asm/Kbuild:generic-y += shmparam.h
>   arch/riscv/include/asm/Kbuild:generic-y += shmparam.h
>   arch/unicore32/include/uapi/asm/Kbuild:generic-y += shmparam.h
>
> The newly added riscv correctly creates the asm-generic wrapper
> in the kernel space, but the others (c6x, h8300, hexagon, m68k,
> microblaze, openrisc, unicore32) create the one in the uapi directory.
>
> Digging into the git history, now I guess fcc8487d477a ("uapi:
> export all headers under uapi directories") was the misconversion.
> Prior to that commit, no architecture exported to shmparam.h
> As its commit description said, that commit exported shmparam.h
> for c6x, h8300, hexagon, m68k, openrisc, unicore32.
>
> 83f0124ad81e ("microblaze: remove asm-generic wrapper headers")
> accidentally exported shmparam.h for microblaze.
>
> This commit unexports shmparam.h for those architectures.
>
> There is no more reason to export include/uapi/asm-generic/shmparam.h,
> so it has been moved to include/asm-generic/shmparam.h
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks for your patch!

include/uapi/asm-generic/shmparam.h contains a single definition:

    #define SHMLBA PAGE_SIZE         /* attach addr a multiple of this */

So this definition is not used by userspace?

Note that it is refered to by include/uapi/linux/shm.h, albeit in a comment:

    #define SHM_RND         020000  /* round attach address to SHMLBA
boundary */

Glibc provides its own definition in /usr/include/x86_64-linux-gnu/bits/shm.h

    #define SHMLBA (__getpagesize ())

So probably this is safe.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
