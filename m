From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/9] drbd: stop including <asm-generic/kmap_types.h>
Date: Fri, 28 Aug 2015 09:27:17 +0200
Message-ID: <1440746842-19029-5-git-send-email-hch@lst.de>
References: <1440746842-19029-1-git-send-email-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440746842-19029-1-git-send-email-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: mitake@dcl.info.waseda.ac.jp, dhowells@redhat.com, herbert@gondor.apana.org.au, oded.gabbay@amd.com, eli@mellanox.com, james_p_freyensee@linux.intel.com, linux-gpio@vger.kernel.org, drbd-dev@lists.linbit.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

<linux/highmem.h> is the placace the get the kmap type flags, asm-generic
files are generic implementations only to be used by architecture code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 434c77d..2498e883 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -29,7 +29,7 @@
 #include <linux/string.h>
 #include <linux/drbd.h>
 #include <linux/slab.h>
-#include <asm/kmap_types.h>
+#include <linux/highmem.h>
 
 #include "drbd_int.h"
 
-- 
1.9.1
