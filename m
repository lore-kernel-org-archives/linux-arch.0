From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 3/3] misc: sram: Allow ARM64 to select SRAM_EXEC
Date: Thu, 15 Jun 2017 16:21:17 -0700
Message-ID: <20170615232117.29727-4-f.fainelli@gmail.com>
References: <20170615232117.29727-1-f.fainelli@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35279 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752071AbdFOXVi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jun 2017 19:21:38 -0400
In-Reply-To: <20170615232117.29727-1-f.fainelli@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Keerthy J <j-keerthy@ti.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>

Now that ARM64 also has a fncpy() implementation, allow selection
SRAM_EXEC for ARM64 as well.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/misc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 07bbd4cc1852..ac8779278c0c 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -464,7 +464,7 @@ config SRAM
 	bool "Generic on-chip SRAM driver"
 	depends on HAS_IOMEM
 	select GENERIC_ALLOCATOR
-	select SRAM_EXEC if ARM
+	select SRAM_EXEC if ARM || ARM64
 	help
 	  This driver allows you to declare a memory region to be managed by
 	  the genalloc API. It is supposed to be used for small on-chip SRAM
-- 
2.9.3
