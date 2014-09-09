From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 0/2] Support CrystalCove PMIC ACPI operation region
Date: Tue,  9 Sep 2014 10:26:00 +0800
Message-ID: <1410229562-11507-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:37975 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754439AbaIIC0H (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 8 Sep 2014 22:26:07 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Lejun Zhu <lejun.zhu@intel.com>, Radivoje Jovanovic <radivoje.jovanovic@intel.com>, =?UTF-8?q?Daniel=20Gl=C3=B6ckner?= <dg@emlix.com>

The two patches add support for CrystalCove PMIC ACPI operation region.
The PMIC chip has two customized operation regions: one for power rail
manipulation and one for thermal purpose: sensor temperature reading
and trip point value reading/setting.

For an example ASL code on ASUS T100 with CrystalCove PMIC, see here:
https://gist.github.com/aaronlu/f5f65771a6c3251fae5d

Aaron Lu (2):
  gpio / CrystalCove: support virtual GPIO
  PMIC / opregion: support PMIC customized operation region for
    CrystalCove

 drivers/gpio/gpio-crystalcove.c           |  19 +-
 drivers/mfd/Kconfig                       |  11 +
 drivers/mfd/Makefile                      |   1 +
 drivers/mfd/intel_soc_pmic_crc.c          |   3 +
 drivers/mfd/intel_soc_pmic_crc_opregion.c | 229 +++++++++++++++++++
 drivers/mfd/intel_soc_pmic_opregion.c     | 350 ++++++++++++++++++++++++++++++
 drivers/mfd/intel_soc_pmic_opregion.h     |  35 +++
 include/asm-generic/gpio.h                |   2 +-
 8 files changed, 646 insertions(+), 4 deletions(-)
 create mode 100644 drivers/mfd/intel_soc_pmic_crc_opregion.c
 create mode 100644 drivers/mfd/intel_soc_pmic_opregion.c
 create mode 100644 drivers/mfd/intel_soc_pmic_opregion.h

-- 
1.9.3
