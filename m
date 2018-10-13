From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v4 3/6] parisc: add system call table generation support
Date: Sat, 13 Oct 2018 21:04:34 +0530
Message-ID: <CALxhOngneZuumfn9X9nU3MSB5S7Vasm9gwXvFSw_T_hzSuuKtQ@mail.gmail.com>
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
 <1539337442-3676-4-git-send-email-firoz.khan@linaro.org> <CAK8P3a1Ua0c9H006=_m=EHUufoUX5-d-m9fZcL_sF4mMJuLhkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a1Ua0c9H006=_m=EHUufoUX5-d-m9fZcL_sF4mMJuLhkQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

+ Rolf
Hi Arnd, Helge, Rolf,

On Fri, 12 Oct 2018 at 17:21, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Oct 12, 2018 at 11:45 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> > diff --git a/arch/parisc/kernel/syscalls/Makefile b/arch/parisc/kernel/syscalls/Makefile
> > new file mode 100644
> > index 0000000..a0af5a3
> > --- /dev/null
> > +++ b/arch/parisc/kernel/syscalls/Makefile
>
> > +syshdr_abi_unistd_32 := common,32
> > +syshdr_offset_unistd_32 := __NR_Linux
> > +$(uapi)/unistd_32.h: $(syscall) $(syshdr)
> > +       $(call if_changed,syshdr)
> > +
> > +syshdr_abi_unistd_64 := common,64
> > +syshdr_offset_unistd_64 := __NR_Linux
> > +$(uapi)/unistd_64.h: $(syscall) $(syshdr)
> > +       $(call if_changed,syshdr)
>
> The __NR_Linux seems misplaced here, don't we need that only for ia64
> and mips?

No, It wasn't misplaced. you can refer below link.
https://github.com/torvalds/linux/blob/master/arch/parisc/include/uapi/asm/unistd.h#L16

FYI, In IA64, I added the __NR_Linux to come up a generic .tbl file
starts with 0 as a part
system call table generation. I think you might be applied my IA64
patches locally sometimes
before and now you might be confused.
https://github.com/torvalds/linux/blob/master/arch/ia64/include/uapi/asm/unistd.h

Yes, MIPS also uses this macro.

>
> > +systbl_abi_syscall_table_32 := common,32
> > +$(kapi)/syscall_table_32.h: $(syscall) $(systbl)
> > +       $(call if_changed,systbl)
> > +
> > +systbl_abi_syscall_table_64 := common,64
> > +$(kapi)/syscall_table_64.h: $(syscall) $(systbl)
> > +       $(call if_changed,systbl)
>
> Have you considered making the 'common' part implied?
> I expected to see it done that way, although listing it explicitly
> doesn't seem harmful either.

It can't be done in that way easily, I see some problem there existing script.

The problem you will understand by removing "common" and run the script.
You can do diff before and after the generated files.
ref: grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (

FYI, x86/arm/s390 implementation listing explicitly! So I almost followed
there way of implementation.

If you really want that way, please comment here. I need to redo the
scripting for
all 10 architecture.

>
> > +systbl_abi_syscall_table_c32 := common,compat,32
> > +$(kapi)/syscall_table_c32.h: $(syscall) $(systbl)
> > +       $(call if_changed,systbl)
>
> The way you specify 'compat' as one item in a list of
> ABIs seems rather odd, I'd suggest keeping that a separate
> flag.

Commented below.

>
> Passing "common|32" as the list of ABIs in the first argument,
> and 'compat' as the second argument.
>
> I think you can also pass arguments to 'if_changed', rather than
> setting a global variable to control it.

Sure. I'll have a look into this one!

> arch/powerpc/boot/Makefile has some examples of that.
> It should be possible to do this like
>
> $(kapi)/syscall_table_c32.h: $(syscall) $(systbl)
>        $(call if_changed,systbl,common|32,compat)

This is something interesting!
Rolf, I was trying to explain this one yesterday. Sorry, I know I
haven't composed
the mail properly.

The uapi header generation script syscall table header generation script is
invoked by this Makefile.

systbl_abi_syscall_table_32 := common,32
$(kapi)/syscall_table_32.h: $(syscall) $(systbl)
        $(call if_changed,systbl)

Here I want to generate systbl_abi_syscall_table_32, so I'll pass few
args including the .tbl file.
So script must have to identify that it is for 32. It has to read 4th
column as <32/64 entry point>
from the .tbl file.

# The format is:
# <number> <abi> <name> <32/64 entry point> <compat entry point>
5       common  open                            sys_open
         compat_sys_open

Similarly for 64 also. Same 4th column should have to read.

systbl_abi_syscall_table_c32 := common,compat,32
$(kapi)/syscall_table_c32.h: $(syscall) $(systbl)
        $(call if_changed,systbl)

But for compat interface either it has to read 5th column if present,
otherwise 4th column.
Script won't understand it is for compat unless we have to explicitly
inform from Makefile.

There are multiple way to do:

1. This implementation
systbl_abi_syscall_table_c32 := common,compat,32 /* Makefile */

my_abi="$(cut -d'|' -f2 <<< $my_abis)" /*systbl.sh */
if [ $my_abi = "compat" ]; then
            if [ -z "$compat" ]; then
                emit $nxt $nr $entry
            else
                emit $nxt $nr $compat
            fi
        else
            emit $nxt $nr $entry
        fi

2. Add extra flag in the Makefile

systbl_abi_syscall_table_c32 := common,32
systbl_xyz_syscall_table_c32 := compat
$(kapi)/syscall_table_c32.h: $(syscall) $(systbl)
        $(call if_changed,systbl)

and check from the script and identify it.
This looks the direct method. Here I think the problem is
adding one more args

3. Without Makefile change we can identify it. No need to add extra flag

Makefile
------------
systbl_abi_syscall_table_c32 := common,32
$(kapi)/syscall_table_c32.h: $(syscall) $(systbl)
        $(call if_changed,systbl)

systbl.sh
-------------
    if [ ${out: -5} = "c32.h" ]; then
            if [ -z "$compat" ]; then
                emit $nxt $nr $entry
            else
                emit $nxt $nr $compat
            fi
        elif [ ${out: -4} = "64.h" -o  ${out: -4} = "32.h" ]; then
            emit $nxt $nr $entry
        fi

Here I was asking is there any better way to do the same.

Note: The name compat in Makefile may change to c32.
Note: This implementation remain same for spark and powerpc
hopefully. But Mips has extra one more interface. We need to consider
that also here.

>
> > diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> > new file mode 100644
> > index 0000000..7c9f268
> > --- /dev/null
> > +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> ...
> > +346     common  copy_file_range                 sys_copy_file_range
> > +347     common  preadv2                         sys_preadv2                     compat_sys_preadv2
> > +348     common  pwritev2                        sys_pwritev2                    compat_sys_pwritev2
> > +349     common  statx                           sys_statx
> > +350    common  io_pgetevents                   sys_io_pgetevents               compat_sys_io_pgetevents
> > \ No newline at end of file
>
> Here is the missing newline again. This should never happen if your text
> editor is configured correctly.
>
> > diff --git a/arch/parisc/kernel/syscalls/syscallhdr.sh b/arch/parisc/kernel/syscalls/syscallhdr.sh
> > new file mode 100644
> > index 0000000..607d4ca
> > --- /dev/null
> > +++ b/arch/parisc/kernel/syscalls/syscallhdr.sh
> > @@ -0,0 +1,35 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
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
>
> Maybe use ${ARCH} instead of PARISC here to keep it the same
> across architectures?

Sure. FYI, x86/arm/s390 has the above implementation,

>
> > +    my_abi="$(cut -d'|' -f2 <<< $my_abis)"
> > +    while read nr abi name entry compat ; do
> > +       if [ $my_abi = "compat" ]; then
>
> This check seems really fragile, but if you add another argument to the
> script instead of listing "compat" as the second option in the
> list of ABIs, I think it's fine.

Hmm. Please share ur comment in the above for the same.

Thanks
Firoz

>
>         ARnd
