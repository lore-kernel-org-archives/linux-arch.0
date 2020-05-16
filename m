From: guoren@kernel.org
Subject: [GIT PULL] csky updates for v5.7-rc6
Date: Sat, 16 May 2020 17:33:36 +0800
Message-ID: <20200516093336.13886-1-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org, guoren@kernel.org
List-Id: linux-arch.vger.kernel.org

Hi Linus,

Please pull the changes (10 fixups) for v5.7-rc6.

Best Regards
 Guo Ren

The following changes since commit 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8:

  Linux 5.7-rc5 (2020-05-10 15:16:58 -0700)

are available in the Git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.7-rc6

for you to fetch changes up to 51bb38cb78363fdad1f89e87357b7bc73e39ba88:

  csky: Fixup raw_copy_from_user() (2020-05-15 00:16:30 +0800)

----------------------------------------------------------------
csky updates for 5.7-rc6

10 Fixups for this updates :P

 - 1 fixup for copy_from/to_user (a hard-to-find bug, thx Viro)
 - 1 fixup for calltrace panic without FRAME_POINT
 - 2 fixups for perf
 - 2 fixups for compile error
 - 4 fixups for non-fatal bugs:
   (msa, rm dis_irq, cleanup psr, gdbmacros.txt)

----------------------------------------------------------------
Al Viro (1):
      csky: Fixup raw_copy_from_user()

Guo Ren (6):
      csky/ftrace: Fixup error when disable CONFIG_DYNAMIC_FTRACE
      csky: Fixup compile error for abiv1 entry.S
      csky: Fixup perf probe -x hungup
      csky: Fixup calltrace panic
      csky: Fixup remove unnecessary save/restore PSR code
      csky: Fixup gdbmacros.txt with name sp in thread_struct

Liu Yibin (2):
      csky: Fixup msa highest 3 bits mask
      csky: Fixup remove duplicate irq_disable

Mao Han (1):
      csky: Fixup perf callchain unwind

 arch/csky/Kconfig                   |   2 +
 arch/csky/Makefile                  |   2 +-
 arch/csky/abiv1/inc/abi/entry.h     |   4 +-
 arch/csky/abiv2/inc/abi/entry.h     |   4 +-
 arch/csky/abiv2/mcount.S            |   2 +
 arch/csky/include/asm/processor.h   |   6 +-
 arch/csky/include/asm/ptrace.h      |  10 ++
 arch/csky/include/asm/thread_info.h |  16 +++-
 arch/csky/include/asm/uaccess.h     |  49 +++++-----
 arch/csky/kernel/Makefile           |   2 +-
 arch/csky/kernel/asm-offsets.c      |   3 +-
 arch/csky/kernel/dumpstack.c        |  49 ----------
 arch/csky/kernel/entry.S            |  12 +--
 arch/csky/kernel/ftrace.c           |   2 +
 arch/csky/kernel/perf_callchain.c   |   9 +-
 arch/csky/kernel/probes/uprobes.c   |   5 +
 arch/csky/kernel/process.c          |  37 +-------
 arch/csky/kernel/ptrace.c           |   6 ++
 arch/csky/kernel/stacktrace.c       | 176 ++++++++++++++++++++++++++++--------
 arch/csky/lib/usercopy.c            |   8 +-
 20 files changed, 226 insertions(+), 178 deletions(-)
 delete mode 100644 arch/csky/kernel/dumpstack.c
