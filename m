Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46718 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbeIXNHC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Sep 2018 09:07:02 -0400
MIME-Version: 1.0
References: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Sep 2018 09:06:09 +0200
Message-ID: <CAMuHMdVnnBRyt1MdNz4=nT4_ahPVUa8ReYkK1_cACsykPEJ_Kg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] System call table generation support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: firoz.khan@linaro.org
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, Greg KH <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, marcin.juszkiewicz@linaro.org
Message-ID: <20180924070609.A_r30o-Urlqb6N1WimyPx1c7UmLQJVqCI8pdnCMbzrQ@z>

On Thu, Sep 20, 2018 at 5:06 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> The purpose of this patch series is:
> 1. We can easily add/modify/delete system call by changing entry
> in syscall.tbl file. No need to manually edit many files.
>
> 2. It is easy to unify the system call implementation across all
> the architectures.
>
> The system call tables are in different format in all architecture
> and it will be difficult to manually add or modify the system calls
> in the respective files manually. To make it easy by keeping a script
> and which'll generate the header file and syscall table file so this
> change will unify them across all architectures.
>
> syscall.tbl contains the list of available system calls along with
> system call number and corresponding entry point. Add a new system
> call in this architecture will be possible by adding new entry in
> the syscall.tbl file.
>
> Adding a new table entry consisting of:
>         - System call number.
>         - ABI.
>         - System call name.
>         - Entry point name.
>         - Compat entry name, if required.
>
> ARM, s390 and x86 architecuture does exist the similar support. I
> leverage their implementation to come up with a generic solution.
>
> I have done the same support for work for alpha, microblaze, sparc,
> mips, parisc, powerpc, sh, sparc, and xtensa. But I started sending
> the patch for one architecuture for review. Below mentioned git
> repository contains more details.
> Git repo:- https://github.com/frzkhn/system_call_table_generator/
>
> Added an extra patch to keep __IGNORE* entries in asm/unistd.h.
>
> Finally, this is the ground work for solving the Y2038 issue. We
> need to add/change two dozen of system calls to solve Y2038 issue.
> So this patch series will help to easily modify from existing
> system call to Y2038 compatible system calls.
>
> Firoz Khan (5):
>   m68k: Rename system call table file name
>   m68k: Replace NR_syscalls macro from asm/unistd.h
>   m68k: Added system call table generation support
>   m68k: uapi header and system call table file generation
>   m68k: added __IGNORE* entries in asm/unistd.h
>
>  arch/m68k/Makefile                      |   3 +
>  arch/m68k/include/asm/Kbuild            |   1 +
>  arch/m68k/include/asm/unistd.h          |  10 +-
>  arch/m68k/include/uapi/asm/Kbuild       |   1 +
>  arch/m68k/include/uapi/asm/unistd.h     | 385 +-----------------------------
>  arch/m68k/kernel/Makefile               |   2 +-
>  arch/m68k/kernel/syscall_table.S        |  14 ++
>  arch/m68k/kernel/syscalls/Makefile      |  37 +++
>  arch/m68k/kernel/syscalls/syscall.tbl   | 369 +++++++++++++++++++++++++++++
>  arch/m68k/kernel/syscalls/syscallhdr.sh |  39 ++++
>  arch/m68k/kernel/syscalls/syscalltbl.sh |  28 +++
>  arch/m68k/kernel/syscalltable.S         | 403 --------------------------------
>  12 files changed, 502 insertions(+), 790 deletions(-)
>  create mode 100644 arch/m68k/kernel/syscall_table.S
>  create mode 100644 arch/m68k/kernel/syscalls/Makefile
>  create mode 100644 arch/m68k/kernel/syscalls/syscall.tbl
>  create mode 100644 arch/m68k/kernel/syscalls/syscallhdr.sh
>  create mode 100644 arch/m68k/kernel/syscalls/syscalltbl.sh
>  delete mode 100644 arch/m68k/kernel/syscalltable.S

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
