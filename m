From: Arnd Bergmann <arnd@arndb.de>
Subject: [GIT PULL] asm-generic changes for 4.5
Date: Thu, 21 Jan 2016 00:01:33 +0100
Message-ID: <14539762.rT2m1Dhbyc@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:54302 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240AbcATXBj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jan 2016 18:01:39 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nicolas Pitre <nico@linaro.org>, rmk@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-for-linus

for you to fetch changes up to 040b323b5012b5503561ec7fe15cccd6a4bcaec2:

  ARM: asm/div64.h: adjust to generic codde (2015-11-19 20:00:43 -0500)

----------------------------------------------------------------
asm-generic changes for 4.5

The asm-generic tree this time contains one series from Nicolas Pitre
that makes the optimized do_div() implementation from the ARM
architecture available to all architectures. This also adds stricter
type checking for callers of do_div, which has uncovered a number
of bugs in existing code, and fixes up the ones we have found.

----------------------------------------------------------------
Nicolas Pitre (14):
      nouveau/nvkm/subdev/clk/gk20a.c: fix wrong do_div() usage
      imx/clk-pllv1: fix wrong do_div() usage
      imx/clk-pllv2: fix wrong do_div() usage
      tegra/clk-divider: fix wrong do_div() usage
      ti/clkt_dpll: fix wrong do_div() usage
      ti/fapll: fix wrong do_div() usage
      hid-sensor-hub.c: fix wrong do_div() usage
      drm/mgag200/mgag200_mode.c: fix wrong do_div() usage
      mtd/sm_ftl.c: fix wrong do_div() usage
      div64.h: optimize do_div() for power-of-two constant divisors
      do_div(): generic optimization for constant divisor on 32-bit machines
      __div64_const32(): abstract out the actual 128-bit cross product code
      __div64_32(): make it overridable at compile time
      ARM: asm/div64.h: adjust to generic codde

 arch/arm/include/asm/div64.h                    | 283 ++++++++----------------
 drivers/clk/imx/clk-pllv1.c                     |  14 +-
 drivers/clk/imx/clk-pllv2.c                     |   9 +-
 drivers/clk/tegra/clk-divider.c                 |   4 +-
 drivers/clk/ti/clkt_dpll.c                      |   4 +-
 drivers/clk/ti/fapll.c                          |   4 +-
 drivers/gpu/drm/mgag200/mgag200_mode.c          |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.c |   3 +-
 drivers/hid/hid-sensor-hub.c                    |   3 +-
 drivers/mtd/sm_ftl.c                            |   3 +-
 include/asm-generic/div64.h                     | 178 ++++++++++++++-
 lib/div64.c                                     |   6 +-
 12 files changed, 298 insertions(+), 215 deletions(-)
