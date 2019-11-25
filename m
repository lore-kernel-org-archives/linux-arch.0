Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36242 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKYWAq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Nov 2019 17:00:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so20027736wru.3
        for <linux-arch@vger.kernel.org>; Mon, 25 Nov 2019 14:00:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573179553.git.thehajime@gmail.com> <64a5d6c94d331058331af7d191d2cdbe870d009b.1573179553.git.thehajime@gmail.com>
In-Reply-To: <64a5d6c94d331058331af7d191d2cdbe870d009b.1573179553.git.thehajime@gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 25 Nov 2019 23:00:33 +0100
Message-ID: <CAFLxGvw+w+xmput3xMjKPXPn4hj9opbo+gtV6896hhzDUzQNiA@mail.gmail.com>
Subject: Re: [RFC v2 03/37] lkl: architecture skeleton for Linux kernel library
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, Linux-Arch <linux-arch@vger.kernel.org>, Patrick Collins <pscollins@google.com>, Levente Kurusa <levex@linux.com>, Matthieu Coudron <mattator@gmail.com>, Conrad Meyer <cem@freebsd.org>, Octavian Purdila <tavi.purdila@gmail.com>, Jens Staal <staal1978@gmail.com>, Motomu Utsumi <motomuman@gmail.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Akira Moroo <retrage01@gmail.com>, Petros Angelatos <petrosagg@gmail.com>, Yuan Liu <liuyuan@google.com>, Xiao Jia <xiaoj@google.com>, Mark Stillwell <mark@stillwell.me>, linux-kernel-library@freelists.org, Pierre-Hugues Husson <phh@phh.me>, Michael Zimmermann <sigmaepsilon92@gmail.com>, Luca Dariz <luca.dariz@gmail.com>, "Edison M . Castro" <edisonmcastro@hotmail.com>

On Fri, Nov 8, 2019 at 6:03 AM Hajime Tazaki <thehajime@gmail.com> wrote:
>
> From: Octavian Purdila <tavi.purdila@gmail.com>
>
> Adds the LKL Kconfig, vmlinux linker script, basic architecture
> headers and miscellaneous basic functions or stubs such as
> dump_stack(), show_regs() and cpuinfo proc ops.
>
> The headers we introduce in this patch are simple wrappers to the
> asm-generic headers or stubs for things we don't support, such as
> ptrace, DMA, signals, ELF handling and low level processor operations.
>
> The kernel configuration is automatically updated to reflect the
> endianness of the host, 64bit support or the output format for
> vmlinux's linker script. We do this by looking at the ld's default
> output format.
>
> Signed-off-by: Andreas Abel <aabel@google.com>
> Signed-off-by: Conrad Meyer <cem@FreeBSD.org>
> Signed-off-by: Edison M. Castro <edisonmcastro@hotmail.com>
> Signed-off-by: H.K. Jerry Chu <hkchu@google.com>
> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> Signed-off-by: Jens Staal <staal1978@gmail.com>
> Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
> Signed-off-by: Levente Kurusa <levex@linux.com>
> Signed-off-by: Luca Dariz <luca.dariz@gmail.com>
> Signed-off-by: Mark Stillwell <mark@stillwell.me>
> Signed-off-by: Matthieu Coudron <mattator@gmail.com>
> Signed-off-by: Michael Zimmermann <sigmaepsilon92@gmail.com>
> Signed-off-by: Motomu Utsumi <motomuman@gmail.com>
> Signed-off-by: Patrick Collins <pscollins@google.com>
> Signed-off-by: Petros Angelatos <petrosagg@gmail.com>
> Signed-off-by: Pierre-Hugues Husson <phh@phh.me>
> Signed-off-by: Xiao Jia <xiaoj@google.com>
> Signed-off-by: Yuan Liu <liuyuan@google.com>
> Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>

Can we please have this chain cleaned up?
Please see process/submitting-patches.rst.

> ---
>  MAINTAINERS                                |   8 +
>  arch/um/lkl/.gitignore                     |   2 +
>  arch/um/lkl/Kconfig                        |  95 ++++++
>  arch/um/lkl/Kconfig.debug                  |   0
>  arch/um/lkl/configs/lkl_defconfig          |  91 ++++++
>  arch/um/lkl/include/asm/Kbuild             |  80 +++++
>  arch/um/lkl/include/asm/bitsperlong.h      |  11 +
>  arch/um/lkl/include/asm/byteorder.h        |   7 +
>  arch/um/lkl/include/asm/cpu.h              |  14 +
>  arch/um/lkl/include/asm/elf.h              |  15 +
>  arch/um/lkl/include/asm/mutex.h            |   7 +
>  arch/um/lkl/include/asm/processor.h        |  60 ++++
>  arch/um/lkl/include/asm/ptrace.h           |  25 ++
>  arch/um/lkl/include/asm/sched.h            |  23 ++
>  arch/um/lkl/include/asm/syscalls.h         |  18 ++
>  arch/um/lkl/include/asm/syscalls_32.h      |  43 +++
>  arch/um/lkl/include/asm/tlb.h              |  12 +
>  arch/um/lkl/include/asm/uaccess.h          |  64 ++++
>  arch/um/lkl/include/asm/unistd_32.h        |  31 ++
>  arch/um/lkl/include/asm/vmlinux.lds.h      |  14 +
>  arch/um/lkl/include/asm/xor.h              |   9 +
>  arch/um/lkl/include/uapi/asm/Kbuild        |   9 +
>  arch/um/lkl/include/uapi/asm/bitsperlong.h |  13 +
>  arch/um/lkl/include/uapi/asm/byteorder.h   |  11 +
>  arch/um/lkl/include/uapi/asm/siginfo.h     |  11 +
>  arch/um/lkl/include/uapi/asm/swab.h        |  11 +
>  arch/um/lkl/include/uapi/asm/syscalls.h    | 348 +++++++++++++++++++++

I think this is the first big thing which needs a unification.

In UML we try hard to re-use headers from x86.
We also have some headers in arch/x86/um/.

LKL should do the same. At least try hard to avoid duplication.

-- 
Thanks,
//richard
