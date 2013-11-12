From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH 08/17] microblaze: Remove _fdt_start casts
Date: Tue, 12 Nov 2013 20:42:18 +0100
Message-ID: <1384285347-13506-9-git-send-email-geert@linux-m68k.org>
References: <1384285347-13506-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <microblaze-linux-bounces-FR6EJeJVuqfA6Z3fQjNZrN9u6TNh0Fb7@public.gmane.org>
In-Reply-To: <1384285347-13506-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
List-Unsubscribe: <https://lists.eait.uq.edu.au/mailman/options/microblaze-linux>,
 <mailto:microblaze-linux-request-FR6EJeJVuqfA6Z3fQjNZrN9u6TNh0Fb7@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.eait.uq.edu.au/pipermail/microblaze-linux>
List-Post: <mailto:microblaze-linux-FR6EJeJVuqfA6Z3fQjNZrN9u6TNh0Fb7@public.gmane.org>
List-Help: <mailto:microblaze-linux-request-FR6EJeJVuqfA6Z3fQjNZrN9u6TNh0Fb7@public.gmane.org?subject=help>
List-Subscribe: <https://lists.eait.uq.edu.au/mailman/listinfo/microblaze-linux>,
 <mailto:microblaze-linux-request-FR6EJeJVuqfA6Z3fQjNZrN9u6TNh0Fb7@public.gmane.org?subject=subscribe>
Errors-To: microblaze-linux-bounces-FR6EJeJVuqfA6Z3fQjNZrN9u6TNh0Fb7@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

_fdt_start is an array, i.e. a pointer.

Signed-off-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Cc: microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org
---
 arch/microblaze/kernel/setup.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/microblaze/kernel/setup.c b/arch/microblaze/kernel/setup.c
index 8de8ebc309f1..603e22fec6d5 100644
--- a/arch/microblaze/kernel/setup.c
+++ b/arch/microblaze/kernel/setup.c
@@ -136,7 +136,7 @@ void __init machine_early_init(const char *cmdline, unsigned int ram,
 	lockdep_init();
 
 /* initialize device tree for usage in early_printk */
-	early_init_devtree((void *)_fdt_start);
+	early_init_devtree(_fdt_start);
 
 #ifdef CONFIG_EARLY_PRINTK
 	setup_early_printk(NULL);
@@ -152,8 +152,7 @@ void __init machine_early_init(const char *cmdline, unsigned int ram,
 	if (fdt)
 		pr_info("FDT at 0x%08x\n", fdt);
 	else
-		pr_info("Compiled-in FDT at 0x%08x\n",
-					(unsigned int)_fdt_start);
+		pr_info("Compiled-in FDT at %p\n", _fdt_start);
 
 #ifdef CONFIG_MTD_UCLINUX
 	pr_info("Found romfs @ 0x%08x (0x%08x)\n",
-- 
1.7.9.5

_______________________________________________
microblaze-linux mailing list
microblaze-linux-FR6EJeJVuqfA6Z3fQjNZrN9u6TNh0Fb7@public.gmane.org
https://lists.eait.uq.edu.au/mailman/listinfo/microblaze-linux
