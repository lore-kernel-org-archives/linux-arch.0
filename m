From: Lennert Buytenhek <buytenh-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>
Subject: [PATCH 5/7] mv643xx_eth: mbus decode window support
Date: Fri, 7 Mar 2008 11:22:44 +0100
Message-ID: <20080307102244.GE11977@xi.wantstofly.org>
References: <20080307101913.GA11918@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080307101913.GA11918-mfnYTeDhw6uOVk/H6u/4e9i2O/JbrIOy@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Saeed Bishara <saeed-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Dale Farnsworth <dale-1viX+2+OPRFcxvNqPlePQg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Tzachi Perelstein <tzachi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nicolas Pitre <nico-mo2vmkxb4K0@public.gmane.org>

Make it possible to pass mbus_dram_target_info to the mv643xx_eth
driver via the platform data, and make the mv643xx_eth driver
program the window registers based on this data if it is passed in.

Signed-off-by: Lennert Buytenhek <buytenh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

Index: linux-2.6.25-rc4/drivers/net/mv643xx_eth.c
===================================================================
--- linux-2.6.25-rc4.orig/drivers/net/mv643xx_eth.c
+++ linux-2.6.25-rc4/drivers/net/mv643xx_eth.c
@@ -91,6 +91,11 @@
  */
 #define PHY_ADDR_REG				0x0000
 #define SMI_REG					0x0004
+#define WINDOW_BASE(i)				(0x0200 + ((i) << 3))
+#define WINDOW_SIZE(i)				(0x0204 + ((i) << 3))
+#define WINDOW_REMAP_HIGH(i)			(0x0280 + ((i) << 2))
+#define WINDOW_BAR_ENABLE			0x0290
+#define WINDOW_PROTECT(i)			(0x0294 + ((i) << 4))
 
 /*
  * Per-port registers.
@@ -514,6 +519,8 @@ struct mv643xx_shared_private {
 	spinlock_t phy_lock;
 
 	unsigned int t_clk;
+
+	u32 win_protect;
 };
 
 struct mv643xx_private {
@@ -1892,6 +1899,9 @@ static int mv643xx_eth_probe(struct plat
 	mp->shared = platform_get_drvdata(pd->shared);
 	port_num = mp->port_num = pd->port_number;
 
+	if (mp->shared->win_protect)
+		wrl(mp, WINDOW_PROTECT(port_num), mp->shared->win_protect);
+
 	mp->shared_smi = mp->shared;
 	if (pd->override_smi) {
 		if (pd->shared_smi != NULL)
@@ -2006,6 +2016,43 @@ static int mv643xx_eth_remove(struct pla
 	return 0;
 }
 
+static void mv643xx_eth_conf_mbus_windows(struct mv643xx_shared_private *msp,
+					  struct mbus_dram_target_info *dram)
+{
+	void __iomem *base = msp->eth_base;
+	u32 win_enable;
+	u32 win_protect;
+	int i;
+
+	for (i = 0; i < 6; i++) {
+		writel(0, base + WINDOW_BASE(i));
+		writel(0, base + WINDOW_SIZE(i));
+		if (i < 4)
+			writel(0, base + WINDOW_REMAP_HIGH(i));
+	}
+
+	win_enable = 0x3f;
+	win_protect = 0;
+
+	for (i = 0; i < dram->num_cs; i++) {
+		struct mbus_dram_window *cs = dram->cs + i;
+
+		writel((cs->base & 0xffff0000) |
+			 (cs->mbus_attr << 8) |
+			 dram->mbus_dram_target_id, base + WINDOW_BASE(i));
+		writel((cs->size - 1) & 0xffff0000, base + WINDOW_SIZE(i));
+
+		if (i < 4)
+			writel(0, base + WINDOW_REMAP_HIGH(i));
+
+		win_enable &= ~(1 << i);
+		win_protect |= 3 << (2 * i);
+	}
+
+	writel(win_enable, base + WINDOW_BAR_ENABLE);
+	msp->win_protect = win_protect;
+}
+
 static int mv643xx_eth_shared_probe(struct platform_device *pdev)
 {
 	static int mv643xx_version_printed = 0;
@@ -2026,6 +2073,7 @@ static int mv643xx_eth_shared_probe(stru
 	msp = kmalloc(sizeof(*msp), GFP_KERNEL);
 	if (msp == NULL)
 		goto out;
+	memset(msp, 0, sizeof(*msp));
 
 	msp->eth_base = ioremap(res->start, res->end - res->start + 1);
 	if (msp->eth_base == NULL)
@@ -2036,6 +2084,12 @@ static int mv643xx_eth_shared_probe(stru
 
 	platform_set_drvdata(pdev, msp);
 
+	/*
+	 * (Re-)program MBUS remapping windows if we are asked to.
+	 */
+	if (pd != NULL && pd->dram != NULL)
+		mv643xx_eth_conf_mbus_windows(msp, pd->dram);
+
 	return 0;
 
 
Index: linux-2.6.25-rc4/include/linux/mv643xx_eth.h
===================================================================
--- linux-2.6.25-rc4.orig/include/linux/mv643xx_eth.h
+++ linux-2.6.25-rc4/include/linux/mv643xx_eth.h
@@ -5,6 +5,8 @@
 #ifndef __LINUX_MV643XX_ETH_H
 #define __LINUX_MV643XX_ETH_H
 
+#include <linux/mbus.h>
+
 #define MV643XX_ETH_SHARED_NAME		"mv643xx_eth_comm"
 #define MV643XX_ETH_NAME		"mv643xx_eth"
 #define MV643XX_ETH_SHARED_REGS		0x2000
@@ -15,6 +17,7 @@
 
 struct mv643xx_eth_shared_platform_data {
 	unsigned int	t_clk;
+	struct mbus_dram_target_info	*dram;
 };
 
 struct mv643xx_eth_platform_data {
--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
