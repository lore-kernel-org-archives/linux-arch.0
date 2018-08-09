Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43040 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbeHIIAU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Aug 2018 04:00:20 -0400
Received: by mail-pl0-f65.google.com with SMTP id x6-v6so2050332plv.10
        for <linux-arch@vger.kernel.org>; Wed, 08 Aug 2018 22:37:16 -0700 (PDT)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 0/3] System call table generation support
Date: Thu,  9 Aug 2018 11:06:42 +0530
Message-ID: <1533793005-4525-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20180809053642.Rl38MCaZuAZO1OV-Jk1zDWiFoWYsW_f6FCrHVtwiABQ@z>

The purpose of this patch series is:
1. We can easily add/modify/delete system call by changing entry 
in syscall.tbl file. No need to manually edit many files.

2. It is easy to unify the system call implementation across all 
the architectures. 

The system call tables are in different format in all architecture 
and it will be difficult to manually add or modify the system calls
manually in the respective files. To make it easy by keeping a script 
and which'll generate the header file and syscall table file so this 
change will unify the implementation across all architectures.

syscall.tbl contains the list of available system calls along with 
system call number and corresponding entry point. Add a new system 
call in this architecture will be possible by adding new entry in 
the syscall.tbl file.

Adding a new table entry consisting of:
        - System call number.
        - ABI.
        - System call name.
        - Entry point name.

Important thing to note, I have added this support only for 32-bit
ABI. It seems like no one using 64-bit ABI for long time. But it is
very easy to add the support for64-bit. Please let me know if any-
one need this support:)

ARM, s390 and x86 architecuture does exist the similar support. I 
leverage their implementation to come up with a generic solution.

I have done the same support for work for alpha, m68k, microblaze, 
ia64, mips, parisc, powerpc, sparc, and xtensa. But I started sending 
the patch for one architecuture for review. Below mentioned git
repository contains more details.
Git repo:- https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work for solving the Y2038 issue. We 
need to add/change two dozen of system calls to solve Y2038 issue. 
So this patch series will help to easily modify from existing 
system call to Y2038 compatible system calls.

I started working system call table generation on 4.17-rc1. I used 
marcin's script - https://github.com/hrw/syscalls-table to generate 
the syscall.tbl file. And this will be the input to the system call 
table generation script. But there are couple system call got add 
in the latest rc release. If run Marcin's script on latest release,
it will generate a different syscall.tbl. But I still use the old 
file - syscall.tbl and once all review got over I'll update 
syscall.tbl alone w.r.to the tip of the kernel. The impact of this
is, few of the system call won't work.

Firoz Khan (3):
  sh: Rename NR_syscalls macro to __NR_syscalls
  sh: Added system call table generation support
  sh: uapi header and system call table file generation

 arch/sh/Makefile                      |   3 +
 arch/sh/include/asm/Kbuild            |   2 +
 arch/sh/include/asm/ftrace.h          |   2 +-
 arch/sh/include/uapi/asm/Kbuild       |   2 +
 arch/sh/include/uapi/asm/unistd_32.h  |   2 +-
 arch/sh/include/uapi/asm/unistd_64.h  |   2 +-
 arch/sh/kernel/Makefile               |   2 +-
 arch/sh/kernel/cpu/sh5/entry.S        |   2 +-
 arch/sh/kernel/entry-common.S         |   2 +-
 arch/sh/kernel/syscall.S              |   9 +
 arch/sh/kernel/syscalls/Makefile      |  37 ++++
 arch/sh/kernel/syscalls/syscall.tbl   | 388 ++++++++++++++++++++++++++++++++
 arch/sh/kernel/syscalls/syscallhdr.sh |  33 +++
 arch/sh/kernel/syscalls/syscalltbl.sh |  28 +++
 arch/sh/kernel/syscalls_32.S          | 402 ----------------------------------
 15 files changed, 508 insertions(+), 408 deletions(-)
 create mode 100644 arch/sh/kernel/syscall.S
 create mode 100644 arch/sh/kernel/syscalls/Makefile
 create mode 100644 arch/sh/kernel/syscalls/syscall.tbl
 create mode 100644 arch/sh/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/sh/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/sh/kernel/syscalls_32.S

-- 
1.9.1
