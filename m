From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [GIT PULL] siginfo work for v4.18-rc1
Date: Sun, 03 Jun 2018 23:16:37 -0500
Message-ID: <87in6zmbiy.fsf@xmission.com>
References: <87o9grmbrp.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87o9grmbrp.fsf@xmission.com> (Eric W. Biederman's message of
        "Sun, 03 Jun 2018 23:11:22 -0500")
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Linus,

Please pull the siginfo-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git siginfo-linus

   HEAD: 26da35010c6d6ce317d511c8186585bdd8ab6629 signal/sh: Stop gcc warning about an impossible case in do_divide_error

Apologies for the resend I spaced and forgot the diffstat earlier.

This set of changes close the known issues with setting si_code to an
invalid value, and with not fully initializing struct siginfo.  There
remains work to do on nds32, arc, unicore32, powerpc, arm, arm64, ia64
and x86 to get the code that generates siginfo into a simpler and more
maintainable state.  Most of that work involves refactoring the signal
handling code and thus careful code review.

Also not included is the work to shrink the in kernel version of struct
siginfo.  That depends on getting the number of places that directly
manipulate struct siginfo under control, as it requires the introduction
of struct kernel_siginfo for the in kernel things.

Overall this set of changes looks like it is making good progress,
and with a little luck I will be wrapping up the siginfo work
next development cycle.

Dmitry V. Levin (1):
      sparc: fix compat siginfo ABI regression

Eric W. Biederman (44):
      signal/alpha: Document a conflict with SI_USER for SIGFPE
      signal/sh: Use force_sig_fault in hw_breakpoint_handler
      signal/nds32: Use force_sig in unhandled_interruption and unhandled_exceptions
      signal/nds32: Use force_sig(SIGILL) in do_revisn
      signal: Ensure every siginfo we send has all bits initialized
      signal: Reduce copy_siginfo_to_user to just copy_to_user
      signal: Stop special casing TRAP_FIXME and FPE_FIXME in siginfo_layout
      signal: Remove SEGV_BNDERR ifdefs
      signal: Remove ifdefs for BUS_MCEERR_AR and BUS_MCEERR_AO
      signal/alpha: Replace FPE_FIXME with FPE_FLTUNK
      signal/ia64: Replace FPE_FIXME with FPE_FLTUNK
      signal/powerpc: Replace FPE_FIXME with FPE_FLTUNK
      signal/unicore32: Use FPE_FLTUNK instead of 0 in ucf64_raise_sigfpe
      signal: Add TRAP_UNK si_code for undiagnosted trap exceptions
      signal/alpha:  Replace TRAP_FIXME with TRAP_UNK
      signal/powerpc: Replace TRAP_FIXME with TRAP_UNK
      signal/alpha: Use send_sig_fault where appropriate
      signal/alpha: Use force_sig_fault where appropriate
      signal/c6x: Use force_sig_fault where appropriate
      signal/hexagon: Use force_sig_fault as appropriate
      signal/m68k: Use force_sig_fault where appropriate
      signal/microblaze: Remove the commented out force_sig_info in do_page_fault
      signal/microblaze: Use force_sig_fault where appropriate
      signal/mips: Use force_sig_fault where appropriate
      signal/nds32: Use force_sig_fault where appropriate
      signal/nios2: Use force_sig_fault where appropriate
      signal/openrisc: Use force_sig_fault where appropriate
      signal/parisc: Use force_sig_mceerr where appropriate
      signal/parisc: Use force_sig_fault where appropriate
      signal/riscv: Use force_sig_fault where appropriate
      signal/riscv: Replace do_trap_siginfo with force_sig_fault
      signal/s390: Use force_sig_fault where appropriate
      signal/sh: Use force_sig_fault where appropriate
      signal/sparc: Use send_sig_fault where appropriate
      signal/sparc: Use force_sig_fault where appropriate
      signal/um: Use force_sig_fault where appropriate
      signal/xtensa: Consistenly use SIGBUS in do_unaligned_user
      signal/xtensa: Use force_sig_fault where appropriate
      signal/signalfd: Remove __put_user from signalfd_copyinfo
      signal/signalfd: Add support for SIGSYS
      signal: Remove unncessary #ifdef SEGV_PKUERR in 32bit compat code
      signal: Extend siginfo_layout with SIL_FAULT_{MCEERR|BNDERR|PKUERR}
      signal/um: More carefully relay signals in relay_signal.
      signal/sh: Stop gcc warning about an impossible case in do_divide_error

Guenter Roeck (1):
      signal/mips: Report FPE_FLTUNK for undiagnosed floating point exceptions

 arch/alpha/include/uapi/asm/siginfo.h     |  14 ---
 arch/alpha/kernel/osf_sys.c               |  11 +-
 arch/alpha/kernel/signal.c                |  20 +---
 arch/alpha/kernel/traps.c                 |  79 ++++---------
 arch/alpha/mm/fault.c                     |  13 +--
 arch/arc/mm/fault.c                       |   2 +
 arch/arm/kernel/ptrace.c                  |   1 +
 arch/arm/kernel/swp_emulate.c             |   1 +
 arch/arm/kernel/traps.c                   |   5 +
 arch/arm/mm/alignment.c                   |   1 +
 arch/arm/mm/fault.c                       |   4 +
 arch/arm/vfp/vfpmodule.c                  |   3 +-
 arch/arm64/kernel/fpsimd.c                |   2 +-
 arch/arm64/kernel/sys_compat.c            |   1 +
 arch/arm64/kernel/traps.c                 |   1 +
 arch/arm64/mm/fault.c                     |  18 ++-
 arch/c6x/kernel/traps.c                   |   9 +-
 arch/hexagon/kernel/traps.c               |   9 +-
 arch/hexagon/mm/vm_fault.c                |  20 ++--
 arch/ia64/include/uapi/asm/siginfo.h      |   7 --
 arch/ia64/kernel/brl_emu.c                |   1 +
 arch/ia64/kernel/signal.c                 |   2 +
 arch/ia64/kernel/traps.c                  |  31 ++++-
 arch/ia64/kernel/unaligned.c              |   1 +
 arch/ia64/mm/fault.c                      |   4 +-
 arch/m68k/kernel/traps.c                  |  58 +++++-----
 arch/m68k/mm/fault.c                      |  25 ++---
 arch/microblaze/kernel/exceptions.c       |   8 +-
 arch/microblaze/mm/fault.c                |  12 +-
 arch/mips/kernel/traps.c                  |  65 +++--------
 arch/mips/mm/fault.c                      |  18 +--
 arch/nds32/kernel/traps.c                 |  35 ++----
 arch/nds32/mm/fault.c                     |  18 +--
 arch/nios2/kernel/traps.c                 |   8 +-
 arch/openrisc/kernel/traps.c              |  30 +----
 arch/openrisc/mm/fault.c                  |  18 +--
 arch/parisc/kernel/ptrace.c               |  10 +-
 arch/parisc/kernel/traps.c                |  61 ++++------
 arch/parisc/kernel/unaligned.c            |  15 +--
 arch/parisc/math-emu/driver.c             |   8 +-
 arch/parisc/mm/fault.c                    |  54 +++++----
 arch/powerpc/include/uapi/asm/siginfo.h   |  15 ---
 arch/powerpc/kernel/process.c             |   1 +
 arch/powerpc/kernel/traps.c               |  13 +--
 arch/powerpc/mm/fault.c                   |   1 +
 arch/powerpc/platforms/cell/spufs/fault.c |   2 +-
 arch/riscv/kernel/traps.c                 |  16 +--
 arch/s390/kernel/traps.c                  |  29 +----
 arch/s390/mm/fault.c                      |  21 +---
 arch/sh/kernel/hw_breakpoint.c            |   9 +-
 arch/sh/kernel/traps_32.c                 |  20 ++--
 arch/sh/math-emu/math.c                   |   8 +-
 arch/sh/mm/fault.c                        |   9 +-
 arch/sparc/include/uapi/asm/siginfo.h     |   7 --
 arch/sparc/kernel/process_64.c            |   9 +-
 arch/sparc/kernel/sys_sparc_32.c          |   8 +-
 arch/sparc/kernel/sys_sparc_64.c          |   8 +-
 arch/sparc/kernel/traps_32.c              | 104 ++++-------------
 arch/sparc/kernel/traps_64.c              | 131 +++++----------------
 arch/sparc/kernel/unaligned_32.c          |  11 +-
 arch/sparc/mm/fault_32.c                  |  12 +-
 arch/sparc/mm/fault_64.c                  |   8 +-
 arch/um/kernel/ptrace.c                   |  13 +--
 arch/um/kernel/trap.c                     |  62 ++++------
 arch/unicore32/kernel/fpu-ucf64.c         |   8 +-
 arch/unicore32/mm/fault.c                 |   3 +
 arch/x86/entry/vsyscall/vsyscall_64.c     |   2 +-
 arch/x86/kernel/ptrace.c                  |   2 +-
 arch/x86/kernel/signal_compat.c           |   2 +-
 arch/x86/kernel/traps.c                   |   3 +
 arch/x86/kernel/umip.c                    |   1 +
 arch/x86/kvm/mmu.c                        |   1 +
 arch/x86/mm/fault.c                       |   1 +
 arch/xtensa/kernel/traps.c                |   9 +-
 arch/xtensa/mm/fault.c                    |  18 +--
 fs/signalfd.c                             |  93 +++++++--------
 include/linux/ptrace.h                    |   1 -
 include/linux/signal.h                    |   3 +
 include/linux/tracehook.h                 |   1 +
 include/uapi/asm-generic/siginfo.h        |   3 +-
 include/uapi/linux/signalfd.h             |   6 +-
 kernel/signal.c                           | 181 +++++++++---------------------
 virt/kvm/arm/mmu.c                        |   1 +
 83 files changed, 493 insertions(+), 1066 deletions(-)

Eric
