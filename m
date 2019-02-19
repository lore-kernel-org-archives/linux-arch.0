Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43777 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbfBSUGW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Feb 2019 15:06:22 -0500
MIME-Version: 1.0
References: <20190218210712.3503891-1-arnd@arndb.de> <20190218210712.3503891-5-arnd@arndb.de>
In-Reply-To: <20190218210712.3503891-5-arnd@arndb.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 Feb 2019 21:06:04 +0100
Message-ID: <CAMuHMdVbz=_GFMnKx4PuxpmG9jpdA=Do2XnR3bY5wRZPM3G+Gw@mail.gmail.com>
Subject: Re: [PATCH 4/8] asm-generic: Make time32 syscall numbers optional
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038 Mailman List <y2038@lists.linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linux-Arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Yury Norov <yury.norov@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, Stafford Horne <shorne@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Palmer Dabbelt <palmer@sifive.com>, Guo Ren <guoren@kernel.org>, Greentime Hu <green.hu@gmail.com>, linux-riscv@lists.infradead.org, Guan Xuetao <gxt@pku.edu.cn>
Message-ID: <20190219200604.E9K9-nWx2CEjZc5osJ1xM3dxElltzrRGFgWfO7Qqltc@z>

Hi Arnd,

On Tue, Feb 19, 2019 at 3:34 AM Arnd Bergmann <arnd@arndb.de> wrote:
> We don't want new architectures to even provide the old 32-bit time_t
> based system calls any more, or define the syscall number macros.
>
> Add a new __ARCH_WANT_TIME32_SYSCALLS macro that gets enabled for all
> existing 32-bit architectures so we don't change any current behavior.

... (only) 32-bit architectures using the generic syscall list, right?

> Since this symbol is evaluated in user space as well, we cannot use
> a Kconfig CONFIG_* macro but have to define it in uapi/asm/unistd.h.
>
> On 64-bit architectures, the same system call numbers mostly refer to
> the system calls we want to keep, as they already pass 64-bit time_t.
>
> As new architectures no longer provide these, we need new exceptions
> in checksyscalls.sh.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arc/include/uapi/asm/unistd.h       |  1 +
>  arch/arm64/include/uapi/asm/unistd.h     |  1 +
>  arch/c6x/include/uapi/asm/unistd.h       |  1 +
>  arch/csky/include/uapi/asm/unistd.h      |  1 +
>  arch/h8300/include/uapi/asm/unistd.h     |  1 +
>  arch/hexagon/include/uapi/asm/unistd.h   |  1 +
>  arch/nds32/include/uapi/asm/unistd.h     |  1 +
>  arch/nios2/include/uapi/asm/unistd.h     |  1 +
>  arch/openrisc/include/uapi/asm/unistd.h  |  1 +
>  arch/riscv/include/uapi/asm/unistd.h     |  3 ++
>  arch/unicore32/include/uapi/asm/unistd.h |  1 +
>  include/uapi/asm-generic/unistd.h        | 36 ++++++++++++++++++++++++
>  scripts/checksyscalls.sh                 |  7 +++++
>  13 files changed, 56 insertions(+)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
