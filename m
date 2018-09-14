Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42416 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbeINNq5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Sep 2018 09:46:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id y4-v6so4048180pgp.9
        for <linux-arch@vger.kernel.org>; Fri, 14 Sep 2018 01:33:32 -0700 (PDT)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 0/3] System call table generation support
Date: Fri, 14 Sep 2018 14:02:57 +0530
Message-ID: <1536913980-4811-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Ram Pai <linuxram@us.ibm.com>, Breno Leitao <leitao@debian.org>, Boqun Feng <boqun.feng@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20180914083257.F2t5jY-qW5cNW8PwR-M-TWmAd7lZZnCdUCBSgWZxgcY@z>

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
ia64, mips, parisc, sh, sparc, and xtensa. But I started sending 
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

Firoz Khan (3):
  powerpc: Replace NR_syscalls macro from asm/unistd.h
  powerpc: Add system call table generation support
  powerpc: uapi header and system call table file generation

 arch/powerpc/Makefile                       |   3 +
 arch/powerpc/include/asm/Kbuild             |   3 +
 arch/powerpc/include/asm/unistd.h           |   3 +-
 arch/powerpc/include/uapi/asm/Kbuild        |   2 +
 arch/powerpc/include/uapi/asm/unistd.h      | 391 +---------------------------
 arch/powerpc/kernel/Makefile                |   3 +-
 arch/powerpc/kernel/syscall_table_32.S      |   9 +
 arch/powerpc/kernel/syscall_table_64.S      |  17 ++
 arch/powerpc/kernel/syscalls/Makefile       |  51 ++++
 arch/powerpc/kernel/syscalls/syscall_32.tbl | 378 +++++++++++++++++++++++++++
 arch/powerpc/kernel/syscalls/syscall_64.tbl | 372 ++++++++++++++++++++++++++
 arch/powerpc/kernel/syscalls/syscallhdr.sh  |  37 +++
 arch/powerpc/kernel/syscalls/syscalltbl.sh  |  38 +++
 arch/powerpc/kernel/systbl.S                |  50 ----
 14 files changed, 916 insertions(+), 441 deletions(-)
 create mode 100644 arch/powerpc/kernel/syscall_table_32.S
 create mode 100644 arch/powerpc/kernel/syscall_table_64.S
 create mode 100644 arch/powerpc/kernel/syscalls/Makefile
 create mode 100644 arch/powerpc/kernel/syscalls/syscall_32.tbl
 create mode 100644 arch/powerpc/kernel/syscalls/syscall_64.tbl
 create mode 100644 arch/powerpc/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/powerpc/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/powerpc/kernel/systbl.S

-- 
1.9.1
