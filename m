From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 12/20] memconsole: fix __iomem mishandling, switch to memremap
Date: Fri, 09 Oct 2015 18:16:41 -0400
Message-ID: <20151009221641.32203.201.stgit@dwillia2-desk3.jf.intel.com>
References: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Waychison <mikew@google.com>
List-Id: linux-arch.vger.kernel.org

The memconsole driver is not using proper accessors for __iomem.  Switch
to memremap to fix this issue, and this also prepares the driver for the
removal of ioremap_cache.

Cc: Mike Waychison <mikew@google.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/firmware/google/memconsole.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/google/memconsole.c b/drivers/firmware/google/memconsole.c
index 2f569aaed4c7..fd5041716860 100644
--- a/drivers/firmware/google/memconsole.c
+++ b/drivers/firmware/google/memconsole.c
@@ -52,14 +52,15 @@ static ssize_t memconsole_read(struct file *filp, struct kobject *kobp,
 	char *memconsole;
 	ssize_t ret;
 
-	memconsole = ioremap_cache(memconsole_baseaddr, memconsole_length);
+	memconsole = memremap(memconsole_baseaddr, memconsole_length,
+			MEMREMAP_WB);
 	if (!memconsole) {
-		pr_err("memconsole: ioremap_cache failed\n");
+		pr_err("memconsole: memremap failed\n");
 		return -ENOMEM;
 	}
 	ret = memory_read_from_buffer(buf, count, &pos, memconsole,
 				      memconsole_length);
-	iounmap(memconsole);
+	memunmap(memconsole);
 	return ret;
 }
