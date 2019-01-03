From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] m68k: remove nargs from __SYSCALL
Date: Thu, 3 Jan 2019 11:45:17 +0100
Message-ID: <CAMuHMdXD5PpF0VswotPP=DQUZ6Rcx0jUq1Czo_WFdGAUrkddyw@mail.gmail.com>
References: <1546442319-20461-1-git-send-email-firoz.khan@linaro.org> <1546442319-20461-2-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546442319-20461-2-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, marcin.juszkiewicz@linaro.org
List-Id: linux-arch.vger.kernel.org

Hi Firoz,

Thanks for your patch!

On Wed, Jan 2, 2019 at 4:19 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> The __SYSCALL macro's arguments are system call number,
> system call entry name and number of arguments for the

name,

> system call.
>
> Argument- nargs in __SYSCALL(nr, entry, nargs) is neither

Argument nargs

> calculated nor used anywhere. So it would be better to
> keep the implementaion as  __SYSCALL(nr, entry). This will

implementation

> unifies the implementation with some other architetures

unify
architectures

> too.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> ---
>  arch/m68k/kernel/syscalls/syscalltbl.sh | 4 ++--
>  arch/m68k/kernel/syscalltable.S         | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/m68k/kernel/syscalls/syscalltbl.sh b/arch/m68k/kernel/syscalls/syscalltbl.sh
> index 85d78d9..904b8e6 100644
> --- a/arch/m68k/kernel/syscalls/syscalltbl.sh
> +++ b/arch/m68k/kernel/syscalls/syscalltbl.sh
> @@ -13,10 +13,10 @@ emit() {
>         t_entry="$3"
>
>         while [ $t_nxt -lt $t_nr ]; do
> -               printf "__SYSCALL(%s, sys_ni_syscall, )\n" "${t_nxt}"
> +               printf "__SYSCALL(%s,sys_ni_syscall)\n" "${t_nxt}"

Please keep the space after the comma.

>                 t_nxt=$((t_nxt+1))
>         done
> -       printf "__SYSCALL(%s, %s, )\n" "${t_nxt}" "${t_entry}"
> +       printf "__SYSCALL(%s,%s)\n" "${t_nxt}" "${t_entry}"

Idem ditto.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
