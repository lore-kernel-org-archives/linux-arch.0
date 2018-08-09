Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34936 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbeHIHi4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Aug 2018 03:38:56 -0400
Received: by mail-pl0-f68.google.com with SMTP id w3-v6so2042047plq.2
        for <linux-arch@vger.kernel.org>; Wed, 08 Aug 2018 22:15:57 -0700 (PDT)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 0/4] System call table generation support
Date: Thu,  9 Aug 2018 10:45:19 +0530
Message-ID: <1533791723-3882-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20180809051519.v3wpqt6r50yE56b9ufTb-1mVNVQ5f8YWh28NaOWNoZY@z>

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

ARM, s390 and x86 architecuture does exist the similar support. I 
leverage their implementation to come up with a generic solution.

I have done the same support for work for alpha, microblaze, ia64, 
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
it will generate a different syscall.tbl. But I still use the old 
file - syscall.tbl and once all review got over I'll update 
syscall.tbl alone w.r.to the tip of the kernel. The impact of this
is, few of the system call won't work.

Firoz Khan (4):
  m68k: Rename system call table file name
  m68k: Replace NR_syscalls macro from asm/unistd.h
  m68k: Added system call table generation support
  m68k: uapi header and system call table file generation

 arch/m68k/68000/entry.S                 |   4 +-
 arch/m68k/Makefile                      |   3 +
 arch/m68k/coldfire/entry.S              |   2 +-
 arch/m68k/include/asm/Kbuild            |   2 +
 arch/m68k/include/asm/unistd.h          |   3 -
 arch/m68k/include/uapi/asm/Kbuild       |   2 +
 arch/m68k/include/uapi/asm/unistd.h     | 385 +-----------------------------
 arch/m68k/kernel/Makefile               |   2 +-
 arch/m68k/kernel/entry.S                |   4 +-
 arch/m68k/kernel/syscall_table.S        |  14 ++
 arch/m68k/kernel/syscalls/Makefile      |  37 +++
 arch/m68k/kernel/syscalls/syscall.tbl   | 386 ++++++++++++++++++++++++++++++
 arch/m68k/kernel/syscalls/syscallhdr.sh |  33 +++
 arch/m68k/kernel/syscalls/syscalltbl.sh |  28 +++
 arch/m68k/kernel/syscalltable.S         | 403 --------------------------------
 15 files changed, 512 insertions(+), 796 deletions(-)
 create mode 100644 arch/m68k/kernel/syscall_table.S
 create mode 100644 arch/m68k/kernel/syscalls/Makefile
 create mode 100644 arch/m68k/kernel/syscalls/syscall.tbl
 create mode 100644 arch/m68k/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/m68k/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/m68k/kernel/syscalltable.S

-- 
1.9.1
