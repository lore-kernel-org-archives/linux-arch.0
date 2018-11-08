From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 3/3] microblaze: generate uapi header and system call
 table files
Date: Thu, 8 Nov 2018 14:44:21 +0100
Message-ID: <CAK8P3a2h1sdM62r6TjwWf9E-h9A4pUNR69XbbGbPSpPaub7DVg@mail.gmail.com>
References: <1540530552-3652-1-git-send-email-firoz.khan@linaro.org>
 <1540530552-3652-4-git-send-email-firoz.khan@linaro.org> <a04a6d10-d6d7-3ead-3b1e-68d87e1ea931@monstr.eu>
 <CALxhOnjWHVfVVi5aN5OAr4AN13NfktNVOarvnoAAWYgj9fYr6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALxhOnjWHVfVVi5aN5OAr4AN13NfktNVOarvnoAAWYgj9fYr6g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Michal Simek <monstr@monstr.eu>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 5, 2018 at 11:26 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> On Mon, 5 Nov 2018 at 14:46, Michal Simek <monstr@monstr.eu> wrote:
> > On 26. 10. 18 7:09, Firoz Khan wrote:

> > > -     .long sys_rseq
> > > +#include <asm/syscall_table.h>
> > > +#undef __SYSCALL
> > >
> >
> > I still don't think this is correct.
> >
> > I have done these steps
> >
> > make mrproper
> > make ARCH=microblaze headers_install INSTALL_HDR_PATH=/tmp/ && move
> > Applied 1/3
> > make ARCH=microblaze headers_install INSTALL_HDR_PATH=/tmp/ && move
> > Applied 2/3
> > make ARCH=microblaze headers_install INSTALL_HDR_PATH=/tmp/ && move
> > Applied 3/3
> > make ARCH=microblaze headers_install INSTALL_HDR_PATH=/tmp/ && move
> >
> > And compare all these versions. Till 2/3 all is fine but when 3/3 is
> > applied
> >
> > include/asm/unistd.h contains
> > #include <asm/unistd_32.h>
> >
> > Then include/asm/unistd_32.h contains
> > #include <asm-generic/unistd_32.h>
> > which is different syscalls table.
> >
> > I didn't play with it for a long time but removing generic unistd_32.h
> > is fixing it. Please take a look.
>
> Sure, I'll check and update you ASAP.
>
> >
> > diff --git a/arch/microblaze/include/uapi/asm/Kbuild
> > b/arch/microblaze/include/uapi/asm/Kbuild
> > index cda864f4b62e..2c6a6bffea32 100644
> > --- a/arch/microblaze/include/uapi/asm/Kbuild
> > +++ b/arch/microblaze/include/uapi/asm/Kbuild
> > @@ -28,4 +28,3 @@ generic-y += termbits.h
> >  generic-y += termios.h
> >  generic-y += types.h
> >  generic-y += ucontext.h
> > -generic-y += unistd_32.h
>
> AFAIK, If I apply the above fix; the generated file - unistd_32.h will
> get removed.
> No longer present in arch/microblaze/include/generated/uapi/asm.

It certainly must be 'generated-y', not 'generic-y', since you are
generating an architecture specific file, not taking the one
from asm-generic. I think this was correct in an earlier version.

       Arnd
