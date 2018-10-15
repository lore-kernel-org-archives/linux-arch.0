Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45735 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeJOLzr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Oct 2018 07:55:47 -0400
Received: by mail-yw1-f66.google.com with SMTP id v198-v6so7041982ywg.12
        for <linux-arch@vger.kernel.org>; Sun, 14 Oct 2018 21:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <1538397477-4003-1-git-send-email-firoz.khan@linaro.org>
 <1538397477-4003-4-git-send-email-firoz.khan@linaro.org> <alpine.LNX.2.21.1810020843320.10@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1810020843320.10@nippy.intranet>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Mon, 15 Oct 2018 09:42:10 +0530
Message-ID: <CALxhOnhzKeax4fC2yibSU38+7JDgA6MearVTbF=CU+4cQGakHA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] m68k: add system call table generation support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: fthain@telegraphics.com.au
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20181015041210.-gehNhHSsxjL_4rxQlmsf1V9a8CDXRkxwjEeCEbcobc@z>

Hi Finn,

On Tue, 2 Oct 2018 at 04:22, Finn Thain <fthain@telegraphics.com.au> wrote:
>
> On Mon, 1 Oct 2018, Firoz Khan wrote:
>
> > --- /dev/null
> > +++ b/arch/m68k/kernel/syscalls/syscallhdr.sh
> > @@ -0,0 +1,35 @@
> > +#!/bin/sh
>
> That's not accurate. These are bash scripts, not Bourne shell.
>
> If you run 'checkbashisms', you'll see that a few small changes are needed
> in order to gain standards compliance and portability.

Sure.

>
> Some untested suggestions:
>
> diff --git a/arch/m68k/kernel/syscalls/syscallhdr.sh b/arch/m68k/kernel/syscalls/syscallhdr.sh
> index e0e3108cfc7f..9811f82848e6 100644
> --- a/arch/m68k/kernel/syscalls/syscallhdr.sh
> +++ b/arch/m68k/kernel/syscalls/syscallhdr.sh
> @@ -18,17 +18,17 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
>      nxt=0
>      while read nr abi name entry ; do
>         if [ -z "$offset" ]; then
> -           echo -e "#define __NR_${prefix}${name}\t$nr"
> +           echo "#define __NR_${prefix}${name} $nr"
>         else
> -           echo -e "#define __NR_${prefix}${name}\t($offset + $nr)"
> +           echo "#define __NR_${prefix}${name} ($offset + $nr)"
>         fi
>         nxt=$nr
> -       let nxt=nxt+1
> +       nxt=$((nxt+1))
>      done
>
>      echo ""
>      echo "#ifdef __KERNEL__"
> -    echo -e "#define __NR_syscalls\t$nxt"
> +    echo "#define __NR_syscalls        $nxt"
>      echo "#endif"
>      echo ""
>      echo "#endif /* ${fileguard} */"
> diff --git a/arch/m68k/kernel/syscalls/syscalltbl.sh b/arch/m68k/kernel/syscalls/syscalltbl.sh
> index d2635dea4e96..89ab047097ce 100644
> --- a/arch/m68k/kernel/syscalls/syscalltbl.sh
> +++ b/arch/m68k/kernel/syscalls/syscalltbl.sh
> @@ -13,7 +13,7 @@ emit() {
>
>      while [ $nxt -lt $nr ]; do
>         echo "__SYSCALL($nxt, sys_ni_syscall, )"
> -       let nxt=nxt+1
> +       nxt=$((nxt+1))
>      done
>
>      echo "__SYSCALL($nr, $entry, )"
> @@ -29,6 +29,6 @@ grep '^[0-9]' "$in" | sort -n | (
>      while read nr abi name entry ; do
>         emit $nxt $nr $entry
>         nxt=$nr
> -        let nxt=nxt+1
> +        nxt=$((nxt+1))
>      done
>  ) > "$out"

Thanks for your comments! I'll have a look into it.

Firoz
>
> --
