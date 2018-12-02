From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v5 2/3] m68k: add system call table generation support
Date: Sun, 2 Dec 2018 14:56:52 +0100
Message-ID: <CAMuHMdVsBwL9vcqejfc47GN793wMXdQ=SwEsSUP1fbpMt-OoWw@mail.gmail.com>
References: <1542088829-19790-1-git-send-email-firoz.khan@linaro.org> <1542088829-19790-3-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542088829-19790-3-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: firoz.khan@linaro.org
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, Greg KH <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, marcin.juszkiewicz@linaro.org
List-Id: linux-arch.vger.kernel.org

Hi Firoz,

On Tue, Nov 13, 2018 at 7:01 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> The system call tables are in different format in all
> architecture and it will be difficult to manually add,
> modify or delete the syscall table entries in the res-
> pective files. To make it easy by keeping a script and
> which will generate the uapi header and syscall table
> file. This change will also help to unify the implemen-
> tation across all architectures.
>
> The system call table generation script is added in
> kernel/syscalls directory which contain the scripts to
> generate both uapi header file and system call table
> files. The syscall.tbl will be input for the scripts.
>
> syscall.tbl contains the list of available system calls
> along with system call number and corresponding entry
> point. Add a new system call in this architecture will
> be possible by adding new entry in the syscall.tbl file.
>
> Adding a new table entry consisting of:
>         - System call number.
>         - ABI.
>         - System call name.
>         - Entry point name.
>
> syscallhdr.sh and syscalltbl.sh will generate uapi header
> unistd_32.h and syscall_table.h files respectively. Both
> .sh files will parse the content syscall.tbl to generate
> the header and table files. unistd_32.h will be included
> by uapi/asm/unistd.h and syscall_table.h is included by
> kernel/syscall_table.S - the real system call table.
>
> ARM, s390 and x86 architecuture does have similar support.
> I leverage their implementation to come up with a generic
> solution.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/m68k/kernel/syscalls/syscallhdr.sh
> @@ -0,0 +1,36 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +in="$1"
> +out="$2"
> +my_abis=`echo "($3)" | tr ',' '|'`
> +prefix="$4"
> +offset="$5"
> +
> +fileguard=_UAPI_ASM_M68K_`basename "$out" | sed \
> +       -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
> +       -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
> +grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> +       printf "#ifndef %s\n" "${fileguard}"
> +       printf "#define %s\n" "${fileguard}"
> +       printf "\n"
> +
> +       nxt=0
> +       while read nr abi name entry ; do
> +               if [ -z "$offset" ]; then
> +                       printf "#define __NR_%s%s\t%s\n" \
> +                               "${prefix}" "${name}" "${nr}"
> +               else
> +                       printf "#define __NR_%s%s\t(%s + %s)\n" \
> +                               "${prefix}" "${name}" "${offset}" "${nr}"
> +               fi
> +               nxt=$((nr+1))
> +       done
> +
> +       printf "\n"
> +       printf "#ifdef __KERNEL__\n"
> +       printf "#define __NR_syscalls\t%s\n" "${nxt}"
> +       printf "#endif\n"
> +       printf "\n"
> +       printf "#endif /* %s */" "${fileguard}"

The above line is lacking a "\n", causing:

    ./arch/m68k/include/generated/uapi/asm/unistd_32.h:370:42:
warning: no newline at end of file

Changing it to:

    printf "#endif /* %s */\n" "${fileguard}"

fixes this.

Interestingly, this issue seems to be present on powerpc, parisc, sparc,
sh, xtensa (and probably more, I gave up looking), too?

Apart from that, it seems to work fine on m68k.

> +) > "$out"

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
