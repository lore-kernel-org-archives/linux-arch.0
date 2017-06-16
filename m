From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v2 0/4] Generalize fncpy availability
Date: Fri, 16 Jun 2017 14:28:04 -0700
Message-ID: <20170616212808.19073-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Keerthy J <j-keerthy@ti.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi all,

This patch series makes ARM's fncpy() implementation more generic (dropping the
Thumb-specifics) and available in an asm-generic header file.

Tested on a Broadcom ARM64 STB platform with code that is written to SRAM.

Changes in v2:
- leave the ARM implementation where it is
- make the generic truly generic (no)

This is helpful in making SoC-specific power management code become true drivers
that can be shared between different architectures.

Thanks!

Florian Fainelli (4):
  ARM: fncpy: Rename include guards
  asm-generic: Provide a fncpy() implementation
  arm64: Provide a fncpy implementation
  misc: sram: Allow ARM64 to select SRAM_EXEC

 arch/arm/include/asm/fncpy.h   |  6 +--
 arch/arm64/include/asm/fncpy.h |  6 +++
 drivers/misc/Kconfig           |  2 +-
 include/asm-generic/fncpy.h    | 93 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/include/asm/fncpy.h
 create mode 100644 include/asm-generic/fncpy.h

-- 
2.9.3
