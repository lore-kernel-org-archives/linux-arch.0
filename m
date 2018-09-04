Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35300 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbeIDJFY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Sep 2018 05:05:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id p12-v6so1049143pfh.2
        for <linux-arch@vger.kernel.org>; Mon, 03 Sep 2018 21:42:06 -0700 (PDT)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 0/4] System call table generation support
Date: Tue,  4 Sep 2018 10:11:23 +0530
Message-ID: <1536036087-15260-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20180904044123.-w7WnEqGjJu1bPeQ_HkaU-zExx8AFq49sU9Ah_p_vzw@z>

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
mips, parisc, powerpc, sh, sparc, and xtensa. But I started sending 
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
  sparc: Move __IGNORE* entries to non uapi header
  sparc: Replace NR_SYSCALLS macro with __NR_SYSCALLS
  sparc: Add system call table generation support
  sparc: uapi header and system call table file generation

 arch/sparc/Makefile                       |   3 +
 arch/sparc/include/asm/Kbuild             |   5 +-
 arch/sparc/include/asm/unistd.h           |  27 ++
 arch/sparc/include/uapi/asm/Kbuild        |   3 +
 arch/sparc/include/uapi/asm/unistd.h      | 434 +-----------------------------
 arch/sparc/kernel/Makefile                |   2 +-
 arch/sparc/kernel/head_64.S               |   2 +-
 arch/sparc/kernel/syscall_table_32.S      |  12 +
 arch/sparc/kernel/syscall_table_64.S      |  22 ++
 arch/sparc/kernel/syscalls/Makefile       |  50 ++++
 arch/sparc/kernel/syscalls/syscall_32.tbl | 365 +++++++++++++++++++++++++
 arch/sparc/kernel/syscalls/syscall_64.tbl | 349 ++++++++++++++++++++++++
 arch/sparc/kernel/syscalls/syscallhdr.sh  |  33 +++
 arch/sparc/kernel/syscalls/syscalltbl.sh  |  38 +++
 arch/sparc/kernel/systbls_32.S            |  93 -------
 arch/sparc/kernel/systbls_64.S            | 176 ------------
 16 files changed, 912 insertions(+), 702 deletions(-)
 create mode 100644 arch/sparc/kernel/syscall_table_32.S
 create mode 100644 arch/sparc/kernel/syscall_table_64.S
 create mode 100644 arch/sparc/kernel/syscalls/Makefile
 create mode 100644 arch/sparc/kernel/syscalls/syscall_32.tbl
 create mode 100644 arch/sparc/kernel/syscalls/syscall_64.tbl
 create mode 100644 arch/sparc/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/sparc/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/sparc/kernel/systbls_32.S
 delete mode 100644 arch/sparc/kernel/systbls_64.S

-- 
1.9.1
