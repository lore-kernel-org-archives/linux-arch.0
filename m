Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io1-f68.google.com ([209.85.166.68]:37856 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730122AbfACMA6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Jan 2019 07:00:58 -0500
Received: by mail-io1-f68.google.com with SMTP id g8so15473832iok.4
        for <linux-arch@vger.kernel.org>; Thu, 03 Jan 2019 04:00:57 -0800 (PST)
MIME-Version: 1.0
References: <1546442319-20461-1-git-send-email-firoz.khan@linaro.org>
 <1546442319-20461-3-git-send-email-firoz.khan@linaro.org> <CAMuHMdUT3B2JLkijM5Ofd3TUYa8TZJaj1NWaEJvU_19B-naF-w@mail.gmail.com>
In-Reply-To: <CAMuHMdUT3B2JLkijM5Ofd3TUYa8TZJaj1NWaEJvU_19B-naF-w@mail.gmail.com>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Thu, 3 Jan 2019 17:30:46 +0530
Message-ID: <CALxhOnhhHy2ztRiCn4400UweHU_+O_t2Wf5862Rc_Dyh3NtNPQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] m68k: generate uapi header and syscall table header files
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20190103120046.67zuJMGTxXIAbX7h4w_mB_QtVFKX-erYMi2neW6VrUw@z>

Hi Geert,

Thanks for your feedback!

On Thu, 3 Jan 2019 at 17:13, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > The generated uapi header file will be included in uapi/-
> > asm/unistd.h and generated system call table header file
> > will be included by kernel/syscalltable.S file.
>
> This doesn't really describe what this patch is doing.
> This patch switches m68k over to use the common scripts for
> system call header file generation.

Sure. I'll compose new commit message.

> >  syscall := $(srctree)/$(src)/syscall.tbl
> > -syshdr := $(srctree)/$(src)/syscallhdr.sh
> > -systbl := $(srctree)/$(src)/syscalltbl.sh
> > +syshdr := $(srctree)/scripts/syscallhdr.sh
> > +sysnr := $(srctree)/scripts/syscallnr.sh
>
> What's the purpose of adding sysnr?

Yes. This is not really required here. I planned to change the
implementation in some other way, but didn't looks perfect and
this was left here unnoticed.

> >
> > +quiet_cmd_sysnr = SYSNR  $@
> > +      cmd_sysnr = $(CONFIG_SHELL) '$(sysnr)' '$<' '$@'         \
> > +                 '$(sysnr_abis_$(basetarget))'                 \
> > +                 '$(sysnr_pfx_$(basetarget))'                  \
> > +                 '$(sysnr_offset_$(basetarget))'
> > +
>
> What's the purpose of adding this build rule, which is unused?

Sure.

Firoz
