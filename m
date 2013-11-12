From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 13/17] openrisc: Refactor or32_early_setup()
Date: Tue, 12 Nov 2013 20:42:23 +0100
Message-ID: <1384285347-13506-14-git-send-email-geert@linux-m68k.org>
References: <1384285347-13506-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bounces@lists.openrisc.net>
In-Reply-To: <1384285347-13506-1-git-send-email-geert@linux-m68k.org>
List-Unsubscribe: <http://lists.openrisc.net/options/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=unsubscribe>
List-Archive: <http://lists.openrisc.net/pipermail/linux>
List-Post: <mailto:linux@lists.openrisc.net>
List-Help: <mailto:linux-request@lists.openrisc.net?subject=help>
List-Subscribe: <http://lists.openrisc.net/listinfo/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=subscribe>
Sender: linux-bounces@lists.openrisc.net
Errors-To: linux-bounces@lists.openrisc.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux@lists.openrisc.net
List-Id: linux-arch.vger.kernel.org

  - Change fdt pointer (passed from head.S) from unsigned int to void *,
    which allows to kill a cast, and makes it compatible with __dtb_start.
  - Use pr_info(),
  - Extract common part.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: linux@lists.openrisc.net
---
 arch/openrisc/kernel/setup.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index d0e7693c67a3..4fc7ccc0a2cf 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -208,15 +208,15 @@ void __init setup_cpuinfo(void)
  * Falls back on built-in device tree in case null pointer is passed.
  */
 
-void __init or32_early_setup(unsigned int fdt)
+void __init or32_early_setup(void *fdt)
 {
-	if (fdt) {
-		early_init_devtree((void*) fdt);
-		printk(KERN_INFO "FDT at 0x%08x\n", fdt);
-	} else {
-		early_init_devtree(__dtb_start);
-		printk(KERN_INFO "Compiled-in FDT at %p\n", __dtb_start);
+	if (fdt)
+		pr_info("FDT at %p\n", fdt);
+	else {
+		fdt = __dtb_start;
+		pr_info("Compiled-in FDT at %p\n", fdt);
 	}
+	early_init_devtree(fdt);
 }
 
 static int __init openrisc_device_probe(void)
-- 
1.7.9.5
