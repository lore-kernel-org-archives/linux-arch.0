From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 3/6] parisc: add system call table generation support
Date: Fri, 12 Oct 2018 13:51:04 +0200
Message-ID: <CAK8P3a1Ua0c9H006=_m=EHUufoUX5-d-m9fZcL_sF4mMJuLhkQ@mail.gmail.com>
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org> <1539337442-3676-4-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539337442-3676-4-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Parisc List <linux-parisc@vger.kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Oct 12, 2018 at 11:45 AM Firoz Khan <firoz.khan@linaro.org> wrote:

> diff --git a/arch/parisc/kernel/syscalls/Makefile b/arch/parisc/kernel/syscalls/Makefile
> new file mode 100644
> index 0000000..a0af5a3
> --- /dev/null
> +++ b/arch/parisc/kernel/syscalls/Makefile

> +syshdr_abi_unistd_32 := common,32
> +syshdr_offset_unistd_32 := __NR_Linux
> +$(uapi)/unistd_32.h: $(syscall) $(syshdr)
> +       $(call if_changed,syshdr)
> +
> +syshdr_abi_unistd_64 := common,64
> +syshdr_offset_unistd_64 := __NR_Linux
> +$(uapi)/unistd_64.h: $(syscall) $(syshdr)
> +       $(call if_changed,syshdr)

The __NR_Linux seems misplaced here, don't we need that only for ia64
and mips?

> +systbl_abi_syscall_table_32 := common,32
> +$(kapi)/syscall_table_32.h: $(syscall) $(systbl)
> +       $(call if_changed,systbl)
> +
> +systbl_abi_syscall_table_64 := common,64
> +$(kapi)/syscall_table_64.h: $(syscall) $(systbl)
> +       $(call if_changed,systbl)

Have you considered making the 'common' part implied?
I expected to see it done that way, although listing it explicitly
doesn't seem harmful either.

> +systbl_abi_syscall_table_c32 := common,compat,32
> +$(kapi)/syscall_table_c32.h: $(syscall) $(systbl)
> +       $(call if_changed,systbl)

The way you specify 'compat' as one item in a list of
ABIs seems rather odd, I'd suggest keeping that a separate
flag.

I think you can also pass arguments to 'if_changed', rather than
setting a global variable to control it.
arch/powerpc/boot/Makefile has some examples of that.
It should be possible to do this like

$(kapi)/syscall_table_c32.h: $(syscall) $(systbl)
       $(call if_changed,systbl,common|32,compat)

Passing "common|32" as the list of ABIs in the first argument,
and 'compat' as the second argument.

> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> new file mode 100644
> index 0000000..7c9f268
> --- /dev/null
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
...
> +346     common  copy_file_range                 sys_copy_file_range
> +347     common  preadv2                         sys_preadv2                     compat_sys_preadv2
> +348     common  pwritev2                        sys_pwritev2                    compat_sys_pwritev2
> +349     common  statx                           sys_statx
> +350    common  io_pgetevents                   sys_io_pgetevents               compat_sys_io_pgetevents
> \ No newline at end of file

Here is the missing newline again. This should never happen if your text
editor is configured correctly.

> diff --git a/arch/parisc/kernel/syscalls/syscallhdr.sh b/arch/parisc/kernel/syscalls/syscallhdr.sh
> new file mode 100644
> index 0000000..607d4ca
> --- /dev/null
> +++ b/arch/parisc/kernel/syscalls/syscallhdr.sh
> @@ -0,0 +1,35 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +in="$1"
> +out="$2"
> +my_abis=`echo "($3)" | tr ',' '|'`
> +prefix="$4"
> +offset="$5"
> +
> +fileguard=_UAPI_ASM_PARISC_`basename "$out" | sed \
> +    -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
> +    -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`

Maybe use ${ARCH} instead of PARISC here to keep it the same
across architectures?

> +    my_abi="$(cut -d'|' -f2 <<< $my_abis)"
> +    while read nr abi name entry compat ; do
> +       if [ $my_abi = "compat" ]; then

This check seems really fragile, but if you add another argument to the
script instead of listing "compat" as the second option in the
list of ABIs, I think it's fine.

        ARnd
