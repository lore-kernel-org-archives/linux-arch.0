From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] scripts: unify system call table generation scripts
Date: Thu, 3 Jan 2019 12:34:25 +0100
Message-ID: <CAMuHMdUS5rSmPaA75JEc-D0CKH5DkX6dfzu8n0CYy5O_JVAycg@mail.gmail.com>
References: <1546439331-18646-1-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546439331-18646-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Paul Burton <paul.burton@mips.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, marcin.juszkiewicz@linaro.org
List-Id: linux-arch.vger.kernel.org

Hi Firoz,

Thanks for your patch!

On Wed, Jan 2, 2019 at 3:30 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> System call table generation support is provided for
> alpha, ia64, m68k, microblaze, mips, parisc, powerpc,
> sh, sparc and xtensa architectures. The implementat-
> ions are almost similar across all the above archte-
> ctures.

architectures

>
> In order to reduce the source code across all the
> above architectures, create common ".sh" files and
> keep it in the common directory, script/.
>
> This will be a generic scripts which can use for all

be generic scripts which can be used for all of

> the above architectures.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> ---
>  scripts/syscallhdr.sh | 37 +++++++++++++++++++++++++++++++++++++
>  scripts/syscallnr.sh  | 32 ++++++++++++++++++++++++++++++++
>  scripts/syscalltbl.sh | 37 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 106 insertions(+)
>  create mode 100644 scripts/syscallhdr.sh
>  create mode 100644 scripts/syscallnr.sh
>  create mode 100644 scripts/syscalltbl.sh
>
> diff --git a/scripts/syscallhdr.sh b/scripts/syscallhdr.sh
> new file mode 100644
> index 0000000..d03fe3d
> --- /dev/null
> +++ b/scripts/syscallhdr.sh
> @@ -0,0 +1,37 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +in="$1"
> +out="$2"
> +my_abis=`echo "($3)" | tr ',' '|'`
> +prefix="$4"
> +offset="$5"
> +
> +fileguard=_UAPI_ASM_`basename "$out" | sed \

Currently, all but MIPS have the architecture name included in
the file guard.  Shouldn't that be retained?

> +       -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
> +       -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
> +grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> +       printf "#ifndef %s\n" "${fileguard}"
> +       printf "#define %s\n" "${fileguard}"
> +       printf "\n"
> +
> +       nxt=0
> +       while read nr abi name entry compat ; do
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
> +       printf "\n"

I think this "\n" should be integrated into the previous printf,
as it terminates the previous output line.

> +) > "$out"
> diff --git a/scripts/syscallnr.sh b/scripts/syscallnr.sh
> new file mode 100644
> index 0000000..8cf33fa
> --- /dev/null
> +++ b/scripts/syscallnr.sh
> @@ -0,0 +1,32 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +in="$1"
> +out="$2"
> +my_abis=`echo "($3)" | tr ',' '|'`
> +prefix="$4"
> +offset="$5"
> +
> +fileguard=_UAPI_ASM_`basename "$out" | sed \

Don't you want the architecture name in the file guard here, too?

> +       -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
> +       -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
> +grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> +       printf "#ifndef %s\n" "${fileguard}"
> +       printf "#define %s\n" "${fileguard}"
> +       printf "\n"
> +
> +       nxt=0
> +       while read nr abi name entry compat ; do
> +               nxt=$((nr+1))
> +       done
> +
> +       if [ ! -z "$prefix" ]; then
> +               printf "#define __NR_%s_Linux_syscalls\t%s\n" "${prefix}" "${nxt}"
> +               if [ ! -z "$offset" ]; then
> +                       printf "#define __NR_%s_Linux\t%s\n" "${prefix}" "${offset}"
> +               fi
> +       fi
> +       printf "\n"
> +       printf "#endif /* %s */" "${fileguard}"
> +       printf "\n"
> +) > "$out"
> diff --git a/scripts/syscalltbl.sh b/scripts/syscalltbl.sh
> new file mode 100644
> index 0000000..f60f762
> --- /dev/null
> +++ b/scripts/syscalltbl.sh
> @@ -0,0 +1,37 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +in="$1"
> +out="$2"
> +my_abis=`echo "($3)" | tr ',' '|'`
> +my_abi="$4"
> +offset="$5"
> +
> +emit() {
> +       t_nxt="$1"
> +       t_nr="$2"
> +       t_entry="$3"
> +
> +       while [ $t_nxt -lt $t_nr ]; do
> +               printf "__SYSCALL(%s,sys_ni_syscall)\n" "${t_nxt}"

Please add a space after the comma.

> +               t_nxt=$((t_nxt+1))
> +       done
> +       printf "__SYSCALL(%s,%s)\n" "${t_nxt}" "${t_entry}"

Idem ditto.


> +}
> +
> +grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> +       nxt=0
> +       if [ -z "$offset" ]; then
> +               offset=0
> +       fi
> +
> +       while read nr abi name entry compat ; do
> +               if [ "$my_abi" = "c32" -o "$my_abi" = "64_o32" ] &&
> +                       [ ! -z "$compat" ]; then
> +                       emit $((nxt+offset)) $((nr+offset)) $compat
> +               else
> +                       emit $((nxt+offset)) $((nr+offset)) $entry
> +               fi
> +               nxt=$((nr+1))
> +       done
> +) > "$out"
> --
> 1.9.1
>


--
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
