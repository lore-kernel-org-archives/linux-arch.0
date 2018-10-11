Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36961 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeJKOdb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Oct 2018 10:33:31 -0400
MIME-Version: 1.0
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-5-git-send-email-firoz.khan@linaro.org> <20181009201321.GA28911@ls3530.fritz.box>
 <CALxhOnjxkq1-N59i81+ra58tZhx7Gik6iPyUsNFJY9wEJA+D1w@mail.gmail.com>
In-Reply-To: <CALxhOnjxkq1-N59i81+ra58tZhx7Gik6iPyUsNFJY9wEJA+D1w@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 11 Oct 2018 09:07:18 +0200
Message-ID: <CAK8P3a1DAEFR+PQAAediEKq1XPpxutS82SgW93_--xbjVn5wuw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] parisc: uapi header and system call table file generation
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Helge Deller <deller@gmx.de>, Parisc List <linux-parisc@vger.kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Thomas Gleixner <tglx@linutronix.de>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20181011070718.98RDfq1xOR8nT3BDjGfAudy9dVmGLUeq2RW0XDhvw3U@z>

On Thu, Oct 11, 2018 at 8:10 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> On Wed, 10 Oct 2018 at 01:48, Helge Deller <deller@gmx.de> wrote:
> >
> > * Firoz Khan <firoz.khan@linaro.org>:
> > > System call table generation script must be run to generate
> > > unistd_32/64.h and syscall_table_32/64/c32.h files. This patch
> > > will have changes which will invokes the script.
> > >
> > > This patch will generate unistd_32/64.h and syscall_table_
> > > 32/64/c32.h files by the syscall table generation script
> > > invoked by arch/parisc/Makefile and the generated files against
> > > the removed files will be identical.
> > >
> > > The generated uapi header file will be included in uapi/asm/
> > > unistd_32/64.h and generated system call table support file will
> > > be included by arch/sparc/kernel/syscall_table_32/64.S file.
> > >
> > > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> > > ---
> > >  arch/parisc/Makefile                  |   4 +
> > >  arch/parisc/include/asm/Kbuild        |   3 +
> > >  arch/parisc/include/uapi/asm/Kbuild   |   2 +
> > >  arch/parisc/include/uapi/asm/unistd.h | 373 +--------------------------
> > >  arch/parisc/kernel/syscall.S          |  12 +-
> > >  arch/parisc/kernel/syscall_table.S    | 459 ----------------------------------
> >
> >
> > Can we please get rid of those two new files:
>
> Yes, we don't need those files some of the architecture and other
> architecture does have same/similar files. That's why I added below
> files, so every architecture implementation looks same.
>
> I feel it is better to remove these files.
> Arnd, Do u have any comment on this?

I agree with Helge. This was a big different in a previous version where
you generated the syscall_table.S file from syscalls.tbl, but now that
you generade the syscall_table.h file instead, we no longer need to
keep the .S file synchronized across architectures.

Having a separate .S file would make it easier to replace that with
a .c file later, but it's also easier to split it out after your series than
as part of it.

      Arnd
