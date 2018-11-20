From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v2 4/5] mips: add system call table generation support
Date: Tue, 20 Nov 2018 12:43:53 +0530
Message-ID: <CALxhOnjYzvDGdvuWitiOP46YuV6XViu9O3Fi0FU9u2jnV3W2EQ@mail.gmail.com>
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org>
 <1542262461-29024-5-git-send-email-firoz.khan@linaro.org> <20181119223524.gsvjkf5v24ic7ilj@pburton-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181119223524.gsvjkf5v24ic7ilj@pburton-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Paul,

On Tue, 20 Nov 2018 at 04:05, Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Firoz,
>
> On Thu, Nov 15, 2018 at 11:44:20AM +0530, Firoz Khan wrote:
> > diff --git a/arch/mips/kernel/syscalls/Makefile b/arch/mips/kernel/syscalls/Makefile
> > new file mode 100644
> > index 0000000..dc6bbb1
> > --- /dev/null
> > +++ b/arch/mips/kernel/syscalls/Makefile
> > @@ -0,0 +1,71 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +kapi := arch/$(SRCARCH)/include/generated/asm
> > +uapi := arch/$(SRCARCH)/include/generated/uapi/asm
> > +
> > +_dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')    \
> > +       $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
> > +
> > +syscallo32 := $(srctree)/$(src)/syscall_o32.tbl
> > +syscall64 := $(srctree)/$(src)/syscall_64.tbl
> > +syscalln32 := $(srctree)/$(src)/syscall_n32.tbl
> > +syshdr := $(srctree)/$(src)/syscallhdr.sh
> > +systbl := $(srctree)/$(src)/syscalltbl.sh
>
> Could we go with 'n64' instead of just '64'?
>
> When we get nanoMIPS support we'll be introducing the p32 ABI, and
> there's a reasonable chance that the equivalent p64 ABI may come along
> in the future. Using 'n64' now would avoid confusion in that case where
> we may have 2 different 64-bit ABIs.

Sure, will do.

Thanks
Firoz

>
> Thanks,
>     Paul
