Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f196.google.com ([209.85.166.196]:39190 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbeKFNoh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Nov 2018 08:44:37 -0500
Received: by mail-it1-f196.google.com with SMTP id m15so15938089itl.4
        for <linux-arch@vger.kernel.org>; Mon, 05 Nov 2018 20:21:23 -0800 (PST)
MIME-Version: 1.0
References: <1541080581-4072-1-git-send-email-firoz.khan@linaro.org>
 <1541080581-4072-5-git-send-email-firoz.khan@linaro.org> <CAMo8BfKaSUTMT0h2jRg2ysRnc2yvVT-3=-gq6pH-XpKm1iydQQ@mail.gmail.com>
In-Reply-To: <CAMo8BfKaSUTMT0h2jRg2ysRnc2yvVT-3=-gq6pH-XpKm1iydQQ@mail.gmail.com>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Tue, 6 Nov 2018 09:51:11 +0530
Message-ID: <CALxhOnh3RQNw7zArOpsBqOi82_JpTP1pG9tDmrp1PyRER8eGzg@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] xtensa: generate uapi header and syscall table
 header files
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20181106042111.OzTaH_xMxeY2EzKFn3fnRWnto81oPF1L6xw6qWdeRUw@z>

Hi Max,

On Tue, 6 Nov 2018 at 03:14, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> On Thu, Nov 1, 2018 at 6:57 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> >
> > System call table generation script must be run to gener-
> > ate unistd_32.h and syscall_table.h files. This patch will
> > have changes which will invokes the script.
> >
> > This patch will generate unistd_32.h and syscall_table.h
> > files by the syscall table generation script invoked by
> > xtensa/Makefile and the generated files against the removed
> > files must be identical.
> >
> > The generated uapi header file will be included in uapi/-
> > asm/unistd.h and generated system call table header file
> > will be included by kernel/syscall.c file.
> >
> > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> > ---
> >  arch/xtensa/Makefile                  |   3 +
> >  arch/xtensa/include/asm/Kbuild        |   1 +
> >  arch/xtensa/include/uapi/asm/Kbuild   |   1 +
> >  arch/xtensa/include/uapi/asm/unistd.h | 782 +---------------------------------
> >  arch/xtensa/kernel/syscall.c          |   5 +-
> >  5 files changed, 10 insertions(+), 782 deletions(-)
> >
> > diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
> > index d67e30fa..1e7b179 100644
> > --- a/arch/xtensa/Makefile
> > +++ b/arch/xtensa/Makefile
> > @@ -99,6 +99,9 @@ all Image zImage uImage: vmlinux
> >  dtbs: scripts
> >         $(Q)$(MAKE) $(build)=$(boot)/dts
> >
> > +archheaders:
> > +       $(Q)$(MAKE) $(build)=arch/xtensa/kernel/syscalls all
> > +
> >  define archhelp
> >    @echo '* Image       - Kernel ELF image with reset vector'
> >    @echo '* zImage      - Compressed kernel image (arch/xtensa/boot/images/zImage.*)'
> > diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
> > index 82c75643..b35d2e6 100644
> > --- a/arch/xtensa/include/asm/Kbuild
> > +++ b/arch/xtensa/include/asm/Kbuild
> > @@ -28,3 +28,4 @@ generic-y += topology.h
> >  generic-y += trace_clock.h
> >  generic-y += word-at-a-time.h
> >  generic-y += xor.h
> > +generic-y += syscall_table.h
>
> This doesn't look right: syscall_table.h is not asm-generic header.

If I remove Kbuild entries, the generated file get removed in build time.

SYSTBL  arch/xtensa/include/generated/asm/syscall_table.h
SYSHDR  arch/xtensa/include/generated/uapi/asm/unistd_32.h
REMOVE  arch/xtensa/include/generated/uapi/asm/unistd_32.h
REMOVE  arch/xtensa/include/generated/asm/syscall_table.h

Firoz

>
> > diff --git a/arch/xtensa/include/uapi/asm/Kbuild b/arch/xtensa/include/uapi/asm/Kbuild
> > index 837d4dd..f826d52 100644
> > --- a/arch/xtensa/include/uapi/asm/Kbuild
> > +++ b/arch/xtensa/include/uapi/asm/Kbuild
> > @@ -11,3 +11,4 @@ generic-y += resource.h
> >  generic-y += siginfo.h
> >  generic-y += statfs.h
> >  generic-y += termios.h
> > +generic-y += unistd_32.h
>
> Ditto: unistd32_.h is not asm-generic header.
>
> --
> Thanks.
> -- Max
