From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 0/6] Simplify setting thread flags to a particular value
Date: Thu, 19 Apr 2018 11:58:42 +0100
Message-ID: <1524135528-28561-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

There are a number of bits of code sprinkled around the kernel to
set a thread flag if a certain condition is true, and clear it
otherwise.

To help make those call sites terser and less cumbersome, this
patch adds a new family of thread flag manipulators

	update*_thread_flag([...,] flag, cond)

See patch 1 for details.

Reviewers please pay close attention to accidental conversion of
set_tsk_thread_flag() to set_thread_flag() for example, and accidental
inversion of conditions.  I'm pretty sure neither happens, but
build-testing can't pick these up.

Build-tested on x86 and the explicitly patched architectures (defconfig
and multi_v7_defconfig for arm, defconfig for arm64, mips, powerpc,
sparc).

Boot-tested on arm64, with some context-switch stress tests that depend
on correct maintenance of TIF_FOREIGN_FPSTATE.


Background rationale:

I've found myself coding this idiom a few times now and would like to
stop duplicating it.  Using an ungainly lash-up of sed and grep I tried
to find other users of the same idiom without too many false positives,
and there while there aren't a huge number it seemed enough to be worth
having a go at a simple cleanup.

The core changes are in the first patch; other changes are split
per-arch.


Dave Martin (6):
  thread_info: Add update_thread_flag() helpers
  ARM: Use update_thread_flag()
  arm64: Use update{,_tsk}_thread_flag()
  MIPS: Use update{,_tsk}_thread_flag()
  powerpc: Use update_thread_flag()
  sparc: Use update_thread_flag()

 arch/arm/kernel/elf.c           |  9 +++------
 arch/arm64/kernel/fpsimd.c      | 19 +++++++------------
 arch/mips/kernel/elf.c          | 10 ++--------
 arch/mips/kernel/process.c      | 15 ++++++---------
 arch/mips/kernel/ptrace.c       |  5 +----
 arch/mips/kernel/syscall.c      | 10 ++--------
 arch/powerpc/include/asm/elf.h  | 10 ++--------
 arch/sparc/include/asm/elf_64.h |  5 +----
 include/linux/sched.h           |  6 ++++++
 include/linux/thread_info.h     | 11 +++++++++++
 include/trace/syscall.h         |  6 ++----
 kernel/ptrace.c                 | 13 +++++--------
 12 files changed, 48 insertions(+), 71 deletions(-)

-- 
2.1.4
