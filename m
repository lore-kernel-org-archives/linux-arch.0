Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39970 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfBHXEz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Feb 2019 18:04:55 -0500
MIME-Version: 1.0
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 9 Feb 2019 00:04:37 +0100
Message-ID: <CAK8P3a3pPwnOW7pXjOhU386zCekAda+p8AgzbOM6ybT=dKMGwA@mail.gmail.com>
Subject: [GIT PULL 1/2] arch: System call unification and cleanup
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20190208230437.Z8fGoOF8XP2W_ff3BiNsMIjpCnbS9VXNRJFWy97R1eU@z>

The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the Git repository at:

  git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git
tags/y2038-syscall-cleanup

for you to fetch changes up to 805089c2f77047d81f47ddc227435d606ceb180e:

  syscalls: remove obsolete __IGNORE_ macros (2019-02-07 00:13:27 +0100)

----------------------------------------------------------------
arch: System call unification and cleanup

The system call tables have diverged a bit over the years, and a number
of the recent additions never made it into all architectures, for one
reason or another.

This is an attempt to clean it up as far as we can without breaking
compatibility, doing a number of steps:

- Add system calls that have not yet been integrated into all
  architectures but that we definitely want there. This includes
  {,f}statfs64() and get{eg,eu,g,p,u,pp}id() on alpha, which have
  been missing traditionally.

- The s390 compat syscall handling is cleaned up to be more like
  what we do on other architectures, while keeping the 31-bit
  pointer extension. This was merged as a shared branch by the
  s390 maintainers and is included here in order to base the other
  patches on top.

- Add the separate ipc syscalls on all architectures that
  traditionally only had sys_ipc(). This version is done without
  support for IPC_OLD that is we have in sys_ipc. The
  new semtimedop_time64 syscall will only be added here, not
  in sys_ipc

- Add syscall numbers for a couple of syscalls that we probably
  don't need everywhere, in particular pkey_* and rseq,
  for the purpose of symmetry: if it's in asm-generic/unistd.h,
  it makes sense to have it everywhere. I expect that any future
  system calls will get assigned on all platforms together, even
  when they appear to be specific to a single architecture.

- Prepare for having the same system call numbers for any future
  calls. In combination with the generated tables, this hopefully
  makes it easier to add new calls across all architectures
  together.

All of the above are technically separate from the y2038 work,
but are done as preparation before we add the new 64-bit time_t
system calls everywhere, providing a common baseline set of system
calls.

I expect that glibc and other libraries that want to use 64-bit
time_t will require linux-5.1 kernel headers for building in
the future, and at a much later point may also require linux-5.1
or a later version as the minimum kernel at runtime. Having a
common baseline then allows the removal of many architecture or
kernel version specific workarounds.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Arnd Bergmann (22):
      s390: open-code s390_personality syscall
      ipc: introduce ksys_ipc()/compat_ksys_ipc() for s390
      s390: use generic UID16 implementation
      s390: autogenerate compat syscall wrappers
      s390: remove compat_wrapper.c
      ia64: add __NR_umount2 definition
      ia64: add statx and io_pgetevents syscalls
      ia64: assign syscall numbers for perf and seccomp
      alpha: wire up io_pgetevents system call
      alpha: update syscall macro definitions
      ARM: add migrate_pages() system call
      ARM: add kexec_file_load system call number
      m68k: assign syscall number for seccomp
      sh: remove duplicate unistd_32.h file
      sh: add statx system call
      sparc64: fix sparc_ipc type conversion
      ipc: rename old-style shmctl/semctl/msgctl syscalls
      arch: add split IPC system calls where needed
      arch: add pkey and rseq syscall numbers everywhere
      alpha: add standard statfs64/fstatfs64 syscalls
      alpha: add generic get{eg,eu,g,p,u,pp}id() syscalls
      syscalls: remove obsolete __IGNORE_ macros

 arch/alpha/include/asm/unistd.h             |  21 --
 arch/alpha/include/uapi/asm/unistd.h        |  10 +
 arch/alpha/kernel/syscalls/syscall.tbl      |  20 +-
 arch/arm/include/asm/unistd.h               |   1 -
 arch/arm/tools/syscall.tbl                  |   8 +-
 arch/arm64/include/asm/unistd.h             |   2 +-
 arch/arm64/include/asm/unistd32.h           |  10 +-
 arch/ia64/include/asm/unistd.h              |  14 -
 arch/ia64/include/uapi/asm/unistd.h         |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl       |  10 +-
 arch/m68k/kernel/syscalls/syscall.tbl       |  16 ++
 arch/microblaze/kernel/syscalls/syscall.tbl |   6 +-
 arch/mips/include/asm/unistd.h              |  13 -
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   6 +-
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   6 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl   |  11 +
 arch/parisc/include/asm/unistd.h            |   4 -
 arch/parisc/kernel/syscalls/syscall.tbl     |   4 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |  13 +
 arch/s390/Kconfig                           |   2 +
 arch/s390/include/asm/syscall_wrapper.h     | 135 ++++++++++
 arch/s390/include/asm/unistd.h              |   5 -
 arch/s390/include/uapi/asm/posix_types.h    |   6 +
 arch/s390/kernel/Makefile                   |   2 +-
 arch/s390/kernel/compat_linux.c             | 235 +---------------
 arch/s390/kernel/compat_wrapper.c           | 186 -------------
 arch/s390/kernel/entry.S                    |   4 +-
 arch/s390/kernel/sys_s390.c                 |  16 +-
 arch/s390/kernel/syscalls/syscall.tbl       | 301 +++++++++++----------
 arch/sh/include/uapi/asm/unistd_32.h        | 403 ----------------------------
 arch/sh/kernel/syscalls/syscall.tbl         |  16 ++
 arch/sparc/include/asm/unistd.h             |   5 -
 arch/sparc/kernel/sys_sparc_64.c            |   2 +-
 arch/sparc/kernel/syscalls/syscall.tbl      |  16 ++
 arch/x86/entry/syscalls/syscall_32.tbl      |  11 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   2 +
 arch/xtensa/include/asm/unistd.h            |  12 -
 arch/xtensa/kernel/syscalls/syscall.tbl     |   7 +-
 include/linux/syscalls.h                    |   7 +
 include/uapi/asm-generic/unistd.h           |   1 +
 ipc/msg.c                                   |  39 ++-
 ipc/sem.c                                   |  39 ++-
 ipc/shm.c                                   |  40 ++-
 ipc/syscall.c                               |  32 ++-
 ipc/util.h                                  |  21 +-
 kernel/sys_ni.c                             |   4 +
 46 files changed, 608 insertions(+), 1118 deletions(-)
 create mode 100644 arch/s390/include/asm/syscall_wrapper.h
 delete mode 100644 arch/s390/kernel/compat_wrapper.c
 delete mode 100644 arch/sh/include/uapi/asm/unistd_32.h
