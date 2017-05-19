From: Olof Johansson <olof@lixom.net>
Subject: [GIT PULL] ARM: SoC fixes (and a cross-arch dt-include fix)
Date: Fri, 19 May 2017 12:34:55 -0700
Message-ID: <20170519193455.GA24206@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: torvalds@linux-foundation.org
Cc: olof@lixom.net, linux-arch@vger.kernel.org, arm@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 6bf1c2d26716dcd483699cc62474e49d164c5563:

  arm64: dts: rockchip: fix include reference (2017-05-19 14:12:00 +0200)

----------------------------------------------------------------
ARM: SoC fixes (and a cross-arch dt-include fix)

We had a small batch of fixes before -rc1, but here is a larger one. It
contains a backmerge of 4.12-rc1 since some of the downstream branches we
merge had that as base; at the same time we already had merged contents
before -rc1 and rebase wasn't the right solution.

A mix of random smaller fixes and a few things worth pointing out:

 - We've started telling people to avoid cross-tree shared branches if all
   they're doing is picking up one or two DT-used constants from a
   shared include file, and instead to use the numeric values on first
   submission. Follow-up moving over to symbolic names are sent in right
   after -rc1, i.e. here. It's only a few minor patches of this type.

 - Linus Walleij and others are resurrecting the 'Gemini' platform, and
   wanted a cut-down platform-specific defconfig for it. So I picked that
   up for them.

 - Rob Herring ran 'savedefconfig' on arm64, it's a bit churny but it helps
   people to prepare patches since it's a pain when defconfig and current
   savedefconfig contents differs too much.

 - Devicetree additions for some pinctrl drivers for Armada that were
   merged this window. I'd have preferred to see those earlier but it's not
   a huge deail.

The biggest change worth pointing out though since it's touching other
parts of the tree: We added prefixes to be used when cross-including
DT contents between arm64 and arm, allowing someone to #include
<arm/foo.dtsi> from arm64, and likewise. As part of that, we needed
arm/foo.dtsi to work on arm as well. The way I suggested this to Heiko
resulted in a recursive symlink.

Instead, I've now moved it out of arch/*/boot/dts/include, into a shared
location under scripts/dtc. While I was at it, I consolidated so all
architectures now behave the same way in this manner.

Rob Herring (DT maintainer) has acked it. I cc:d most other arch
maintainers but nobody seems to care much; it doesn't really affect them
since functionality is unchanged for them by default.

----------------------------------------------------------------
Adam Ford (1):
      ARM: dts: LogicPD Torpedo: Fix camera pin mux

Andreas Kemnade (1):
      ARM: dts: gta04: fix polarity of clocks for mcbsp4

Arnd Bergmann (11):
      ARM: omap2+: make omap4_get_cpu1_ns_pa_addr declaration usable
      Merge tag 'v4.11-next-fixes' of https://github.com/mbgg/linux-mediatek into fixes
      Merge tag 'renesas-fixes-for-v4.12' of https://git.kernel.org/.../horms/renesas into fixes
      Merge tag 'mvebu-dt64-4.12-3' of git://git.infradead.org/linux-mvebu into fixes
      Merge tag 'mvebu-arm64-4.12-1' of git://git.infradead.org/linux-mvebu into fixes
      Merge branch 'tee/initial-merge' into fixes
      tee: add ARM_SMCCC dependency
      soc: imx: add PM dependency for IMX7_PM_DOMAINS
      ARM: remove duplicate 'const' annotations'
      firmware: ti_sci: fix strncat length check
      arm64: dts: rockchip: fix include reference

Baruch Siach (4):
      ARM: dts: bcm2835: fix uart0 pinctrl node names
      ARM: dts: bcm2835: fix i2c0 pins
      ARM: dts: bcm2835: fix uart0/uart1 pins
      ARM: dts: bcm2835: add index to the ethernet alias

Fabio Estevam (1):
      ARM: dts: imx53-qsrb: Pulldown PMIC IRQ pin

Florian Fainelli (2):
      Merge tag 'bcm2835-dt-next-2017-03-30' into devicetree/fixes
      soc: bcm: brcmstb: Correctly match 7435 SoC

Geert Uytterhoeven (1):
      soc: renesas: Provide dummy rcar_rst_read_mode_pins() for compile-testing

Gregory CLEMENT (3):
      arm64: marvell: enable the Armada 37xx pinctrl driver
      ARM64: dts: marvell: Add pinctrl nodes for Armada 3700
      ARM64: dts: marvell: armada37xx: add pinctrl definition

Hans Verkuil (1):
      ARM: dts: omap4: enable CEC pin for Pandaboard A4 and ES

John Crispin (1):
      arm: dts: mt7623: add clock-frequency to the a7 timer node to mt7623.dtsi

Keerthy (1):
      ARM: dts: dra7: Add power hold and power controller properties to palmas

Leonard Crestez (1):
      ARM: dts: imx6sx-sdb: Remove OPP override

Linus Walleij (1):
      ARM: configs: add a gemini defconfig

Olof Johansson (6):
      Merge tag 'v4.12-rc1' into fixes
      devicetree: Move include prefixes from arch to separate directory
      Merge tag 'arm-soc/for-4.12/devicetree-fixes' of http://github.com/Broadcom/stblinux into fixes
      Merge tag 'arm-soc/for-4.12/drivers-fixes' of http://github.com/Broadcom/stblinux into fixes
      Merge tag 'imx-fixes-4.12' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'omap-for-v4.12/fixes-v2-signed' of git://git.kernel.org/.../tmlind/linux-omap into fixes

Ravikumar Kattekola (1):
      ARM: dts: dra7: Reduce cpu thermal shutdown temperature

Rob Herring (2):
      arm64: defconfig: sync with savedefconfig
      arm64: defconfig: enable options needed for QCom DB410c board

Tony Lindgren (1):
      memory: omap-gpmc: Fix debug output for access width

yong mao (1):
      ARM64: dts: mediatek: configure some fixed mmc parameters

 arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi       |   2 +-
 arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi       |   2 +-
 arch/arm/boot/dts/bcm283x.dtsi                    |  22 +++--
 arch/arm/boot/dts/dra7-evm.dts                    |   2 +
 arch/arm/boot/dts/dra7.dtsi                       |   4 +
 arch/arm/boot/dts/imx53-qsrb.dts                  |   2 +-
 arch/arm/boot/dts/imx6sx-sdb.dts                  |  17 ----
 arch/arm/boot/dts/include/arm                     |   1 -
 arch/arm/boot/dts/include/arm64                   |   1 -
 arch/arm/boot/dts/include/dt-bindings             |   1 -
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts |   6 +-
 arch/arm/boot/dts/mt7623.dtsi                     |   2 +
 arch/arm/boot/dts/omap3-gta04.dtsi                |   3 +-
 arch/arm/boot/dts/omap4-panda-a4.dts              |   2 +-
 arch/arm/boot/dts/omap4-panda-es.dts              |   2 +-
 arch/arm/configs/gemini_defconfig                 |  68 ++++++++++++++
 arch/arm/mach-at91/pm.c                           |   2 +-
 arch/arm/mach-bcm/bcm_kona_smc.c                  |   2 +-
 arch/arm/mach-cns3xxx/core.c                      |   2 +-
 arch/arm/mach-omap2/common.h                      |   3 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c         |  10 +-
 arch/arm/mach-omap2/omap-smp.c                    |  11 ++-
 arch/arm/mach-omap2/prm_common.c                  |   2 +-
 arch/arm/mach-omap2/vc.c                          |   2 +-
 arch/arm/mach-spear/time.c                        |   2 +-
 arch/arm64/Kconfig.platforms                      |   5 +
 arch/arm64/boot/dts/include/arm                   |   1 -
 arch/arm64/boot/dts/include/arm64                 |   1 -
 arch/arm64/boot/dts/include/dt-bindings           |   1 -
 arch/arm64/boot/dts/marvell/armada-3720-db.dts    |   8 ++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi      |  73 ++++++++++++++-
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts       |   3 +
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts |   2 +-
 arch/arm64/configs/defconfig                      | 106 ++++++++++------------
 arch/cris/boot/dts/include/dt-bindings            |   1 -
 arch/metag/boot/dts/include/dt-bindings           |   1 -
 arch/mips/boot/dts/include/dt-bindings            |   1 -
 arch/powerpc/boot/dts/include/dt-bindings         |   1 -
 drivers/firmware/ti_sci.c                         |   3 +-
 drivers/memory/omap-gpmc.c                        |   2 +-
 drivers/soc/bcm/brcmstb/common.c                  |   2 +-
 drivers/soc/imx/Kconfig                           |   3 +-
 drivers/tee/Kconfig                               |   1 +
 include/linux/soc/renesas/rcar-rst.h              |   5 +
 scripts/Makefile.lib                              |   2 +-
 scripts/dtc/include-prefixes/arc                  |   1 +
 scripts/dtc/include-prefixes/arm                  |   1 +
 scripts/dtc/include-prefixes/arm64                |   1 +
 scripts/dtc/include-prefixes/c6x                  |   1 +
 scripts/dtc/include-prefixes/cris                 |   1 +
 scripts/dtc/include-prefixes/dt-bindings          |   1 +
 scripts/dtc/include-prefixes/h8300                |   1 +
 scripts/dtc/include-prefixes/metag                |   1 +
 scripts/dtc/include-prefixes/microblaze           |   1 +
 scripts/dtc/include-prefixes/mips                 |   1 +
 scripts/dtc/include-prefixes/nios2                |   1 +
 scripts/dtc/include-prefixes/openrisc             |   1 +
 scripts/dtc/include-prefixes/powerpc              |   1 +
 scripts/dtc/include-prefixes/sh                   |   1 +
 scripts/dtc/include-prefixes/xtensa               |   1 +
 60 files changed, 281 insertions(+), 129 deletions(-)
 delete mode 120000 arch/arm/boot/dts/include/arm
 delete mode 120000 arch/arm/boot/dts/include/arm64
 delete mode 120000 arch/arm/boot/dts/include/dt-bindings
 create mode 100644 arch/arm/configs/gemini_defconfig
 delete mode 120000 arch/arm64/boot/dts/include/arm
 delete mode 120000 arch/arm64/boot/dts/include/arm64
 delete mode 120000 arch/arm64/boot/dts/include/dt-bindings
 delete mode 120000 arch/cris/boot/dts/include/dt-bindings
 delete mode 120000 arch/metag/boot/dts/include/dt-bindings
 delete mode 120000 arch/mips/boot/dts/include/dt-bindings
 delete mode 120000 arch/powerpc/boot/dts/include/dt-bindings
 create mode 120000 scripts/dtc/include-prefixes/arc
 create mode 120000 scripts/dtc/include-prefixes/arm
 create mode 120000 scripts/dtc/include-prefixes/arm64
 create mode 120000 scripts/dtc/include-prefixes/c6x
 create mode 120000 scripts/dtc/include-prefixes/cris
 create mode 120000 scripts/dtc/include-prefixes/dt-bindings
 create mode 120000 scripts/dtc/include-prefixes/h8300
 create mode 120000 scripts/dtc/include-prefixes/metag
 create mode 120000 scripts/dtc/include-prefixes/microblaze
 create mode 120000 scripts/dtc/include-prefixes/mips
 create mode 120000 scripts/dtc/include-prefixes/nios2
 create mode 120000 scripts/dtc/include-prefixes/openrisc
 create mode 120000 scripts/dtc/include-prefixes/powerpc
 create mode 120000 scripts/dtc/include-prefixes/sh
 create mode 120000 scripts/dtc/include-prefixes/xtensa
