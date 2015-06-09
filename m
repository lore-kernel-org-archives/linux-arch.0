From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 00/28] ARCv2 port to Linux - (B) ISA / Core / platform support
Date: Tue, 9 Jun 2015 17:18:00 +0530
Message-ID: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:33094 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753700AbbFILuQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 07:50:16 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Hi,

ARCv2 is the next generation ISA from Synopsys and basis for the
HS3{4,6,8} families of processors which retain the traditional ARC mantra of
low power and configurability and are now more performant and feature rich.

Linux has been ported to HS38x series, a 10 stage pipeline core which
supports MMU (with huge pages) and SMP (upto 4 cores) among other features.

 - www.synopsys.com/dw/ipdir.php?ds=arc-hs38-processor
 - http://news.synopsys.com/2014-10-14-New-DesignWare-ARC-HS38-Processor-Doubles-Performance-for-Embedded-Linux-Applications
 - http://www.embedded.com/electronics-news/4435975/Synopsys-ARC-HS38-core-gives-2X-boost-to-Linux-based-apps

This sub-series builds upon the preparatory patches posted previously [1] and implements the
actual ARC HS38x core support.

Please review !

Thx,
-Vineet

[1] https://lkml.org/lkml/2015/6/7/25

Alexey Brodkin (1):
  ARC: [axs101] Prepare for AXS103

Claudiu Zissulescu (1):
  ARCv2: optimised string/mem lib routines

Ruud Derwig (1):
  ARCv2: [vdk] dts files and defconfig for HS38 VDK

Vineet Gupta (25):
  ARCv2: [intc] HS38 core interrupt controller
  ARCv2: Support for ARCv2 ISA and HS38x cores
  ARCv2: STAR 9000793984: Handle return from intr to Delay Slot
  ARCv2: STAR 9000808988: signals involving Delay Slot
  ARCv2: STAR 9000814690: Really Re-enable interrupts to avoid deadlocks
  ARCv2: MMUv4: TLB programming Model changes
  ARCv2: MMUv4: cache programming model changes
  ARCv2: MMUv4: support aliasing icache config
  ARCv2: Adhere to Zero Delay loop restriction
  ARCv2: extable: Enable sorting at build time
  ARCv2: clocksource: Introduce 64bit local RTC counter
  ARC: make plat_smp_ops weak to allow over-rides
  ARCv2: SMP: ARConnect debug/robustness
  ARCv2: SMP: clocksource: Enable Global Real Time counter
  ARCv2: SMP: intc: IDU 2nd level intc for dynamic IRQ distribution
  ARC: add compiler barrier to LLSC based cmpxchg
  ARC: add smp barriers around atomics per memory-barrriers.txt
  arch: conditionally define smp_{mb,rmb,wmb}
  ARCv2: barriers
  ARC: Reduce bitops lines of code using macros
  ARCv2: STAR 9000837815 workaround hardware exclusive transactions
    livelock
  ARCv2: SLC: Handle explcit flush for DMA ops (w/o IO-coherency)
  ARCv2: All bits in place, allow ARCv2 builds
  ARCv2: [nsim*hs*] Support simulation platforms for HS38x cores
  ARCv2: [axs103] Support ARC SDP FPGA platform for HS38x cores

 .../devicetree/bindings/arc/archs-idu-intc.txt     |  46 ++
 .../devicetree/bindings/arc/archs-intc.txt         |  22 +
 Documentation/devicetree/bindings/arc/axs103.txt   |   8 +
 arch/arc/Kconfig                                   | 130 ++++-
 arch/arc/Makefile                                  |   8 +-
 arch/arc/boot/dts/axc001.dtsi                      |  21 +
 arch/arc/boot/dts/axc003.dtsi                      | 102 ++++
 arch/arc/boot/dts/axc003_idu.dtsi                  | 126 +++++
 arch/arc/boot/dts/axs103.dts                       |  24 +
 arch/arc/boot/dts/axs103_idu.dts                   |  24 +
 arch/arc/boot/dts/axs10x_mb.dtsi                   |  17 -
 arch/arc/boot/dts/nsim_hs.dts                      |  53 +++
 arch/arc/boot/dts/nsim_hs_idu.dts                  |  72 +++
 arch/arc/boot/dts/nsimosci_hs.dts                  |  80 ++++
 arch/arc/boot/dts/nsimosci_hs_idu.dts              | 101 ++++
 arch/arc/boot/dts/vdk_axc003.dtsi                  |  61 +++
 arch/arc/boot/dts/vdk_axc003_idu.dtsi              |  76 +++
 arch/arc/boot/dts/vdk_axs10x_mb.dtsi               |  93 ++++
 arch/arc/boot/dts/vdk_hs38.dts                     |  21 +
 arch/arc/boot/dts/vdk_hs38_smp.dts                 |  21 +
 arch/arc/configs/axs103_defconfig                  | 117 +++++
 arch/arc/configs/axs103_smp_defconfig              | 118 +++++
 arch/arc/configs/nsim_hs_defconfig                 |  64 +++
 arch/arc/configs/nsim_hs_smp_defconfig             |  63 +++
 arch/arc/configs/nsimosci_hs_defconfig             |  73 +++
 arch/arc/configs/nsimosci_hs_smp_defconfig         |  93 ++++
 arch/arc/configs/vdk_hs38_defconfig                | 102 ++++
 arch/arc/configs/vdk_hs38_smp_defconfig            | 104 ++++
 arch/arc/include/asm/Kbuild                        |   1 -
 arch/arc/include/asm/arcregs.h                     |  60 ++-
 arch/arc/include/asm/atomic.h                      |  24 +-
 arch/arc/include/asm/barrier.h                     |  48 ++
 arch/arc/include/asm/bitops.h                      | 522 ++++++++-------------
 arch/arc/include/asm/cache.h                       |  18 +-
 arch/arc/include/asm/cmpxchg.h                     |  19 +-
 arch/arc/include/asm/delay.h                       |   9 +-
 arch/arc/include/asm/elf.h                         |   5 +
 arch/arc/include/asm/entry-arcv2.h                 | 190 ++++++++
 arch/arc/include/asm/entry.h                       |  21 +-
 arch/arc/include/asm/irq.h                         |   6 +
 arch/arc/include/asm/irqflags-arcv2.h              | 124 +++++
 arch/arc/include/asm/irqflags-compact.h            |   2 +
 arch/arc/include/asm/irqflags.h                    |   4 +
 arch/arc/include/asm/mcip.h                        |  94 ++++
 arch/arc/include/asm/mmu.h                         |  24 +-
 arch/arc/include/asm/pgtable.h                     |  10 +
 arch/arc/include/asm/ptrace.h                      |  43 ++
 arch/arc/include/asm/spinlock.h                    |  10 +
 arch/arc/include/asm/thread_info.h                 |   1 +
 arch/arc/include/asm/uaccess.h                     |  17 +-
 arch/arc/kernel/Makefile                           |   4 +-
 arch/arc/kernel/asm-offsets.c                      |   5 +
 arch/arc/kernel/devtree.c                          |   2 +-
 arch/arc/kernel/entry-arcv2.S                      | 239 ++++++++++
 arch/arc/kernel/head.S                             |   2 -
 arch/arc/kernel/intc-arcv2.c                       | 126 +++++
 arch/arc/kernel/mcip.c                             | 341 ++++++++++++++
 arch/arc/kernel/process.c                          |  12 +-
 arch/arc/kernel/ptrace.c                           |   2 +-
 arch/arc/kernel/setup.c                            |  56 ++-
 arch/arc/kernel/signal.c                           |   6 +-
 arch/arc/kernel/smp.c                              |  22 +-
 arch/arc/kernel/time.c                             |  95 ++++
 arch/arc/kernel/troubleshoot.c                     |  33 +-
 arch/arc/lib/Makefile                              |   6 +-
 arch/arc/lib/memcmp.S                              |  30 +-
 arch/arc/lib/memcpy-archs.S                        | 236 ++++++++++
 arch/arc/lib/memset-archs.S                        |  93 ++++
 arch/arc/lib/strcmp-archs.S                        |  78 +++
 arch/arc/mm/cache.c                                | 188 +++++++-
 arch/arc/mm/dma.c                                  |  12 +
 arch/arc/mm/tlb.c                                  |  54 ++-
 arch/arc/mm/tlbex.S                                |  28 +-
 arch/arc/plat-axs10x/Kconfig                       |  13 +-
 arch/arc/plat-axs10x/axs10x.c                      | 206 +++++++-
 arch/arc/plat-sim/platform.c                       |   7 +
 include/asm-generic/barrier.h                      |  25 +
 scripts/sortextable.c                              |   5 +
 78 files changed, 4567 insertions(+), 451 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arc/archs-idu-intc.txt
 create mode 100644 Documentation/devicetree/bindings/arc/archs-intc.txt
 create mode 100644 Documentation/devicetree/bindings/arc/axs103.txt
 create mode 100644 arch/arc/boot/dts/axc003.dtsi
 create mode 100644 arch/arc/boot/dts/axc003_idu.dtsi
 create mode 100644 arch/arc/boot/dts/axs103.dts
 create mode 100644 arch/arc/boot/dts/axs103_idu.dts
 create mode 100644 arch/arc/boot/dts/nsim_hs.dts
 create mode 100644 arch/arc/boot/dts/nsim_hs_idu.dts
 create mode 100644 arch/arc/boot/dts/nsimosci_hs.dts
 create mode 100644 arch/arc/boot/dts/nsimosci_hs_idu.dts
 create mode 100644 arch/arc/boot/dts/vdk_axc003.dtsi
 create mode 100644 arch/arc/boot/dts/vdk_axc003_idu.dtsi
 create mode 100644 arch/arc/boot/dts/vdk_axs10x_mb.dtsi
 create mode 100644 arch/arc/boot/dts/vdk_hs38.dts
 create mode 100644 arch/arc/boot/dts/vdk_hs38_smp.dts
 create mode 100644 arch/arc/configs/axs103_defconfig
 create mode 100644 arch/arc/configs/axs103_smp_defconfig
 create mode 100644 arch/arc/configs/nsim_hs_defconfig
 create mode 100644 arch/arc/configs/nsim_hs_smp_defconfig
 create mode 100644 arch/arc/configs/nsimosci_hs_defconfig
 create mode 100644 arch/arc/configs/nsimosci_hs_smp_defconfig
 create mode 100644 arch/arc/configs/vdk_hs38_defconfig
 create mode 100644 arch/arc/configs/vdk_hs38_smp_defconfig
 create mode 100644 arch/arc/include/asm/barrier.h
 create mode 100644 arch/arc/include/asm/entry-arcv2.h
 create mode 100644 arch/arc/include/asm/irqflags-arcv2.h
 create mode 100644 arch/arc/include/asm/mcip.h
 create mode 100644 arch/arc/kernel/entry-arcv2.S
 create mode 100644 arch/arc/kernel/intc-arcv2.c
 create mode 100644 arch/arc/kernel/mcip.c
 create mode 100644 arch/arc/lib/memcpy-archs.S
 create mode 100644 arch/arc/lib/memset-archs.S
 create mode 100644 arch/arc/lib/strcmp-archs.S

-- 
1.9.1
