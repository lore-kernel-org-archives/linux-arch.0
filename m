From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 00/11] prctl: Modernise wiring for optional prctl() calls
Date: Mon, 14 May 2018 18:14:16 +0100
Message-ID: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, Fenghua Yu <fenghua.yu@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, James Hogan <jhogan@kernel.org>, Kees Cook <keescook@chromium.org>, Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Henderson <rth@twiddle.net>, Rich Felker <dalias@libc.org>, Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>, Will Deacon <will.deacon@arm.com>, x86@kernel.org, Yoshinori Sato <ysato@users.sourceforge.>
List-Id: linux-arch.vger.kernel.org

[Reviewer note: this is a cross-arch series.  To reduce spam, I have
tried not to Cc people on patches they aren't likely to care about.
The complete series can be found in the LKML or linux-arch archives.]

The core framework for the prctl() syscall is unloved and looking
rather crusty these days.  It also relies on defining ancillary
boilerplate macros for each prctl() in order to control conditional
compilation of the different prctl calls.  We have better ways to
do this now.

This series attempts to modernise the code by defining a couple of new
Kconfig variables HAVE_PRCTL_ARCH and HAVE_ARCH_PR_SET_GET_UNALIGN to
allow architectures to provide hooks for arch-dependent prctls.


For now this series has had minimal testing: some basic testing of
arch-specific prctls using PR_SVE_SET_VL on arm64; build-tested on
x86; otherwise untested.

This is not polished yet... but I'm interested to know what people
think about the approach.

Cheers
---Dave


Dave Martin (11):
  prctl: Support movement of arch prctls out of common code
  arm64: Move arch-specific prctls out of core code
  MIPS: Remove unused task argument from prctl functions
  MIPS: Move arch-specific prctls out of core code
  x86: Move arch-specific prctls out of core code
  powerpc: Remove unused task argument from prctl functions
  powerpc: Move arch-specific prctls out of core code
  ia64: Remove unused task argument from prctl functions
  ia64: Move arch-specific prctls out of core code
  prctl: Remove redundant task argument from PR_{SET,GET}_UNALIGN
    backends
  prctl: Refactor PR_{SET,GET}_UNALIGN to reduce boilerplate

 arch/Kconfig                         |   6 ++
 arch/alpha/Kconfig                   |   1 +
 arch/alpha/include/asm/thread_info.h |  23 --------
 arch/alpha/kernel/Makefile           |   2 +-
 arch/alpha/kernel/sys.c              |  36 ++++++++++++
 arch/arm64/Kconfig                   |   1 +
 arch/arm64/include/asm/processor.h   |   4 --
 arch/arm64/kernel/sys.c              |  15 +++++
 arch/ia64/Kconfig                    |   2 +
 arch/ia64/include/asm/processor.h    |  24 --------
 arch/ia64/kernel/sys_ia64.c          |  37 ++++++++++++
 arch/mips/Kconfig                    |   1 +
 arch/mips/include/asm/processor.h    |   3 -
 arch/mips/kernel/process.c           |  23 ++++----
 arch/mips/kernel/syscall.c           |  15 +++++
 arch/parisc/Kconfig                  |   1 +
 arch/parisc/include/asm/processor.h  |  14 -----
 arch/parisc/kernel/sys_parisc.c      |  15 +++++
 arch/powerpc/Kconfig                 |   2 +
 arch/powerpc/include/asm/processor.h |  20 ++-----
 arch/powerpc/kernel/process.c        |  38 ++++++------
 arch/powerpc/kernel/syscalls.c       |  17 ++++++
 arch/sh/Kconfig                      |   1 +
 arch/sh/include/asm/processor.h      |   7 ---
 arch/sh/mm/alignment.c               |  12 ++--
 arch/x86/Kconfig                     |   1 +
 arch/x86/include/asm/processor.h     |   6 --
 arch/x86/kernel/Makefile             |   1 +
 arch/x86/kernel/sys.c                |  26 +++++++++
 include/linux/prctl.h                |  27 +++++++++
 include/uapi/linux/prctl.h           |   6 +-
 kernel/sys.c                         | 110 ++++-------------------------------
 tools/include/uapi/linux/prctl.h     |   6 +-
 33 files changed, 263 insertions(+), 240 deletions(-)
 create mode 100644 arch/alpha/kernel/sys.c
 create mode 100644 arch/x86/kernel/sys.c
 create mode 100644 include/linux/prctl.h

-- 
2.1.4
