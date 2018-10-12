From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v4 3/6] parisc: add system call table generation support
Date: Fri, 12 Oct 2018 19:27:22 +0530
Message-ID: <CALxhOnggUEkXVVupq0SebJV0StKqbTTCqQtaaao+oQveUFHgbg@mail.gmail.com>
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
 <1539337442-3676-4-git-send-email-firoz.khan@linaro.org> <c6280818c999449646ec216984f2df9e@sf-tec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c6280818c999449646ec216984f2df9e@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
To: eike-kernel@sf-tec.de
Cc: linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, linux-parisc-owner@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi Arnd, Rolf,

Thanks for the comments. It will help me to fine tune my scripts!

On Fri, 12 Oct 2018 at 17:37, Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
>
> Firoz Khan wrote:
>
> > diff --git a/arch/parisc/kernel/syscalls/syscallhdr.sh
> > b/arch/parisc/kernel/syscalls/syscallhdr.sh
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
>
> Any reason not to use $() instead of backticks?
>
> > +prefix="$4"
> > +offset="$5"
> > +
> > +fileguard=_UAPI_ASM_PARISC_`basename "$out" | sed \
> > +    -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
> > +    -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
> > +grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> > +    echo "#ifndef ${fileguard}"
> > +    echo "#define ${fileguard}"
> > +    echo ""
> > +
> > +    nxt=0
> > +    while read nr abi name entry compat ; do
> > +     if [ -z "$offset" ]; then
> > +         echo -e "#define __NR_${prefix}${name}\t$nr"
>
> This mixed indentation with both tabs and spaces is a bit messy.
>
> > +     else
> > +         echo -e "#define __NR_${prefix}${name}\t($offset + $nr)"
> > +     fi
> > +     nxt=$nr
> > +     let nxt=nxt+1
>
> Why do you use let here when you do $(()) calculations at other places?
>
> > +    done
> > +
> > +    echo ""
> > +    echo "#ifdef __KERNEL__"
> > +    echo -e "#define __NR_syscalls\t$nxt"
> > +    echo "#endif"
> > +    echo ""
> > +    echo "#endif /* ${fileguard} */"
> > +) > "$out"
> > diff --git a/arch/parisc/kernel/syscalls/syscalltbl.sh
> > b/arch/parisc/kernel/syscalls/syscalltbl.sh
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
>
> This could be one line, no? Or just set offset to 0 if it is empty and
> avoid that if alltogether.
>
> > +    fi
> > +    entry="$3"
> > +
> > +    while [ $nxt -lt $nr ]; do
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
>
> Another argument for offset=0 as default.
>
> > +
> > +    my_abi="$(cut -d'|' -f2 <<< $my_abis)"

Here is the logic of identifying the generated script is for compat interface
or not. So systbl_abi_syscall_table_c32 := common,compat,32 in Makefile
will parse the script and check the second string whether this is
"compat" or not.

Other ways are:
1. add an extra flag, that will again add the complexity
2. check if [ ${out: -5} = "c32.h" ], this looks weird

Is there any better way to do the same?

>
> "<<<" is a bash extension and will not work with /bin/sh.
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
>
> I would go for a local variable being set to $compat or $entry and
> calling emit at only one place. And there should be only one if with 2
> expressions, no need for 3 branches.
>
> > +        let nxt=nxt+1
>
> Inconsistent indentation.
>
> > +    done
> > +) > "$out"

I'll address rest of the comment soon.

Helge, I can update this patches asap with their comments and we can
perform the
boot test with next version. And thanks for your great support!

Firoz

>
> Eike
