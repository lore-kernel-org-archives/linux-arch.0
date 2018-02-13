From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v7 05/37] drivers/video/concole: add negative dependency for VGA_CONSOLE on nds32
Date: Tue, 13 Feb 2018 17:09:09 +0800
Message-ID: <30ead4b33eb84bd2d0b2d51c7644d7733b14283c.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Cc: green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

nds32 does not support VGA console, so prevent that kconfig symbol from
being enabled for nds32, thus fixing these build errors:

  drivers/video/console/vgacon.o: In function `vgacon_save_screen':
  /NOBACKUP/sqa2/greentime/contrib/src_pkg/linux-nds32/drivers/video/console/vgacon.c:1327:
  undefined reference to `screen_info'
  /NOBACKUP/sqa2/greentime/contrib/src_pkg/linux-nds32/drivers/video/console/vgacon.c:1327:
  undefined reference to `screen_info'
  /NOBACKUP/sqa2/greentime/contrib/src_pkg/linux-nds32/drivers/video/console/vgacon.c:1328:
  undefined reference to `screen_info'
  /NOBACKUP/sqa2/greentime/contrib/src_pkg/linux-nds32/drivers/video/console/vgacon.c:1328:
  undefined reference to `screen_info'
  drivers/video/console/vgacon.o: In function `vgacon_init':
  /NOBACKUP/sqa2/greentime/contrib/src_pkg/linux-nds32/drivers/video/console/vgacon.c:591:
  undefined reference to `screen_info'
  drivers/video/console/vgacon.o:/NOBACKUP/sqa2/greentime/contrib/src_pkg/linux-nds32/drivers/video/console/vgacon.c:591:
  more undefined references to `screen_info' follow
  make: *** [vmlinux] Error 1

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 drivers/video/console/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 7f1f1fbcef9e..27bb893cf6b2 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -9,7 +9,7 @@ config VGA_CONSOLE
 	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC && !FRV && \
 		!SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !CRIS && \
 		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
-		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC
+		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !NDS32
 	default y
 	help
 	  Saying Y here will allow you to use Linux in text mode through a
-- 
2.16.1
