Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:37054 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757067AbaCTPUj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 20 Mar 2014 11:20:39 -0400
MIME-Version: 1.0
In-Reply-To: <20140320145128.GE4403@osiris>
References: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
	<1394121083-2507-2-git-send-email-heiko.carstens@de.ibm.com>
	<CAMuHMdUqjhcmaRo-2=qr_DgbXoj9bAGfvzuRPDZ+tOMx6Hvr-Q@mail.gmail.com>
	<20140320113333.GD4403@osiris>
	<20140320145128.GE4403@osiris>
Date: Thu, 20 Mar 2014 16:20:38 +0100
Message-ID: <CAMuHMdU32mPcaKKup1XVw0zDijAMWr-QCFVB=8sf46usnjX+Gw@mail.gmail.com>
Subject: Re: [PATCH/RFC 01/16] compat: let architectures define __ARCH_WANT_COMPAT_SYS_GETDENTS64
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Linux-Arch <linux-arch@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Linux-Next <linux-next@vger.kernel.org>, Chris Metcalf <cmetcalf@tilera.com>
Message-ID: <20140320152038.-B92n-KYVoxb5arnUzyhnp0L5iYKW_UGbwpY1yuyC9s@z>

Hi Heiko,

On Thu, Mar 20, 2014 at 3:51 PM, Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
> I think the simple patch below should fix the compile error.

Thanks!

> Unfortunately I don't have a tile cross compiler.

Unfortunately https://www.kernel.org/pub/tools/crosstool/ doesn't have
one for s390 hosts, only for ia32 and amd64.

> linux/compat.h does not include linux/unistd.h but the compat.h header
> file contains various conditional
>
>  #ifdef __ARCH_WANT_COMPAT_...
>  asmlinkage long compat...()
>  #endif
>
> compat system call function declarations.
> If linux/unistd.h isn't included it depends on previous includes if those
> __ARCH_WANT_COMPAT_... defines are defined or not. So add an additional
> linux/unistd.h include.
>
> Should fix this compile error on tile:
>
> include/uapi/asm-generic/unistd.h:195:1: error: 'compat_sys_getdents64' undeclared
> make[3]: *** [arch/tile/kernel/compat.o] Error 1
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
