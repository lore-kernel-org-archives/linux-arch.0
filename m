From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v5 0/3] m68k: system call table generation support
Date: Tue, 4 Dec 2018 09:52:17 +0100
Message-ID: <CAMuHMdW6JiponxLiGNEXUX4xJk3hK4b8dTOCNvVBr7s2LyfhJw@mail.gmail.com>
References: <1542088829-19790-1-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542088829-19790-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: firoz.khan@linaro.org
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, Greg KH <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, marcin.juszkiewicz@linaro.org
List-Id: linux-arch.vger.kernel.org

On Tue, Nov 13, 2018 at 7:01 AM Firoz Khan <firoz.khan@linaro.org> wrote:
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
> itecture will be possible by adding new entry in the
> syscall.tbl file.
>
> Adding a new table entry consisting of:
>         - System call number.
>         - ABI.
>         - System call name.
>         - Entry point name.
>
> ARM, s390 and x86 architecuture does exist the sim-
> ilar support. I leverage their implementation to
> come up with a generic solution.
>
> I have done the same support for work for alpha, ia64,
> microblaze, mips, parisc, powerpc, sh, sparc and xtensa.
> Below mentioned git repository contains more details
> about the workflow.
>
> https://github.com/frzkhn/system_call_table_generator/
>
> Finally, this is the ground work to solve the Y2038
> issue. We need to add two dozen of system calls to
> solve Y2038 issue. So this patch series will help to
> add new system calls easily by adding new entry in
> the syscall.tbl.
>
> changes since v4:
>  - changed from generic-y to generated-y in Kbuild.
>  - remove the patch "0001-m68k-rename-system-call-
>    table-file-name.patch".
>
> changes since v3:
>  - optimized/updated the syscall table generation
>    scripts.
>  - fixed all mixed indentation issues in syscall.tbl.
>  - added "comments" in syscall_*.tbl.
>
> changes since v2:
>  - removed __IGNORE entries which was added in v2
>    to suppress the warning.
>  - added missing new line.
>
> changes since v1:
>  - enclosed __NR_sycalls macro with __KERNEL__.
>
> Firoz Khan (3):
>   m68k: add __NR_syscalls along with NR_syscalls
>   m68k: add system call table generation support
>   m68k: generate uapi header and syscall table header files
>
>  arch/m68k/Makefile                      |   3 +
>  arch/m68k/include/asm/Kbuild            |   1 +
>  arch/m68k/include/asm/unistd.h          |   3 +-
>  arch/m68k/include/uapi/asm/Kbuild       |   1 +
>  arch/m68k/include/uapi/asm/unistd.h     | 385 +------------------------------
>  arch/m68k/kernel/syscalls/Makefile      |  38 ++++
>  arch/m68k/kernel/syscalls/syscall.tbl   | 389 ++++++++++++++++++++++++++++++++
>  arch/m68k/kernel/syscalls/syscallhdr.sh |  36 +++
>  arch/m68k/kernel/syscalls/syscalltbl.sh |  32 +++
>  arch/m68k/kernel/syscalltable.S         | 387 +------------------------------
>  10 files changed, 507 insertions(+), 768 deletions(-)
>  create mode 100644 arch/m68k/kernel/syscalls/Makefile
>  create mode 100644 arch/m68k/kernel/syscalls/syscall.tbl
>  create mode 100644 arch/m68k/kernel/syscalls/syscallhdr.sh
>  create mode 100644 arch/m68k/kernel/syscalls/syscalltbl.sh

Thanks, applied and queued for v4.21 (with the missing newline added).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
