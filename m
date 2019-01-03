From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] m68k: generate uapi header and syscall table header files
Date: Thu, 3 Jan 2019 12:43:13 +0100
Message-ID: <CAMuHMdUT3B2JLkijM5Ofd3TUYa8TZJaj1NWaEJvU_19B-naF-w@mail.gmail.com>
References: <1546442319-20461-1-git-send-email-firoz.khan@linaro.org> <1546442319-20461-3-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546442319-20461-3-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, marcin.juszkiewicz@linaro.org
List-Id: linux-arch.vger.kernel.org

Hi Firoz,

Thanks for your patch!

On Wed, Jan 2, 2019 at 4:19 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> Subject: m68k: generate uapi header and syscall table header files
>
> Unified system call table generation script must be run to
> generate unistd_32.h and syscall_table.h files. This patch
> will have changes which will invokes the script.
>
> This patch will generate unistd_32.h and syscall_table.h
> files by the syscall table generation script invoked by
> m68k/Makefile and the generated files against the removed
> files must be identical.
>
> The generated uapi header file will be included in uapi/-
> asm/unistd.h and generated system call table header file
> will be included by kernel/syscalltable.S file.

This doesn't really describe what this patch is doing.
This patch switches m68k over to use the common scripts for
system call header file generation.

> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> ---
>  arch/m68k/kernel/syscalls/Makefile      | 11 ++++++++--
>  arch/m68k/kernel/syscalls/syscallhdr.sh | 36 ---------------------------------
>  arch/m68k/kernel/syscalls/syscalltbl.sh | 32 -----------------------------
>  3 files changed, 9 insertions(+), 70 deletions(-)
>  delete mode 100644 arch/m68k/kernel/syscalls/syscallhdr.sh
>  delete mode 100644 arch/m68k/kernel/syscalls/syscalltbl.sh
>
> diff --git a/arch/m68k/kernel/syscalls/Makefile b/arch/m68k/kernel/syscalls/Makefile
> index 659faef..75c7421 100644
> --- a/arch/m68k/kernel/syscalls/Makefile
> +++ b/arch/m68k/kernel/syscalls/Makefile
> @@ -6,8 +6,9 @@ _dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')       \
>           $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
>
>  syscall := $(srctree)/$(src)/syscall.tbl
> -syshdr := $(srctree)/$(src)/syscallhdr.sh
> -systbl := $(srctree)/$(src)/syscalltbl.sh
> +syshdr := $(srctree)/scripts/syscallhdr.sh
> +sysnr := $(srctree)/scripts/syscallnr.sh

What's the purpose of adding sysnr?

> +systbl := $(srctree)/scripts/syscalltbl.sh
>
>  quiet_cmd_syshdr = SYSHDR  $@
>        cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@'       \
> @@ -15,6 +16,12 @@ quiet_cmd_syshdr = SYSHDR  $@
>                    '$(syshdr_pfx_$(basetarget))'                \
>                    '$(syshdr_offset_$(basetarget))'
>
> +quiet_cmd_sysnr = SYSNR  $@
> +      cmd_sysnr = $(CONFIG_SHELL) '$(sysnr)' '$<' '$@'         \
> +                 '$(sysnr_abis_$(basetarget))'                 \
> +                 '$(sysnr_pfx_$(basetarget))'                  \
> +                 '$(sysnr_offset_$(basetarget))'
> +

What's the purpose of adding this build rule, which is unused?

The patch works fine though.

I assume the common build rules will be moved to a common place later?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
