Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59000 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbfBVMZi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 07:25:38 -0500
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v5 00/23] Unify vDSOs across more architectures
Date: Fri, 22 Feb 2019 12:24:07 +0000
Message-ID: <20190222122430.21180-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190222122407.QnIq5nmW48MB13id6XAOjgdV0AEVsJMeRDNaot-0224@z>

vDSO (virtual dynamic shared object) is a mechanism that the Linux
kernel provides as an alternative to system calls to reduce where
possible the costs in terms of cycles.
This is possible because certain syscalls like gettimeofday() do
not write any data and return one or more values that are stored
in the kernel, which makes relatively safe calling them directly
as a library function.

Even if the mechanism is pretty much standard, every architecture
in the last few years ended up implementing their own vDSO library
in the architectural code.

The purpose of this patch-set is to identify the commonalities in
between the architectures and try to consolidate the common code
paths, starting with gettimeofday().

This implementation contains the following design choices:
 * Every architecture defines the arch specific code in an header in
   "asm/vdso/".
 * The generic implementation includes the arch specific one and lives
   in "lib/vdso".
 * The arch specific code for gettimeofday lives in
   "<arch path>/vdso/gettimeofday.c" and includes the generic code only.
 * This approach allows to consolidate the common code in a single place
   with the benefit of avoiding code duplication.

This implementation contains the portings to the common library for: arm64,
compat mode for arm64, arm, mips, x86_64, compat mode for x86_64 and i386.

The mips porting has been tested on qemu for mips32el. A configuration to
repeat the tests can be found at [4].

The x86_64 porting has been tested on an Intel Xeon 5120T based machine
running Ubuntu 18.04 and using the Ubuntu provided defconfig.

The i386 porting has been tested on qemu using the i386_defconfig
configuration.

Last but not least from this porting arm64, compat arm64, arm and mips gain
the support for:
 * CLOCK_BOOTTIME that can be useful in certain scenarios since it keeps
   track of the time during sleep as well.
 * CLOCK_TAI that is like CLOCK_REALTIME, but uses the International
   Atomic Time (TAI) reference instead of UTC to avoid jumping on leap
   second updates.
for both clock_gettime and clock_getres.

The porting has been validated using the vdsotest test-suite [1] extended
to cover all the clock ids [2].

A new test has been added to the linux kselftest in order to validate the
newly added library.

To simplify the testing, a copy of the patchset on top of a recent linux
tree can be found at [3] and [4].

[1] https://github.com/nathanlynch/vdsotest
[2] https://github.com/fvincenzo/vdsotest
[3] git://linux-arm.org/linux-vf.git vdso/v5
[4] git://linux-arm.org/linux-vf.git vdso-mips/v5

Changes:
--------
v5:
  - Rebased on 5.0-rc7.
  - Added x86_64, compat mode for x86_64 and i386 portings.
  - Extended vDSO kselftest.
  - Addressed review comments.
v4:
  - Rebased on 5.0-rc2.
  - Addressed review comments.
  - Disabled compat vdso on arm64 when the kernel is compiled with
    clang.
v3:
  - Ported the latest fixes and optimizations done on the x86
    architecture to the generic library.
  - Addressed review comments.
  - Improved the documentation of the interfaces.
  - Changed the HAVE_ARCH_TIMER config option to a more generic
    HAVE_HW_COUNTER.
v2:
  - Added -ffixed-x18 to arm64
  - Repleced occurrences of timeval and timespec
  - Modified datapage.h to be compliant with y2038 on all the architectures
  - Removed __u_vdso type

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Salyzyn <salyzyn@android.com>
Cc: Peter Collingbourne <pcc@google.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Peter Collingbourne (1):
  arm64: Build vDSO with -ffixed-x18

Vincenzo Frascino (22):
  kernel: Standardize vdso_datapage
  kernel: Define gettimeofday vdso common code
  arm64: Substitute gettimeofday with C implementation
  arm64: compat: Alloc separate pages for vectors and sigpage
  arm64: compat: Split kuser32
  arm64: compat: Refactor aarch32_alloc_vdso_pages()
  arm64: compat: Add KUSER_HELPERS config option
  arm64: compat: Add missing syscall numbers
  arm64: compat: Expose signal related structures
  arm64: compat: Generate asm offsets for signals
  lib: vdso: Add compat support
  arm64: compat: Add vDSO
  arm64: Refactor vDSO code
  arm64: compat: vDSO setup for compat layer
  arm64: elf: vDSO code page discovery
  arm64: compat: Get sigreturn trampolines from vDSO
  arm64: Add vDSO compat support
  arm64: Enable compat vDSO support
  arm: Add support for generic vDSO
  mips: Add support for generic vDSO
  x86: Add support for generic vDSO
  kselftest: Extend vDSO selftest

 arch/arm/Kconfig                              |   3 +
 arch/arm/include/asm/vdso/gettimeofday.h      |  82 +++
 arch/arm/include/asm/vdso_datapage.h          |  25 +-
 arch/arm/kernel/vdso.c                        | 108 ++--
 arch/arm/vdso/Makefile                        |  13 +-
 arch/arm/vdso/note.c                          |  15 +
 arch/arm/vdso/vdso.lds.S                      |   1 +
 arch/arm/vdso/vgettimeofday.c                 | 267 +--------
 arch/arm64/Kconfig                            |  24 +
 arch/arm64/Makefile                           |  23 +-
 arch/arm64/configs/defconfig                  |   1 +
 arch/arm64/include/asm/elf.h                  |  20 +-
 arch/arm64/include/asm/processor.h            |   4 +-
 arch/arm64/include/asm/signal32.h             |  58 +-
 arch/arm64/include/asm/unistd.h               |   3 +
 arch/arm64/include/asm/vdso.h                 |   3 +
 arch/arm64/include/asm/vdso/compat_barrier.h  |  36 ++
 .../include/asm/vdso/compat_gettimeofday.h    | 119 ++++
 arch/arm64/include/asm/vdso/gettimeofday.h    |  85 +++
 arch/arm64/include/asm/vdso_datapage.h        |  47 --
 arch/arm64/kernel/Makefile                    |   7 +-
 arch/arm64/kernel/asm-offsets.c               |  45 +-
 arch/arm64/kernel/kuser32.S                   |  65 +--
 arch/arm64/kernel/signal32.c                  |  76 +--
 arch/arm64/kernel/sigreturn32.S               |  46 ++
 arch/arm64/kernel/vdso.c                      | 506 +++++++++++++-----
 arch/arm64/kernel/vdso/Makefile               |  28 +-
 arch/arm64/kernel/vdso/gettimeofday.S         | 328 ------------
 arch/arm64/kernel/vdso/vgettimeofday.c        |  28 +
 arch/arm64/kernel/vdso32/.gitignore           |   2 +
 arch/arm64/kernel/vdso32/Makefile             | 184 +++++++
 arch/arm64/kernel/vdso32/note.c               |  15 +
 arch/arm64/kernel/vdso32/sigreturn.S          |  62 +++
 arch/arm64/kernel/vdso32/vdso.S               |  19 +
 arch/arm64/kernel/vdso32/vdso.lds.S           |  81 +++
 arch/arm64/kernel/vdso32/vgettimeofday.c      |  41 ++
 arch/mips/Kconfig                             |   2 +
 arch/mips/include/asm/vdso.h                  |  60 +--
 arch/mips/include/asm/vdso/gettimeofday.h     | 165 ++++++
 arch/mips/{ => include/asm}/vdso/vdso.h       |   6 +-
 arch/mips/kernel/vdso.c                       | 107 +++-
 arch/mips/vdso/Makefile                       |  23 +-
 arch/mips/vdso/elf.S                          |   2 +-
 arch/mips/vdso/gettimeofday.c                 | 273 ----------
 arch/mips/vdso/sigreturn.S                    |   2 +-
 arch/mips/vdso/vdso.lds.S                     |   1 +
 arch/mips/vdso/vgettimeofday.c                |  28 +
 arch/x86/Kconfig                              |   3 +
 arch/x86/entry/vdso/Makefile                  |   9 +
 arch/x86/entry/vdso/vclock_gettime.c          | 239 +--------
 arch/x86/entry/vdso/vdso.lds.S                |   2 +
 arch/x86/entry/vdso/vdso32/vdso32.lds.S       |   1 +
 arch/x86/entry/vdso/vdsox32.lds.S             |   1 +
 arch/x86/entry/vsyscall/vsyscall_gtod.c       | 110 ++--
 arch/x86/include/asm/vdso/gettimeofday.h      | 203 +++++++
 arch/x86/include/asm/vgtod.h                  |  73 +--
 arch/x86/include/asm/vvar.h                   |   2 +-
 include/vdso/datapage.h                       |  75 +++
 include/vdso/helpers.h                        |  52 ++
 include/vdso/types.h                          |  39 ++
 lib/Kconfig                                   |   5 +
 lib/vdso/Kconfig                              |  37 ++
 lib/vdso/Makefile                             |  22 +
 lib/vdso/gettimeofday.c                       | 179 +++++++
 tools/testing/selftests/vDSO/Makefile         |   2 +
 tools/testing/selftests/vDSO/vdso_full_test.c | 246 +++++++++
 66 files changed, 2812 insertions(+), 1627 deletions(-)
 create mode 100644 arch/arm/include/asm/vdso/gettimeofday.h
 create mode 100644 arch/arm/vdso/note.c
 create mode 100644 arch/arm64/include/asm/vdso/compat_barrier.h
 create mode 100644 arch/arm64/include/asm/vdso/compat_gettimeofday.h
 create mode 100644 arch/arm64/include/asm/vdso/gettimeofday.h
 delete mode 100644 arch/arm64/include/asm/vdso_datapage.h
 create mode 100644 arch/arm64/kernel/sigreturn32.S
 delete mode 100644 arch/arm64/kernel/vdso/gettimeofday.S
 create mode 100644 arch/arm64/kernel/vdso/vgettimeofday.c
 create mode 100644 arch/arm64/kernel/vdso32/.gitignore
 create mode 100644 arch/arm64/kernel/vdso32/Makefile
 create mode 100644 arch/arm64/kernel/vdso32/note.c
 create mode 100644 arch/arm64/kernel/vdso32/sigreturn.S
 create mode 100644 arch/arm64/kernel/vdso32/vdso.S
 create mode 100644 arch/arm64/kernel/vdso32/vdso.lds.S
 create mode 100644 arch/arm64/kernel/vdso32/vgettimeofday.c
 create mode 100644 arch/mips/include/asm/vdso/gettimeofday.h
 rename arch/mips/{ => include/asm}/vdso/vdso.h (90%)
 delete mode 100644 arch/mips/vdso/gettimeofday.c
 create mode 100644 arch/mips/vdso/vgettimeofday.c
 create mode 100644 arch/x86/include/asm/vdso/gettimeofday.h
 create mode 100644 include/vdso/datapage.h
 create mode 100644 include/vdso/helpers.h
 create mode 100644 include/vdso/types.h
 create mode 100644 lib/vdso/Kconfig
 create mode 100644 lib/vdso/Makefile
 create mode 100644 lib/vdso/gettimeofday.c
 create mode 100644 tools/testing/selftests/vDSO/vdso_full_test.c

-- 
2.20.1
