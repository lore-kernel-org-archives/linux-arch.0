From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 0/6] System call table generation support
Date: Mon, 16 Jul 2018 15:53:52 +0530
Message-ID: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-alpha@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, Firoz Khan <firoz.khan@linaro.org>
List-Id: linux-arch.vger.kernel.org

The goal of this patch series is to easily add/modify/delete a
system call by changing entry in syscall.tbl file. No need
to manually edit many files.

The another goal of this patch series is to to unify the system
call implementation across all the architectures. ARM, s390 and 
x86 architecuture does have the similar support. I leverage their 
implementation to come up with a generic solution.

I have done the same support for work for ia64, m68k, microblaze, 
mips, parisc, powerpc, sh, sparc, and xtensa. But I started sending 
the patch for one architecuture for review. Below mentioned git
repository contains more details.
Git repo:- https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work for solving the Y2038 issue. We 
need to change two dozen of system calls to solve Y2038 issue. So
this implementation will help to easily modify from existing system
call to Y2038 compatible system calls.

Firoz Khan (6):
  alpha: Move __IGNORE* entries to non uapi header
  alpha: Add CONFIG_OSF4_COMPAT for compat syscall support
  alpha: Unify the not-implemented system call entry name
  alpha: Replace NR_SYSCALLS macro from asm/unistd.h
  alpha: Add system call table generation support
  alpha: uapi header and system call table file generation

 arch/alpha/Makefile                      |   3 +
 arch/alpha/include/asm/Kbuild            |   3 +-
 arch/alpha/include/asm/unistd.h          |   7 +-
 arch/alpha/include/uapi/asm/Kbuild       |   2 +
 arch/alpha/include/uapi/asm/unistd.h     | 489 ---------------------------
 arch/alpha/kernel/Makefile               |   2 +-
 arch/alpha/kernel/entry.S                |   4 +-
 arch/alpha/kernel/osf_sys.c              |   9 +-
 arch/alpha/kernel/syscall.S              |  20 ++
 arch/alpha/kernel/syscalls/Makefile      |  37 +++
 arch/alpha/kernel/syscalls/syscall.tbl   | 450 +++++++++++++++++++++++++
 arch/alpha/kernel/syscalls/syscallhdr.sh |  33 ++
 arch/alpha/kernel/syscalls/syscalltbl.sh |  28 ++
 arch/alpha/kernel/systbls.S              | 552 -------------------------------
 14 files changed, 589 insertions(+), 1050 deletions(-)
 delete mode 100644 arch/alpha/include/uapi/asm/unistd.h
 create mode 100644 arch/alpha/kernel/syscall.S
 create mode 100644 arch/alpha/kernel/syscalls/Makefile
 create mode 100644 arch/alpha/kernel/syscalls/syscall.tbl
 create mode 100644 arch/alpha/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/alpha/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/alpha/kernel/systbls.S

-- 
2.7.4
