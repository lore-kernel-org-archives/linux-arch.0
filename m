From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 00/45] remove in-kernel syscall invocations (part 3 == remainder outside arch/)
Date: Thu, 22 Mar 2018 10:00:14 +0100
Message-ID: <20180322090059.19361-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Here is a third series of patches which reduce the number of syscall
invocations from within the kernel. Once this long-term goal is achieved,
the syscall entry path can be streamlined.

This series builds on top of

- part1 (random bits and pieces) 
  http://lkml.kernel.org/r/20180315190529.20943-1-linux@dominikbrodowski.net

- part2 (net)
  http://lkml.kernel.org/r/20180316170614.5392-1-linux@dominikbrodowski.net

and replaces the RFC of a subset of this series. Most of the patches are
just "mindless" conversions and helpers. If wrappers or helpers are limited
to one subsystem, I have named them do_*(), kern_*() or __sys_*(), depending
on what was used by the subsystem and/or what was still available. Otherwise,
I have used ksys_*() to reflect that this is meant as a drop-in replacement
for sys_*() within the kernel.

With this third series, *all* in-kernel callers of sys_*() and compat_sys_*()
outside of arch/ are converted.[*] On top of this, three things may be
attempted now:

- ptregs system call conversion for x86-64.

- re-work initramfs etc. code to not use in-kernel equivalents of
   syscalls, but operate on the VFS level instead.

- re-work SYSCALL_DEFINEx() / COMPAT_SYSCALL_DEFINEx() to do the right
  thing depending on arch-specific requirements on padding, long long handling,
  etc. (Al Viro). 

Also thrown in are a patch by Michael Tautschnig to use proper
SYSCALL_DEFINE0() macros on x86 and a patch by Howard McLauchlan to whitelist
all syscalls for error injection.

The whole series, including part 1 and part 2, can be found at

        https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git syscalls-next

Thanks,
	Dominik

[*] Within arch, only x86 is fully covered by these series.

Dominik Brodowski (43):
  fs: add ksys_getdents64() helper; remove in-kernel calls to
    sys_getdents64()
  fs: add ksys_ioctl() helper; remove in-kernel calls to sys_ioctl()
  fs: add ksys_lseek() helper; remove in-kernel calls to sys_lseek()
  fs: add ksys_read() helper; remove in-kernel calls to sys_read()
  fs: add ksys_sync() helper; remove in-kernel calls to sys_sync()
  fs: add do_lookup_dcookie() helper; remove in-kernel call to syscall
  fs: add do_vmsplice() helper; remove in-kernel call to syscall
  fs: add kern_select() helper; remove in-kernel call to sys_select()
  fs: add ksys_truncate() wrapper; remove in-kernel calls to
    sys_truncate()
  fs: add ksys_p{read,write}64() helpers; remove in-kernel calls to
    syscalls
  fs: add ksys_fallocate() wrapper; remove in-kernel calls to
    sys_fallocate()
  fs: add do_compat_fcntl64() helper; remove in-kernel call to comapt
    syscall
  fs: add do_compat_select() helper; remove in-kernel call to comapt
    syscall
  fs: add do_compat_signalfd4() helper; remove in-kernel call to comapt
    syscall
  fs: add do_compat_futimesat() helper; remove in-kernel call to comapt
    syscall
  inotify: add do_inotify_init() helper; remove in-kernel call to
    syscall
  fanotify: add do_fanotify_mark() helper; remove in-kernel call to
    syscall
  fs/quota: add kernel_quotactl() helper; remove in-kernel call to
    syscall
  fs/quota: use COMPAT_SYSCALL_DEFINE for sys32_quotactl()
  kernel: add do_compat_sigaltstack() helper; remove in-kernel call to
    compat syscall
  kernel: add ksys_setsid() helper; remove in-kernel call to
    sys_setsid()
  kernel: provide ksys_*() wrappers for syscalls called by
    kernel/uid16.c
  sched: add do_sched_yield() helper; remove in-kernel call to
    sched_yield()
  kexec: call do_kexec_load() in compat syscall directly
  mm: add kernel_migrate_pages() helper, move compat syscall to
    mm/mempolicy.c
  mm: add kernel_move_pages() helper, move compat syscall to
    mm/migrate.c
  mm: add kernel_mbind() helper; remove in-kernel call to syscall
  mm: add kernel_[sg]et_mempolicy() helpers; remove in-kernel calls to
    syscalls
  mm: add ksys_readahead() helper; remove in-kernel calls to
    sys_readahead()
  ipc: add semtimedop syscall/compat_syscall wrappers
  ipc: add semget syscall wrapper
  ipc: add semctl syscall/compat_syscall wrappers
  ipc: add msgget syscall wrapper
  ipc: add shmget syscall wrapper
  ipc: add shmdt syscall wrapper
  ipc: add shmctl syscall/compat_syscall wrappers
  ipc: add msgctl syscall/compat_syscall wrappers
  ipc: add msgrcv syscall/compat_syscall wrappers
  ipc: add msgsnd syscall/compat_syscall wrappers
  x86: use _do_fork() in compat_sys_x86_clone()
  x86: remove compat_sys_x86_waitpid()
  x86: fix sys_sigreturn() return type to be long, not unsigned long
  kernel/sys_ni: sort cond_syscall() entries

Howard McLauchlan (1):
  bpf: whitelist all syscalls for error injection

Tautschnig, Michael (1):
  x86/sigreturn: use SYSCALL_DEFINE0

 arch/mips/kernel/linux32.c             |  12 +-
 arch/parisc/kernel/sys_parisc.c        |  16 +-
 arch/powerpc/kernel/sys_ppc32.c        |  10 +-
 arch/s390/kernel/compat_linux.c        |  14 +-
 arch/sh/kernel/sys_sh32.c              |   4 +-
 arch/sparc/kernel/setup_32.c           |   2 +-
 arch/sparc/kernel/sys_sparc32.c        |  12 +-
 arch/x86/entry/syscalls/syscall_32.tbl |   4 +-
 arch/x86/ia32/sys_ia32.c               |  26 +-
 arch/x86/include/asm/sys_ia32.h        |   3 -
 arch/x86/include/asm/syscalls.h        |   2 +-
 arch/x86/kernel/signal.c               |   5 +-
 drivers/tty/sysrq.c                    |   2 +-
 fs/dcookies.c                          |  11 +-
 fs/fcntl.c                             |  12 +-
 fs/ioctl.c                             |   7 +-
 fs/notify/fanotify/fanotify_user.c     |  14 +-
 fs/notify/inotify/inotify_user.c       |   9 +-
 fs/open.c                              |   9 +-
 fs/quota/compat.c                      |  13 +-
 fs/quota/quota.c                       |  10 +-
 fs/read_write.c                        |  36 ++-
 fs/readdir.c                           |  11 +-
 fs/select.c                            |  29 +-
 fs/signalfd.c                          |  17 +-
 fs/splice.c                            |  12 +-
 fs/sync.c                              |   7 +-
 fs/utimes.c                            |  12 +-
 include/linux/compat.h                 |   6 +
 include/linux/quotaops.h               |   3 +
 include/linux/syscalls.h               |  27 +-
 init/do_mounts.c                       |  10 +-
 init/do_mounts_initrd.c                |   4 +-
 init/do_mounts_md.c                    |  15 +-
 init/do_mounts_rd.c                    |  22 +-
 init/initramfs.c                       |   4 +-
 ipc/msg.c                              |  60 +++-
 ipc/sem.c                              |  44 ++-
 ipc/shm.c                              |  28 +-
 ipc/syscall.c                          |  58 ++--
 ipc/util.h                             |  31 ++
 kernel/compat.c                        |  55 ----
 kernel/kexec.c                         |  50 +++-
 kernel/power/hibernate.c               |   2 +-
 kernel/power/suspend.c                 |   2 +-
 kernel/power/user.c                    |   2 +-
 kernel/sched/core.c                    |   8 +-
 kernel/signal.c                        |  14 +-
 kernel/sys.c                           |  65 ++++-
 kernel/sys_ni.c                        | 506 +++++++++++++++++++++------------
 kernel/uid16.c                         |  19 +-
 kernel/uid16.h                         |  14 +
 mm/mempolicy.c                         |  92 +++++-
 mm/migrate.c                           |  39 ++-
 mm/readahead.c                         |   7 +-
 55 files changed, 1030 insertions(+), 478 deletions(-)
 create mode 100644 kernel/uid16.h

-- 
2.16.2
