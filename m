From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6/9] mlx5: stop including <asm-generic/kmap_types.h>
Date: Fri, 28 Aug 2015 09:27:19 +0200
Message-ID: <1440746842-19029-7-git-send-email-hch@lst.de>
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
 drivers/infiniband/hw/mlx5/main.c                   | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c       | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c      | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 085c24b..37d7c0e 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -30,7 +30,7 @@
  * SOFTWARE.
  */
 
-#include <asm-generic/kmap_types.h>
+#include <linux/highmem.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/errno.h>
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index 75ff58d..594a149 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -30,7 +30,7 @@
  * SOFTWARE.
  */
 
-#include <asm-generic/kmap_types.h>
+#include <linux/highmem.h>
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/pci.h>
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 06e3e1e..b9140b0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -30,7 +30,7 @@
  * SOFTWARE.
  */
 
-#include <asm-generic/kmap_types.h>
+#include <linux/highmem.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/errno.h>
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
index 8a64542..fda02ec 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
@@ -30,7 +30,7 @@
  * SOFTWARE.
  */
 
-#include <asm-generic/kmap_types.h>
+#include <linux/highmem.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mlx5/driver.h>
-- 
1.9.1
