From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 00/10] unify ioremap definitions and introduce memremap
Date: Sun, 19 Jul 2015 20:17:32 -0400
Message-ID: <20150720001614.30857.89063.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40908 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610AbbGTAXQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 19 Jul 2015 20:23:16 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com
Cc: linux-arch@vger.kernel.org, tony.luck@intel.com, toshi.kani@hp.com, arnd@arndb.de, benh@kernel.crashing.org, mcgrof@suse.com, x86@kernel.org, linux-kernel@vger.kernel.org, geert@linux-m68k.org, Mike Travis <travis@sgi.com>, Roland Dreier <roland@purestorage.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, ralf@linux-mips.org, linux@arm.linux.org.uk, Andrew Morton <akpm@linux-foundation.org>, kbuild test robot <fengguang.wu@intel.com>, hch@lst.de, ross.zwisler@linux.intel.com, linux-arm-kernel@lists.infradead.org

While developing the pmem driver it became clear that not all
architectures implement all the various ioremap types, and when they do
implement an ioremap instance the declaration is inconsistent.

In addition to ioremap prototype confusion, it was also noticed that
several usages of ioremap_cache() were ignoring the __iomem annotation
on returned pointers.  The common theme of these call sites is treating
the return value from ioremap() as an unannotated pointer to normal
memory.  Introduce memremap() as a method to treat a given resource as
memory (safe to speculatively read, pre-fetch, write-combine, etc).

Note that Christoph proposed, in the longer term, changing the calling
convention of ioremap() to take a mapping and prot flags.  It seems that
outside of the _nocache usages of ioremap_*() most instances should be
converted to some form of memremap().  For this reason memremap() takes
a mapping type 'flags' argument and breaks from the pattern of
"ioremap_<type>()".

This series also folds in, with a few fixups, Toshi's fixes for
region_is_ram().  The memremap() implementation needs a functional
region_is_ram() to block attempts to remap system memory.

The series applies against latest 4.2-rc and is targeted for -tip, but
I'm open to carrying a branch, or, if proposed, a better alternative to
handle this cross-tree thrash.  This content has passed a cycle through
the 0day-kbuild infrastructure.

---

Dan Williams (7):
      arch, drivers: don't include <asm/io.h> directly, use <linux/io.h> instead
      arch: unify ioremap prototypes and macro aliases
      cleanup IORESOURCE_CACHEABLE vs ioremap()
      devm: fix ioremap_cache() usage
      arch: introduce strict_ioremap
      arch: introduce memremap()
      pmem: convert to generic memremap

Toshi Kani (3):
      mm, x86: Fix warning in ioremap RAM check
      mm, x86: Remove region_is_ram() call from ioremap
      mm: Fix bugs in region_is_ram()


 arch/alpha/include/asm/io.h                 |    7 ++
 arch/arc/include/asm/io.h                   |    6 --
 arch/arm/Kconfig                            |    1 
 arch/arm/include/asm/io.h                   |    8 +--
 arch/arm/mach-clps711x/board-cdb89712.c     |    2 -
 arch/arm/mach-shmobile/pm-rcar.c            |    2 -
 arch/arm/mm/ioremap.c                       |    6 +-
 arch/arm/mm/nommu.c                         |    6 +-
 arch/arm64/Kconfig                          |    1 
 arch/arm64/include/asm/io.h                 |   23 ++++++--
 arch/arm64/kernel/efi.c                     |    7 +-
 arch/arm64/kernel/smp_spin_table.c          |   17 +++---
 arch/avr32/include/asm/io.h                 |   22 ++++---
 arch/avr32/mm/ioremap.c                     |    2 -
 arch/cris/include/asm/io.h                  |    8 +--
 arch/cris/mm/ioremap.c                      |    2 -
 arch/frv/Kconfig                            |    1 
 arch/frv/include/asm/io.h                   |   23 +++-----
 arch/hexagon/include/asm/io.h               |    5 +-
 arch/ia64/include/asm/io.h                  |   10 +--
 arch/ia64/kernel/cyclone.c                  |    2 -
 arch/ia64/mm/ioremap.c                      |    4 +
 arch/m32r/include/asm/io.h                  |    9 +--
 arch/m68k/Kconfig                           |    1 
 arch/m68k/include/asm/io_mm.h               |   21 ++++---
 arch/m68k/include/asm/io_no.h               |   34 +++++++----
 arch/m68k/include/asm/raw_io.h              |    3 +
 arch/m68k/mm/kmap.c                         |    2 -
 arch/metag/Kconfig                          |    1 
 arch/metag/include/asm/io.h                 |   35 +++++++-----
 arch/microblaze/include/asm/io.h            |    6 --
 arch/microblaze/mm/pgtable.c                |    2 -
 arch/mips/Kconfig                           |    1 
 arch/mips/include/asm/io.h                  |   42 +++++---------
 arch/mn10300/include/asm/io.h               |   10 ++-
 arch/nios2/include/asm/io.h                 |   15 +----
 arch/openrisc/include/asm/io.h              |    3 +
 arch/openrisc/mm/ioremap.c                  |    2 -
 arch/parisc/include/asm/io.h                |    6 +-
 arch/parisc/mm/ioremap.c                    |    2 -
 arch/powerpc/Kconfig                        |    1 
 arch/powerpc/include/asm/io.h               |    7 +-
 arch/powerpc/kernel/pci_of_scan.c           |    2 -
 arch/s390/include/asm/io.h                  |    8 +--
 arch/sh/include/asm/io.h                    |    9 ++-
 arch/sparc/include/asm/io_32.h              |    7 +-
 arch/sparc/include/asm/io_64.h              |    8 +--
 arch/sparc/kernel/ioport.c                  |    2 -
 arch/sparc/kernel/pci.c                     |    3 -
 arch/tile/include/asm/io.h                  |   17 ++++--
 arch/unicore32/include/asm/io.h             |   25 +++++++-
 arch/x86/Kconfig                            |    1 
 arch/x86/include/asm/io.h                   |   17 +++---
 arch/x86/kernel/crash_dump_64.c             |    6 +-
 arch/x86/kernel/kdebugfs.c                  |    8 +--
 arch/x86/kernel/ksysfs.c                    |   28 +++++----
 arch/x86/mm/ioremap.c                       |   53 ++++++++---------
 arch/xtensa/Kconfig                         |    1 
 arch/xtensa/include/asm/io.h                |   13 ++--
 drivers/acpi/apei/einj.c                    |    9 ++-
 drivers/acpi/apei/erst.c                    |    6 +-
 drivers/firmware/google/memconsole.c        |    5 +-
 drivers/isdn/icn/icn.h                      |    2 -
 drivers/mtd/devices/slram.c                 |    2 -
 drivers/mtd/nand/diskonchip.c               |    2 -
 drivers/mtd/onenand/generic.c               |    2 -
 drivers/net/ethernet/sfc/io.h               |    2 -
 drivers/nvdimm/pmem.c                       |    2 -
 drivers/pci/probe.c                         |    3 -
 drivers/pnp/manager.c                       |    2 -
 drivers/scsi/aic94xx/aic94xx_init.c         |    7 --
 drivers/scsi/arcmsr/arcmsr_hba.c            |    5 --
 drivers/scsi/mvsas/mv_init.c                |   15 +----
 drivers/scsi/sun3x_esp.c                    |    2 -
 drivers/staging/comedi/drivers/ii_pci20kc.c |    1 
 drivers/tty/serial/8250/8250_core.c         |    2 -
 drivers/video/fbdev/ocfb.c                  |    1 
 drivers/video/fbdev/s1d13xxxfb.c            |    3 -
 drivers/video/fbdev/stifb.c                 |    1 
 include/asm-generic/io.h                    |   15 +++--
 include/asm-generic/iomap.h                 |    8 ---
 include/linux/device.h                      |    5 ++
 include/linux/io-mapping.h                  |    2 -
 include/linux/io.h                          |   82 +++++++++++++++++++++++++++
 include/linux/mtd/map.h                     |    2 -
 include/linux/pmem.h                        |   29 +++++-----
 include/video/vga.h                         |    2 -
 kernel/resource.c                           |   57 +++++++++++++++++--
 lib/Kconfig                                 |    5 +-
 lib/devres.c                                |   68 ++++++++++++++--------
 lib/pci_iomap.c                             |    7 +-
 tools/testing/nvdimm/Kbuild                 |    4 +
 tools/testing/nvdimm/test/iomap.c           |   34 ++++++++---
 93 files changed, 565 insertions(+), 405 deletions(-)
