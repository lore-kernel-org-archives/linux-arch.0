From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v5 00/36] Warn on orphan section placement
Date: Fri, 31 Jul 2020 16:07:44 -0700
Message-ID: <20200731230820.1742553-1-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=linker/orphans/warn/v5

v5:
- rebase from -rc2 to -rc7 to avoid build failures on Clang vs binutils
- include Arvind's GOT fix-up series[3], since it touches many similar areas
- add PGO/AutoFDO section patch[4]
- split up x86 and arm changes into more digestable steps
- move several sections out of DISCARD and into zero-size asserts
- introduce COMMON_DISCARDS to improve ARM's linker scripts
v4: https://lore.kernel.org/lkml/20200629061840.4065483-1-keescook@chromium.org/
v3: https://lore.kernel.org/lkml/20200624014940.1204448-1-keescook@chromium.org/
v2: https://lore.kernel.org/lkml/20200622205815.2988115-1-keescook@chromium.org/
v1: https://lore.kernel.org/lkml/20200228002244.15240-1-keescook@chromium.org/

A recent bug[1] was solved for builds linked with ld.lld, and tracking
it down took way longer than it needed to (a year). Ultimately, it
boiled down to differences between ld.bfd and ld.lld's handling of
orphan sections. Similar situation have continued to recur, and it's
clear the kernel build needs to be much more explicit about linker
sections. Similarly, the recent FGKASLR series brought up orphan section
handling too[2]. In all cases, it would have been nice if the linker was
running with --orphan-handling=warn so that surprise sections wouldn't
silently get mapped into the kernel image at locations up to the whim
of the linker's orphan handling logic. Instead, all desired sections
should be explicitly identified in the linker script (to be either kept,
discarded, or verified to be zero-sized) with any orphans throwing a
warning. The powerpc architecture has actually been doing this for some
time, so this series just extends that coverage to x86, arm, and arm64.

This has gotten sucecssful build testing under the following matrix:

compiler/linker: gcc+ld.bfd, clang+ld.lld
targets: defconfig, allmodconfig
architectures: x86, i386, arm64, arm
versions: v5.8-rc7, next-20200731 (with various build fixes[7][8])

Two known-failure exceptions (unchanged by this series) being:
- clang+arm/arm64 needs CONFIG_CPU_BIG_ENDIAN=n to pass allmodconfig[5]
- clang+i386 only builds in -next, which was recently fixed[6]

All three architectures depend on the first several commits to
vmlinux.lds.h. x86 depends on Arvind's GOT series[3], so I collected it
into this version of my series, as it hadn't been taken into -tip yet.
arm64 depends on the efi/libstub patch. As such, I'd like to land this
series as a whole. Given that two thirds of it is in the arm universe,
perhaps this can land via the arm64 tree? If x86 -tip is preferred, that
works too. If I don't hear otherwise, I will just carry this myself in
-next. In all cases, I would really appreciate reviews/acks/etc. :)

Thanks!

-Kees

[1] https://github.com/ClangBuiltLinux/linux/issues/282
[2] https://lore.kernel.org/lkml/202002242122.AA4D1B8@keescook/
[3] https://lore.kernel.org/lkml/20200715004133.1430068-1-nivedita@alum.mit.edu/
[4] https://lore.kernel.org/lkml/20200625184752.73095-1-ndesaulniers@google.com/
[5] https://github.com/ClangBuiltLinux/linux/issues/1071
[6] https://github.com/ClangBuiltLinux/linux/issues/194
[7] https://lore.kernel.org/lkml/1596166744-2954-2-git-send-email-neal.liu@mediatek.com/
[8] https://lore.kernel.org/lkml/82f750c4-d423-1ed8-a158-e75153745e07@huawei.com/


Ard Biesheuvel (3):
  x86/boot/compressed: Move .got.plt entries out of the .got section
  x86/boot/compressed: Force hidden visibility for all symbol references
  x86/boot/compressed: Get rid of GOT fixup code

Arvind Sankar (4):
  x86/boot: Add .text.* to setup.ld
  x86/boot: Remove run-time relocations from .head.text code
  x86/boot: Remove run-time relocations from head_{32,64}.S
  x86/boot: Check that there are no run-time relocations

Kees Cook (28):
  vmlinux.lds.h: Create COMMON_DISCARDS
  vmlinux.lds.h: Add .gnu.version* to COMMON_DISCARDS
  vmlinux.lds.h: Avoid KASAN and KCSAN's unwanted sections
  vmlinux.lds.h: Split ELF_DETAILS from STABS_DEBUG
  vmlinux.lds.h: Add .symtab, .strtab, and .shstrtab to ELF_DETAILS
  efi/libstub: Disable -mbranch-protection
  arm64/mm: Remove needless section quotes
  arm64/kernel: Remove needless Call Frame Information annotations
  arm64/build: Remove .eh_frame* sections due to unwind tables
  arm64/build: Use common DISCARDS in linker script
  arm64/build: Add missing DWARF sections
  arm64/build: Assert for unwanted sections
  arm64/build: Warn on orphan section placement
  arm/build: Refactor linker script headers
  arm/build: Explicitly keep .ARM.attributes sections
  arm/build: Add missing sections
  arm/build: Warn on orphan section placement
  arm/boot: Handle all sections explicitly
  arm/boot: Warn on orphan section placement
  x86/asm: Avoid generating unused kprobe sections
  x86/build: Enforce an empty .got.plt section
  x86/build: Assert for unwanted sections
  x86/build: Warn on orphan section placement
  x86/boot/compressed: Reorganize zero-size section asserts
  x86/boot/compressed: Remove, discard, or assert for unwanted sections
  x86/boot/compressed: Add missing debugging sections to output
  x86/boot/compressed: Warn on orphan section placement
  arm/build: Assert for unwanted sections

Nick Desaulniers (1):
  vmlinux.lds.h: add PGO and AutoFDO input sections

 arch/alpha/kernel/vmlinux.lds.S               |   1 +
 arch/arc/kernel/vmlinux.lds.S                 |   1 +
 arch/arm/Makefile                             |   4 +
 arch/arm/boot/compressed/Makefile             |   2 +
 arch/arm/boot/compressed/vmlinux.lds.S        |  20 +--
 .../arm/{kernel => include/asm}/vmlinux.lds.h |  29 ++-
 arch/arm/kernel/vmlinux-xip.lds.S             |   8 +-
 arch/arm/kernel/vmlinux.lds.S                 |   8 +-
 arch/arm64/Makefile                           |   9 +-
 arch/arm64/kernel/smccc-call.S                |   2 -
 arch/arm64/kernel/vmlinux.lds.S               |  28 ++-
 arch/arm64/mm/mmu.c                           |   2 +-
 arch/csky/kernel/vmlinux.lds.S                |   1 +
 arch/hexagon/kernel/vmlinux.lds.S             |   1 +
 arch/ia64/kernel/vmlinux.lds.S                |   1 +
 arch/mips/kernel/vmlinux.lds.S                |   1 +
 arch/nds32/kernel/vmlinux.lds.S               |   1 +
 arch/nios2/kernel/vmlinux.lds.S               |   1 +
 arch/openrisc/kernel/vmlinux.lds.S            |   1 +
 arch/parisc/boot/compressed/vmlinux.lds.S     |   1 +
 arch/parisc/kernel/vmlinux.lds.S              |   1 +
 arch/powerpc/kernel/vmlinux.lds.S             |   2 +-
 arch/riscv/kernel/vmlinux.lds.S               |   1 +
 arch/s390/kernel/vmlinux.lds.S                |   1 +
 arch/sh/kernel/vmlinux.lds.S                  |   1 +
 arch/sparc/kernel/vmlinux.lds.S               |   1 +
 arch/um/kernel/dyn.lds.S                      |   2 +-
 arch/um/kernel/uml.lds.S                      |   2 +-
 arch/unicore32/kernel/vmlinux.lds.S           |   1 +
 arch/x86/Makefile                             |   4 +
 arch/x86/boot/compressed/Makefile             |  41 +----
 arch/x86/boot/compressed/head_32.S            |  99 ++++-------
 arch/x86/boot/compressed/head_64.S            | 165 +++++++-----------
 arch/x86/boot/compressed/mkpiggy.c            |   6 +
 arch/x86/boot/compressed/vmlinux.lds.S        |  48 ++++-
 arch/x86/boot/setup.ld                        |   2 +-
 arch/x86/include/asm/asm.h                    |   6 +-
 arch/x86/kernel/vmlinux.lds.S                 |  39 ++++-
 drivers/firmware/efi/libstub/Makefile         |  11 +-
 drivers/firmware/efi/libstub/hidden.h         |   6 -
 include/asm-generic/vmlinux.lds.h             |  49 +++++-
 include/linux/hidden.h                        |  19 ++
 42 files changed, 377 insertions(+), 252 deletions(-)
 rename arch/arm/{kernel => include/asm}/vmlinux.lds.h (84%)
 delete mode 100644 drivers/firmware/efi/libstub/hidden.h
 create mode 100644 include/linux/hidden.h

-- 
2.25.1
