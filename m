From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [RFC nowrap: PATCH v7 00/19] ILP32 for ARM64
Date: Sat, 18 Jun 2016 02:54:09 +0300
Message-ID: <1466207668-10549-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <libc-alpha-return-70759-glibc-alpha=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ynorov@caviumnetworks.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net
List-Id: linux-arch.vger.kernel.org

This series enables aarch64 with ilp32 mode, and as supporting work,
introduces ARCH_32BIT_OFF_T configuration option that is enabled for
existing 32-bit architectures but disabled for new arches (so 64-bit
off_t is is used by new userspace).

This version is based on kernel v4.7-rc3.
It works with glibc-2.23, and tested with LTP.

This is RFC because there is no solid understanding what type of registers
top-halves delousing we prefer. In this patchset, w0-w7 are cleared for each
syscall in assembler entry. The alternative approach is in introducing compat
wrappers which is little faster for natively routed syscalls (~2.6% for syscall
with no payload) but much more complicated.

v3: https://lkml.org/lkml/2014/9/3/704
v4: https://lkml.org/lkml/2015/4/13/691
v5: https://lkml.org/lkml/2015/9/29/911
v6: https://lkml.org/lkml/2016/5/23/661
v7: RFC nowrap:
     - wrappers removed, unconditional register delousing is introduced.
     - ino_t, off_t etc are turned to 64-bit.
     - added is_compat_thread(),
     - fixed ilp32 ELF_PLATFORM MACRO,
     - fixed ilp32 ELF_DYN_BASE,
     - ptrace redirected to compat version.
     - stat, statfs - related syscalls are redirected to native handlers.
     - elf_greg_t and elf_gregset_t types are taken from lp64.
     - Documentation updated.

Links:
This series:		https://github.com/norov/linux/commits/ilp32-nowrap
v7 with wrappers:	https://github.com/norov/linux/commits/ilp32
glibc (dirty):		https://github.com/norov/glibc/commits/ilp32-nowrap
glibc with wrappers:	https://github.com/norov/glibc/commits/ilp32-dev

Andrew Pinski (6):
  arm64: ensure the kernel is compiled for LP64
  arm64: rename COMPAT to AARCH32_EL0 in Kconfig
  arm64:uapi: set __BITS_PER_LONG correctly for ILP32 and LP64
  arm64: ilp32: add sys_ilp32.c and a separate table (in entry.S) to use it
  arm64: ilp32: introduce ilp32-specific handlers for sigframe and ucontext
  arm64:ilp32: add ARM64_ILP32 to Kconfig

Philipp Tomsich (1):
  arm64:ilp32: add vdso-ilp32 and use for signal return

Yury Norov (12):
  compat ABI: use non-compat openat and open_by_handle_at variants
  32-bit ABI: introduce ARCH_32BIT_OFF_T config option
  arm64: ilp32: add documentation on the ILP32 ABI for ARM64
  thread: move thread bits accessors to separated file
  arm64: introduce is_a32_task and is_a32_thread (for AArch32 compat)
  arm64: ilp32: add is_ilp32_compat_{task,thread} and TIF_32BIT_AARCH64
  arm64: introduce binfmt_elf32.c
  arm64: ilp32: introduce binfmt_ilp32.c
  arm64: ptrace: handle ptrace_request differently for aarch32 and ilp32
  arm64: ilp32: share aarch32 syscall handlers
  arm64: signal: share lp64 signal routines to ilp32
  arm64: signal32: move ilp32 and aarch32 common code to separated file

 Documentation/arm64/ilp32.txt                 |  54 +++++++
 arch/Kconfig                                  |   4 +
 arch/arc/Kconfig                              |   1 +
 arch/arm/Kconfig                              |   1 +
 arch/arm64/Kconfig                            |  19 ++-
 arch/arm64/Makefile                           |   5 +
 arch/arm64/include/asm/compat.h               |  19 +--
 arch/arm64/include/asm/elf.h                  |  29 +++-
 arch/arm64/include/asm/fpsimd.h               |   2 +-
 arch/arm64/include/asm/ftrace.h               |   2 +-
 arch/arm64/include/asm/hwcap.h                |   6 +-
 arch/arm64/include/asm/is_compat.h            |  90 ++++++++++++
 arch/arm64/include/asm/memory.h               |   5 +-
 arch/arm64/include/asm/processor.h            |  11 +-
 arch/arm64/include/asm/ptrace.h               |   2 +-
 arch/arm64/include/asm/signal32.h             |   6 +-
 arch/arm64/include/asm/signal32_common.h      |  25 ++++
 arch/arm64/include/asm/signal_common.h        |  33 +++++
 arch/arm64/include/asm/signal_ilp32.h         |  34 +++++
 arch/arm64/include/asm/syscall.h              |   2 +-
 arch/arm64/include/asm/thread_info.h          |   4 +-
 arch/arm64/include/asm/unistd.h               |   6 +-
 arch/arm64/include/asm/unistd32.h             |   2 +-
 arch/arm64/include/asm/vdso.h                 |   6 +
 arch/arm64/include/uapi/asm/bitsperlong.h     |   9 +-
 arch/arm64/kernel/Makefile                    |  14 +-
 arch/arm64/kernel/asm-offsets.c               |   9 +-
 arch/arm64/kernel/binfmt_elf32.c              |  31 ++++
 arch/arm64/kernel/binfmt_ilp32.c              |  96 +++++++++++++
 arch/arm64/kernel/cpufeature.c                |   8 +-
 arch/arm64/kernel/cpuinfo.c                   |  20 +--
 arch/arm64/kernel/entry.S                     |  35 ++++-
 arch/arm64/kernel/entry32.S                   |  65 ---------
 arch/arm64/kernel/entry32_common.S            |  93 ++++++++++++
 arch/arm64/kernel/entry_ilp32.S               |  23 +++
 arch/arm64/kernel/head.S                      |   2 +-
 arch/arm64/kernel/hw_breakpoint.c             |  10 +-
 arch/arm64/kernel/perf_regs.c                 |   2 +-
 arch/arm64/kernel/process.c                   |   7 +-
 arch/arm64/kernel/ptrace.c                    |  67 +++++++--
 arch/arm64/kernel/signal.c                    | 102 +++++++++-----
 arch/arm64/kernel/signal32.c                  |  85 -----------
 arch/arm64/kernel/signal32_common.c           | 115 +++++++++++++++
 arch/arm64/kernel/signal_ilp32.c              | 194 ++++++++++++++++++++++++++
 arch/arm64/kernel/sys32.c                     |   1 +
 arch/arm64/kernel/sys_ilp32.c                 |  84 +++++++++++
 arch/arm64/kernel/traps.c                     |   5 +-
 arch/arm64/kernel/vdso-ilp32/.gitignore       |   2 +
 arch/arm64/kernel/vdso-ilp32/Makefile         |  74 ++++++++++
 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S     |  33 +++++
 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S |  95 +++++++++++++
 arch/arm64/kernel/vdso.c                      |  65 +++++++--
 arch/arm64/kernel/vdso/gettimeofday.S         |  20 ++-
 arch/blackfin/Kconfig                         |   1 +
 arch/cris/Kconfig                             |   1 +
 arch/frv/Kconfig                              |   1 +
 arch/h8300/Kconfig                            |   1 +
 arch/hexagon/Kconfig                          |   1 +
 arch/m32r/Kconfig                             |   1 +
 arch/m68k/Kconfig                             |   1 +
 arch/metag/Kconfig                            |   1 +
 arch/microblaze/Kconfig                       |   1 +
 arch/mips/Kconfig                             |   1 +
 arch/mn10300/Kconfig                          |   1 +
 arch/nios2/Kconfig                            |   1 +
 arch/openrisc/Kconfig                         |   1 +
 arch/parisc/Kconfig                           |   1 +
 arch/powerpc/Kconfig                          |   1 +
 arch/score/Kconfig                            |   1 +
 arch/sh/Kconfig                               |   1 +
 arch/sparc/Kconfig                            |   1 +
 arch/tile/Kconfig                             |   1 +
 arch/tile/kernel/compat.c                     |   3 +
 arch/unicore32/Kconfig                        |   1 +
 arch/x86/Kconfig                              |   1 +
 arch/x86/um/Kconfig                           |   1 +
 arch/xtensa/Kconfig                           |   1 +
 drivers/clocksource/arm_arch_timer.c          |   2 +-
 include/linux/fcntl.h                         |   2 +-
 include/linux/ptrace.h                        |   6 +
 include/linux/thread_bits.h                   |  55 ++++++++
 include/linux/thread_info.h                   |  44 +-----
 kernel/ptrace.c                               |  10 +-
 83 files changed, 1536 insertions(+), 343 deletions(-)
 create mode 100644 Documentation/arm64/ilp32.txt
 create mode 100644 arch/arm64/include/asm/is_compat.h
 create mode 100644 arch/arm64/include/asm/signal32_common.h
 create mode 100644 arch/arm64/include/asm/signal_common.h
 create mode 100644 arch/arm64/include/asm/signal_ilp32.h
 create mode 100644 arch/arm64/kernel/binfmt_elf32.c
 create mode 100644 arch/arm64/kernel/binfmt_ilp32.c
 create mode 100644 arch/arm64/kernel/entry32_common.S
 create mode 100644 arch/arm64/kernel/entry_ilp32.S
 create mode 100644 arch/arm64/kernel/signal32_common.c
 create mode 100644 arch/arm64/kernel/signal_ilp32.c
 create mode 100644 arch/arm64/kernel/sys_ilp32.c
 create mode 100644 arch/arm64/kernel/vdso-ilp32/.gitignore
 create mode 100644 arch/arm64/kernel/vdso-ilp32/Makefile
 create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S
 create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S
 create mode 100644 include/linux/thread_bits.h

-- 
2.7.4
