From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v2 0/5] System call table generation support
Date: Mon, 24 Sep 2018 09:38:27 +0530
Message-ID: <CALxhOnjwrjuZjDnymesqe1Wj=8=YvEwW5wTjLnOHcfzLaFBK4Q@mail.gmail.com>
References: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org> <b42ac34f-ab67-5d5c-1d6f-354af40773d8@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b42ac34f-ab67-5d5c-1d6f-354af40773d8@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gerg@linux-m68k.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Greg,

On Mon, 24 Sep 2018 at 06:38, Greg Ungerer <gerg@linux-m68k.org> wrote:
>
> Hi Firoz,
>
> On 21/09/18 01:06, Firoz Khan wrote:
> > The purpose of this patch series is:
> > 1. We can easily add/modify/delete system call by changing entry
> > in syscall.tbl file. No need to manually edit many files.
> >
> > 2. It is easy to unify the system call implementation across all
> > the architectures.
> >
> > The system call tables are in different format in all architecture
> > and it will be difficult to manually add or modify the system calls
> > in the respective files manually. To make it easy by keeping a script
> > and which'll generate the header file and syscall table file so this
> > change will unify them across all architectures.
> >
> > syscall.tbl contains the list of available system calls along with
> > system call number and corresponding entry point. Add a new system
> > call in this architecture will be possible by adding new entry in
> > the syscall.tbl file.
> >
> > Adding a new table entry consisting of:
> >          - System call number.
> >          - ABI.
> >          - System call name.
> >          - Entry point name.
> >          - Compat entry name, if required.
> >
> > ARM, s390 and x86 architecuture does exist the similar support. I
> > leverage their implementation to come up with a generic solution.
> >
> > I have done the same support for work for alpha, microblaze, sparc,
> > mips, parisc, powerpc, sh, sparc, and xtensa. But I started sending
> > the patch for one architecuture for review. Below mentioned git
> > repository contains more details.
> > Git repo:- https://github.com/frzkhn/system_call_table_generator/
> >
> > Added an extra patch to keep __IGNORE* entries in asm/unistd.h.
> >
> > Finally, this is the ground work for solving the Y2038 issue. We
> > need to add/change two dozen of system calls to solve Y2038 issue.
> > So this patch series will help to easily modify from existing
> > system call to Y2038 compatible system calls.
> >
> > Firoz Khan (5):
> >    m68k: Rename system call table file name
> >    m68k: Replace NR_syscalls macro from asm/unistd.h
> >    m68k: Added system call table generation support
> >    m68k: uapi header and system call table file generation
> >    m68k: added __IGNORE* entries in asm/unistd.h
>
> Built and tested on a couple of m68k/ColdFire targets,
> m520x (no MMU) and m5475 (with MMU). Load and run on real hardware,
> no problems found. So for m68knommu/ColdFire:

Thanks for your support!

Philippe De Muyter shared one comment. I have to include that change in the
patch series. BTW I can post version 3 patch series within couple of days.

It would be great if someone can review this patches now and share
your comments.
So I can include it in the next version.

- Firoz

>
> Tested-by: Greg Ungerer <gerg@linux-m68k.org>
>
> Regards
> Greg
>
>
> >   arch/m68k/Makefile                      |   3 +
> >   arch/m68k/include/asm/Kbuild            |   1 +
> >   arch/m68k/include/asm/unistd.h          |  10 +-
> >   arch/m68k/include/uapi/asm/Kbuild       |   1 +
> >   arch/m68k/include/uapi/asm/unistd.h     | 385 +-----------------------------
> >   arch/m68k/kernel/Makefile               |   2 +-
> >   arch/m68k/kernel/syscall_table.S        |  14 ++
> >   arch/m68k/kernel/syscalls/Makefile      |  37 +++
> >   arch/m68k/kernel/syscalls/syscall.tbl   | 369 +++++++++++++++++++++++++++++
> >   arch/m68k/kernel/syscalls/syscallhdr.sh |  39 ++++
> >   arch/m68k/kernel/syscalls/syscalltbl.sh |  28 +++
> >   arch/m68k/kernel/syscalltable.S         | 403 --------------------------------
> >   12 files changed, 502 insertions(+), 790 deletions(-)
> >   create mode 100644 arch/m68k/kernel/syscall_table.S
> >   create mode 100644 arch/m68k/kernel/syscalls/Makefile
> >   create mode 100644 arch/m68k/kernel/syscalls/syscall.tbl
> >   create mode 100644 arch/m68k/kernel/syscalls/syscallhdr.sh
> >   create mode 100644 arch/m68k/kernel/syscalls/syscalltbl.sh
> >   delete mode 100644 arch/m68k/kernel/syscalltable.S
> >
