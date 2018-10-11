From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v3 4/6] parisc: uapi header and system call table file generation
Date: Thu, 11 Oct 2018 11:44:13 +0530
Message-ID: <CALxhOnhcP==cGqMQvtrZ9GiNWGB69hz4G0n0kocBtd9NpDthCg@mail.gmail.com>
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-5-git-send-email-firoz.khan@linaro.org> <20181009201321.GA28911@ls3530.fritz.box>
 <CALxhOnjxkq1-N59i81+ra58tZhx7Gik6iPyUsNFJY9wEJA+D1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALxhOnjxkq1-N59i81+ra58tZhx7Gik6iPyUsNFJY9wEJA+D1w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Typo fixed!

On Thu, 11 Oct 2018 at 11:40, Firoz Khan <firoz.khan@linaro.org> wrote:
>
> Hi Helge,
>
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
Yes, we don't need those files some of the architecture does have ...

> files, so every architecture implementation looks same.
>
> I feel it is better to remove these files.
> Arnd, Do u have any comment on this?
>
> Thanks
> Firoz
>
> >
> > >  arch/parisc/kernel/syscall_table_32.S |  13 +
> > >  arch/parisc/kernel/syscall_table_64.S |  20 ++
> >
> > Both are not needed (at least on parisc) if you apply the following
> > patch on top of your patch series.
> > This patch finally fixes the 64-bit kernel on parisc (tested on real
> > hardware).
> >
> > Helge
> >
> > diff --git a/arch/parisc/kernel/syscall.S b/arch/parisc/kernel/syscall.S
> > index 2523b83b88d8..45cddeeb968f 100644
> > --- a/arch/parisc/kernel/syscall.S
> > +++ b/arch/parisc/kernel/syscall.S
> > @@ -923,10 +923,20 @@ ENTRY(lws_table)
> >  END(lws_table)
> >         /* End of lws table */
> >
> > -#include "syscall_table_32.S"
> > +#define __SYSCALL(nr, entry, nargs) ASM_ULONG_INSN entry
> > +
> > +ENTRY(sys_call_table)
> > +#if defined(CONFIG_64BIT)
> > +#include <asm/syscall_table_c32.h>     /* compat syscalls */
> > +#else
> > +#include <asm/syscall_table_32.h>      /* 32-bit native syscalls */
> > +#endif
> > +END(sys_call_table)
> > +
> >  #ifdef CONFIG_64BIT
> > -#define SYSCALL_TABLE_64BIT
> > -#include "syscall_table_64.S"
> > +ENTRY(sys_call_table64)
> > +#include <asm/syscall_table_64.h>      /* 64-bit native syscalls */
> > +END(sys_call_table64)
> >  #endif
> >
> >         /*
