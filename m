From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 4/6] parisc: uapi header and system call table file generation
Date: Thu, 11 Oct 2018 09:03:51 +0200
Message-ID: <CAK8P3a1Kbxue2PXRL87-Saiotyq-+v=Uc3vL9KArRuLqCwC4bw@mail.gmail.com>
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-5-git-send-email-firoz.khan@linaro.org> <20181009201321.GA28911@ls3530.fritz.box>
 <CALxhOnjxkq1-N59i81+ra58tZhx7Gik6iPyUsNFJY9wEJA+D1w@mail.gmail.com> <CALxhOnj1SnTO9Sm-1cAL9B8gEmYrOHr03K6OqF4qqt5Oh0x+4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALxhOnj1SnTO9Sm-1cAL9B8gEmYrOHr03K6OqF4qqt5Oh0x+4g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Helge Deller <deller@gmx.de>, Parisc List <linux-parisc@vger.kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Thomas Gleixner <tglx@linutronix.de>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Oct 11, 2018 at 8:48 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> On Thu, 11 Oct 2018 at 11:40, Firoz Khan <firoz.khan@linaro.org> wrote:
> > On Wed, 10 Oct 2018 at 01:48, Helge Deller <deller@gmx.de> wrote:

> > > +
> > > +ENTRY(sys_call_table)
> > > +#if defined(CONFIG_64BIT)
> > > +#include <asm/syscall_table_c32.h>     /* compat syscalls */
> > > +#else
> > > +#include <asm/syscall_table_32.h>      /* 32-bit native syscalls */
> > > +#endif
> > > +END(sys_call_table)
> > > +
> > >  #ifdef CONFIG_64BIT
> > > -#define SYSCALL_TABLE_64BIT
> > > -#include "syscall_table_64.S"
> > > +ENTRY(sys_call_table64)
> > > +#include <asm/syscall_table_64.h>      /* 64-bit native syscalls */
> > > +END(sys_call_table64)
> > >  #endif
> > >
> > >         /*
>
> I could see a patch (commit 47514da3ac20150cdf764466fbc2010c0fca0163)
> which will perform a compile-check when adding a new syscall. My patches
> will remove this feature. Is that fine?

I think it's ok: You are automating it so the bug can no longer happen,
which is better than adding checks to prevent human errors.

        Arnd
