From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] sh: generate uapi header and syscall table header files
Date: Sat, 12 Jan 2019 10:22:56 +0100
Message-ID: <CAMuHMdXuo1wMvwx-FZB6uBJahSSbqrmnxEAfepnhAS_odQkHDA@mail.gmail.com>
References: <1546443445-21075-1-git-send-email-firoz.khan@linaro.org>
 <1546443445-21075-3-git-send-email-firoz.khan@linaro.org> <20190110235428.GA10016@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190110235428.GA10016@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Firoz Khan <firoz.khan@linaro.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms+renesas@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Jan 11, 2019 at 1:37 AM Guenter Roeck <linux@roeck-us.net> wrote:
> On Wed, Jan 02, 2019 at 09:07:25PM +0530, Firoz Khan wrote:
> > Unified system call table generation script must be run to
> > generate unistd_32.h and syscall_table.h files. This patch
> > will have changes which will invokes the script.
> >
> > This patch will generate unistd_32.h and syscall_table.h
> > files by the syscall table generation script invoked by
> > sh/Makefile and the generated files against the removed
> > files must be identical.
> >
> > The generated uapi header file will be included in uapi/-
> > asm/unistd.h and generated system call table header file
> > will be included by kernel/syscall_32.S file.
> >
> > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
>
> Have you tested this patch ?

All these series depend on "scripts: unify system call table generation
scripts"
https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/

Yeah, 0day also didn't know that.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
