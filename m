From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v3 3/4] arm64: Provide a fncpy implementation
Date: Fri, 16 Jun 2017 17:07:43 -0700
Message-ID: <20170617000744.22158-4-f.fainelli@gmail.com>
References: <20170617000744.22158-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170617000744.22158-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Keerthy J <j-keerthy@ti.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>
List-Id: linux-arch.vger.kernel.org

Utilize the asm-generic/fncpy.h implementation for ARM64 to allow the
use of drivers/misc/sram*.c on these platforms as well.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/include/asm/Kbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index a7a97a608033..5cfd822d3256 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -7,6 +7,7 @@ generic-y += dma-contiguous.h
 generic-y += early_ioremap.h
 generic-y += emergency-restart.h
 generic-y += errno.h
+generic-y += fncpy.h
 generic-y += hw_irq.h
 generic-y += ioctl.h
 generic-y += ioctls.h
-- 
2.9.3
