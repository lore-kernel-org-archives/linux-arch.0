From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v4 0/3] microblaze: system call table generation support
Date: Fri, 16 Nov 2018 14:57:51 +0530
Message-ID: <CALxhOnjQgk8gX-N14H+4VtZhSSDB==NYdt5Y7-ihy6pxa6BPEA@mail.gmail.com>
References: <1542089074-20027-1-git-send-email-firoz.khan@linaro.org> <632c1d3f-26cf-7e65-4e7a-cc882ef168c4@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <632c1d3f-26cf-7e65-4e7a-cc882ef168c4@monstr.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <monstr@monstr.eu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Michal,

On Fri, 16 Nov 2018 at 14:01, Michal Simek <monstr@monstr.eu> wrote:
>
> On 13. 11. 18 7:04, Firoz Khan wrote:
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
> > m68k, mips, parisc, powerpc, sh, sparc and xtensa.
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
> > changes since v3:
> >  - changed from generic-y to generated-y in Kbuild.
> >
> > changes since v2:
> >  - optimized/updated the syscall table generation
> >    scripts.
> >  - fixed all mixed indentation issues in syscall.tbl.
> >  - added "comments" in syscall_*.tbl.
> >
> > changes since v1:
> >  - enclosed __NR_sycalls macro with __KERNEL__.
> >  - added missing new line.
>
> next time please also keep this changelog in every patch.

Sure. Basically I haven't came across changelog till a point
where  Geert Uytterhoeven <geert@linux-m68k.org> pointed
out changelog is missing. Thanks Geert :)

>
> >
> > Firoz Khan (3):
> >   microblaze: move __NR_syscalls macro from asm/unistd.h
> >   microblaze: add system call table generation support
> >   microblaze: generate uapi header and system call table files
> >
> >  arch/microblaze/Makefile                      |   3 +
> >  arch/microblaze/include/asm/Kbuild            |   1 +
> >  arch/microblaze/include/asm/unistd.h          |   2 -
> >  arch/microblaze/include/uapi/asm/Kbuild       |   1 +
> >  arch/microblaze/include/uapi/asm/unistd.h     | 407 +------------------------
> >  arch/microblaze/kernel/syscall_table.S        | 406 +------------------------
> >  arch/microblaze/kernel/syscalls/Makefile      |  38 +++
> >  arch/microblaze/kernel/syscalls/syscall.tbl   | 410 ++++++++++++++++++++++++++
> >  arch/microblaze/kernel/syscalls/syscallhdr.sh |  36 +++
> >  arch/microblaze/kernel/syscalls/syscalltbl.sh |  32 ++
> >  10 files changed, 526 insertions(+), 810 deletions(-)
> >  create mode 100644 arch/microblaze/kernel/syscalls/Makefile
> >  create mode 100644 arch/microblaze/kernel/syscalls/syscall.tbl
> >  create mode 100644 arch/microblaze/kernel/syscalls/syscallhdr.sh
> >  create mode 100644 arch/microblaze/kernel/syscalls/syscalltbl.sh
> >
>
> Looks good now. I have queue it to next. And also asked our team to
> retest everything.

Sounds good!

Thanks
Firoz

>
> Thanks,
> Michal
>
> --
> Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
> w: www.monstr.eu p: +42-0-721842854
> Maintainer of Linux kernel - Xilinx Microblaze
> Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
> U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
>
>
