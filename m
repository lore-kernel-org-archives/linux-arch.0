From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 0/3] Generalize fncpy availability
Date: Thu, 15 Jun 2017 16:21:14 -0700
Message-ID: <20170615232117.29727-1-f.fainelli@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33831 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbdFOXV1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jun 2017 19:21:27 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Keerthy J <j-keerthy@ti.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>

Hi all,

This patch series relocates ARM's fncpy to asm-generic in order for us to
be able to use SRAM_EXEC on ARM64 platforms.

Florian Fainelli (3):
  ARM: Generalize fncpy implementation
  arm64: Provide a fncpy implenentation
  misc: sram: Allow ARM64 to select SRAM_EXEC

 arch/arm/include/asm/fncpy.h   | 77 ++--------------------------------
 arch/arm64/include/asm/fncpy.h |  6 +++
 drivers/misc/Kconfig           |  2 +-
 include/asm-generic/fncpy.h    | 94 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 104 insertions(+), 75 deletions(-)
 create mode 100644 arch/arm64/include/asm/fncpy.h
 create mode 100644 include/asm-generic/fncpy.h

-- 
2.9.3
