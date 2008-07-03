From: Andrea Righi <righi.andrea@gmail.com>
Subject: [PATCH -mm 8/8] fix implicit declarations of function 'PAGE_ALIGN' in various drivers
Date: Thu,  3 Jul 2008 11:59:31 +0200
Message-ID: <1215079171-22637-9-git-send-email-righi.andrea@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from host198-128-dynamic.19-87-r.retail.telecomitalia.it ([87.19.128.198]:12568
	"EHLO linux.localdomain" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758033AbYGCMOT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 3 Jul 2008 08:14:19 -0400
In-Reply-To: <>
References: <>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, paulus@samba.org, balbir@linux.vnet.ibm.com, Andrea Righi <righi.andrea@gmail.com>

Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
---
 drivers/ieee1394/iso.c           |    1 +
 drivers/net/mlx4/eq.c            |    1 +
 drivers/pcmcia/electra_cf.c      |    1 +
 drivers/scsi/sun_esp.c           |    1 +
 drivers/video/acornfb.c          |    1 +
 drivers/video/imxfb.c            |    1 +
 drivers/video/omap/dispc.c       |    1 +
 drivers/video/omap/omapfb_main.c |    1 +
 drivers/video/pxafb.c            |    1 +
 drivers/video/sa1100fb.c         |    1 +
 10 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/ieee1394/iso.c b/drivers/ieee1394/iso.c
index 07ca35c..1cf6487 100644
--- a/drivers/ieee1394/iso.c
+++ b/drivers/ieee1394/iso.c
@@ -11,6 +11,7 @@
 
 #include <linux/pci.h>
 #include <linux/sched.h>
+#include <linux/mm.h>
 #include <linux/slab.h>
 
 #include "hosts.h"
diff --git a/drivers/net/mlx4/eq.c b/drivers/net/mlx4/eq.c
index 4ca78aa..7df928d 100644
--- a/drivers/net/mlx4/eq.c
+++ b/drivers/net/mlx4/eq.c
@@ -33,6 +33,7 @@
 
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/mm.h>
 #include <linux/dma-mapping.h>
 
 #include <linux/mlx4/cmd.h>
diff --git a/drivers/pcmcia/electra_cf.c b/drivers/pcmcia/electra_cf.c
index 52d0aa8..257039e 100644
--- a/drivers/pcmcia/electra_cf.c
+++ b/drivers/pcmcia/electra_cf.c
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/mm.h>
 #include <linux/vmalloc.h>
 
 #include <pcmcia/ss.h>
diff --git a/drivers/scsi/sun_esp.c b/drivers/scsi/sun_esp.c
index 2c87db9..f9cf701 100644
--- a/drivers/scsi/sun_esp.c
+++ b/drivers/scsi/sun_esp.c
@@ -7,6 +7,7 @@
 #include <linux/types.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/mm.h>
 #include <linux/init.h>
 
 #include <asm/irq.h>
diff --git a/drivers/video/acornfb.c b/drivers/video/acornfb.c
index eedb828..017233d 100644
--- a/drivers/video/acornfb.c
+++ b/drivers/video/acornfb.c
@@ -23,6 +23,7 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <linux/slab.h>
+#include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/fb.h>
 #include <linux/platform_device.h>
diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 94e4d3a..0c5a475 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -24,6 +24,7 @@
 #include <linux/string.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
+#include <linux/mm.h>
 #include <linux/fb.h>
 #include <linux/delay.h>
 #include <linux/init.h>
diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index ab32ceb..ab77c51 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -20,6 +20,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/dma-mapping.h>
+#include <linux/mm.h>
 #include <linux/vmalloc.h>
 #include <linux/clk.h>
 #include <linux/io.h>
diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index 14d0f7a..f85af5c 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -25,6 +25,7 @@
  * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
  */
 #include <linux/platform_device.h>
+#include <linux/mm.h>
 #include <linux/uaccess.h>
 
 #include <asm/mach-types.h>
diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 778b250..dc98c3b 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -30,6 +30,7 @@
 #include <linux/string.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
+#include <linux/mm.h>
 #include <linux/fb.h>
 #include <linux/delay.h>
 #include <linux/init.h>
diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
index 2dd1b8a..78bcdbc 100644
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -167,6 +167,7 @@
 #include <linux/string.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
+#include <linux/mm.h>
 #include <linux/fb.h>
 #include <linux/delay.h>
 #include <linux/init.h>
-- 
1.5.4.3
