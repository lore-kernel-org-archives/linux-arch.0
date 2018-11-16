From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v7 0/5] parisc: system call table generation support
Date: Fri, 16 Nov 2018 11:21:01 +0530
Message-ID: <CALxhOngc1cSSDVznnX+iLg-Ne9+k0ct0wT-z0MXKSeKxJE3Vsg@mail.gmail.com>
References: <1542177301-25844-1-git-send-email-firoz.khan@linaro.org> <58c3c4a4-7f55-bf08-1c96-ef1aa7f97072@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <58c3c4a4-7f55-bf08-1c96-ef1aa7f97072@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Helge,

On Fri, 16 Nov 2018 at 01:01, Helge Deller <deller@gmx.de> wrote:
>
> On 14.11.2018 07:34, Firoz Khan wrote:
> > The purpose of this patch series is, we can easily
> > add/modify/delete system call table support by cha-
> > nging entry in syscall.tbl file instead of manually
> > changing many files. The other goal is to unify the
> > system call table generation support implementation
> > across all the architectures.
> >
> > The system call tables are in different format in
> > all architecture. It will be difficult to manually
> > add, modify or delete the system calls in the resp-
> > ective files manually. To make it easy by keeping a
> > script and which'll generate uapi header file and
> > syscall table file.
> >
> > syscall.tbl contains the list of available system
> > calls along with system call number and correspond-
> > ing entry point. Add a new system call in this arch-
> > itecture will be possible by adding new entry in the
> > syscall.tbl file.
> >
> > Adding a new table entry consisting of:
> >         - System call number.
> >         - ABI.
> >         - System call name.
> >         - Entry point name.
> >
> > ARM, s390 and x86 architecuture does exist the sim-
> > ilar support. I leverage their implementation to
> > come up with a generic solution.
> >
> > I have done the same support for work for alpha, ia64,
> > m68k, microblaze, mips, powerpc, sh, sparc and xtensa.
> > Below mentioned git repository contains more details
> > about the workflow.
> >
> > https://github.com/frzkhn/system_call_table_generator/
> >
> > Finally, this is the ground work to solve the Y2038
> > issue. We need to add two dozen of system calls to
> > solve Y2038 issue. So this patch series will help to
> > add new system calls easily by adding new entry in
> > the syscall.tbl.
> >
> > changes since v6:
> >  - changed from generic-y to generated-y in Kbuild.
> >
> > changes since v5:
> >  - optimized/updated the syscall table generation
> >    scripts.
> >  - fixed all mixed indentation issues in syscall.tbl.
> >  - added "comments" in syscall_*.tbl.
> >
> > changes since v4:
> >  - optimized/updated the syscall table generation
> >    scripts.
> >  - removed __IGNORE entries which was added in v2
> >    to suppress the warning.
> >
> > changes since v3:
> >  - optimized/updated the syscall table generation
> >    scripts.
> >  - added missing new line.
> >
> > changes since v2:
> >  - updated the syscall.tbl file by including missed
> >    entries.
> >
> > changes since v1:
> >  - enclosed __NR_sycalls macro with __KERNEL__.
> >
> > Firoz Khan (5):
> >   parisc: move __IGNORE* entries to non uapi header
> >   parisc: add __NR_syscalls along with __NR_Linux_syscalls
> >   parisc: add system call table generation support
> >   parisc: generate uapi header and system call table files
> >   parisc: syscalls: ignore nfsservctl for other architectures
>
> Firoz, you may add
> Acked-by: Helge Deller <deller@gmx.de>
> to the whole parisc series.

Sure, will do.
I'm on a vacation right now. will send mid next week.

Thanks
Firoz

>
> Thanks!
> Helge
>
>
>
> >  arch/parisc/Makefile                      |   3 +
> >  arch/parisc/include/asm/Kbuild            |   3 +
> >  arch/parisc/include/asm/unistd.h          |   8 +
> >  arch/parisc/include/uapi/asm/Kbuild       |   2 +
> >  arch/parisc/include/uapi/asm/unistd.h     | 382 +------------------------
> >  arch/parisc/kernel/syscall.S              |  11 +-
> >  arch/parisc/kernel/syscall_table.S        | 459 ------------------------------
> >  arch/parisc/kernel/syscalls/Makefile      |  57 ++++
> >  arch/parisc/kernel/syscalls/syscall.tbl   | 369 ++++++++++++++++++++++++
> >  arch/parisc/kernel/syscalls/syscallhdr.sh |  36 +++
> >  arch/parisc/kernel/syscalls/syscalltbl.sh |  36 +++
> >  scripts/checksyscalls.sh                  |   1 +
> >  12 files changed, 531 insertions(+), 836 deletions(-)
> >  delete mode 100644 arch/parisc/kernel/syscall_table.S
> >  create mode 100644 arch/parisc/kernel/syscalls/Makefile
> >  create mode 100644 arch/parisc/kernel/syscalls/syscall.tbl
> >  create mode 100644 arch/parisc/kernel/syscalls/syscallhdr.sh
> >  create mode 100644 arch/parisc/kernel/syscalls/syscalltbl.sh
> >
>
