From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH v2 3/3] drivers/block - make Xilinx SystemACE driver arch-independent
Date: Mon, 24 Jun 2013 12:26:04 +0400
Message-ID: <1372062364-25861-4-git-send-email-abrodkin@synopsys.com>
References: <1372062364-25861-1-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from vaxjo.synopsys.com ([198.182.60.75]:37583 "EHLO
	vaxjo.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904Ab3FXI0j (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2013 04:26:39 -0400
In-Reply-To: <1372062364-25861-1-git-send-email-abrodkin@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Mischa Jonker <Mischa.Jonker@synopsys.com>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Michal Simek <monstr@monstr.eu>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andy Shevchenko <andy.shevchenko@gmail.com>

With generic accessors Xilinx SystemACE driver is no longer limited to
PPC/Microblaze architecures. It might be built and used on any
architecture now.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>

Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Mischa Jonker <mjonker@synopsys.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/block/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index b81ddfe..746d2f7 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -460,7 +460,6 @@ source "drivers/s390/block/Kconfig"
 
 config XILINX_SYSACE
 	tristate "Xilinx SystemACE support"
-	depends on 4xx || MICROBLAZE
 	help
 	  Include support for the Xilinx SystemACE CompactFlash interface
 
-- 
1.7.10.4
