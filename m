From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v4 3/6] parisc: add system call table generation support
Date: Mon, 15 Oct 2018 10:42:27 +0530
Message-ID: <CALxhOnhLQooctntdD69BsSmwzsx692QbMmHVTcemKFHr2a1SPQ@mail.gmail.com>
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
 <1539337442-3676-4-git-send-email-firoz.khan@linaro.org> <20181014010658.GB717@asgard.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181014010658.GB717@asgard.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: esyr@redhat.com
Cc: linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Eugene,

On Sun, 14 Oct 2018 at 06:36, Eugene Syromiatnikov <esyr@redhat.com> wrote:
>
> On Fri, Oct 12, 2018 at 03:13:59PM +0530, Firoz Khan wrote:
> > diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> > new file mode 100644
> > index 0000000..7c9f268
>
> > +86      common  uselib                          sys_ni_syscall
>
> Again, why is this definition left, while others have been removed?

The system call generation script will generate new uapi and syscall
table files and replace the existed one. We'll make sure the generated
file against replaced one will be identical.

uselib is declared in uapi header:
https://github.com/torvalds/linux/blob/master/arch/parisc/include/uapi/asm/unistd.h#L103
So I have to make sure this entry is present in the generated uapi header.

>
> > +348     common  pwritev2                        sys_pwritev2                    compat_sys_pwritev2
> > +349     common  statx                           sys_statx
> > +350  common  io_pgetevents                   sys_io_pgetevents               compat_sys_io_pgetevents
>
> Tab instead of spaces.

I'm using emacs editor with default settings. In the actual file, there is no
indentation problem which I find but if I get patch using git format-patch,
it has inconsistent indentation.

No idea. I could find the same problem in other patches also.
Let me use the vi editor to save the file and get the patch.

>
> > diff --git a/arch/parisc/kernel/syscalls/syscallhdr.sh b/arch/parisc/kernel/syscalls/syscallhdr.sh
> > new file mode 100644
> > index 0000000..607d4ca
> > --- /dev/null
> > +++ b/arch/parisc/kernel/syscalls/syscallhdr.sh
> > @@ -0,0 +1,35 @@
> > +#!/bin/sh
>
> /bin/sh -efu
>
> > +# SPDX-License-Identifier: GPL-2.0
>
> "export LANG=C", due to usage of sed/grep/sort.

I got this frame work from x86/entry/syscalls;
https://github.com/torvalds/linux/blob/master/arch/x86/entry/syscalls/syscallhdr.sh
I haven't modified the script but I tune this script to meet my requirements.

Sure, I'll look into this.

>
> > +
> > +in="$1"
> > +out="$2"
> > +my_abis=`echo "($3)" | tr ',' '|'`
> > +prefix="$4"
> > +offset="$5"
> > +
> > +fileguard=_UAPI_ASM_PARISC_`basename "$out" | sed \
> > +    -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
> > +    -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
> > +grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
>
> grep -E '^[[:xdigit:]Xx]+[[:space:]]+'"${my_abis}" "$in"
> sort -n -k1,1
>
> > +    echo "#ifndef ${fileguard}"
> > +    echo "#define ${fileguard}"
> > +    echo ""
>
>         cat <<-EOF
>                 #ifndef ${fileguard}
>                 #define ${fileguard}
>
>         EOF
>
> > +
> > +    nxt=0
> > +    while read nr abi name entry compat ; do
> > +     if [ -z "$offset" ]; then
> > +         echo -e "#define __NR_${prefix}${name}\t$nr"
> > +     else
> > +         echo -e "#define __NR_${prefix}${name}\t($offset + $nr)"
> > +     fi
>
> echo options are not portable; something like
>
>         printf "#define __NR_%s%s\t(%s + %s)" "${prefix}" "${name}" "${offset}" "${nr}"

x86/armhas similar echo implementation.
https://github.com/torvalds/linux/blob/master/arch/arm/tools/syscallhdr.sh

s390 has this printf implemenation.
https://github.com/torvalds/linux/blob/master/arch/s390/kernel/syscalls/syscalltbl

I chose echo one. but it is easy to change to printf :)

>
> > +     nxt=$nr
> > +     let nxt=nxt+1
>
> "let" is a bash extension, posix-conformant expression would be
>
>         nxt=$((nr + 1))
>
> (I would also check that nr >= nxt, however)

Sure.

>
> > +    done
> > +
> > +    echo ""
> > +    echo "#ifdef __KERNEL__"
> > +    echo -e "#define __NR_syscalls\t$nxt"
> > +    echo "#endif"
> > +    echo ""
> > +    echo "#endif /* ${fileguard} */"
>
>         cat <<-EOF
>
>                 #ifdef __KERNEL__
>                 # define __NR_syscalls\t${nxt}
>                 #endif
>
>                 #endif /* ${fileguard} */
>         EOF
>
> > +) > "$out"
> > diff --git a/arch/parisc/kernel/syscalls/syscalltbl.sh b/arch/parisc/kernel/syscalls/syscalltbl.sh
> > new file mode 100644
> > index 0000000..04abde7
> > --- /dev/null
> > +++ b/arch/parisc/kernel/syscalls/syscalltbl.sh
> > @@ -0,0 +1,46 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +in="$1"
> > +out="$2"
> > +my_abis=`echo "($3)" | tr ',' '|'`
> > +offset="$4"
> > +
> > +emit() {
> > +    nxt="$1"
> > +    if [ -z "$offset" ]; then
> > +     nr="$2"
> > +    else
> > +     nr="$2"
> > +     nr=$((nr+offset))
> > +    fi
> > +    entry="$3"
> > +
> > +    while [ $nxt -lt $nr ]; do
>
> It would break nicely if nxt="-n x -o 1" or something like that.
>
> > +     echo "__SYSCALL($nxt, sys_ni_syscall, )"
> > +        let nxt=nxt+1
> > +    done
> > +    echo "__SYSCALL($nxt, $entry, )"
> > +}
> > +
> > +grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> > +    if [ -z "$offset" ]; then
> > +     nxt=0
> > +    else
> > +     nxt=$offset
> > +    fi
> > +
> > +    my_abi="$(cut -d'|' -f2 <<< $my_abis)"
>
>         my_abi="${my_abis#*|}"
>
> But it looks like that $my_abis includes parentheses and this code
> is broken.

I may planned to have some different implementation for the same.

>
> > +    while read nr abi name entry compat ; do
> > +     if [ $my_abi = "compat" ]; then
> > +         if [ -z "$compat" ]; then
> > +             emit $nxt $nr $entry
> > +         else
> > +             emit $nxt $nr $compat
> > +         fi
> > +     else
> > +         emit $nxt $nr $entry
> > +     fi
> > +        let nxt=nxt+1
> > +    done
> > +) > "$out"

Thanks
Firoz

> > --
> > 1.9.1
> >
