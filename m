From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 1/5] kbuild: thin archives final link close
 --whole-archives option
Date: Mon, 19 Jun 2017 15:16:17 +0900
Message-ID: <CAK7LNASxuE-6eMk+Y-vyrMfibtYoD2JkjNS2z8QF85x9NdiiaA@mail.gmail.com>
References: <20170609052417.561-1-npiggin@gmail.com> <20170609052417.561-2-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-06.nifty.com ([210.131.2.91]:31174 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbdFSGQW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Jun 2017 02:16:22 -0400
In-Reply-To: <20170609052417.561-2-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>

Hi Nicholas,


2017-06-09 14:24 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
> Close the --whole-archives option with --no-whole-archive. Some
> architectures end up including additional .o and files multiple
> times after this, and they get duplicate symbols when they are
> brought under the --whole-archives option.

Which architectures have additional files after --no-whole-archive ?

I see this case only for ARCH = "um" in vmlinux_link()
where it adds some -l* options after --no-whole-archive.

I think it is good to close the --whole-archives everywhere.
So, the code looks OK to me, but I just wondered about the log.


> This matches more closely with the incremental final link.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  scripts/link-vmlinux.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index c80291319cb2..2a062ea130b5 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -63,7 +63,7 @@ modpost_link()
>         local objects
>
>         if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
> -               objects="--whole-archive built-in.o"
> +               objects="--whole-archive built-in.o --no-whole-archive"
>         else
>                 objects="${KBUILD_VMLINUX_INIT}                         \
>                         --start-group                                   \
> @@ -83,7 +83,7 @@ vmlinux_link()
>
>         if [ "${SRCARCH}" != "um" ]; then
>                 if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
> -                       objects="--whole-archive built-in.o ${1}"
> +                       objects="--whole-archive built-in.o ${1} --no-whole-archive"
>                 else
>                         objects="${KBUILD_VMLINUX_INIT}                 \
>                                 --start-group                           \
> @@ -96,7 +96,7 @@ vmlinux_link()
>                         -T ${lds} ${objects}
>         else
>                 if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
> -                       objects="-Wl,--whole-archive built-in.o ${1}"
> +                       objects="-Wl,--whole-archive built-in.o ${1} -Wl,--no-whole-archive"
>                 else
>                         objects="${KBUILD_VMLINUX_INIT}                 \
>                                 -Wl,--start-group                       \







-- 
Best Regards
Masahiro Yamada
