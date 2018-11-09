From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 00/27] Unify vDSOs across more architectures
Date: Fri,  9 Nov 2018 12:37:03 +0000
Message-ID: <20181109123730.8743-1-vincenzo.frascino@arm.com>
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
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>
List-Id: linux-arch.vger.kernel.org

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
compat mode for arm64, arm and mips.

The mips porting has been tested on qemu for mips32el. A configuration to
repeat the tests can be found at [4].

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

To simplify the testing, a copy of the patchset on top of a recent linux tree
can be found at [3]. 

[1] https://github.com/nlynch-mentor/vdsotest
[2] https://github.com/fvincenzo/vdsotest
[3] git://linux-arm.org/linux-vf.git vdso/v1
[4] git://linux-arm.org/linux-vf.git vdso-mips/v1

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
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Vincenzo Frascino (27):
  kernel: Standardize vdso_datapage
  kernel: Add Monotonic boot time support
  kernel: Add International Atomic Time support
  kernel: Add masks support for Raw and NTP time
  kernel: Add clock_mode support
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
  mips: Introduce vdso_direct
  clock: csrc-4k: Add support for vdso_direct
  clock: gic-timer: Add support for vdso_direct
  mips: Add support for generic vDSO

 arch/arm/Kconfig                              |   4 +
 arch/arm/include/asm/vdso/gettimeofday.h      |  79 ++++
 arch/arm/include/asm/vdso_datapage.h          |  25 +-
 arch/arm/kernel/vdso.c                        |  28 +-
 arch/arm/vdso/Makefile                        |  13 +-
 arch/arm/vdso/note.c                          |  15 +
 arch/arm/vdso/vdso.lds.S                      |   2 +
 arch/arm/vdso/vgettimeofday.c                 | 263 +----------
 arch/arm64/Kconfig                            |  25 ++
 arch/arm64/Makefile                           |  21 +-
 arch/arm64/configs/defconfig                  |   1 +
 arch/arm64/include/asm/elf.h                  |  20 +-
 arch/arm64/include/asm/processor.h            |   4 +-
 arch/arm64/include/asm/signal32.h             |  58 ++-
 arch/arm64/include/asm/unistd.h               |   3 +
 arch/arm64/include/asm/vdso.h                 |   3 +
 arch/arm64/include/asm/vdso/compat_barrier.h  |  36 ++
 .../include/asm/vdso/compat_gettimeofday.h    |  89 ++++
 arch/arm64/include/asm/vdso/gettimeofday.h    |  82 ++++
 arch/arm64/include/asm/vdso_datapage.h        |  47 --
 arch/arm64/kernel/Makefile                    |   7 +-
 arch/arm64/kernel/asm-offsets.c               |  13 +-
 arch/arm64/kernel/kuser32.S                   |  65 +--
 arch/arm64/kernel/signal32.c                  |  76 ++--
 arch/arm64/kernel/sigreturn32.S               |  46 ++
 arch/arm64/kernel/vdso.c                      | 413 ++++++++++++-----
 arch/arm64/kernel/vdso/Makefile               |  24 +-
 arch/arm64/kernel/vdso/gettimeofday.S         | 328 --------------
 arch/arm64/kernel/vdso/vdso.lds.S             |   1 +
 arch/arm64/kernel/vdso/vgettimeofday.c        |  30 ++
 arch/arm64/kernel/vdso32/.gitignore           |   2 +
 arch/arm64/kernel/vdso32/Makefile             | 184 ++++++++
 arch/arm64/kernel/vdso32/note.c               |  15 +
 arch/arm64/kernel/vdso32/sigreturn.S          |  62 +++
 arch/arm64/kernel/vdso32/vdso.S               |  19 +
 arch/arm64/kernel/vdso32/vdso.lds.S           |  82 ++++
 arch/arm64/kernel/vdso32/vgettimeofday.c      |  43 ++
 arch/mips/Kconfig                             |   3 +
 arch/mips/include/asm/clocksource.h           |   1 +
 arch/mips/include/asm/vdso.h                  |  53 +--
 arch/mips/include/asm/vdso/gettimeofday.h     | 161 +++++++
 arch/mips/{ => include/asm}/vdso/vdso.h       |   6 +-
 arch/mips/kernel/csrc-r4k.c                   |   4 +-
 arch/mips/kernel/vdso.c                       |  56 ++-
 arch/mips/vdso/Makefile                       |  23 +-
 arch/mips/vdso/elf.S                          |   2 +-
 arch/mips/vdso/gettimeofday.c                 | 273 ------------
 arch/mips/vdso/sigreturn.S                    |   2 +-
 arch/mips/vdso/vdso.lds.S                     |   2 +
 arch/mips/vdso/vgettimeofday.c                |  30 ++
 drivers/clocksource/mips-gic-timer.c          |   5 +-
 include/vdso/datapage.h                       |  65 +++
 lib/Kconfig                                   |   5 +
 lib/vdso/Kconfig                              |  41 ++
 lib/vdso/Makefile                             |  22 +
 lib/vdso/gettimeofday.c                       | 418 ++++++++++++++++++
 56 files changed, 2167 insertions(+), 1233 deletions(-)
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
 create mode 100644 include/vdso/datapage.h
 create mode 100644 lib/vdso/Kconfig
 create mode 100644 lib/vdso/Makefile
 create mode 100644 lib/vdso/gettimeofday.c

-- 
2.19.1
