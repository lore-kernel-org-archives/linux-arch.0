Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io1-f68.google.com ([209.85.166.68]:35604 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeKNRGV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Nov 2018 12:06:21 -0500
Received: by mail-io1-f68.google.com with SMTP id u19so6710413ioc.2
        for <linux-arch@vger.kernel.org>; Tue, 13 Nov 2018 23:04:25 -0800 (PST)
MIME-Version: 1.0
References: <1542173191-24981-1-git-send-email-firoz.khan@linaro.org> <CAOMdWSJ1NiMTThftBysvsntPdRBHN7gq_w19gtzi6KmBKAdz+Q@mail.gmail.com>
In-Reply-To: <CAOMdWSJ1NiMTThftBysvsntPdRBHN7gq_w19gtzi6KmBKAdz+Q@mail.gmail.com>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Wed, 14 Nov 2018 12:34:13 +0530
Message-ID: <CALxhOngcKwEGRQPu0qmK0ytDwfgoo0UHCHJSQsfacZ6XDrW8Ww@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] sparc: system call table generation support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: allen.lkml@gmail.com
Cc: "David S . Miller" <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20181114070413.SAQkTAmEQK2isoLYlZfCE8FoloWU-yFtjv-xmUaCOr4@z>

Hi Allen,

On Wed, 14 Nov 2018 at 12:14, Allen <allen.lkml@gmail.com> wrote:
>
> > Changes since v2:
> >  - changed from generic-y to generated-y in Kbuild.
> >  - added io_pgetevents entry in the syscall.tbl.
> >  - updated the compat system call table.
> >
> > Changes since v1:
> >  - optimized/updated the syscall table generation
> >    scripts.
> >  - fixed all mixed indentation issues in syscall.tbl.
> >  - added "comments" in syscall.tbl.
> >
> > Firoz Khan (4):
> >   sparc: move __IGNORE* entries to non uapi header
> >   sparc: add __NR_syscalls along with NR_syscalls
> >   sparc: add system call table generation support
> >   sparc: generate uapi header and system call table files
>
> Tested and looks fine.

Great, thanks!

Firoz

>
> Tested-by: Allen Pais <allen.lkml@gmail.com>
>
> >  arch/sparc/Makefile                      |   3 +
> >  arch/sparc/include/asm/Kbuild            |   4 +-
> >  arch/sparc/include/asm/unistd.h          |  18 ++
> >  arch/sparc/include/uapi/asm/Kbuild       |   2 +
> >  arch/sparc/include/uapi/asm/unistd.h     | 426 +------------------------------
> >  arch/sparc/kernel/syscalls/Makefile      |  55 ++++
> >  arch/sparc/kernel/syscalls/syscall.tbl   | 409 +++++++++++++++++++++++++++++
> >  arch/sparc/kernel/syscalls/syscallhdr.sh |  36 +++
> >  arch/sparc/kernel/syscalls/syscalltbl.sh |  36 +++
> >  arch/sparc/kernel/systbls_32.S           |  81 +-----
> >  arch/sparc/kernel/systbls_64.S           | 157 +-----------
> >  11 files changed, 572 insertions(+), 655 deletions(-)
> >  create mode 100644 arch/sparc/kernel/syscalls/Makefile
> >  create mode 100644 arch/sparc/kernel/syscalls/syscall.tbl
> >  create mode 100644 arch/sparc/kernel/syscalls/syscallhdr.sh
> >  create mode 100644 arch/sparc/kernel/syscalls/syscalltbl.sh
> >
> > --
> > 1.9.1
> >
>
>
> --
>        - Allen
