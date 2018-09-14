Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37295 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeINNkk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Sep 2018 09:40:40 -0400
Received: by mail-pl1-f193.google.com with SMTP id f1-v6so3870466plt.4
        for <linux-arch@vger.kernel.org>; Fri, 14 Sep 2018 01:27:18 -0700 (PDT)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 0/4] System call table generation support
Date: Fri, 14 Sep 2018 13:56:39 +0530
Message-ID: <1536913603-4584-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thibaut Varene <T-Bone@parisc-linux.org>, linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20180914082639.MNJ76aX7ww8MXRO3GpvtZ2ZGxnU5XIoOQEiJWAB2HHI@z>

The purpose of this patch series is:
1. We can easily add/modify/delete system call by changing entry 
in syscall.tbl file. No need to manually edit many files.

2. It is easy to unify the system call implementation across all 
the architectures. 

The system call tables are in different format in all architecture 
and it will be difficult to manually add or modify the system calls
in the respective files manually. To make it easy by keeping a script 
and which'll generate the header file and syscall table file so this 
change will unify them across all architectures.

syscall.tbl contains the list of available system calls along with 
system call number and corresponding entry point. Add a new system 
call in this architecture will be possible by adding new entry in 
the syscall.tbl file.

Adding a new table entry consisting of:
        - System call number.
        - ABI.
        - System call name.
        - Entry point name.
        - Compat entry name, if required.

ARM, s390 and x86 architecuture does exist the similar support. I 
leverage their implementation to come up with a generic solution.

I have done the same support for work for alpha, m68k, microblaze, 
ia64, mips, powerpc, sh, sparc, and xtensa. But I started sending 
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
It will generate a new syscall.tbl. But I still use the old file - 
syscall.tbl and once all review got over I'll update syscall.tbl 
alone w.r.to the tip of the kernel. The impact of this thing, few 
of the system call won't work. 

Firoz Khan (4):
  parisc: Move __IGNORE* entries to non uapi header
  parisc: Replace __NR_Linux_syscalls macro with __NR_syscalls
  parisc: Add system call table generation support
  parisc: uapi header and system call table file generation

 arch/parisc/Makefile                       |   4 +
 arch/parisc/include/asm/Kbuild             |   3 +
 arch/parisc/include/asm/unistd.h           |   8 +
 arch/parisc/include/uapi/asm/Kbuild        |   2 +
 arch/parisc/include/uapi/asm/unistd.h      | 377 +----------------------
 arch/parisc/kernel/syscall.S               |  14 +-
 arch/parisc/kernel/syscall_table.S         | 459 -----------------------------
 arch/parisc/kernel/syscall_table_32.S      |  11 +
 arch/parisc/kernel/syscall_table_64.S      |  19 ++
 arch/parisc/kernel/syscalls/Makefile       |  52 ++++
 arch/parisc/kernel/syscalls/syscall_32.tbl | 358 ++++++++++++++++++++++
 arch/parisc/kernel/syscalls/syscall_64.tbl | 357 ++++++++++++++++++++++
 arch/parisc/kernel/syscalls/syscallhdr.sh  |  38 +++
 arch/parisc/kernel/syscalls/syscalltbl.sh  |  36 +++
 14 files changed, 896 insertions(+), 842 deletions(-)
 delete mode 100644 arch/parisc/kernel/syscall_table.S
 create mode 100644 arch/parisc/kernel/syscall_table_32.S
 create mode 100644 arch/parisc/kernel/syscall_table_64.S
 create mode 100644 arch/parisc/kernel/syscalls/Makefile
 create mode 100644 arch/parisc/kernel/syscalls/syscall_32.tbl
 create mode 100644 arch/parisc/kernel/syscalls/syscall_64.tbl
 create mode 100644 arch/parisc/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/parisc/kernel/syscalls/syscalltbl.sh

-- 
1.9.1
