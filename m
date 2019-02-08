Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33563 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfBHXGF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Feb 2019 18:06:05 -0500
MIME-Version: 1.0
References: <CAK8P3a3pPwnOW7pXjOhU386zCekAda+p8AgzbOM6ybT=dKMGwA@mail.gmail.com>
In-Reply-To: <CAK8P3a3pPwnOW7pXjOhU386zCekAda+p8AgzbOM6ybT=dKMGwA@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 9 Feb 2019 00:05:48 +0100
Message-ID: <CAK8P3a2+NBY58T75zjSrE59+iOXuny+rpWfk_zfzzr3=PAsVuw@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] arch: System call unification and cleanup
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20190208230548.je3L3c3mFX7C1SE9fCq_4DdKxXXPYoHneXEz7NLP_Ko@z>

The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the Git repository at:

  git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git
tags/y2038-new-syscalls

for you to fetch changes up to 48166e6ea47d23984f0b481ca199250e1ce0730a:

  y2038: add 64-bit time_t syscalls to all 32-bit architectures
(2019-02-07 00:13:28 +0100)

----------------------------------------------------------------
y2038: Add time64 system calls

This series finally gets us to the point of having system calls with
64-bit time_t on all architectures, after a long time of incremental
preparation patches.

There was actually one conversion that I missed during the summer,
i.e. Deepa's timex series, which I now updated based the 5.0-rc1 changes
and review comments.

The following system calls are now added on all 32-bit architectures
using the same system call numbers:

403 clock_gettime64
404 clock_settime64
405 clock_adjtime64
406 clock_getres_time64
407 clock_nanosleep_time64
408 timer_gettime64
409 timer_settime64
410 timerfd_gettime64
411 timerfd_settime64
412 utimensat_time64
413 pselect6_time64
414 ppoll_time64
416 io_pgetevents_time64
417 recvmmsg_time64
418 mq_timedsend_time64
419 mq_timedreceiv_time64
420 semtimedop_time64
421 rt_sigtimedwait_time64
422 futex_time64
423 sched_rr_get_interval_time64

Each one of these corresponds directly to an existing system call
that includes a 'struct timespec' argument, or a structure containing
a timespec or (in case of clock_adjtime) timeval. Not included here
are new versions of getitimer/setitimer and getrusage/waitid, which
are planned for the future but only needed to make a consistent API
rather than for correct operation beyond y2038. These four system
calls are based on 'timeval', and it has not been finally decided
what the replacement kernel interface will use instead.

So far, I have done a lot of build testing across most architectures,
which has found a number of bugs. Runtime testing so far included
testing LTP on 32-bit ARM with the existing system calls, to ensure
we do not regress for existing binaries, and a test with a 32-bit
x86 build of LTP against a modified version of the musl C library
that has been adapted to the new system call interface [3].
This library can be used for testing on all architectures supported
by musl-1.1.21, but it is not how the support is getting integrated
into the official musl release. Official musl support is planned
but will require more invasive changes to the library.

Link: https://lore.kernel.org/lkml/20190110162435.309262-1-arnd@arndb.de/T/
Link: https://lore.kernel.org/lkml/20190118161835.2259170-1-arnd@arndb.de/
Link: https://git.linaro.org/people/arnd/musl-y2038.git/ [2]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Arnd Bergmann (31):
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
      time: make adjtime compat handling available for 32 bit
      time: fix sys_timer_settime prototype
      sparc64: add custom adjtimex/clock_adjtime functions
      x86/x32: use time64 versions of sigtimedwait and recvmmsg
      y2038: syscalls: rename y2038 compat syscalls
      y2038: use time32 syscall names on 32-bit
      y2038: remove struct definition redirects
      y2038: rename old time and utime syscalls
      y2038: add 64-bit time_t syscalls to all 32-bit architectures

Deepa Dinamani (3):
      time: Add struct __kernel_timex
      timex: use __kernel_timex internally
      timex: change syscalls to use struct __kernel_timex

 arch/Kconfig                                |   2 +-
 arch/alpha/include/asm/unistd.h             |  21 --
 arch/alpha/include/uapi/asm/unistd.h        |  10 +
 arch/alpha/kernel/osf_sys.c                 |   5 +-
 arch/alpha/kernel/syscalls/syscall.tbl      |  22 +-
 arch/arm/include/asm/unistd.h               |   5 +-
 arch/arm/kernel/sys_oabi-compat.c           |   8 +-
 arch/arm/tools/syscall.tbl                  |  85 +++---
 arch/arm64/include/asm/unistd.h             |   2 +-
 arch/arm64/include/asm/unistd32.h           |  99 +++++--
 arch/ia64/include/asm/unistd.h              |  14 -
 arch/ia64/include/uapi/asm/unistd.h         |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl       |  11 +-
 arch/m68k/include/asm/unistd.h              |   4 +-
 arch/m68k/kernel/syscalls/syscall.tbl       |  88 ++++--
 arch/microblaze/include/asm/unistd.h        |   4 +-
 arch/microblaze/kernel/syscalls/syscall.tbl |  83 +++---
 arch/mips/include/asm/unistd.h              |  17 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl   |  77 ++++--
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   7 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl   |  85 ++++--
 arch/parisc/include/asm/unistd.h            |  13 +-
 arch/parisc/kernel/syscalls/syscall.tbl     | 109 ++++++--
 arch/powerpc/include/asm/unistd.h           |   8 +-
 arch/powerpc/kernel/syscalls/syscall.tbl    | 134 +++++++--
 arch/s390/Kconfig                           |   2 +
 arch/s390/include/asm/syscall_wrapper.h     | 135 ++++++++++
 arch/s390/include/asm/unistd.h              |   7 +-
 arch/s390/include/uapi/asm/posix_types.h    |   6 +
 arch/s390/kernel/Makefile                   |   2 +-
 arch/s390/kernel/compat_linux.c             | 235 +---------------
 arch/s390/kernel/compat_wrapper.c           | 186 -------------
 arch/s390/kernel/entry.S                    |   4 +-
 arch/s390/kernel/sys_s390.c                 |  16 +-
 arch/s390/kernel/syscalls/syscall.tbl       | 373 +++++++++++++------------
 arch/sh/include/asm/unistd.h                |   4 +-
 arch/sh/include/uapi/asm/unistd_32.h        | 403 ----------------------------
 arch/sh/kernel/syscalls/syscall.tbl         |  88 ++++--
 arch/sparc/include/asm/unistd.h             |  13 +-
 arch/sparc/kernel/sys_sparc_64.c            |  61 ++++-
 arch/sparc/kernel/syscalls/syscall.tbl      | 116 ++++++--
 arch/x86/entry/syscalls/syscall_32.tbl      |  85 ++++--
 arch/x86/entry/syscalls/syscall_64.tbl      |   6 +-
 arch/x86/include/asm/unistd.h               |   8 +-
 arch/xtensa/include/asm/unistd.h            |  14 +-
 arch/xtensa/kernel/syscalls/syscall.tbl     |  78 ++++--
 drivers/ptp/ptp_clock.c                     |   2 +-
 fs/aio.c                                    |  10 +-
 fs/select.c                                 |   4 +-
 fs/timerfd.c                                |   4 +-
 fs/utimes.c                                 |  10 +-
 include/linux/compat.h                      | 104 +------
 include/linux/posix-clock.h                 |   2 +-
 include/linux/syscalls.h                    |  72 ++++-
 include/linux/time32.h                      |  32 ++-
 include/linux/time64.h                      |   8 -
 include/linux/timex.h                       |   4 +-
 include/uapi/asm-generic/unistd.h           | 103 ++++---
 include/uapi/linux/time.h                   |   4 -
 include/uapi/linux/timex.h                  |  39 +++
 ipc/mqueue.c                                |  16 +-
 ipc/msg.c                                   |  39 ++-
 ipc/sem.c                                   |  41 ++-
 ipc/shm.c                                   |  40 ++-
 ipc/syscall.c                               |  32 ++-
 ipc/util.h                                  |  21 +-
 kernel/compat.c                             |  64 -----
 kernel/futex.c                              |   2 +-
 kernel/sched/core.c                         |   5 +-
 kernel/signal.c                             |   2 +-
 kernel/sys_ni.c                             |  22 +-
 kernel/time/hrtimer.c                       |   2 +-
 kernel/time/ntp.c                           |  18 +-
 kernel/time/ntp_internal.h                  |   2 +-
 kernel/time/posix-clock.c                   |   2 +-
 kernel/time/posix-stubs.c                   |  25 +-
 kernel/time/posix-timers.c                  |  72 +++--
 kernel/time/posix-timers.h                  |   2 +-
 kernel/time/time.c                          |  92 ++++++-
 kernel/time/timekeeping.c                   |   4 +-
 net/compat.c                                |   2 +-
 scripts/checksyscalls.sh                    |  40 +++
 82 files changed, 1870 insertions(+), 1830 deletions(-)
 create mode 100644 arch/s390/include/asm/syscall_wrapper.h
 delete mode 100644 arch/s390/kernel/compat_wrapper.c
 delete mode 100644 arch/sh/include/uapi/asm/unistd_32.h
