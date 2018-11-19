Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io1-f68.google.com ([209.85.166.68]:34029 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeKSPa6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Nov 2018 10:30:58 -0500
Received: by mail-io1-f68.google.com with SMTP id f6so18300593iob.1
        for <linux-arch@vger.kernel.org>; Sun, 18 Nov 2018 21:08:30 -0800 (PST)
MIME-Version: 1.0
References: <1542169930-24118-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542169930-24118-1-git-send-email-firoz.khan@linaro.org>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Mon, 19 Nov 2018 10:38:20 +0530
Message-ID: <CALxhOnis61eCGyS22e0_s5PLOimsNX+mhgMa_-enLWQ=EarBfg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] sh: system call table generation support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20181119050820.zMVmyESiplnbieBnfnVF0pBbFb1qTCD9XGlts3j-rIw@z>

On Wed, 14 Nov 2018 at 10:02, Firoz Khan <firoz.khan@linaro.org> wrote:
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
>
> Please note, this support is only available for 32-bit
> kernel, not 64-bit kernel. As I came across the 64-bit
> kernel is not active for long time.
>
> ARM, s390 and x86 architecuture does exist the sim-
> ilar support. I leverage their implementation to come
> up with a generic solution.
>
> I have done the same support for work for alpha, ia64,
> m68k, microblaze, mips, parisc, powerpc, sparc, and
> xtensa. Below mentioned git repository contains more
> details about the workflow.
>
> https://github.com/frzkhn/system_call_table_generator/
>
> Finally, this is the ground work to solve the Y2038
> issue. We need to add two dozen of system calls to solve
> Y2038 issue. So this patch series will help to add new
> system calls easily by adding new entry in the syscall-
> .tbl.
>
> Changes since v2:
>  - changed from generic-y to generated-y in Kbuild.
>
> Changes since v1:
>  - optimized/updated the syscall table generation
>    scripts.
>  - fixed all mixed indentation issues in syscall.tbl.
>  - added "comments" in syscall.tbl.
>
> Firoz Khan (3):
>   sh: add __NR_syscalls along with NR_syscalls
>   sh: add system call table generation support
>   sh: generate uapi header and syscall table header files

Gentle reminder!

Could someone review this patch series. I haven't received any
feedback till now.

FYI, this support is only available for 32-bit kernel, not 64-bit
kernel. As I came across the 64-bit kernel is not active for long time.

Thanks
Firoz

>
>  arch/sh/Makefile                      |   3 +
>  arch/sh/include/asm/Kbuild            |   1 +
>  arch/sh/include/asm/unistd.h          |   2 +
>  arch/sh/include/uapi/asm/Kbuild       |   1 +
>  arch/sh/include/uapi/asm/unistd_32.h  |   4 +-
>  arch/sh/include/uapi/asm/unistd_64.h  |   4 +-
>  arch/sh/kernel/syscalls/Makefile      |  38 ++++
>  arch/sh/kernel/syscalls/syscall.tbl   | 392 ++++++++++++++++++++++++++++++++++
>  arch/sh/kernel/syscalls/syscallhdr.sh |  36 ++++
>  arch/sh/kernel/syscalls/syscalltbl.sh |  32 +++
>  arch/sh/kernel/syscalls_32.S          | 387 +--------------------------------
>  11 files changed, 514 insertions(+), 386 deletions(-)
>  create mode 100644 arch/sh/kernel/syscalls/Makefile
>  create mode 100644 arch/sh/kernel/syscalls/syscall.tbl
>  create mode 100644 arch/sh/kernel/syscalls/syscallhdr.sh
>  create mode 100644 arch/sh/kernel/syscalls/syscalltbl.sh
>
> --
> 1.9.1
>
