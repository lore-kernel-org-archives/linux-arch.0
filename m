From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [GIT PULL] siginfo cleanups for 4.16-rc1
Date: Mon, 29 Jan 2018 14:02:30 -0600
Message-ID: <87372oph61.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>
List-Id: linux-arch.vger.kernel.org


Linus,

Please pull the siginfo-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git siginfo-linus

   HEAD: c0f45555b82450a56c0da11866163b764aeb1a21 signal/memory-failure: Use force_sig_mceerr and send_sig_mceerr

Long ago when 2.4 was just a testing release copy_siginfo_to_user was
made to copy individual fields to userspace, possibly for efficiency and
to ensure initialized values were not copied to userspace.
Unfortunately the design was complex, it's assumptions unstated, and
humans are failible and so while work much of the time that design
failed to ensure unitialized memory is not copied to userspace.

This set of changes is part of a new design to clean up siginfo
and simplify things, and hopefully make the siginfo handling robust
enough that a simple inspection of the code can be made to ensure we
don't copy any unitializied fields to userspace.

The design is to unifiy struct siginfo and struct compat_siginfo
into a single definition that is shared between all architectures so
that anyone adding to the set of information shared with struct siginfo
can see the whole picture.  Hopefully ensuring all future si_code
assignments are arch independent.

The design is to unify copy_siginfo_to_user32 and
copy_siginfo_from_user32 so that those function are complete and cope
with all of the different cases documented in signinfo_layout.  I don't
think there was a single implementation of either of those functions
that was complete and correct before my changes unified them.

The design is to introduce a series of helpers including
force_siginfo_fault that take the values that are needed in struct
siginfo and build the siginfo structure for their callers.  Ensuring
struct siginfo is built correctly.

The remaining work for 4.17 (unless someone thinks it is post -rc1
material) is to push usage of those helpers down into the architectures
so that architecture specific code will not need to deal with the fiddly
work of intializing struct siginfo, and then when struct siginfo is
guaranteed to be fully initialized change copy siginfo_to_user into
a simple wrapper around copy_to_user.

Further there is work in progress on the issues that have been
documented requires arch specific knowledge to sort out.

The changes below fix or at least document all of the issues that have
been found with siginfo generation.  Then proceed to unify struct
siginfo the 32 bit helpers that copy siginfo to and from userspace,
and generally clean up anything that is not arch specific with
regards to siginfo generation.

It is a lot but with the unification you can of siginfo you can
already see the code reduction in the kernel.

Eric

Al Viro (3):
      signal/mips: switch mips to generic siginfo
      signal: kill __ARCH_SI_UID_T
      signal: unify compat_siginfo_t

Eric W. Biederman (42):
      signal: Simplify and fix kdb_send_sig
      signal/sh: Ensure si_signo is initialized in do_divide_error
      signal/openrisc: Fix do_unaligned_access to send the proper signal
      signal/parisc: Document a conflict with SI_USER with SIGFPE
      signal/metag: Document a conflict with SI_USER with SIGFPE
      signal/powerpc: Document conflicts with SI_USER and SIGFPE and SIGTRAP
      signal/arm64: Document conflicts with SI_USER and SIGFPE,SIGTRAP,SIGBUS
      signal/arm: Document conflicts with SI_USER and SIGFPE
      signal: Reduce copy_siginfo to just a memcpy
      signal: Introduce clear_siginfo
      signal: Ensure generic siginfos the kernel sends have all bits initialized
      mn10300/misalignment: Use SIGSEGV SEGV_MAPERR to report a failed user copy
      x86/mm/pkeys: Fix fill_sig_info_pkey
      signal: Document all of the signals that use the _sigfault union member
      signal: Document the strange si_codes used by ptrace event stops
      signal: Document glibc's si_code of SI_ASYNCNL
      signal: Ensure no siginfo union member increases the size of struct siginfo
      signal: Clear si_sys_private before copying siginfo to userspace
      signal: Remove _sys_private and _overrun_incr from struct compat_siginfo
      ia64/signal: switch to generic struct siginfo
      signal/ia64: switch the last arch-specific copy_siginfo_to_user() to generic version
      signal: Remove unnecessary ifdefs now that there is only one struct siginfo
      signal: Move addr_lsb into the _sigfault union for clarity
      signal/powerpc: Remove redefinition of NSIGTRAP on powerpc
      signal/ia64: Move the ia64 specific si_codes to asm-generic/siginfo.h
      signal/frv: Move the frv specific si_codes to asm-generic/siginfo.h
      signal/tile: Move the tile specific si_codes to asm-generic/siginfo.h
      signal/blackfin: Move the blackfin specific si_codes to asm-generic/siginfo.h
      signal/blackfin: Remove pointless UID16_SIGINFO_COMPAT_NEEDED
      signal: Unify and correct copy_siginfo_from_user32
      signal: Remove the code to clear siginfo before calling copy_siginfo_from_user32
      signal: Unify and correct copy_siginfo_to_user32
      ptrace: Use copy_siginfo in setsiginfo and getsiginfo
      signal/arm64: Better isolate the COMPAT_TASK portion of ptrace_hbptriggered
      signal: Don't use structure initializers for struct siginfo
      signal: Replace memset(info,...) with clear_siginfo for clarity
      signal: Add send_sig_fault and force_sig_fault
      signal: Helpers for faults with specialized siginfo layouts
      signal/powerpc: Remove unnecessary signal_code parameter of do_send_trap
      signal/ptrace: Add force_sig_ptrace_errno_trap and use it where needed
      mm/memory_failure: Remove unused trapno from memory_failure
      signal/memory-failure: Use force_sig_mceerr and send_sig_mceerr

 arch/arc/kernel/traps.c                            |  14 +-
 arch/arm/include/uapi/asm/siginfo.h                |  13 +
 arch/arm/kernel/ptrace.c                           |   8 +-
 arch/arm/vfp/vfpmodule.c                           |   2 +-
 arch/arm64/include/asm/compat.h                    |  64 ----
 arch/arm64/include/uapi/asm/siginfo.h              |  21 ++
 arch/arm64/kernel/debug-monitors.c                 |  13 +-
 arch/arm64/kernel/fpsimd.c                         |   2 +-
 arch/arm64/kernel/ptrace.c                         |  42 +--
 arch/arm64/kernel/signal32.c                       |  80 -----
 arch/arm64/mm/fault.c                              | 114 +++----
 arch/blackfin/include/uapi/asm/siginfo.h           |  34 --
 arch/frv/include/uapi/asm/Kbuild                   |   1 +
 arch/frv/include/uapi/asm/siginfo.h                |  13 -
 arch/ia64/include/uapi/asm/siginfo.h               |  96 ------
 arch/ia64/kernel/signal.c                          |  52 ---
 arch/m68k/mm/fault.c                               |   3 +-
 arch/metag/include/uapi/asm/siginfo.h              |   7 +
 arch/metag/kernel/traps.c                          |   2 +-
 arch/mips/include/asm/compat.h                     |  73 -----
 arch/mips/include/uapi/asm/siginfo.h               |  86 +----
 arch/mips/kernel/signal32.c                        |  67 ----
 arch/mips/kernel/traps.c                           |  29 +-
 arch/mn10300/mm/misalignment.c                     |   2 +-
 arch/openrisc/kernel/traps.c                       |  10 +-
 arch/parisc/include/asm/compat.h                   |  64 ----
 arch/parisc/include/uapi/asm/siginfo.h             |   7 +
 arch/parisc/kernel/pdt.c                           |   2 +-
 arch/parisc/kernel/signal32.c                      | 106 -------
 arch/parisc/kernel/signal32.h                      |   3 -
 arch/parisc/kernel/traps.c                         |   2 +-
 arch/powerpc/include/asm/compat.h                  |  65 ----
 arch/powerpc/include/asm/debug.h                   |   2 +-
 arch/powerpc/include/uapi/asm/siginfo.h            |  16 +-
 arch/powerpc/kernel/process.c                      |  13 +-
 arch/powerpc/kernel/signal_32.c                    |  66 ----
 arch/powerpc/kernel/traps.c                        |  22 +-
 .../powerpc/platforms/powernv/opal-memory-errors.c |   2 +-
 arch/s390/include/asm/compat.h                     |  73 -----
 arch/s390/kernel/compat_signal.c                   | 100 ------
 arch/sh/kernel/traps_32.c                          |   3 +-
 arch/sparc/include/asm/compat.h                    |  59 ----
 arch/sparc/kernel/signal32.c                       |  69 ----
 arch/tile/include/asm/compat.h                     |  62 ----
 arch/tile/include/uapi/asm/siginfo.h               |   8 -
 arch/tile/kernel/compat_signal.c                   |  73 -----
 arch/tile/kernel/single_step.c                     |  24 +-
 arch/tile/kernel/traps.c                           |   4 +-
 arch/tile/kernel/unaligned.c                       |  46 +--
 arch/um/kernel/trap.c                              |   2 +-
 arch/x86/include/asm/compat.h                      |  86 +----
 arch/x86/include/asm/fpu/signal.h                  |   6 -
 arch/x86/kernel/cpu/mcheck/mce.c                   |   6 +-
 arch/x86/kernel/signal_compat.c                    | 123 +-------
 arch/x86/mm/fault.c                                |   7 +-
 arch/xtensa/kernel/ptrace.c                        |   8 +-
 drivers/acpi/apei/ghes.c                           |   2 +-
 drivers/base/memory.c                              |   2 +-
 drivers/ras/cec.c                                  |   2 +-
 drivers/usb/core/devio.c                           |   4 +-
 fs/fcntl.c                                         |   1 +
 include/linux/compat.h                             | 100 +++++-
 include/linux/mm.h                                 |   4 +-
 include/linux/sched/signal.h                       |  28 ++
 include/linux/signal.h                             |  15 +-
 include/uapi/asm-generic/siginfo.h                 | 109 +++++--
 ipc/mqueue.c                                       |   1 +
 kernel/debug/kdb/kdb_main.c                        |  10 +-
 kernel/debug/kdb/kdb_private.h                     |   2 +-
 kernel/ptrace.c                                    |   5 +-
 kernel/seccomp.c                                   |   2 +-
 kernel/signal.c                                    | 350 +++++++++++++++++++--
 kernel/time/posix-timers.c                         |   2 +-
 mm/hwpoison-inject.c                               |   2 +-
 mm/madvise.c                                       |   2 +-
 mm/memory-failure.c                                |  48 ++-
 76 files changed, 858 insertions(+), 1810 deletions(-)
