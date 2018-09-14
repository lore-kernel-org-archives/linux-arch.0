Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42088 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbeINNwc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Sep 2018 09:52:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so3966172pff.9
        for <linux-arch@vger.kernel.org>; Fri, 14 Sep 2018 01:39:05 -0700 (PDT)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 0/3] System call table generation support
Date: Fri, 14 Sep 2018 14:08:31 +0530
Message-ID: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>, linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20180914083831.QDk5m_9Bk2camDMCABbtSWANgwUm8Gb9c-ByV1_XWJM@z>

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
ia64, powerpc, parisc, sh, sparc, and xtensa. But I started sending 
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
  mips: Add __NR_syscalls macro in uapi/asm/unistd.h
  mips: Add system call table generation support
  mips: uapi header and system call table file generation

 arch/mips/Makefile                        |    3 +
 arch/mips/include/asm/Kbuild              |    4 +
 arch/mips/include/uapi/asm/Kbuild         |    3 +
 arch/mips/include/uapi/asm/unistd.h       | 1053 +----------------------------
 arch/mips/kernel/scall32-o32.S            |  385 +----------
 arch/mips/kernel/scall64-64.S             |  334 +--------
 arch/mips/kernel/scall64-n32.S            |  337 +--------
 arch/mips/kernel/scall64-o32.S            |  374 +---------
 arch/mips/kernel/syscall_table_32_o32.S   |    8 +
 arch/mips/kernel/syscall_table_64_64.S    |    9 +
 arch/mips/kernel/syscall_table_64_n32.S   |    8 +
 arch/mips/kernel/syscall_table_64_o32.S   |    9 +
 arch/mips/kernel/syscalls/Makefile        |   62 ++
 arch/mips/kernel/syscalls/README.md       |   16 +
 arch/mips/kernel/syscalls/syscall_32.tbl  |  375 ++++++++++
 arch/mips/kernel/syscalls/syscall_64.tbl  |  335 +++++++++
 arch/mips/kernel/syscalls/syscall_n32.tbl |  339 ++++++++++
 arch/mips/kernel/syscalls/syscallhdr.sh   |   37 +
 arch/mips/kernel/syscalls/syscalltbl.sh   |   44 ++
 19 files changed, 1268 insertions(+), 2467 deletions(-)
 create mode 100644 arch/mips/kernel/syscall_table_32_o32.S
 create mode 100644 arch/mips/kernel/syscall_table_64_64.S
 create mode 100644 arch/mips/kernel/syscall_table_64_n32.S
 create mode 100644 arch/mips/kernel/syscall_table_64_o32.S
 create mode 100644 arch/mips/kernel/syscalls/Makefile
 create mode 100644 arch/mips/kernel/syscalls/README.md
 create mode 100644 arch/mips/kernel/syscalls/syscall_32.tbl
 create mode 100644 arch/mips/kernel/syscalls/syscall_64.tbl
 create mode 100644 arch/mips/kernel/syscalls/syscall_n32.tbl
 create mode 100644 arch/mips/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/mips/kernel/syscalls/syscalltbl.sh

-- 
1.9.1
