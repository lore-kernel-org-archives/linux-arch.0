From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v3 0/4] powerpc: system call table generation support
Date: Thu, 29 Nov 2018 14:27:48 +0530
Message-ID: <CALxhOniXc5ePTXkGjiUZxrDQPqu3FyOGH=SR=2eP947JHLBk9Q@mail.gmail.com>
References: <1543465611-17122-1-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543465611-17122-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Ram Pai <linuxram@us.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Breno Leitao <leitao@debian.org>, Boqun Feng <boqun.feng@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, sathnaga@linux.vnet.ibm.com
Cc: y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

++ sathnaga@linux.vnet.ibm.com

On Thu, 29 Nov 2018 at 09:57, Firoz Khan <firoz.khan@linaro.org> wrote:
>
> The purpose of this patch series is, we can easily
> add/modify/delete system call table support by cha-
> nging entry in syscall.tbl file instead of manually
> changing many files. The other goal is to unify the
> system call table generation support implementation
> across all the architectures.
>
> The system call tables are in different format in
> all architecture. It will be difficult to manually
> add, modify or delete the system calls in the resp-
> ective files manually. To make it easy by keeping a
> script and which'll generate uapi header file and
> syscall table file.
>
> syscall.tbl contains the list of available system
> calls along with system call number and correspond-
> ing entry point. Add a new system call in this arch-
> itecture will be possible by adding new entry in
> the syscall.tbl file.
>
> Adding a new table entry consisting of:
>         - System call number.
>         - ABI.
>         - System call name.
>         - Entry point name.
>         - Compat entry name, if required.
>         - spu entry name, if required.
>
> ARM, s390 and x86 architecuture does exist the sim-
> ilar support. I leverage their implementation to
> come up with a generic solution.
>
> I have done the same support for work for alpha,
> ia64, m68k, microblaze, mips, parisc, sh, sparc,
> and xtensa. Below mentioned git repository contains
> more details about the workflow.
>
> https://github.com/frzkhn/system_call_table_generator/
>
> Finally, this is the ground work to solve the Y2038
> issue. We need to add two dozen of system calls to
> solve Y2038 issue. So this patch series will help to
> add new system calls easily by adding new entry in the
> syscall.tbl.
>
> changes since v2:
>  - modified/optimized the syscall.tbl to avoid duplicate
>    for the spu entries.
>  - updated the syscalltbl.sh to meet the above point.
>
> changes since v1:
>  - optimized/updated the syscall table generation
>    scripts.
>  - fixed all mixed indentation issues in syscall.tbl.
>  - added "comments" in syscall_*.tbl.
>  - changed from generic-y to generated-y in Kbuild.
>
> Firoz Khan (4):
>   powerpc: add __NR_syscalls along with NR_syscalls
>   powerpc: move macro definition from asm/systbl.h
>   powerpc: add system call table generation support
>   powerpc: generate uapi header and system call table files
>
>  arch/powerpc/Makefile                       |   3 +
>  arch/powerpc/include/asm/Kbuild             |   4 +
>  arch/powerpc/include/asm/systbl.h           | 396 --------------------------
>  arch/powerpc/include/asm/unistd.h           |   3 +-
>  arch/powerpc/include/uapi/asm/Kbuild        |   2 +
>  arch/powerpc/include/uapi/asm/unistd.h      | 389 +------------------------
>  arch/powerpc/kernel/Makefile                |  10 -
>  arch/powerpc/kernel/syscalls/Makefile       |  63 ++++
>  arch/powerpc/kernel/syscalls/syscall.tbl    | 427 ++++++++++++++++++++++++++++
>  arch/powerpc/kernel/syscalls/syscallhdr.sh  |  36 +++
>  arch/powerpc/kernel/syscalls/syscalltbl.sh  |  36 +++
>  arch/powerpc/kernel/systbl.S                |  37 +--
>  arch/powerpc/kernel/systbl_chk.c            |  60 ----
>  arch/powerpc/platforms/cell/spu_callbacks.c |  17 +-
>  14 files changed, 591 insertions(+), 892 deletions(-)
>  delete mode 100644 arch/powerpc/include/asm/systbl.h
>  create mode 100644 arch/powerpc/kernel/syscalls/Makefile
>  create mode 100644 arch/powerpc/kernel/syscalls/syscall.tbl
>  create mode 100644 arch/powerpc/kernel/syscalls/syscallhdr.sh
>  create mode 100644 arch/powerpc/kernel/syscalls/syscalltbl.sh
>  delete mode 100644 arch/powerpc/kernel/systbl_chk.c
>
> --
> 1.9.1
>
