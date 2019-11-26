Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io1-f66.google.com ([209.85.166.66]:40344 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfKZLmz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Nov 2019 06:42:55 -0500
Received: by mail-io1-f66.google.com with SMTP id b26so18265044ion.7
        for <linux-arch@vger.kernel.org>; Tue, 26 Nov 2019 03:42:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573179553.git.thehajime@gmail.com> <64a5d6c94d331058331af7d191d2cdbe870d009b.1573179553.git.thehajime@gmail.com>
 <CAFLxGvw+w+xmput3xMjKPXPn4hj9opbo+gtV6896hhzDUzQNiA@mail.gmail.com>
In-Reply-To: <CAFLxGvw+w+xmput3xMjKPXPn4hj9opbo+gtV6896hhzDUzQNiA@mail.gmail.com>
From: Octavian Purdila <tavi.purdila@gmail.com>
Date: Tue, 26 Nov 2019 13:42:43 +0200
Message-ID: <CAMoF9u2g2+_qjfAKh3jD-PSEBhwBVBLDvEEa8Sawutp4fQaYNw@mail.gmail.com>
Subject: Re: [RFC v2 03/37] lkl: architecture skeleton for Linux kernel library
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Hajime Tazaki <thehajime@gmail.com>, linux-um <linux-um@lists.infradead.org>, Linux-Arch <linux-arch@vger.kernel.org>, Patrick Collins <pscollins@google.com>, Levente Kurusa <levex@linux.com>, Matthieu Coudron <mattator@gmail.com>, Conrad Meyer <cem@freebsd.org>, Jens Staal <staal1978@gmail.com>, Motomu Utsumi <motomuman@gmail.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Akira Moroo <retrage01@gmail.com>, Petros Angelatos <petrosagg@gmail.com>, Yuan Liu <liuyuan@google.com>, Xiao Jia <xiaoj@google.com>, Mark Stillwell <mark@stillwell.me>, linux-kernel-library <linux-kernel-library@freelists.org>, Pierre-Hugues Husson <phh@phh.me>, Michael Zimmermann <sigmaepsilon92@gmail.com>, Luca Dariz <luca.dariz@gmail.com>, "Edison M . Castro" <edisonmcastro@hotmail.com>

On Tue, Nov 26, 2019 at 12:00 AM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> On Fri, Nov 8, 2019 at 6:03 AM Hajime Tazaki <thehajime@gmail.com> wrote:
> >
> > From: Octavian Purdila <tavi.purdila@gmail.com>
> >
> > Adds the LKL Kconfig, vmlinux linker script, basic architecture
> > headers and miscellaneous basic functions or stubs such as
> > dump_stack(), show_regs() and cpuinfo proc ops.
> >
> > The headers we introduce in this patch are simple wrappers to the
> > asm-generic headers or stubs for things we don't support, such as
> > ptrace, DMA, signals, ELF handling and low level processor operations.
> >
> > The kernel configuration is automatically updated to reflect the
> > endianness of the host, 64bit support or the output format for
> > vmlinux's linker script. We do this by looking at the ld's default
> > output format.
> >
> > Signed-off-by: Andreas Abel <aabel@google.com>
> > Signed-off-by: Conrad Meyer <cem@FreeBSD.org>
> > Signed-off-by: Edison M. Castro <edisonmcastro@hotmail.com>
> > Signed-off-by: H.K. Jerry Chu <hkchu@google.com>
> > Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> > Signed-off-by: Jens Staal <staal1978@gmail.com>
> > Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
> > Signed-off-by: Levente Kurusa <levex@linux.com>
> > Signed-off-by: Luca Dariz <luca.dariz@gmail.com>
> > Signed-off-by: Mark Stillwell <mark@stillwell.me>
> > Signed-off-by: Matthieu Coudron <mattator@gmail.com>
> > Signed-off-by: Michael Zimmermann <sigmaepsilon92@gmail.com>
> > Signed-off-by: Motomu Utsumi <motomuman@gmail.com>
> > Signed-off-by: Patrick Collins <pscollins@google.com>
> > Signed-off-by: Petros Angelatos <petrosagg@gmail.com>
> > Signed-off-by: Pierre-Hugues Husson <phh@phh.me>
> > Signed-off-by: Xiao Jia <xiaoj@google.com>
> > Signed-off-by: Yuan Liu <liuyuan@google.com>
> > Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
>
> Can we please have this chain cleaned up?
> Please see process/submitting-patches.rst.
>
> > ---
> >  MAINTAINERS                                |   8 +
> >  arch/um/lkl/.gitignore                     |   2 +
> >  arch/um/lkl/Kconfig                        |  95 ++++++
> >  arch/um/lkl/Kconfig.debug                  |   0
> >  arch/um/lkl/configs/lkl_defconfig          |  91 ++++++
> >  arch/um/lkl/include/asm/Kbuild             |  80 +++++
> >  arch/um/lkl/include/asm/bitsperlong.h      |  11 +
> >  arch/um/lkl/include/asm/byteorder.h        |   7 +
> >  arch/um/lkl/include/asm/cpu.h              |  14 +
> >  arch/um/lkl/include/asm/elf.h              |  15 +
> >  arch/um/lkl/include/asm/mutex.h            |   7 +
> >  arch/um/lkl/include/asm/processor.h        |  60 ++++
> >  arch/um/lkl/include/asm/ptrace.h           |  25 ++
> >  arch/um/lkl/include/asm/sched.h            |  23 ++
> >  arch/um/lkl/include/asm/syscalls.h         |  18 ++
> >  arch/um/lkl/include/asm/syscalls_32.h      |  43 +++
> >  arch/um/lkl/include/asm/tlb.h              |  12 +
> >  arch/um/lkl/include/asm/uaccess.h          |  64 ++++
> >  arch/um/lkl/include/asm/unistd_32.h        |  31 ++
> >  arch/um/lkl/include/asm/vmlinux.lds.h      |  14 +
> >  arch/um/lkl/include/asm/xor.h              |   9 +
> >  arch/um/lkl/include/uapi/asm/Kbuild        |   9 +
> >  arch/um/lkl/include/uapi/asm/bitsperlong.h |  13 +
> >  arch/um/lkl/include/uapi/asm/byteorder.h   |  11 +
> >  arch/um/lkl/include/uapi/asm/siginfo.h     |  11 +
> >  arch/um/lkl/include/uapi/asm/swab.h        |  11 +
> >  arch/um/lkl/include/uapi/asm/syscalls.h    | 348 +++++++++++++++++++++
>
> I think this is the first big thing which needs a unification.
>
> In UML we try hard to re-use headers from x86.
> We also have some headers in arch/x86/um/.
>
> LKL should do the same. At least try hard to avoid duplication.
>

In LKL we tried to avoid coupling the kernel build part to a
particular architecture, to make it easier to port it (to different
arches, but as well to other OSes or special environments [1][2]).
That is the main reason for having two build steps, one for kernel
proper, and one for the host. That is why the host part was placed
into tools/lkl to make it clear that is not part of the kernel proper.

I think this is one of the biggest differences between UML and LKL and
it would be helpful to get feedback of what people think of a
potential similar split for UML.

[1] https://www.haiku-os.org/blog/lucian/2010-07-08_booting_lkl_inside_haiku/
[2] https://github.com/lkl/lkl-ntk-driver-poc
