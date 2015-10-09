Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:22460 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760AbbJIWVV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 9 Oct 2015 18:21:21 -0400
Subject: [PATCH 00/20] tree-wide convert to memremap()
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 09 Oct 2015 18:15:37 -0400
Message-ID: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Jaroslav Kysela <perex@perex.cz>, Lv Zheng <lv.zheng@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Jeeja KP <jeeja.kp@intel.com>, linux-arch@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Bob Moore <robert.moore@intel.com>, Mike Waychison <mikew@google.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Ross Zwisler <ross.zwisler@linux.intel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Len Brown <lenb@kernel.org>, Joerg Roedel <jroedel@suse.de>, Arnd Bergmann <arnd@arndb.de>, intel-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, Mark Brown <broonie@kernel.org>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org, Tony Luck <tony.luck@intel.com>, Takashi Iwai <tiwai@suse.com>, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Message-ID: <20151009221537.20GqsBsJ4VOlNIsQY0Zuq6N0eCHLb9nwbizrXjXop6w@z>

The memremap() api [1] was merged in 4.3 [2] with an initial
implementation for x86 and a conversion of the pmem driver. Complete the
conversion for the rest of the kernel.

Feel free to either ack or directly apply a conversion-patch as I will
defer the final removal patches until all the conversions have landed.

[1]: https://lwn.net/Articles/653585/
[2]: commit 92281dee825f arch: introduce memremap()

---

Dan Williams (20):
      x86: introduce arch_memremap()
      arm: introduce arch_memremap()
      ia64: introduce arch_memremap()
      sh: introduce arch_memremap()
      m68k: introduce arch_memremap()
      arm: switch from ioremap_cache to memremap
      x86: switch from ioremap_cache to memremap
      gma500: switch from acpi_os_ioremap to memremap
      i915: switch from acpi_os_ioremap to memremap
      acpi: switch from ioremap_cache to memremap
      sound, skylake: switch from ioremap_cache to memremap
      memconsole: fix __iomem mishandling, switch to memremap
      intel-iommu: switch from ioremap_cache to memremap
      pxa2xx-flash: switch from ioremap_cache to memremap
      sfi: switch from ioremap_cache to memremap
      fbdev: switch from ioremap_wt to memremap
      arch: kill ioremap_cached()
      arch: kill ioremap_fullcache()
      arch: remove ioremap_cache, replace with arch_memremap
      arch: remove ioremap_wt, optionally replace with arch_memremap


 Documentation/x86/pat.txt             |    6 +--
 arch/arc/include/asm/io.h             |    1 
 arch/arm/Kconfig                      |    1 
 arch/arm/include/asm/io.h             |    7 ---
 arch/arm/include/asm/xen/page.h       |    4 +-
 arch/arm/mm/ioremap.c                 |   12 ++++-
 arch/arm/mm/mmu.c                     |    2 -
 arch/arm/mm/nommu.c                   |   11 +++--
 arch/arm64/Kconfig                    |    1 
 arch/arm64/include/asm/acpi.h         |   11 -----
 arch/arm64/include/asm/dmi.h          |    8 ++--
 arch/arm64/include/asm/io.h           |    2 -
 arch/arm64/kernel/efi.c               |    9 ++--
 arch/arm64/kernel/smp_spin_table.c    |   19 ++++-----
 arch/arm64/mm/ioremap.c               |   20 +++------
 arch/avr32/include/asm/io.h           |    1 
 arch/frv/include/asm/io.h             |   12 -----
 arch/ia64/Kconfig                     |    1 
 arch/ia64/include/asm/io.h            |    6 ---
 arch/ia64/mm/ioremap.c                |   10 +++++
 arch/m32r/include/asm/io.h            |    1 
 arch/m68k/Kconfig                     |    1 
 arch/m68k/include/asm/io_mm.h         |   13 ------
 arch/m68k/include/asm/io_no.h         |   11 -----
 arch/m68k/include/asm/raw_io.h        |    1 
 arch/m68k/mm/kmap.c                   |   17 +++++++-
 arch/m68k/mm/sun3kmap.c               |    7 +++
 arch/metag/include/asm/io.h           |    6 ---
 arch/microblaze/include/asm/io.h      |    2 -
 arch/mn10300/include/asm/io.h         |    1 
 arch/nios2/include/asm/io.h           |    1 
 arch/s390/include/asm/io.h            |    1 
 arch/sh/Kconfig                       |    1 
 arch/sh/include/asm/io.h              |    7 ---
 arch/sh/mm/ioremap.c                  |    9 ++++
 arch/sparc/include/asm/io_32.h        |    1 
 arch/sparc/include/asm/io_64.h        |    1 
 arch/tile/include/asm/io.h            |    2 -
 arch/unicore32/include/asm/io.h       |    4 --
 arch/unicore32/mm/ioremap.c           |    8 ----
 arch/x86/Kconfig                      |    1 
 arch/x86/include/asm/efi.h            |    3 +
 arch/x86/include/asm/io.h             |    4 --
 arch/x86/kernel/crash_dump_64.c       |    6 +--
 arch/x86/kernel/kdebugfs.c            |    8 ++--
 arch/x86/kernel/ksysfs.c              |   28 ++++++-------
 arch/x86/mm/ioremap.c                 |   43 ++++++++-----------
 arch/xtensa/include/asm/io.h          |   12 -----
 drivers/acpi/apei/einj.c              |    9 ++--
 drivers/acpi/apei/erst.c              |    6 +--
 drivers/acpi/nvs.c                    |    6 +--
 drivers/acpi/osl.c                    |   70 +++++++++-----------------------
 drivers/firmware/google/memconsole.c  |    7 ++-
 drivers/gpu/drm/gma500/opregion.c     |    8 ++--
 drivers/gpu/drm/gma500/psb_drv.h      |    2 -
 drivers/gpu/drm/gma500/psb_lid.c      |    8 ++--
 drivers/gpu/drm/i915/i915_debugfs.c   |    2 -
 drivers/gpu/drm/i915/i915_drv.h       |   12 +++--
 drivers/gpu/drm/i915/intel_bios.c     |    7 +--
 drivers/gpu/drm/i915/intel_opregion.c |   73 ++++++++++++++++-----------------
 drivers/gpu/drm/i915/intel_panel.c    |    2 -
 drivers/iommu/intel-iommu.c           |   20 +++++----
 drivers/iommu/intel_irq_remapping.c   |    8 ++--
 drivers/mtd/maps/pxa2xx-flash.c       |    6 +--
 drivers/nvdimm/Kconfig                |    2 -
 drivers/sfi/sfi_core.c                |    4 +-
 drivers/video/fbdev/Kconfig           |    2 -
 drivers/video/fbdev/amifb.c           |    5 +-
 drivers/video/fbdev/atafb.c           |    5 +-
 drivers/video/fbdev/hpfb.c            |    6 +--
 include/acpi/acpi_io.h                |    6 +--
 include/asm-generic/io.h              |    8 ----
 include/asm-generic/iomap.h           |    4 --
 include/linux/io.h                    |    1 
 kernel/Makefile                       |    2 -
 kernel/memremap.c                     |   27 +++++-------
 lib/Kconfig                           |    6 ++-
 sound/soc/intel/skylake/skl-nhlt.c    |   10 ++---
 sound/soc/intel/skylake/skl.h         |    6 +--
 79 files changed, 284 insertions(+), 400 deletions(-)
