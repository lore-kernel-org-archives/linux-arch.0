From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v5 00/12] arm64: ARMv8.5-A: Branch Target Identification support
Date: Wed, 22 Jan 2020 21:21:32 +0000
Message-ID: <20200122212144.6409-1-broonie@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H . J . Lu " <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Florian Weimer <fweimer@redhat.com>, Sudakshina Das <sudi.das@arm.com>, linux-a
List-Id: linux-arch.vger.kernel.org

This series implements support for ARMv8.5-A Branch Target
Identification (BTI), which is a control flow integrity protection
feature introduced as part of the ARMv8.5-A extensions.

Changes:

v5:
 - Changed a bunch of -EIO to -ENOEXEC in the ELF parsing code.
 - Move PSR_BTYPE defines to UAPI.
 - Use compat_user_mode() rather than open coding.
 - Fix a typo s/BYTPE/BTYPE/ in syscall.c
v4:
 - Dropped patch fixing existing documentation as it has already been merged.
 - Convert WARN_ON() to WARN_ON_ONCE() in "ELF: Add ELF program property
   parsing support".
 - Added display of guarded pages to ptdump.
 - Updated for conversion of exception handling from assembler to C.

Notes:
 * GCC 9 can compile backwards-compatible BTI-enabled code with
   -mbranch-protection=bti or -mbranch-protection=standard.

 * Binutils trunk supports the new ELF note, but this wasn't in a release
   the last time I posted this series.  (The situation _might_ have changed
   in the meantime...)

   Creation of a BTI-enabled binary requires _everything_ linked in to
   be BTI-enabled.  For now ld --force-bti can be used to override this,
   but some things may break until the required C library support is in
   place.

   There is no straightforward way to mark a .s file as BTI-enabled:
   scraping the output from gcc -S works as a quick hack for now.

   readelf -n can be used to examing the program properties in an ELF
   file.

 * Runtime mmap() and mprotect() can be used to enable BTI on a
   page-by-page basis using the new PROT_BTI, but the code in the
   affected pages still needs to be written or compiled to contain the
   appopriate BTI landing pads.


Dave Martin (11):
  ELF: UAPI and Kconfig additions for ELF program properties
  ELF: Add ELF program property parsing support
  mm: Reserve asm-generic prot flag 0x10 for arch use
  arm64: Basic Branch Target Identification support
  elf: Allow arch to tweak initial mmap prot flags
  arm64: elf: Enable BTI at exec based on ELF program properties
  arm64: BTI: Decode BYTPE bits when printing PSTATE
  arm64: unify native/compat instruction skipping
  arm64: traps: Shuffle code to eliminate forward declarations
  arm64: BTI: Reset BTYPE when skipping emulated instructions
  KVM: arm64: BTI: Reset BTYPE when skipping emulated instructions

Mark Brown (1):
  arm64: mm: Display guarded pages in ptdump

 Documentation/arm64/cpu-feature-registers.rst |   2 +
 Documentation/arm64/elf_hwcaps.rst            |   4 +
 arch/arm64/Kconfig                            |  29 ++++
 arch/arm64/include/asm/cpucaps.h              |   3 +-
 arch/arm64/include/asm/cpufeature.h           |   6 +
 arch/arm64/include/asm/elf.h                  |  50 ++++++
 arch/arm64/include/asm/esr.h                  |   2 +-
 arch/arm64/include/asm/exception.h            |   1 +
 arch/arm64/include/asm/hwcap.h                |   1 +
 arch/arm64/include/asm/kvm_emulate.h          |   6 +-
 arch/arm64/include/asm/mman.h                 |  37 +++++
 arch/arm64/include/asm/pgtable-hwdef.h        |   1 +
 arch/arm64/include/asm/pgtable.h              |   2 +-
 arch/arm64/include/asm/ptrace.h               |   1 +
 arch/arm64/include/asm/sysreg.h               |   4 +
 arch/arm64/include/uapi/asm/hwcap.h           |   1 +
 arch/arm64/include/uapi/asm/mman.h            |   9 ++
 arch/arm64/include/uapi/asm/ptrace.h          |   9 ++
 arch/arm64/kernel/cpufeature.c                |  33 ++++
 arch/arm64/kernel/cpuinfo.c                   |   1 +
 arch/arm64/kernel/entry-common.c              |  11 ++
 arch/arm64/kernel/process.c                   |  36 ++++-
 arch/arm64/kernel/ptrace.c                    |   2 +-
 arch/arm64/kernel/signal.c                    |  16 ++
 arch/arm64/kernel/syscall.c                   |  18 +++
 arch/arm64/kernel/traps.c                     | 127 +++++++--------
 arch/arm64/mm/dump.c                          |   5 +
 fs/Kconfig.binfmt                             |   6 +
 fs/binfmt_elf.c                               | 145 +++++++++++++++++-
 fs/compat_binfmt_elf.c                        |   4 +
 include/linux/elf.h                           |  43 ++++++
 include/linux/mm.h                            |   3 +
 include/uapi/asm-generic/mman-common.h        |   1 +
 include/uapi/linux/elf.h                      |  11 ++
 34 files changed, 555 insertions(+), 75 deletions(-)
 create mode 100644 arch/arm64/include/asm/mman.h
 create mode 100644 arch/arm64/include/uapi/asm/mman.h

-- 
2.20.1
