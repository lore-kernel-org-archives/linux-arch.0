From: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
Subject: [PATCH] ARC: add negative dependency for VGA_CONSOLE
Date: Mon, 17 Aug 2015 18:52:57 +0300
Message-ID: <1439826777-11489-1-git-send-email-yuriy.kolerov@synopsys.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:44531 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbbHQPx1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 17 Aug 2015 11:53:27 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: arnd@arndb.de, akpm@linux-foundation.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, Vineet.Gupta1@synopsys.com, Alexey.Brodkin@synopsys.com, Anton.Kolesov@synopsys.com, Francois.Bedard@synopsys.com, Yuriy Kolerov <yuriy.kolerov@synopsys.com>

Architectures which support VGA console must define screen_info
structurture from "uapi/linux/screen_info.h". Otherwise undefined
symbol error occurs. Usually it's defined in "setup.c" for each
architecture.

If an architecture does not support VGA console (ARC's case)
there are 2 ways: define a dummy instance of screen_info or add
a negative dependency for VGA_CONSOLE in to prevent selecting
this option.

I've implemented the second way. However the best solution is to
add HAVE_VGA_CONSOLE option for targets which support VGA
console. Then turn off VGA_CONSOLE by default and add dependency
to HAVE_VGA_CONSOLE. But right now it's better to just add a
negative dependency for ARC and then consider how to collaborate
about this issue with maintainers of other architectures.

Signed-off-by: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
---
 drivers/video/console/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index fe1cd01..5d27ba0 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -9,7 +9,7 @@ config VGA_CONSOLE
 	depends on !4xx && !8xx && !SPARC && !M68K && !PARISC && !FRV && \
 		!SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !CRIS && \
 		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
-		!ARM64
+		!ARM64 && !ARC
 	default y
 	help
 	  Saying Y here will allow you to use Linux in text mode through a
-- 
2.2.0
