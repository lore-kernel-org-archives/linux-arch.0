From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [RFC v2 0/7] linux: add linker tables
Date: Fri, 19 Feb 2016 05:45:52 -0800
Message-ID: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50733 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423502AbcBSNqE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Feb 2016 08:46:04 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, rusty@rustcorp.com.au, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, ming.lei@canonical.com, gregkh@linuxfoundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, benh@kernel.crashing.org, jbaron@akamai.com, ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, masami.hiramatsu.pt@hitachi.com, andriy.shevchenko@linux.intel.com, dwmw2@infradead.org, xen-devel@lists.xensource.com, "Luis R. Rodriguez" <mcgrof@kernel.org>

This is my v2 of the original linker table work [0], now with
six proof of concepts ports of existing code using custom section
with custom linker script modifications:

  * DEFINE_LINKTABLE_TEXT(char, kprobes);
  * DEFINE_LINKTABLE_DATA(struct jump_entry, __jump_table);
  * DEFINE_LINKTABLE_DATA(struct _ddebug, __verbose);
  * DEFINE_LINKTABLE_RO(struct builtin_fw, builtin_fw);
  * DEFINE_LINKTABLE_INIT(struct x86_init_fn, x86_init_fns);
  * DEFINE_LINKTABLE_INIT_DATA(unsigned long, _kprobe_blacklist);

I've tested all except jump tables, I'd appreaciate some help with that.

As requested by hpa I've used standard sections and by doing so it
gives us the ability to simply categorize any custom table by actual
section used.

To help avoid further unnecessary linker script modifications,
and to help bring some clarify to how all these works I went
to some lengths to give documentating standard kernel sections
a shot.

The implementation deviates now from iPXE's linker table
solution more in favor for what we're used to and expect on
Linux. This series leaves out the paravirt_enabled() changes,
and the x86 use of linker tables. The paravirt_enabled() stuff
is now being dealt with separately [1] [2], and the x86 use case
for this will be sent as a separate series for review.

Although the diffstat is large, that's mostly documentation
and the new code. If you skip that you get:

 54 files changed, 104 insertions(+), 136 deletions(-)

Most of the savings come from the ability to skip custom
linker table entries. The users space solutoin has a new home [3].

[0] http://1450217797-19295-1-git-send-email-mcgrof@do-not-panic.com
[1] http://kernelnewbies.org/KernelProjects/remove-paravirt-enabled
[2] http://lkml.kernel.org/r/1455887316-9223-1-git-send-email-mcgrof@kernel.org
[3] https://git.kernel.org/cgit/linux/kernel/git/mcgrof/linker-tables.git/

Luis R. Rodriguez (7):
  sections.h: add sections header to collect all section info
  tables.h: add linker table support
  firmware: port built-in section to linker table
  asm/sections: add a generic push_section_tbl()
  jump_label: port __jump_table to linker tables
  dynamic_debug: port to use linker tables
  kprobes: port to linker table

 Documentation/DocBook/Makefile           |   3 +-
 Documentation/DocBook/linker-tables.tmpl | 169 ++++++++
 Documentation/DocBook/sections.tmpl      |  99 +++++
 Documentation/kbuild/makefiles.txt       |  19 +
 arch/arc/kernel/vmlinux.lds.S            |   1 -
 arch/arm/include/asm/jump_label.h        |   4 +-
 arch/arm/kernel/entry-armv.S             |   2 +-
 arch/arm/kernel/vmlinux.lds.S            |   1 -
 arch/arm64/include/asm/jump_label.h      |   4 +-
 arch/avr32/kernel/entry-avr32b.S         |   4 +-
 arch/avr32/kernel/vmlinux.lds.S          |   1 -
 arch/blackfin/kernel/vmlinux.lds.S       |   1 -
 arch/c6x/kernel/vmlinux.lds.S            |   1 -
 arch/hexagon/kernel/vmlinux.lds.S        |   1 -
 arch/ia64/kernel/jprobes.S               |   2 +-
 arch/ia64/kernel/vmlinux.lds.S           |   1 -
 arch/ia64/lib/flush.S                    |   4 +-
 arch/metag/kernel/vmlinux.lds.S          |   1 -
 arch/microblaze/kernel/vmlinux.lds.S     |   1 -
 arch/mips/include/asm/jump_label.h       |   4 +-
 arch/mips/kernel/vmlinux.lds.S           |   1 -
 arch/mn10300/kernel/vmlinux.lds.S        |   1 -
 arch/nios2/kernel/vmlinux.lds.S          |   1 -
 arch/openrisc/kernel/vmlinux.lds.S       |   1 -
 arch/parisc/kernel/vmlinux.lds.S         |   1 -
 arch/powerpc/include/asm/jump_label.h    |   6 +-
 arch/powerpc/include/asm/ppc_asm.h       |   6 +-
 arch/powerpc/kernel/vmlinux.lds.S        |   1 -
 arch/s390/include/asm/jump_label.h       |   4 +-
 arch/s390/kernel/entry.S                 |   4 +-
 arch/s390/kernel/kprobes.c               |   2 +-
 arch/s390/kernel/mcount.S                |   2 +-
 arch/s390/kernel/vmlinux.lds.S           |   1 -
 arch/score/kernel/vmlinux.lds.S          |   1 -
 arch/sh/kernel/vmlinux.lds.S             |   1 -
 arch/sparc/include/asm/jump_label.h      |   4 +-
 arch/sparc/kernel/vmlinux.lds.S          |   1 -
 arch/sparc/mm/ultra.S                    |   2 +-
 arch/tile/kernel/vmlinux.lds.S           |   1 -
 arch/x86/include/asm/jump_label.h        |   9 +-
 arch/x86/kernel/cpu/microcode/core.c     |   7 +-
 arch/x86/kernel/kprobes/core.c           |  10 +-
 arch/x86/kernel/vmlinux.lds.S            |   1 -
 arch/x86/tools/relocs.c                  |   3 +
 drivers/base/firmware_class.c            |  11 +-
 firmware/Makefile                        |   2 +-
 include/asm-generic/sections.h           |  14 +-
 include/asm-generic/vmlinux.lds.h        |  47 +--
 include/linux/compiler.h                 |   3 +-
 include/linux/dynamic_debug.h            |   6 +-
 include/linux/jump_label.h               |   5 +-
 include/linux/kprobes.h                  |   7 +-
 include/linux/sections.h                 | 224 ++++++++++
 include/linux/tables.h                   | 696 +++++++++++++++++++++++++++++++
 kernel/jump_label.c                      |  16 +-
 kernel/kprobes.c                         |  16 +-
 kernel/module.c                          |   6 +-
 lib/dynamic_debug.c                      |  13 +-
 scripts/Makefile.build                   |   4 +-
 scripts/Makefile.clean                   |   1 +
 scripts/Makefile.lib                     |  12 +
 scripts/mod/modpost.c                    |   3 +-
 scripts/recordmcount.c                   |   3 +-
 scripts/recordmcount.pl                  |   2 +-
 tools/include/linux/sections.h           |  13 +
 65 files changed, 1355 insertions(+), 143 deletions(-)
 create mode 100644 Documentation/DocBook/linker-tables.tmpl
 create mode 100644 Documentation/DocBook/sections.tmpl
 create mode 100644 include/linux/sections.h
 create mode 100644 include/linux/tables.h
 create mode 100644 tools/include/linux/sections.h

-- 
2.7.0
