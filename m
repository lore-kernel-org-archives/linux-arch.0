From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v2 0/6] add support for relative references in special sections
Date: Fri, 18 Aug 2017 12:26:18 +0100
Message-ID: <20170818112624.24991-1-ard.biesheuvel@linaro.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:36968 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750709AbdHRL0n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2017 07:26:43 -0400
Received: by mail-wr0-f179.google.com with SMTP id z91so59491735wrc.4
        for <linux-arch@vger.kernel.org>; Fri, 18 Aug 2017 04:26:43 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>, Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Joe Perches <joe@perches.com>, Nicolas Pitre <nico@linaro.org>, Steve

This adds support for emitting special sections such as initcall arrays,
PCI fixups and tracepoints as relative references rather than absolute
references. This reduces the size by 50% on 64-bit architectures, but
more importantly, it removes the need for carrying relocation metadata
for these sections in relocatables kernels (e.g., for KASLR) that need
to fix up these absolute references at boot time. On arm64, this reduces
the vmlinux footprint of such a reference by 8x (8 byte absolute reference
+ 24 byte RELA entry vs 4 byte relative reference)

Patch #2 was sent out before as a single patch. This series supersedes
the previous submission. This version makes relative ksymtab entries
dependent on the new Kconfig symbol HAVE_ARCH_PREL32_RELOCATIONS rather
than trying to infer from kbuild test robot replies for which architectures
it should be blacklisted.

Patch #1 introduces the new Kconfig symbol HAVE_ARCH_PREL32_RELOCATIONS,
and sets it for the main architectures that are expected to benefit the
most from this feature, i.e., 64-bit architectures, and ones that use
runtime relocation.

Patch #3 fixes several instances where the trailing semicolon is missing
from an initcall() definition. (Needed for patch #4)

Patches #4 - #6 implement relative references for initcallls, PCI fixups
and tracepoints, respectively, all of which produce sections with order
~1000 entries on an arm64 defconfig kernel with tracing enabled. This
means we save about 28 KB of vmlinux space for each of these patches.

For the arm64 kernel, all patches combined reduce the size of vmlinux
by about 300 KB (with KASLR enabled).

Changes since v1:
- Remove checkpatch errors to the extent feasible: in some cases, this
  involves moving extern declarations into C files, and switching to
  struct definitions rather than typedefs. Some errors are impossible
  to fix: please find the remaining ones after the diffstat.
- Used 'int' instead if 'signed int' for the various offset fields: there
  is no ambiguity between architectures regarding its signedness (unlike
  'char')
- Refactor the different patches to be more uniform in the way they define
  the section entry type and accessors in the .h file, and avoid the need to
  add #ifdefs to the C code.

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thomas Garnier <thgarnie@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Morris <james.l.morris@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Joe Perches <joe@perches.com>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Jessica Yu <jeyu@kernel.org>

Ard Biesheuvel (6):
  arch: enable relative relocations for arm64, power, x86, s390 and x86
  module: use relative references for __ksymtab entries
  treewide: add missing trailing semicolons to initcall() invocations
  init: allow initcall tables to be emitted using relative references
  drivers: pci: add support for relative addressing in quirk tables
  kernel: tracepoints: add support for relative references

 arch/Kconfig                             | 10 +++
 arch/arm64/Kconfig                       |  1 +
 arch/arm64/kernel/perf_event.c           |  2 +-
 arch/arm64/kernel/vmlinux.lds.S          |  2 +-
 arch/powerpc/Kconfig                     |  1 +
 arch/s390/Kconfig                        |  1 +
 arch/s390/hypfs/inode.c                  |  2 +-
 arch/x86/Kconfig                         |  1 +
 arch/x86/events/intel/core.c             |  2 +-
 arch/x86/include/asm/Kbuild              |  1 +
 arch/x86/include/asm/export.h            |  4 --
 drivers/net/cris/eth_v10.c               |  2 +-
 drivers/net/dsa/dsa_loop_bdinfo.c        |  2 +-
 drivers/parport/procfs.c                 |  4 +-
 drivers/pci/quirks.c                     |  6 +-
 drivers/perf/arm_pmu_acpi.c              |  2 +-
 drivers/platform/x86/intel_turbo_max_3.c |  2 +-
 fs/hugetlbfs/inode.c                     |  2 +-
 include/asm-generic/export.h             | 12 +++-
 include/linux/compiler.h                 | 11 ++++
 include/linux/export.h                   | 68 ++++++++++++++++----
 include/linux/init.h                     | 64 ++++++++++++++----
 include/linux/pci.h                      | 32 +++++++++
 include/linux/tracepoint.h               | 42 ++++++++++--
 init/main.c                              | 22 ++-----
 kernel/module.c                          | 14 ++--
 kernel/printk/printk.c                   |  4 +-
 kernel/tracepoint.c                      |  7 +-
 mm/compaction.c                          |  2 +-
 mm/oom_kill.c                            |  2 +-
 mm/page_alloc.c                          |  2 +-
 mm/page_owner.c                          |  2 +-
 net/core/lwt_bpf.c                       |  2 +-
 net/sched/sch_blackhole.c                |  2 +-
 security/security.c                      |  6 +-
 sound/core/seq_device.c                  |  4 +-
 36 files changed, 256 insertions(+), 89 deletions(-)
 delete mode 100644 arch/x86/include/asm/export.h

The following checkpatch errors cannot be fixed without breaking the
code, because inline asm at file scope cannot use parens or do-while
loops:

  ERROR: Macros with complex values should be enclosed in parentheses
  #201: FILE: include/linux/export.h:64:
  +#define __KSYMTAB_ENTRY(sym, sec)					\
  +	__ADDRESSABLE(sym)						\
  +	asm("	.section \"___ksymtab" sec "+" #sym "\", \"a\"\n"	\
  +	    "	.balign	8\n"						\
  +	    VMLINUX_SYMBOL_STR(__ksymtab_##sym) ":\n"			\
  +	    "	.long "	VMLINUX_SYMBOL_STR(sym) "- .\n"			\
  +	    "	.long "	VMLINUX_SYMBOL_STR(__kstrtab_##sym) "- .\n"	\
  +	    "	.previous\n")

  ERROR: Macros with multiple statements should be enclosed in a do - while loop
  #284: FILE: include/linux/init.h:162:
  +#define ___define_initcall(fn, id, __sec)		\
  +	__ADDRESSABLE(fn)				\
  +	asm(".section	\"" #__sec ".init\", \"a\"\n"	\
  +	"__initcall_" #fn #id ":\n"			\
  +	    ".long "	VMLINUX_SYMBOL_STR(fn) " - .\n"	\
  +	    ".previous\n");

  ERROR: Macros with complex values should be enclosed in parentheses
  #375: FILE: include/linux/pci.h:1757:
  +#define __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
  +				    class_shift, hook)			\
  +	__ADDRESSABLE(hook)						\
  +	asm(".section "	#sec ", \"a\"\n"				\
  +	    ".balign	16\n"						\
  +	    ".short "	#vendor ", " #device "\n"			\
  +	    ".long "	#class ", " #class_shift "\n"			\
  +	    ".long "	VMLINUX_SYMBOL_STR(hook) " - .\n"		\
  +	    ".previous\n")

The following errors: 

  ERROR: space required after that ',' (ctx:VxO)
  #446: FILE: include/linux/init.h:250:
  +#define console_initcall(fn)	___define_initcall(fn,, .con_initcall)
                               	                     ^
  ERROR: space required after that ',' (ctx:VxO)
  #447: FILE: include/linux/init.h:251:
  +#define security_initcall(fn)	___define_initcall(fn,, .security_initcall)
                              	                     ^
cannot be fixed because attempting so results in:

  ERROR: space prohibited before that ',' (ctx:WxW)
  #349: FILE: include/linux/init.h:250:
  +#define console_initcall(fn)	___define_initcall(fn, , .con_initcall)
                             	                       ^
  ERROR: space prohibited before that ',' (ctx:WxW)
  #350: FILE: include/linux/init.h:251:
  +#define security_initcall(fn)	___define_initcall(fn, , .security_initcall)
                              	                       ^
