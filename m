Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35321 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbfACWou (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Jan 2019 17:44:50 -0500
MIME-Version: 1.0
References: <1546442912-20818-1-git-send-email-firoz.khan@linaro.org> <1546442912-20818-3-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1546442912-20818-3-git-send-email-firoz.khan@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 3 Jan 2019 14:44:37 -0800
Message-ID: <CAMo8Bf+qK=k33boeNOeL69sLC3e-M07QK9ErhYm-byuQ2UnVnw@mail.gmail.com>
Subject: Re: [PATCH 2/2] xtensa: generate uapi header and syscall table header files
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Chris Zankel <chris@zankel.net>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-xtensa@linux-xtensa.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038@lists.linaro.org, LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, marcin.juszkiewicz@linaro.org
Message-ID: <20190103224437._6qJqOGET7VqVDMcZLSOSDSH7doE-qa8qMfMy-GGKcQ@z>

Hi Firoz,

On Wed, Jan 2, 2019 at 7:29 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> Unified system call table generation script must be run to
> generate unistd_32.h and syscall_table.h files. This patch
> will have changes which will invokes the script.
>
> This patch will generate unistd_32.h and syscall_table.h
> files by the syscall table generation script invoked by
> xtensa/Makefile and the generated files against the removed
> files must be identical.
>
> The generated uapi header file will be included in uapi/-
> asm/unistd.h and generated system call table header file
> will be included by kernel/syscall.c file.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> ---
>  arch/xtensa/kernel/syscalls/Makefile      | 11 ++++++++--
>  arch/xtensa/kernel/syscalls/syscallhdr.sh | 36 -------------------------------
>  arch/xtensa/kernel/syscalls/syscalltbl.sh | 32 ---------------------------
>  3 files changed, 9 insertions(+), 70 deletions(-)
>  delete mode 100644 arch/xtensa/kernel/syscalls/syscallhdr.sh
>  delete mode 100644 arch/xtensa/kernel/syscalls/syscalltbl.sh
>
> diff --git a/arch/xtensa/kernel/syscalls/Makefile b/arch/xtensa/kernel/syscalls/Makefile
> index 659faef..75c7421 100644
> --- a/arch/xtensa/kernel/syscalls/Makefile
> +++ b/arch/xtensa/kernel/syscalls/Makefile
> @@ -6,8 +6,9 @@ _dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')       \
>           $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
>
>  syscall := $(srctree)/$(src)/syscall.tbl
> -syshdr := $(srctree)/$(src)/syscallhdr.sh
> -systbl := $(srctree)/$(src)/syscalltbl.sh
> +syshdr := $(srctree)/scripts/syscallhdr.sh
> +sysnr := $(srctree)/scripts/syscallnr.sh
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

This patch seems to do more than it says in the description.
Perhaps adding cmd_sysnr needs a separate patch with its
own description?

-- 
Thanks.
-- Max
