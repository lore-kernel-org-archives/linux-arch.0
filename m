From: Greentime Hu <greentime.hu@sifive.com>
Subject: Re: [RFC PATCH V3 00/11] riscv: Add vector ISA support
Date: Mon, 23 Mar 2020 12:00:10 +0800
Message-ID: <CAHCEehKrzv0TozP7x9Vaq1t+Utpvqfgt=wo7eXXp0HRUKFO=WQ@mail.gmail.com>
References: <20200308094954.13258-1-guoren@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42858 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgCWEA1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Mar 2020 00:00:27 -0400
Received: by mail-qt1-f195.google.com with SMTP id t9so6651153qto.9
        for <linux-arch@vger.kernel.org>; Sun, 22 Mar 2020 21:00:26 -0700 (PDT)
In-Reply-To: <20200308094954.13258-1-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: guoren@kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Anup.Patel@wdc.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, arnd@arndb.de, linux-csky@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>, Guo Ren <guoren@linux.alibaba.com>, Dave Martin <Dave.Martin@arm.com>, Liu Zhiwei <zhiwei_liu@c-sky.com>

<guoren@kernel.org> =E6=96=BC 2020=E5=B9=B43=E6=9C=888=E6=97=A5 =E9=80=B1=
=E6=97=A5 =E4=B8=8B=E5=8D=885:50=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> The implementation follow the RISC-V "V" Vector Extension draft v0.8 with
> 128bit-vlen and it's based on linux-5.6-rc3 and tested with qemu [1].
>
> The patch implement basic context switch, sigcontext save/restore and
> ptrace interface with a new regset NT_RISCV_VECTOR. Only fixed 128bit-vle=
n
> is implemented. We need to discuss about vlen-size for libc sigcontext an=
d
> ptrace (the maximum size of vlen is unlimited in spec).
>
> Puzzle:
> Dave Martin has talked "Growing CPU register state without breaking ABI" =
[2]
> before, and riscv also met vlen size problem. Let's discuss the common is=
sue
> for all architectures and we need a better solution for unlimited vlen.
>
> Any help are welcomed :)
>
>  1: https://github.com/romanheros/qemu.git branch:vector-upstream-v3
>  2: https://blog.linuxplumbersconf.org/2017/ocw/sessions/4671.html
>

Hi Ren,

Thanks for the patch. I have some ideas about the vlen and sigcontext.
Since vlen may not be fixed of each RISC-V cores and it could be super
big, it means we have to allocate the memory dynamically.
In kernel space, we may use a pointer in the context data structure.
Something like https://github.com/torvalds/linux/blob/master/arch/arm64/ker=
nel/fpsimd.c#L498
In user space, we need to let user space know the length of vector
registers. We may create a special header in sigcontext. Something
like https://github.com/torvalds/linux/blob/master/arch/arm64/include/uapi/=
asm/sigcontext.h#L36
https://github.com/torvalds/linux/blob/master/arch/arm64/include/uapi/asm/s=
igcontext.h#L127

For the implementation in makecontext, swapcontext, getcontext,
setcontext of glibc, we may not need to port because it seems to be
deprecated?
https://stackoverflow.com/questions/4298986/is-there-something-to-replace-t=
he-ucontext-h-functions

For the unwinding implementation of libgcc since it needs to know the
meaning of data structure is  changed. It also need to be port.

> ---
> Changelog V3
>  - Rebase linux-5.6-rc3 and tested with qemu
>  - Seperate patches with Anup's advice
>  - Give out a ABI puzzle with unlimited vlen
>
> Changelog V2
>  - Fixup typo "vecotr, fstate_save->vstate_save".
>  - Fixup wrong saved registers' length in vector.S.
>  - Seperate unrelated patches from this one.
>
> Guo Ren (11):
>   riscv: Separate patch for cflags and aflags
>   riscv: Rename __switch_to_aux -> fpu
>   riscv: Extending cpufeature.c to detect V-extension
>   riscv: Add CSR defines related to VECTOR extension
>   riscv: Add vector feature to compile
>   riscv: Add has_vector detect
>   riscv: Reset vector register
>   riscv: Add vector struct and assembler definitions
>   riscv: Add task switch support for VECTOR
>   riscv: Add ptrace support
>   riscv: Add sigcontext save/restore
>
>  arch/riscv/Kconfig                       |   9 ++
>  arch/riscv/Makefile                      |  19 ++-
>  arch/riscv/include/asm/csr.h             |  17 ++-
>  arch/riscv/include/asm/processor.h       |   1 +
>  arch/riscv/include/asm/switch_to.h       |  54 ++++++-
>  arch/riscv/include/uapi/asm/elf.h        |   1 +
>  arch/riscv/include/uapi/asm/hwcap.h      |   1 +
>  arch/riscv/include/uapi/asm/ptrace.h     |   9 ++
>  arch/riscv/include/uapi/asm/sigcontext.h |   1 +
>  arch/riscv/kernel/Makefile               |   1 +
>  arch/riscv/kernel/asm-offsets.c          | 187 +++++++++++++++++++++++
>  arch/riscv/kernel/cpufeature.c           |  12 +-
>  arch/riscv/kernel/entry.S                |   2 +-
>  arch/riscv/kernel/head.S                 |  49 +++++-
>  arch/riscv/kernel/process.c              |  10 ++
>  arch/riscv/kernel/ptrace.c               |  41 +++++
>  arch/riscv/kernel/signal.c               |  40 +++++
>  arch/riscv/kernel/vector.S               |  84 ++++++++++
>  include/uapi/linux/elf.h                 |   1 +
>  19 files changed, 524 insertions(+), 15 deletions(-)
>  create mode 100644 arch/riscv/kernel/vector.S
>
> --
> 2.17.0
>
