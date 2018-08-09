Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl0-f51.google.com ([209.85.160.51]:34582 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbeHIHvS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Aug 2018 03:51:18 -0400
Received: by mail-pl0-f51.google.com with SMTP id f6-v6so2056218plo.1
        for <linux-arch@vger.kernel.org>; Wed, 08 Aug 2018 22:28:16 -0700 (PDT)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 0/3] System call table generation support
Date: Thu,  9 Aug 2018 10:57:43 +0530
Message-ID: <1533792466-4227-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Simek <monstr@monstr.eu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20180809052743.aCMDRJO8iosQAkvhG02-wii_5J0ROu-yHu4JEBoOet0@z>

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

I have done the same support for work for alpha, ia64,m68k, mips,
parisc, powerpc, sh, sparc, and xtensa. But I started sending 
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
  microblaze: Replace NR_syscalls macro from asm/unistd.h
  microblaze: Added system call table generation support
  microblaze: uapi header and system call table file generation

 arch/microblaze/Makefile                      |   3 +
 arch/microblaze/include/asm/Kbuild            |   2 +
 arch/microblaze/include/asm/unistd.h          |   2 -
 arch/microblaze/include/uapi/asm/Kbuild       |   2 +
 arch/microblaze/include/uapi/asm/unistd.h     | 407 +-------------------------
 arch/microblaze/kernel/syscall_table.S        | 406 +------------------------
 arch/microblaze/kernel/syscalls/Makefile      |  37 +++
 arch/microblaze/kernel/syscalls/syscall.tbl   | 404 +++++++++++++++++++++++++
 arch/microblaze/kernel/syscalls/syscallhdr.sh |  33 +++
 arch/microblaze/kernel/syscalls/syscalltbl.sh |  28 ++
 10 files changed, 514 insertions(+), 810 deletions(-)
 create mode 100644 arch/microblaze/kernel/syscalls/Makefile
 create mode 100644 arch/microblaze/kernel/syscalls/syscall.tbl
 create mode 100644 arch/microblaze/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/microblaze/kernel/syscalls/syscalltbl.sh

-- 
1.9.1
