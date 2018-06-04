From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [GIT PULL] siginfo work for v4.18-rc1
Date: Sun, 03 Jun 2018 23:11:22 -0500
Message-ID: <87o9grmbrp.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


Linus,

Please pull the siginfo-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git siginfo-linus

   HEAD: 26da35010c6d6ce317d511c8186585bdd8ab6629 signal/sh: Stop gcc warning about an impossible case in do_divide_error

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

Eric
