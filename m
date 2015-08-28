From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 9/9] gpio-mxc: stop including <asm-generic/bug>
Date: Fri, 28 Aug 2015 09:27:22 +0200
Message-ID: <1440746842-19029-10-git-send-email-hch@lst.de>
References: <1440746842-19029-1-git-send-email-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440746842-19029-1-git-send-email-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: mitake@dcl.info.waseda.ac.jp, dhowells@redhat.com, herbert@gondor.apana.org.au, oded.gabbay@amd.com, eli@mellanox.com, james_p_freyensee@linux.intel.com, linux-gpio@vger.kernel.org, drbd-dev@lists.linbit.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

<asm-generic/bug> contains the default implementation of BUG() and friends,
which architectures may decide to use.  The proper way to get them is
<linux/bug.h>, so use that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpio/gpio-mxc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index ec1eb1b..95be265 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -33,7 +33,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/module.h>
-#include <asm-generic/bug.h>
+#include <linux/bug.h>
 
 enum mxc_gpio_hwtype {
 	IMX1_GPIO,	/* runs on i.mx1 */
-- 
1.9.1
