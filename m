Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f176.google.com ([209.85.215.176]:42844 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbeKNP2h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Nov 2018 10:28:37 -0500
Received: by mail-pg1-f176.google.com with SMTP id d72so3377120pga.9
        for <linux-arch@vger.kernel.org>; Tue, 13 Nov 2018 21:26:58 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH v3 0/4] sparc: system call table generation support
Date: Wed, 14 Nov 2018 10:56:27 +0530
Message-ID: <1542173191-24981-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20181114052627.z2fS6hZ0tT0S2f3J_XA6-YK6SGx_rd-BBsAZ3VTGMjY@z>

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
itecture will be possible by adding new entry in 
the syscall.tbl file.

Adding a new table entry consisting of:
        - System call number.
        - ABI.
        - System call name.
        - Entry point name.
	- Compat entry name, if required.

ARM, s390 and x86 architecuture does exist the sim-
ilar support. I leverage their implementation to 
come up with a generic solution.

I have done the same support for work for alpha, 
ia64, m68k, microblaze, mips, parisc, powerpc, sh 
and xtensa. Below mentioned git repository contains
more details about the workflow.

https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work to solve the Y2038
issue. We need to add two dozen of system calls to 
solve Y2038 issue. So this patch series will help to
add new system calls easily by adding new entry in the
syscall.tbl.

Changes since v2:
 - changed from generic-y to generated-y in Kbuild.
 - added io_pgetevents entry in the syscall.tbl.
 - updated the compat system call table.

Changes since v1:
 - optimized/updated the syscall table generation 
   scripts.
 - fixed all mixed indentation issues in syscall.tbl.
 - added "comments" in syscall.tbl.

Firoz Khan (4):
  sparc: move __IGNORE* entries to non uapi header
  sparc: add __NR_syscalls along with NR_syscalls
  sparc: add system call table generation support
  sparc: generate uapi header and system call table files

 arch/sparc/Makefile                      |   3 +
 arch/sparc/include/asm/Kbuild            |   4 +-
 arch/sparc/include/asm/unistd.h          |  18 ++
 arch/sparc/include/uapi/asm/Kbuild       |   2 +
 arch/sparc/include/uapi/asm/unistd.h     | 426 +------------------------------
 arch/sparc/kernel/syscalls/Makefile      |  55 ++++
 arch/sparc/kernel/syscalls/syscall.tbl   | 409 +++++++++++++++++++++++++++++
 arch/sparc/kernel/syscalls/syscallhdr.sh |  36 +++
 arch/sparc/kernel/syscalls/syscalltbl.sh |  36 +++
 arch/sparc/kernel/systbls_32.S           |  81 +-----
 arch/sparc/kernel/systbls_64.S           | 157 +-----------
 11 files changed, 572 insertions(+), 655 deletions(-)
 create mode 100644 arch/sparc/kernel/syscalls/Makefile
 create mode 100644 arch/sparc/kernel/syscalls/syscall.tbl
 create mode 100644 arch/sparc/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/sparc/kernel/syscalls/syscalltbl.sh

-- 
1.9.1
