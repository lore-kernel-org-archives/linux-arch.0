From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v3 00/12] arm64: ARMv8.5-A: Branch Target Identification
 support
Date: Fri, 18 Oct 2019 18:25:33 +0100
Message-ID: <1571419545-20401-1-git-send-email-Dave.Martin@arm.com>
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
To: linux-kernel@vger.kernel.org
Cc: Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Florian Weimer <fweimer@redhat.com>, Sudakshina Das <sudi.das@arm.com>
List-Id: linux-arch.vger.kernel.org

This patch implements support for ARMv8.5-A Branch Target Identification
(BTI), which is a control flow integrity protection feature introduced
as part of the ARMv8.5-A extensions.

The series is based on v5.4-rc2.

A branch for this series is available in Git [3].

This series supersedes the previous v2 posting [1], and also
incorporates my proposed ELF GNU property parsing implementation.  (See
[2] for the ABI spec describing NT_GNU_PROPERTY_TYPE_0).

Changes:

 * Minor cleanups / nitpick fixes only.

   Since this is an interim update so that Mark Brown can take over
   development of the series, I haven't fully retested.  The series
   builds with defconfig.

   There are some outstanding discussion points: see notes in the
   invidual patches, particularly on patch 5.


Notes:

 * No documentation yet.  We could do with some being written before
   this series gets merged.

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


[1] [PATCH v2 00/12] arm64: ARMv8.5-A: Branch Target Identification support
https://lore.kernel.org/lkml/1570733080-21015-1-git-send-email-Dave.Martin@arm.com/

[2] Linux Extensions to gABI
https://github.com/hjl-tools/linux-abi/wiki/Linux-Extensions-to-gABI

[3] Git branch:
git://linux-arm.org/linux-dm.git arm64/bti/v3/head
http://linux-arm.org/git?p=linux-dm.git;a=shortlog;h=refs/heads/arm64/bti/v3/head


Dave Martin (12):
  ELF: UAPI and Kconfig additions for ELF program properties
  ELF: Add ELF program property parsing support
  mm: Reserve asm-generic prot flag 0x10 for arch use
  arm64: docs: cpu-feature-registers: Document ID_AA64PFR1_EL1
  arm64: Basic Branch Target Identification support
  elf: Allow arch to tweak initial mmap prot flags
  arm64: elf: Enable BTI at exec based on ELF program properties
  arm64: BTI: Decode BYTPE bits when printing PSTATE
  arm64: traps: Fix inconsistent faulting instruction skipping
  arm64: traps: Shuffle code to eliminate forward declarations
  arm64: BTI: Reset BTYPE when skipping emulated instructions
  KVM: arm64: BTI: Reset BTYPE when skipping emulated instructions

 Documentation/arm64/cpu-feature-registers.rst |  17 ++-
 Documentation/arm64/elf_hwcaps.rst            |   4 +
 arch/arm64/Kconfig                            |  31 ++++++
 arch/arm64/include/asm/cpucaps.h              |   3 +-
 arch/arm64/include/asm/cpufeature.h           |   6 ++
 arch/arm64/include/asm/elf.h                  |  50 +++++++++
 arch/arm64/include/asm/esr.h                  |   2 +-
 arch/arm64/include/asm/hwcap.h                |   1 +
 arch/arm64/include/asm/kvm_emulate.h          |   6 +-
 arch/arm64/include/asm/mman.h                 |  37 +++++++
 arch/arm64/include/asm/pgtable-hwdef.h        |   1 +
 arch/arm64/include/asm/pgtable.h              |   2 +-
 arch/arm64/include/asm/ptrace.h               |   8 ++
 arch/arm64/include/asm/sysreg.h               |   4 +
 arch/arm64/include/uapi/asm/hwcap.h           |   1 +
 arch/arm64/include/uapi/asm/mman.h            |   9 ++
 arch/arm64/include/uapi/asm/ptrace.h          |   1 +
 arch/arm64/kernel/cpufeature.c                |  33 ++++++
 arch/arm64/kernel/cpuinfo.c                   |   1 +
 arch/arm64/kernel/entry.S                     |  11 ++
 arch/arm64/kernel/process.c                   |  36 ++++++-
 arch/arm64/kernel/ptrace.c                    |   2 +-
 arch/arm64/kernel/signal.c                    |  16 +++
 arch/arm64/kernel/syscall.c                   |  18 ++++
 arch/arm64/kernel/traps.c                     | 126 +++++++++++-----------
 fs/Kconfig.binfmt                             |   6 ++
 fs/binfmt_elf.c                               | 145 ++++++++++++++++++++++++--
 fs/compat_binfmt_elf.c                        |   4 +
 include/linux/elf.h                           |  43 ++++++++
 include/linux/mm.h                            |   3 +
 include/uapi/asm-generic/mman-common.h        |   1 +
 include/uapi/linux/elf.h                      |  11 ++
 32 files changed, 560 insertions(+), 79 deletions(-)
 create mode 100644 arch/arm64/include/asm/mman.h
 create mode 100644 arch/arm64/include/uapi/asm/mman.h

-- 
2.1.4
