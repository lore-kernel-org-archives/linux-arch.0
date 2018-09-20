Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45911 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731487AbeITUug (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Sep 2018 16:50:36 -0400
Received: by mail-pl1-f195.google.com with SMTP id j8-v6so4473078pll.12
        for <linux-arch@vger.kernel.org>; Thu, 20 Sep 2018 08:06:43 -0700 (PDT)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH v2 0/5] System call table generation support
Date: Thu, 20 Sep 2018 20:36:08 +0530
Message-ID: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20180920150608.KXg9rJOGyUdmP5wgPW7YmQAWI21nxO-WRowy5rPsA4k@z>

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

I have done the same support for work for alpha, microblaze, sparc,
mips, parisc, powerpc, sh, sparc, and xtensa. But I started sending 
the patch for one architecuture for review. Below mentioned git
repository contains more details.
Git repo:- https://github.com/frzkhn/system_call_table_generator/

Added an extra patch to keep __IGNORE* entries in asm/unistd.h.

Finally, this is the ground work for solving the Y2038 issue. We 
need to add/change two dozen of system calls to solve Y2038 issue. 
So this patch series will help to easily modify from existing 
system call to Y2038 compatible system calls.

Firoz Khan (5):
  m68k: Rename system call table file name
  m68k: Replace NR_syscalls macro from asm/unistd.h
  m68k: Added system call table generation support
  m68k: uapi header and system call table file generation
  m68k: added __IGNORE* entries in asm/unistd.h

 arch/m68k/Makefile                      |   3 +
 arch/m68k/include/asm/Kbuild            |   1 +
 arch/m68k/include/asm/unistd.h          |  10 +-
 arch/m68k/include/uapi/asm/Kbuild       |   1 +
 arch/m68k/include/uapi/asm/unistd.h     | 385 +-----------------------------
 arch/m68k/kernel/Makefile               |   2 +-
 arch/m68k/kernel/syscall_table.S        |  14 ++
 arch/m68k/kernel/syscalls/Makefile      |  37 +++
 arch/m68k/kernel/syscalls/syscall.tbl   | 369 +++++++++++++++++++++++++++++
 arch/m68k/kernel/syscalls/syscallhdr.sh |  39 ++++
 arch/m68k/kernel/syscalls/syscalltbl.sh |  28 +++
 arch/m68k/kernel/syscalltable.S         | 403 --------------------------------
 12 files changed, 502 insertions(+), 790 deletions(-)
 create mode 100644 arch/m68k/kernel/syscall_table.S
 create mode 100644 arch/m68k/kernel/syscalls/Makefile
 create mode 100644 arch/m68k/kernel/syscalls/syscall.tbl
 create mode 100644 arch/m68k/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/m68k/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/m68k/kernel/syscalltable.S

-- 
1.9.1
