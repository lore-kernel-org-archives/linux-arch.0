Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35915 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729415AbeJAVB0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Oct 2018 17:01:26 -0400
Received: by mail-yw1-f68.google.com with SMTP id e201-v6so5549041ywa.3
        for <linux-arch@vger.kernel.org>; Mon, 01 Oct 2018 07:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <1538058267-3765-1-git-send-email-firoz.khan@linaro.org>
 <1538058267-3765-4-git-send-email-firoz.khan@linaro.org> <CAK8P3a0D2G8=weYcua7G3HmL07vrYR_iExmmjt2SuokbJ=Vvog@mail.gmail.com>
In-Reply-To: <CAK8P3a0D2G8=weYcua7G3HmL07vrYR_iExmmjt2SuokbJ=Vvog@mail.gmail.com>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Mon, 1 Oct 2018 19:53:12 +0530
Message-ID: <CALxhOnjwY+n5qdNBsL2_ZxCMkGf=Fz=_MwMwBjrWS8=WzYxAQQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] parisc: add system call table generation support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20181001142312.DMot6GfgNVG_DsMF9TDG3jn1vVUHJ6xoro1L6tcNouQ@z>

Hi Arnd,

On Mon, 1 Oct 2018 at 17:06, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Sep 27, 2018 at 4:25 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> >
> > ---
> >  arch/parisc/kernel/syscalls/Makefile       |  55 +++++
> >  arch/parisc/kernel/syscalls/syscall_32.tbl | 342 +++++++++++++++++++++++++++++
> >  arch/parisc/kernel/syscalls/syscall_64.tbl | 342 +++++++++++++++++++++++++++++
> >  arch/parisc/kernel/syscalls/syscallhdr.sh  |  35 +++
> >  arch/parisc/kernel/syscalls/syscalltbl.sh  |  42 ++++
>
> I think we absolutely want to share the .tbl files for generating all
> five outputs
> (32-bit unistd.h, 64-bit unistd.h, 32-bit native syscall-table.S, 64-bit native
> syscall-table.S, and 32-bit compat syscall-table.S) so we only
> have to modify one file when adding another syscall, and to ensure that
>  32/64 are in sync.

For this design, I need to rework. I'll update you shortly

- Firoz
>
>       Arnd
