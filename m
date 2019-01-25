From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] treewide: get rid of HAVE_FUTEX_CMPXCHG
Date: Fri, 25 Jan 2019 19:58:30 +0100
Message-ID: <CAMuHMdUYDPrtnj++C3JZYuGqn1xoc=ZG8i8rp2HAdqXe7H7XjA@mail.gmail.com>
References: <20190125184640.5174-1-jcmvbkbc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125184640.5174-1-jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Paul Burton <paul.burton@mips.com>, Ralf Baechle <ralf@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Ungerer <gerg@linux-m68k.org>
List-Id: linux-arch.vger.kernel.org

Hi Max,

On Fri, Jan 25, 2019 at 7:47 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
> CONFIG_HAVE_FUTEX_CMPXCHG is currently used to determine if
> atomic_inatomic is always working or must be probed. For most
> architectures it is either selected, or it is known that they always
> have futex_atomic_cmpxchg_inatomic working.
>
> Drop HAVE_FUTEX_CMPXCHG from the Kconfig and let architectures that may
> not have it working define macro arch_have_futex_cmpxchg that probes
> whether futex_atomic_cmpxchg_inatomic is working, otherwise assume that
> it is working.
>
> Implement arch_have_futex_cmpxchg for MIPS, Xtensa and for the users of
> asm-generic/futex.h.
>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes v1->v2:
> - fix #ifdef/#ifndef logic in kernel/futex.c

Thanks for the update!

>  arch/m68k/Kconfig               |  1 -

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
