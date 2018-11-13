Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42194 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731911AbeKMURV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Nov 2018 15:17:21 -0500
Received: by mail-pl1-f194.google.com with SMTP id x21-v6so3059492pln.9
        for <linux-arch@vger.kernel.org>; Tue, 13 Nov 2018 02:19:56 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH v2 0/3] xtensa: system call table generation support
Date: Tue, 13 Nov 2018 15:49:27 +0530
Message-ID: <1542104370-22831-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20181113101927.e7y1sbZEXnXfEAKOliyhf8e4A12clWOtD1JHxHnhtGE@z>

The purpose of this patch series is, we can easily
add/modify/delete system call table support by cha-
nging entry in syscall.tbl file instead of manually
changing many files. The other goal is to unify the 
system call table generation support implementation 
across all the architectures. 

The system call tables are in different format in 
all architecture. It will be difficult to manually
add, modify or delete the system calls in the resp-
ective files manually. To make it easy by keeping a 
script and which'll generate uapi header file and 
syscall table file.

syscall.tbl contains the list of available system 
calls along with system call number and correspond-
ing entry point. Add a new system call in this arch-
itecture will be possible by adding new entry in the
syscall.tbl file.

Adding a new table entry consisting of:
        - System call number.
        - ABI.
        - System call name.
        - Entry point name.

ARM, s390 and x86 architecuture does exist the sim-
ilar support. I leverage their implementation to come
up with a generic solution.

I have done the same support for work for alpha, ia64,
m68k, microblaze, mips, parisc, powerpc, sh and sparc.
Below mentioned git repository contains more details 
about the workflow.

https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work to solve the Y2038
issue. We need to add two dozen of system calls to solve
Y2038 issue. So this patch series will help to add new 
system calls easily by adding new entry in the syscall.tbl.

changes since v1:
 - changed from generic-y to generated-y in Kbuild.
 - removed the patch "0001-xtensa-move-SYS_XTENSA_-
   macros-to-non-uapi-header.patch".

Firoz Khan (3):
  xtensa: add __NR_syscalls along with __NR_syscall_count
  xtensa: add system call table generation support
  xtensa: generate uapi header and syscall table header files

 arch/xtensa/Makefile                      |   3 +
 arch/xtensa/include/asm/Kbuild            |   1 +
 arch/xtensa/include/asm/unistd.h          |   2 +
 arch/xtensa/include/uapi/asm/Kbuild       |   1 +
 arch/xtensa/include/uapi/asm/unistd.h     | 781 +-----------------------------
 arch/xtensa/kernel/syscall.c              |   5 +-
 arch/xtensa/kernel/syscalls/Makefile      |  38 ++
 arch/xtensa/kernel/syscalls/syscall.tbl   | 374 ++++++++++++++
 arch/xtensa/kernel/syscalls/syscallhdr.sh |  36 ++
 arch/xtensa/kernel/syscalls/syscalltbl.sh |  32 ++
 10 files changed, 492 insertions(+), 781 deletions(-)
 create mode 100644 arch/xtensa/kernel/syscalls/Makefile
 create mode 100644 arch/xtensa/kernel/syscalls/syscall.tbl
 create mode 100644 arch/xtensa/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/xtensa/kernel/syscalls/syscalltbl.sh

-- 
1.9.1
