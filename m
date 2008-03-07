From: Lennert Buytenhek <buytenh-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>
Subject: [PATCH 3/7] Orion: make PCIe/PCI support use mbus DRAM info
Date: Fri, 7 Mar 2008 11:22:08 +0100
Message-ID: <20080307102208.GC11977@xi.wantstofly.org>
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

Make the Orion PCIe/PCI code initialise MBUS decode windows based on
mbus_dram_target_info instead of reading the info from the Orion DDR
unit decode registers directly, and move the window code with the other
PCI code, where it can be called as part of the generic PCIe/PCI init
process.

Signed-off-by: Lennert Buytenhek <buytenh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

Index: linux-2.6.25-rc4/arch/arm/mach-orion/addr-map.c
===================================================================
--- linux-2.6.25-rc4.orig/arch/arm/mach-orion/addr-map.c
+++ linux-2.6.25-rc4/arch/arm/mach-orion/addr-map.c
@@ -82,56 +82,6 @@
 #define CPU_WIN_REMAP_HI(n)	ORION_BRIDGE_REG(0x00c | ((n) << 4))
 
 /*
- * PCIE Address Decode Windows registers
- */
-#define PCIE_BAR_CTRL(n)	ORION_PCIE_REG(0x1804 + ((n - 1) * 4))
-#define PCIE_BAR_LO(n)		ORION_PCIE_REG(0x0010 + ((n) * 8))
-#define PCIE_BAR_HI(n)		ORION_PCIE_REG(0x0014 + ((n) * 8))
-#define PCIE_WIN_CTRL(n)	(((n) < 5) ? \
-					ORION_PCIE_REG(0x1820 + ((n) << 4)) : \
-					ORION_PCIE_REG(0x1880))
-#define PCIE_WIN_BASE(n)	(((n) < 5) ? \
-					ORION_PCIE_REG(0x1824 + ((n) << 4)) : \
-					ORION_PCIE_REG(0x1884))
-#define PCIE_WIN_REMAP(n)	(((n) < 5) ? \
-					ORION_PCIE_REG(0x182c + ((n) << 4)) : \
-					ORION_PCIE_REG(0x188c))
-#define PCIE_DEFWIN_CTRL	ORION_PCIE_REG(0x18b0)
-#define PCIE_EXPROM_WIN_CTRL	ORION_PCIE_REG(0x18c0)
-#define PCIE_EXPROM_WIN_REMP	ORION_PCIE_REG(0x18c4)
-#define PCIE_MAX_BARS		3
-#define PCIE_MAX_WINS		6
-
-/*
- * Use PCIE BAR '1' for all DDR banks
- */
-#define PCIE_DRAM_BAR		1
-
-/*
- * PCI Address Decode Windows registers
- */
-#define PCI_BAR_SIZE_DDR_CS(n)	(((n) == 0) ? ORION_PCI_REG(0xc08) : \
-				((n) == 1) ? ORION_PCI_REG(0xd08) :  \
-				((n) == 2) ? ORION_PCI_REG(0xc0c) :  \
-				((n) == 3) ? ORION_PCI_REG(0xd0c) : 0)
-#define PCI_BAR_REMAP_DDR_CS(n)	(((n) ==0) ? ORION_PCI_REG(0xc48) : \
-				((n) == 1) ? ORION_PCI_REG(0xd48) :  \
-				((n) == 2) ? ORION_PCI_REG(0xc4c) :  \
-				((n) == 3) ? ORION_PCI_REG(0xd4c) : 0)
-#define PCI_BAR_ENABLE		ORION_PCI_REG(0xc3c)
-#define PCI_CTRL_BASE_LO(n)	ORION_PCI_REG(0x1e00 | ((n) << 4))
-#define PCI_CTRL_BASE_HI(n)	ORION_PCI_REG(0x1e04 | ((n) << 4))
-#define PCI_CTRL_SIZE(n)	ORION_PCI_REG(0x1e08 | ((n) << 4))
-#define PCI_ADDR_DECODE_CTRL	ORION_PCI_REG(0xd3c)
-
-/*
- * PCI configuration heleprs for BAR settings
- */
-#define PCI_CONF_FUNC_BAR_CS(n)		((n) >> 1)
-#define PCI_CONF_REG_BAR_LO_CS(n)	(((n) & 1) ? 0x18 : 0x10)
-#define PCI_CONF_REG_BAR_HI_CS(n)	(((n) & 1) ? 0x1c : 0x14)
-
-/*
  * Gigabit Ethernet Address Decode Windows registers
  */
 #define ETH_WIN_BASE(win)	ORION_ETH_REG(0x200 + ((win) * 8))
@@ -270,104 +220,6 @@ void __init orion_setup_pcie_wa_win(u32 
 }
 
 
-/*
- * Setup PCIE BARs and Address Decode Wins:
- * BAR[0,2] -> disabled, BAR[1] -> covers all DRAM banks
- * WIN[0-3] -> DRAM bank[0-3]
- */
-void __init orion_setup_pcie_wins(void)
-{
-	u32 base, size, i;
-
-	/*
-	 * First, disable and clear BARs and windows
-	 */
-	for (i = 1; i < PCIE_MAX_BARS; i++) {
-		orion_write(PCIE_BAR_CTRL(i), 0);
-		orion_write(PCIE_BAR_LO(i), 0);
-		orion_write(PCIE_BAR_HI(i), 0);
-	}
-
-	for (i = 0; i < PCIE_MAX_WINS; i++) {
-		orion_write(PCIE_WIN_CTRL(i), 0);
-		orion_write(PCIE_WIN_BASE(i), 0);
-		orion_write(PCIE_WIN_REMAP(i), 0);
-	}
-
-	/*
-	 * Setup windows for DDR banks. Count total DDR size on the fly.
-	 */
-	base = DDR_REG_TO_BASE(orion_read(DDR_BASE_CS(0)));
-	size = 0;
-	for (i = 0; i < DDR_MAX_CS; i++) {
-		u32 bank_base, bank_size;
-		bank_size = orion_read(DDR_SIZE_CS(i));
-		bank_base = orion_read(DDR_BASE_CS(i));
-		if (bank_size & DDR_BANK_EN) {
-			bank_size = DDR_REG_TO_SIZE(bank_size);
-			bank_base = DDR_REG_TO_BASE(bank_base);
-			orion_write(PCIE_WIN_BASE(i), bank_base & 0xffff0000);
-			orion_write(PCIE_WIN_REMAP(i), 0);
-			orion_write(PCIE_WIN_CTRL(i),
-					((bank_size-1) & 0xffff0000) |
-					(ATTR_DDR_CS(i) << 8) |
-					(TARGET_DDR << 4) |
-					(PCIE_DRAM_BAR << 1) | WIN_EN);
-			size += bank_size;
-		}
-	}
-
-	/*
-	 * Setup BAR[1] to all DRAM banks
-	 */
-	orion_write(PCIE_BAR_LO(PCIE_DRAM_BAR), base & 0xffff0000);
-	orion_write(PCIE_BAR_HI(PCIE_DRAM_BAR), 0);
-	orion_write(PCIE_BAR_CTRL(PCIE_DRAM_BAR),
-				((size - 1) & 0xffff0000) | WIN_EN);
-}
-
-void __init orion_setup_pci_wins(void)
-{
-	u32 base, size, i;
-
-	/*
-	 * First, disable windows
-	 */
-	orion_write(PCI_BAR_ENABLE, 0xffffffff);
-
-	/*
-	 * Setup windows for DDR banks.
-	 */
-	for (i = 0; i < DDR_MAX_CS; i++) {
-		base = orion_read(DDR_BASE_CS(i));
-		size = orion_read(DDR_SIZE_CS(i));
-		if (size & DDR_BANK_EN) {
-			u32 bus, dev, func, reg, val;
-			size = DDR_REG_TO_SIZE(size);
-			base = DDR_REG_TO_BASE(base);
-			bus = orion_pci_local_bus_nr();
-			dev = orion_pci_local_dev_nr();
-			func = PCI_CONF_FUNC_BAR_CS(i);
-			reg = PCI_CONF_REG_BAR_LO_CS(i);
-			orion_pci_hw_rd_conf(bus, dev, func, reg, 4, &val);
-			orion_pci_hw_wr_conf(bus, dev, func, reg, 4,
-					(base & 0xfffff000) | (val & 0xfff));
-			reg = PCI_CONF_REG_BAR_HI_CS(i);
-			orion_pci_hw_wr_conf(bus, dev, func, reg, 4, 0);
-			orion_write(PCI_BAR_SIZE_DDR_CS(i),
-					(size - 1) & 0xfffff000);
-			orion_write(PCI_BAR_REMAP_DDR_CS(i),
-					base & 0xfffff000);
-			orion_clrbits(PCI_BAR_ENABLE, (1 << i));
-		}
-	}
-
-	/*
-	 * Disable automatic update of address remaping when writing to BARs
-	 */
-	orion_setbits(PCI_ADDR_DECODE_CTRL, 1);
-}
-
 void __init orion_setup_usb_wins(void)
 {
 	int i;
Index: linux-2.6.25-rc4/arch/arm/mach-orion/common.c
===================================================================
--- linux-2.6.25-rc4.orig/arch/arm/mach-orion/common.c
+++ linux-2.6.25-rc4/arch/arm/mach-orion/common.c
@@ -342,8 +342,6 @@ void __init orion_init(void)
 	orion_setup_cpu_mbus_bridge();
 	orion_setup_usb_wins();
 	orion_setup_eth_wins();
-	orion_setup_pci_wins();
-	orion_setup_pcie_wins();
 	if (dev == MV88F5182_DEV_ID)
 		orion_setup_sata_wins();
 
Index: linux-2.6.25-rc4/arch/arm/mach-orion/common.h
===================================================================
--- linux-2.6.25-rc4.orig/arch/arm/mach-orion/common.h
+++ linux-2.6.25-rc4/arch/arm/mach-orion/common.h
@@ -23,8 +23,6 @@ void orion_setup_dev2_win(u32 base, u32 
 void orion_setup_pcie_wa_win(u32 base, u32 size);
 void orion_setup_eth_wins(void);
 void orion_setup_usb_wins(void);
-void orion_setup_pci_wins(void);
-void orion_setup_pcie_wins(void);
 void orion_setup_sata_wins(void);
 
 /*
@@ -38,11 +36,8 @@ struct pci_bus;
 void orion_pcie_id(u32 *dev, u32 *rev);
 u32 orion_pcie_local_bus_nr(void);
 u32 orion_pci_local_bus_nr(void);
-u32 orion_pci_local_dev_nr(void);
 int orion_pci_sys_setup(int nr, struct pci_sys_data *sys);
 struct pci_bus *orion_pci_sys_scan_bus(int nr, struct pci_sys_data *sys);
-int orion_pci_hw_rd_conf(u32 bus, u32 dev, u32 func, u32 where, u32 size, u32 *val);
-int orion_pci_hw_wr_conf(u32 bus, u32 dev, u32 func, u32 where, u32 size, u32 val);
 
 /*
  * Valid GPIO pins according to MPP setup, used by machine-setup.
Index: linux-2.6.25-rc4/arch/arm/mach-orion/pci.c
===================================================================
--- linux-2.6.25-rc4.orig/arch/arm/mach-orion/pci.c
+++ linux-2.6.25-rc4/arch/arm/mach-orion/pci.c
@@ -12,6 +12,7 @@
 
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <linux/mbus.h>
 #include <asm/mach/pci.h>
 #include "common.h"
 
@@ -59,6 +60,29 @@
 #define PCIE_CONF_ADDR_EN		(1 << 31)
 
 /*
+ * PCIE Address Decode Windows registers
+ */
+#define PCIE_BAR_CTRL(n)	ORION_PCIE_REG(0x1804 + ((n - 1) * 4))
+#define PCIE_BAR_LO(n)		ORION_PCIE_REG(0x0010 + ((n) * 8))
+#define PCIE_BAR_HI(n)		ORION_PCIE_REG(0x0014 + ((n) * 8))
+#define PCIE_WIN_CTRL(n)	(((n) < 5) ? \
+					ORION_PCIE_REG(0x1820 + ((n) << 4)) : \
+					ORION_PCIE_REG(0x1880))
+#define PCIE_WIN_BASE(n)	(((n) < 5) ? \
+					ORION_PCIE_REG(0x1824 + ((n) << 4)) : \
+					ORION_PCIE_REG(0x1884))
+#define PCIE_WIN_REMAP(n)	(((n) < 5) ? \
+					ORION_PCIE_REG(0x182c + ((n) << 4)) : \
+					ORION_PCIE_REG(0x188c))
+#define PCIE_MAX_BARS		3
+#define PCIE_MAX_WINS		6
+
+/*
+ * Use PCIE BAR '1' for all DDR banks
+ */
+#define PCIE_DRAM_BAR		1
+
+/*
  * PCIE config cycles are done by programming the PCIE_CONF_ADDR register
  * and then reading the PCIE_CONF_DATA register. Need to make sure these
  * transactions are atomic.
@@ -95,6 +119,56 @@ static void orion_pcie_set_bus_nr(int nr
 	orion_setbits(PCIE_STAT, nr << PCIE_STAT_BUS_OFFS);
 }
 
+/*
+ * Setup PCIE BARs and Address Decode Wins:
+ * BAR[0,2] -> disabled, BAR[1] -> covers all DRAM banks
+ * WIN[0-3] -> DRAM bank[0-3]
+ */
+static void orion_setup_pcie_wins(struct mbus_dram_target_info *dram)
+{
+	u32 size;
+	int i;
+
+	/*
+	 * First, disable and clear BARs and windows
+	 */
+	for (i = 1; i < PCIE_MAX_BARS; i++) {
+		writel(0, PCIE_BAR_CTRL(i));
+		writel(0, PCIE_BAR_LO(i));
+		writel(0, PCIE_BAR_HI(i));
+	}
+
+	for (i = 0; i < PCIE_MAX_WINS; i++) {
+		writel(0, PCIE_WIN_CTRL(i));
+		writel(0, PCIE_WIN_BASE(i));
+		writel(0, PCIE_WIN_REMAP(i));
+	}
+
+	/*
+	 * Setup windows for DDR banks. Count total DDR size on the fly.
+	 */
+	size = 0;
+	for (i = 0; i < dram->num_cs; i++) {
+		struct mbus_dram_window *cs = dram->cs + i;
+
+		writel(cs->base & 0xffff0000, PCIE_WIN_BASE(i));
+		writel(0, PCIE_WIN_REMAP(i));
+		writel(((cs->size - 1) & 0xffff0000) |
+			(cs->mbus_attr << 8) |
+			(dram->mbus_dram_target_id << 4) |
+			(PCIE_DRAM_BAR << 1) | 1, PCIE_WIN_CTRL(i));
+
+		size += cs->size;
+	}
+
+	/*
+	 * Setup BAR[1] to all DRAM banks
+	 */
+	writel(dram->cs[0].base, PCIE_BAR_LO(PCIE_DRAM_BAR));
+	writel(0, PCIE_BAR_HI(PCIE_DRAM_BAR));
+	writel(((size - 1) & 0xffff0000) | 1, PCIE_BAR_CTRL(PCIE_DRAM_BAR));
+}
+
 static void orion_pcie_master_slave_enable(void)
 {
 	orion_setbits(PCIE_CMD_STAT, PCI_COMMAND_MASTER |
@@ -220,6 +294,11 @@ static int orion_pcie_setup(struct pci_s
 	struct resource *res;
 
 	/*
+	 * Point PCIe unit MBUS decode windows to DRAM space.
+	 */
+	orion_setup_pcie_wins(&orion_mbus_dram_info);
+
+	/*
 	 * Master + Slave enable
 	 */
 	orion_pcie_master_slave_enable();
@@ -311,6 +390,27 @@ static int orion_pcie_setup(struct pci_s
 #define PCIX_STAT_BUS_MASK		(0xff << PCIX_STAT_BUS_OFFS)
 
 /*
+ * PCI Address Decode Windows registers
+ */
+#define PCI_BAR_SIZE_DDR_CS(n)	(((n) == 0) ? ORION_PCI_REG(0xc08) : \
+				((n) == 1) ? ORION_PCI_REG(0xd08) :  \
+				((n) == 2) ? ORION_PCI_REG(0xc0c) :  \
+				((n) == 3) ? ORION_PCI_REG(0xd0c) : 0)
+#define PCI_BAR_REMAP_DDR_CS(n)	(((n) ==0) ? ORION_PCI_REG(0xc48) :  \
+				((n) == 1) ? ORION_PCI_REG(0xd48) :  \
+				((n) == 2) ? ORION_PCI_REG(0xc4c) :  \
+				((n) == 3) ? ORION_PCI_REG(0xd4c) : 0)
+#define PCI_BAR_ENABLE		ORION_PCI_REG(0xc3c)
+#define PCI_ADDR_DECODE_CTRL	ORION_PCI_REG(0xd3c)
+
+/*
+ * PCI configuration helpers for BAR settings
+ */
+#define PCI_CONF_FUNC_BAR_CS(n)		((n) >> 1)
+#define PCI_CONF_REG_BAR_LO_CS(n)	(((n) & 1) ? 0x18 : 0x10)
+#define PCI_CONF_REG_BAR_HI_CS(n)	(((n) & 1) ? 0x1c : 0x14)
+
+/*
  * PCI config cycles are done by programming the PCI_CONF_ADDR register
  * and then reading the PCI_CONF_DATA register. Need to make sure these
  * transactions are atomic.
@@ -323,13 +423,13 @@ u32 orion_pci_local_bus_nr(void)
 	return((conf & PCI_P2P_BUS_MASK) >> PCI_P2P_BUS_OFFS);
 }
 
-u32 orion_pci_local_dev_nr(void)
+static u32 orion_pci_local_dev_nr(void)
 {
 	u32 conf = orion_read(PCI_P2P_CONF);
 	return((conf & PCI_P2P_DEV_MASK) >> PCI_P2P_DEV_OFFS);
 }
 
-int orion_pci_hw_rd_conf(u32 bus, u32 dev, u32 func,
+static int orion_pci_hw_rd_conf(u32 bus, u32 dev, u32 func,
 					u32 where, u32 size, u32 *val)
 {
 	unsigned long flags;
@@ -351,7 +451,7 @@ int orion_pci_hw_rd_conf(u32 bus, u32 de
 	return PCIBIOS_SUCCESSFUL;
 }
 
-int orion_pci_hw_wr_conf(u32 bus, u32 dev, u32 func,
+static int orion_pci_hw_wr_conf(u32 bus, u32 dev, u32 func,
 					u32 where, u32 size, u32 val)
 {
 	unsigned long flags;
@@ -451,11 +551,76 @@ static void orion_pci_master_slave_enabl
 	orion_pci_hw_wr_conf(bus_nr, dev_nr, func, reg, 4, val | 0x7);
 }
 
+static void orion_setup_pci_wins(struct mbus_dram_target_info *dram)
+{
+	u32 win_enable;
+	u32 bus;
+	u32 dev;
+	int i;
+
+	/*
+	 * First, disable windows.
+	 */
+	win_enable = 0xffffffff;
+	orion_write(PCI_BAR_ENABLE, win_enable);
+
+	/*
+	 * Setup windows for DDR banks.
+	 */
+	bus = orion_pci_local_bus_nr();
+	dev = orion_pci_local_dev_nr();
+
+	for (i = 0; i < dram->num_cs; i++) {
+		struct mbus_dram_window *cs = dram->cs + i;
+		u32 func = PCI_CONF_FUNC_BAR_CS(cs->cs_index);
+		u32 reg;
+		u32 val;
+
+		/*
+		 * Write DRAM bank base address register.
+		 */
+		reg = PCI_CONF_REG_BAR_LO_CS(cs->cs_index);
+		orion_pci_hw_rd_conf(bus, dev, func, reg, 4, &val);
+		val = (cs->base & 0xfffff000) | (val & 0xfff);
+		orion_pci_hw_wr_conf(bus, dev, func, reg, 4, val);
+
+		/*
+		 * Write DRAM bank size register.
+		 */
+		reg = PCI_CONF_REG_BAR_HI_CS(cs->cs_index);
+		orion_pci_hw_wr_conf(bus, dev, func, reg, 4, 0);
+		orion_write(PCI_BAR_SIZE_DDR_CS(cs->cs_index),
+				(cs->size - 1) & 0xfffff000);
+		orion_write(PCI_BAR_REMAP_DDR_CS(cs->cs_index),
+				cs->base & 0xfffff000);
+
+		/*
+		 * Enable decode window for this chip select.
+		 */
+		win_enable &= ~(1 << cs->cs_index);
+	}
+
+	/*
+	 * Re-enable decode windows.
+	 */
+	orion_write(PCI_BAR_ENABLE, win_enable);
+
+	/*
+	 * Disable automatic update of address remaping when writing to BARs.
+	 */
+	orion_setbits(PCI_ADDR_DECODE_CTRL, 1);
+}
+
 static int orion_pci_setup(struct pci_sys_data *sys)
 {
 	struct resource *res;
 
 	/*
+	 * Point PCI unit MBUS decode windows to DRAM space.
+	 */
+	orion_setup_pci_wins(&orion_mbus_dram_info);
+
+	/*
 	 * Master + Slave enable
 	 */
 	orion_pci_master_slave_enable();
--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
