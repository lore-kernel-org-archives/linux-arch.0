From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 0/5] powerpc: system call table generation support
Date: Fri, 7 Dec 2018 12:57:24 +0530
Message-ID: <20181207072724.GA3750@sathnaga86>
References: <1544163100-15510-1-git-send-email-firoz.khan@linaro.org>
Reply-To: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1544163100-15510-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Ram Pai <linuxram@us.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Breno Leitao <leitao@debian.org>, Boqun Feng <boqun.feng@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, linux-arch@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, marcin.juszkiewicz@linaro.org, deepa.kernel@gmail.com
List-Id: linux-arch.vger.kernel.org

On Fri, Dec 07, 2018 at 11:41:35AM +0530, Firoz Khan wrote:
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
> 	- Compat entry name, if required.
> 	- spu entry name, if required.
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
> Changes since v3:
>  - split compat syscall table out from native table.
>  - modified the script to add new line in the generated
>    file.
Hi Firoz,

This version(v4) booted fine in IBM Power8 box.
Compiled with 'ppc64le_defconfig' aginst https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=merge&id=a26b21082959cee3075b3edb7ef23071c7e0b09a

Reference failure v3 version: https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-November/182110.html

Regards,
-Satheesh.
> 
> Changes since v2:
>  - modified/optimized the syscall.tbl to avoid duplicate
>    for the spu entries.
>  - updated the syscalltbl.sh to meet the above point.
> 
> Changes since v1:
>  - optimized/updated the syscall table generation 
>    scripts.
>  - fixed all mixed indentation issues in syscall.tbl.
>  - added "comments" in syscall_*.tbl.
>  - changed from generic-y to generated-y in Kbuild.
> 
> Firoz Khan (5):
>   powerpc: add __NR_syscalls along with NR_syscalls
>   powerpc: move macro definition from asm/systbl.h
>   powerpc: add system call table generation support
>   powerpc: split compat syscall table out from native table
>   powerpc: generate uapi header and system call table files
> 
>  arch/powerpc/Makefile                       |   3 +
>  arch/powerpc/include/asm/Kbuild             |   4 +
>  arch/powerpc/include/asm/syscall.h          |   3 +-
>  arch/powerpc/include/asm/systbl.h           | 396 --------------------------
>  arch/powerpc/include/asm/unistd.h           |   3 +-
>  arch/powerpc/include/uapi/asm/Kbuild        |   2 +
>  arch/powerpc/include/uapi/asm/unistd.h      | 389 +------------------------
>  arch/powerpc/kernel/Makefile                |  10 -
>  arch/powerpc/kernel/entry_64.S              |   7 +-
>  arch/powerpc/kernel/syscalls/Makefile       |  63 ++++
>  arch/powerpc/kernel/syscalls/syscall.tbl    | 427 ++++++++++++++++++++++++++++
>  arch/powerpc/kernel/syscalls/syscallhdr.sh  |  37 +++
>  arch/powerpc/kernel/syscalls/syscalltbl.sh  |  36 +++
>  arch/powerpc/kernel/systbl.S                |  40 ++-
>  arch/powerpc/kernel/systbl_chk.c            |  60 ----
>  arch/powerpc/kernel/vdso.c                  |   7 +-
>  arch/powerpc/platforms/cell/spu_callbacks.c |  17 +-
>  17 files changed, 606 insertions(+), 898 deletions(-)
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
