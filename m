From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [RFC3 nowrap: PATCH v7 00/18] ILP32 for ARM64
Date: Fri, 21 Oct 2016 23:32:59 +0300
Message-ID: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org
Cc: szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, ynorov@caviumnetworks.com, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, zhouchengming1@huawei.com, Prasun.Kapoor@caviumnetworks.com, agraf@suse.de, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, pinskia@gmail.com, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, maxim.kuvyrkov@linaro.org, Nathan_Lynch@mentor.com, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com
List-Id: linux-arch.vger.kernel.org

This series enables aarch64 with ilp32 mode, and as supporting work,
introduces ARCH_32BIT_OFF_T configuration option that is enabled for
existing 32-bit architectures but disabled for new arches (so 64-bit
off_t is is used by new userspace).

This version is based on kernel v4.9-rc1.  It works with glibc-2.24,
and tested with LTP.

This version contains ABI changes, and should be used with new glibc
version. See links below.

This is RFC because there is still no solid understanding what type
of registers top-halves delousing we prefer and it affects ABI. In
this patchset, w0-w7 are cleared for each syscall in assembler entry.

The alternative approach is in introducing compat wrappers which is
little faster for natively routed syscalls (~2.6% for syscall with
no payload) but much more complicated.

Patch 1 may be applied separately from other patches of series.

v3: https://lkml.org/lkml/2014/9/3/704
v4: https://lkml.org/lkml/2015/4/13/691
v5: https://lkml.org/lkml/2015/9/29/911
v6: https://lkml.org/lkml/2016/5/23/661
v7: RFC nowrap:  https://lkml.org/lkml/2016/6/17/990
v7: RFC2 nowrap: https://lkml.org/lkml/2016/8/17/245
v7: RFC3 nowrap: https://lkml.org/lkml/2016/8/17/245
 - rebased on kernel 4.9-rc1;
 - setrlimit(), getrlimit() special handling is dropped.
   rlim_t is still 64-bit, but glibc is forced to use sys_prlimit64(),
   and redirection is not needed anymore;
 - sys_stat() and sys_stat64() redirection is dropped. Glibc defines
   aarch32-compatible struct stat instead;
 - sys_fcntl() redirection is dropped. Glibc sets proper definitions for
   requests instead;
 - renameat() is disabled for aarch64/ilp32. Glibc is forced to use renameat2();
 - __ARCH_WANT_SYNC_FILE_RANGE2 is enabled for aarch64/ilp32 to force it use
   sys_sync_file_range2 prior to sys_sync_file_range, like aarch32;
 - VDSO code refactored. Version is switched to 4.9.
 - comments  and documentation are revised;
 - checkpatch.pl errors are fixed.

Links:
Kernel: https://github.com/norov/linux/tree/ilp32-v4.9
glibc:  https://github.com/norov/glibc/tree/ilp32-2.24-dev1

Andrew Pinski (6):
  arm64: rename COMPAT to AARCH32_EL0 in Kconfig
  arm64: ensure the kernel is compiled for LP64
  arm64:uapi: set __BITS_PER_LONG correctly for ILP32 and LP64
  arm64: ilp32: add sys_ilp32.c and a separate table (in entry.S) to use
    it
  arm64: ilp32: introduce ilp32-specific handlers for sigframe and
    ucontext
  arm64:ilp32: add ARM64_ILP32 to Kconfig

Philipp Tomsich (1):
  arm64:ilp32: add vdso-ilp32 and use for signal return

Yury Norov (11):
  32-bit ABI: introduce ARCH_32BIT_OFF_T config option
  arm64: ilp32: add documentation on the ILP32 ABI for ARM64
  thread: move thread bits accessors to separated file
  arm64: introduce is_a32_task and is_a32_thread (for AArch32 compat)
  arm64: ilp32: add is_ilp32_compat_{task,thread} and TIF_32BIT_AARCH64
  arm64: introduce binfmt_elf32.c
  arm64: ilp32: introduce binfmt_ilp32.c
  arm64: ilp32: share aarch32 syscall handlers
  arm64: signal: share lp64 signal routines to ilp32
  arm64: signal32: move ilp32 and aarch32 common code to separated file
  arm64: ptrace: handle ptrace_request differently for aarch32 and ilp32

 Documentation/arm64/ilp32.txt                 |  46 +++++++
 arch/Kconfig                                  |   4 +
 arch/arc/Kconfig                              |   1 +
 arch/arm/Kconfig                              |   1 +
 arch/arm64/Kconfig                            |  19 ++-
 arch/arm64/Makefile                           |   5 +
 arch/arm64/include/asm/compat.h               |  19 +--
 arch/arm64/include/asm/elf.h                  |  29 +++--
 arch/arm64/include/asm/fpsimd.h               |   2 +-
 arch/arm64/include/asm/ftrace.h               |   2 +-
 arch/arm64/include/asm/hwcap.h                |   6 +-
 arch/arm64/include/asm/is_compat.h            |  90 +++++++++++++
 arch/arm64/include/asm/memory.h               |   5 +-
 arch/arm64/include/asm/processor.h            |  11 +-
 arch/arm64/include/asm/ptrace.h               |   2 +-
 arch/arm64/include/asm/seccomp.h              |   2 +-
 arch/arm64/include/asm/signal32.h             |   9 +-
 arch/arm64/include/asm/signal32_common.h      |  27 ++++
 arch/arm64/include/asm/signal_common.h        |  33 +++++
 arch/arm64/include/asm/signal_ilp32.h         |  38 ++++++
 arch/arm64/include/asm/syscall.h              |   2 +-
 arch/arm64/include/asm/thread_info.h          |   4 +-
 arch/arm64/include/asm/unistd.h               |   8 +-
 arch/arm64/include/asm/unistd32.h             |   2 +-
 arch/arm64/include/asm/vdso.h                 |   6 +
 arch/arm64/include/uapi/asm/bitsperlong.h     |   9 +-
 arch/arm64/include/uapi/asm/unistd.h          |  12 ++
 arch/arm64/kernel/Makefile                    |  18 ++-
 arch/arm64/kernel/asm-offsets.c               |   9 +-
 arch/arm64/kernel/binfmt_elf32.c              |  31 +++++
 arch/arm64/kernel/binfmt_ilp32.c              |  97 ++++++++++++++
 arch/arm64/kernel/cpufeature.c                |   8 +-
 arch/arm64/kernel/cpuinfo.c                   |  20 +--
 arch/arm64/kernel/entry.S                     |  34 ++++-
 arch/arm64/kernel/entry32.S                   |  80 ------------
 arch/arm64/kernel/entry32_common.S            | 107 ++++++++++++++++
 arch/arm64/kernel/entry_ilp32.S               |  22 ++++
 arch/arm64/kernel/head.S                      |   2 +-
 arch/arm64/kernel/hw_breakpoint.c             |  10 +-
 arch/arm64/kernel/perf_regs.c                 |   2 +-
 arch/arm64/kernel/process.c                   |   7 +-
 arch/arm64/kernel/ptrace.c                    | 110 ++++++++++++++--
 arch/arm64/kernel/signal.c                    | 102 +++++++++------
 arch/arm64/kernel/signal32.c                  | 107 ----------------
 arch/arm64/kernel/signal32_common.c           | 135 ++++++++++++++++++++
 arch/arm64/kernel/signal_ilp32.c              | 174 ++++++++++++++++++++++++++
 arch/arm64/kernel/sys32.c                     |   1 +
 arch/arm64/kernel/sys_ilp32.c                 | 100 +++++++++++++++
 arch/arm64/kernel/traps.c                     |   5 +-
 arch/arm64/kernel/vdso-ilp32/.gitignore       |   2 +
 arch/arm64/kernel/vdso-ilp32/Makefile         |  74 +++++++++++
 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S     |  33 +++++
 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S |  95 ++++++++++++++
 arch/arm64/kernel/vdso.c                      |  70 +++++++++--
 arch/arm64/kernel/vdso/gettimeofday.S         |  20 ++-
 arch/arm64/kernel/vdso/vdso.S                 |   6 +-
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
 include/linux/thread_bits.h                   |  54 ++++++++
 include/linux/thread_info.h                   |  44 +------
 include/uapi/asm-generic/unistd.h             |   5 +-
 kernel/ptrace.c                               |  10 +-
 87 files changed, 1635 insertions(+), 389 deletions(-)
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
