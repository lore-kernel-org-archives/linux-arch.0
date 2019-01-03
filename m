From: guoren@kernel.org
Subject: [GIT PULL] csky patches for the 4.21 merge window
Date: Thu,  3 Jan 2019 17:26:00 +0800
Message-ID: <1546507560-2486-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, ren_guo@c-sky.com
List-Id: linux-arch.vger.kernel.org

Hi Linus,

The following changes since commit 7566ec393f4161572ba6f11ad5171fd5d59b0fbd:

  Linux 4.20-rc7 (2018-12-16 15:46:55 -0800)

are available in the git repository at:

  git@github.com:c-sky/csky-linux.git tags/csky-for-linus-4.21

for you to fetch changes up to f50fd2d8524c15b08da9e7e9d84752f0f1be7172:

  csky: Add perf support for C-SKY (2019-01-02 22:17:11 +0800)

----------------------------------------------------------------
arch/csky patches for 4.21-rc1

Here is the arch/csky patch set for the 4.21-rc1 merge window.
Contianed in here is some features (cpu_hotplug, basic ftrace,
basic perf ...) and some bugfixes.

Features:
 - Add CPU-hotplug support for SMP
 - Add ftrace with function trace and function graph trace
 - Add Perf support
 - Add EM_CSKY_OLD 39
 - optimize kernel panic print.
 - remove syscall_exit_work

Bugfixes:
 - fixup abiv2 mmap(... O_SYNC) failed.
 - fixup gdb coredump error.
 - fixup remove vdsp implement for kernel.
 - fixup qemu fail to bootup sometimes.
 - fixup ftrace call-graph panic
 - fixup leak device tree node reference
 - fixup remove meaningless header-y
 - fixup save hi,lo,dspcr regs in switch_stack.
 - fixup unused members in processor.h

----------------------------------------------------------------
Dmitry V. Levin (2):
      elf-em.h: add EM_CSKY
      csky: define syscall_get_arch()

Guo Ren (15):
      csky: fixup abiv2 mmap(... O_SYNC) failed.
      csky: bugfix gdb coredump error.
      csky: fixup remove vdsp implement for kernel.
      csky: remove syscall_exit_work
      csky: fixup save hi,lo,dspcr regs in switch_stack.
      clocksource/drivers/c-sky: fixup qemu fail to bootup sometimes.
      csky: CPU-hotplug supported for SMP
      csky: stacktrace supported.
      csky: optimize kernel panic print.
      csky: remove unused members in processor.h
      csky: basic ftrace supported
      csky: ftrace call graph supported.
      clocksource/drivers/c-sky: fixup ftrace call-graph panic
      csky: Add EM_CSKY_OLD 39
      csky: Add perf support for C-SKY

Masahiro Yamada (1):
      csky: remove meaningless header-y

Yangtao Li (1):
      csky: Don't leak device tree node reference

 arch/csky/Kconfig                        |   30 +-
 arch/csky/Makefile                       |    4 +
 arch/csky/abiv1/inc/abi/pgtable-bits.h   |    1 +
 arch/csky/abiv1/inc/abi/switch_context.h |   17 +
 arch/csky/abiv2/Makefile                 |    1 +
 arch/csky/abiv2/inc/abi/entry.h          |   28 +-
 arch/csky/abiv2/inc/abi/pgtable-bits.h   |    2 +-
 arch/csky/abiv2/inc/abi/switch_context.h |   32 +
 arch/csky/abiv2/mcount.S                 |  124 ++++
 arch/csky/abiv2/memcpy.S                 |    8 +-
 arch/csky/include/asm/elf.h              |   13 +-
 arch/csky/include/asm/ftrace.h           |   13 +
 arch/csky/include/asm/perf_event.h       |    7 +
 arch/csky/include/asm/processor.h        |   15 +-
 arch/csky/include/asm/smp.h              |    4 +
 arch/csky/include/asm/syscall.h          |    7 +
 arch/csky/include/asm/thread_info.h      |    4 +
 arch/csky/include/uapi/asm/Kbuild        |    2 -
 arch/csky/include/uapi/asm/ptrace.h      |   39 +-
 arch/csky/kernel/Makefile                |    7 +
 arch/csky/kernel/asm-offsets.c           |    3 -
 arch/csky/kernel/dumpstack.c             |   59 +-
 arch/csky/kernel/entry.S                 |   50 +-
 arch/csky/kernel/ftrace.c                |   50 ++
 arch/csky/kernel/perf_event.c            | 1031 ++++++++++++++++++++++++++++++
 arch/csky/kernel/process.c               |   29 +-
 arch/csky/kernel/ptrace.c                |   42 +-
 arch/csky/kernel/signal.c                |    2 -
 arch/csky/kernel/smp.c                   |   73 ++-
 arch/csky/kernel/stacktrace.c            |   57 ++
 arch/csky/kernel/traps.c                 |    6 -
 arch/csky/mm/fault.c                     |    7 +-
 arch/csky/mm/ioremap.c                   |    2 +-
 drivers/clocksource/timer-mp-csky.c      |    6 +-
 include/uapi/linux/audit.h               |    1 +
 include/uapi/linux/elf-em.h              |    1 +
 36 files changed, 1555 insertions(+), 222 deletions(-)
 create mode 100644 arch/csky/abiv1/inc/abi/switch_context.h
 create mode 100644 arch/csky/abiv2/inc/abi/switch_context.h
 create mode 100644 arch/csky/abiv2/mcount.S
 create mode 100644 arch/csky/include/asm/ftrace.h
 create mode 100644 arch/csky/include/asm/perf_event.h
 create mode 100644 arch/csky/kernel/ftrace.c
 create mode 100644 arch/csky/kernel/perf_event.c
 create mode 100644 arch/csky/kernel/stacktrace.c
