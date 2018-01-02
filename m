From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v5 23/39] nds32: L2 cache support
Date: Tue,  2 Jan 2018 16:24:55 +0800
Message-ID: <953b4a99a6ee6505c371d03602019da72762c9c3.1514874857.git.green.hu@gmail.com>
References: <cover.1514874857.git.green.hu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1514874857.git.green.hu@gmail.com>
In-Reply-To: <cover.1514874857.git.green.hu@gmail.com>
References: <cover.1514874857.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime@andestech.com>

This patch adds L2 cache support.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/include/asm/l2_cache.h |  137 +++++++++++++++++++++++++++++++++++++
 arch/nds32/kernel/atl2c.c         |   64 +++++++++++++++++
 2 files changed, 201 insertions(+)
 create mode 100644 arch/nds32/include/asm/l2_cache.h
 create mode 100644 arch/nds32/kernel/atl2c.c

diff --git a/arch/nds32/include/asm/l2_cache.h b/arch/nds32/include/asm/l2_cache.h
new file mode 100644
index 0000000..37dd5ef
--- /dev/null
+++ b/arch/nds32/include/asm/l2_cache.h
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef L2_CACHE_H
+#define L2_CACHE_H
+
+/* CCTL_CMD_OP */
+#define L2_CA_CONF_OFF		0x0
+#define L2_IF_CONF_OFF		0x4
+#define L2CC_SETUP_OFF		0x8
+#define L2CC_PROT_OFF		0xC
+#define L2CC_CTRL_OFF		0x10
+#define L2_INT_EN_OFF           0x20
+#define L2_STA_OFF              0x24
+#define RDERR_ADDR_OFF		0x28
+#define WRERR_ADDR_OFF		0x2c
+#define EVDPTERR_ADDR_OFF	0x30
+#define IMPL3ERR_ADDR_OFF	0x34
+#define L2_CNT0_CTRL_OFF        0x40
+#define L2_EVNT_CNT0_OFF        0x44
+#define L2_CNT1_CTRL_OFF        0x48
+#define L2_EVNT_CNT1_OFF        0x4c
+#define L2_CCTL_CMD_OFF		0x60
+#define L2_CCTL_STATUS_OFF	0x64
+#define L2_LINE_TAG_OFF		0x68
+#define L2_LINE_DPT_OFF		0x70
+
+#define CCTL_CMD_L2_IX_INVAL    0x0
+#define CCTL_CMD_L2_PA_INVAL    0x1
+#define CCTL_CMD_L2_IX_WB       0x2
+#define CCTL_CMD_L2_PA_WB       0x3
+#define CCTL_CMD_L2_PA_WBINVAL  0x5
+#define CCTL_CMD_L2_SYNC        0xa
+
+/* CCTL_CMD_TYPE */
+#define CCTL_SINGLE_CMD         0
+#define CCTL_BLOCK_CMD          0x10
+#define CCTL_ALL_CMD		0x10
+
+/******************************************************************************
+ * L2_CA_CONF (Cache architecture configuration)
+ *****************************************************************************/
+#define L2_CA_CONF_offL2SET		0
+#define L2_CA_CONF_offL2WAY		4
+#define L2_CA_CONF_offL2CLSZ            8
+#define L2_CA_CONF_offL2DW		11
+#define L2_CA_CONF_offL2PT		14
+#define L2_CA_CONF_offL2VER		16
+
+#define L2_CA_CONF_mskL2SET	(0xFUL << L2_CA_CONF_offL2SET)
+#define L2_CA_CONF_mskL2WAY	(0xFUL << L2_CA_CONF_offL2WAY)
+#define L2_CA_CONF_mskL2CLSZ    (0x7UL << L2_CA_CONF_offL2CLSZ)
+#define L2_CA_CONF_mskL2DW	(0x7UL << L2_CA_CONF_offL2DW)
+#define L2_CA_CONF_mskL2PT	(0x3UL << L2_CA_CONF_offL2PT)
+#define L2_CA_CONF_mskL2VER	(0xFFFFUL << L2_CA_CONF_offL2VER)
+
+/******************************************************************************
+ * L2CC_SETUP (L2CC Setup register)
+ *****************************************************************************/
+#define L2CC_SETUP_offPART              0
+#define L2CC_SETUP_mskPART              (0x3UL << L2CC_SETUP_offPART)
+#define L2CC_SETUP_offDDLATC            4
+#define L2CC_SETUP_mskDDLATC            (0x3UL << L2CC_SETUP_offDDLATC)
+#define L2CC_SETUP_offTDLATC            8
+#define L2CC_SETUP_mskTDLATC            (0x3UL << L2CC_SETUP_offTDLATC)
+
+/******************************************************************************
+ * L2CC_PROT (L2CC Protect register)
+ *****************************************************************************/
+#define L2CC_PROT_offMRWEN              31
+#define L2CC_PROT_mskMRWEN      (0x1UL << L2CC_PROT_offMRWEN)
+
+/******************************************************************************
+ * L2_CCTL_STATUS_Mn (The L2CCTL command working status for Master n)
+ *****************************************************************************/
+#define L2CC_CTRL_offEN                 31
+#define L2CC_CTRL_mskEN                 (0x1UL << L2CC_CTRL_offEN)
+
+/******************************************************************************
+ * L2_CCTL_STATUS_Mn (The L2CCTL command working status for Master n)
+ *****************************************************************************/
+#define L2_CCTL_STATUS_offCMD_COMP      31
+#define L2_CCTL_STATUS_mskCMD_COMP      (0x1 << L2_CCTL_STATUS_offCMD_COMP)
+
+extern void __iomem *atl2c_base;
+#include <linux/smp.h>
+#include <asm/io.h>
+#include <asm/bitfield.h>
+
+#define L2C_R_REG(offset)               readl(atl2c_base + offset)
+#define L2C_W_REG(offset, value)        writel(value, atl2c_base + offset)
+
+#define L2_CMD_RDY()    \
+        do{;}while((L2C_R_REG(L2_CCTL_STATUS_OFF) & L2_CCTL_STATUS_mskCMD_COMP) == 0)
+
+static inline unsigned long L2_CACHE_SET(void)
+{
+	return 64 << ((L2C_R_REG(L2_CA_CONF_OFF) & L2_CA_CONF_mskL2SET) >>
+		      L2_CA_CONF_offL2SET);
+}
+
+static inline unsigned long L2_CACHE_WAY(void)
+{
+	return 1 +
+	    ((L2C_R_REG(L2_CA_CONF_OFF) & L2_CA_CONF_mskL2WAY) >>
+	     L2_CA_CONF_offL2WAY);
+}
+
+static inline unsigned long L2_CACHE_LINE_SIZE(void)
+{
+
+	return 4 << ((L2C_R_REG(L2_CA_CONF_OFF) & L2_CA_CONF_mskL2CLSZ) >>
+		     L2_CA_CONF_offL2CLSZ);
+}
+
+static inline unsigned long GET_L2CC_CTRL_CPU(unsigned long cpu)
+{
+	if (cpu == smp_processor_id())
+		return L2C_R_REG(L2CC_CTRL_OFF);
+	return L2C_R_REG(L2CC_CTRL_OFF + (cpu << 8));
+}
+
+static inline void SET_L2CC_CTRL_CPU(unsigned long cpu, unsigned long val)
+{
+	if (cpu == smp_processor_id())
+		L2C_W_REG(L2CC_CTRL_OFF, val);
+	else
+		L2C_W_REG(L2CC_CTRL_OFF + (cpu << 8), val);
+}
+
+static inline unsigned long GET_L2CC_STATUS_CPU(unsigned long cpu)
+{
+	if (cpu == smp_processor_id())
+		return L2C_R_REG(L2_CCTL_STATUS_OFF);
+	return L2C_R_REG(L2_CCTL_STATUS_OFF + (cpu << 8));
+}
+#endif
diff --git a/arch/nds32/kernel/atl2c.c b/arch/nds32/kernel/atl2c.c
new file mode 100644
index 0000000..0c6d031
--- /dev/null
+++ b/arch/nds32/kernel/atl2c.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/compiler.h>
+#include <linux/of_address.h>
+#include <linux/of_fdt.h>
+#include <linux/of_platform.h>
+#include <asm/l2_cache.h>
+
+void __iomem *atl2c_base;
+static const struct of_device_id atl2c_ids[] __initconst = {
+	{.compatible = "andestech,atl2c",}
+};
+
+static int __init atl2c_of_init(void)
+{
+	struct device_node *np;
+	struct resource res;
+	unsigned long tmp = 0;
+	unsigned long l2set, l2way, l2clsz;
+
+	if (!(__nds32__mfsr(NDS32_SR_MSC_CFG) & MSC_CFG_mskL2C))
+		return -ENODEV;
+
+	np = of_find_matching_node(NULL, atl2c_ids);
+	if (!np)
+		return -ENODEV;
+
+	if (of_address_to_resource(np, 0, &res))
+		return -ENODEV;
+
+	atl2c_base = ioremap(res.start, resource_size(&res));
+	if (!atl2c_base)
+		return -ENOMEM;
+
+	l2set =
+	    64 << ((L2C_R_REG(L2_CA_CONF_OFF) & L2_CA_CONF_mskL2SET) >>
+		   L2_CA_CONF_offL2SET);
+	l2way =
+	    1 +
+	    ((L2C_R_REG(L2_CA_CONF_OFF) & L2_CA_CONF_mskL2WAY) >>
+	     L2_CA_CONF_offL2WAY);
+	l2clsz =
+	    4 << ((L2C_R_REG(L2_CA_CONF_OFF) & L2_CA_CONF_mskL2CLSZ) >>
+		  L2_CA_CONF_offL2CLSZ);
+	pr_info("L2:%luKB/%luS/%luW/%luB\n",
+		l2set * l2way * l2clsz / 1024, l2set, l2way, l2clsz);
+
+	tmp = L2C_R_REG(L2CC_PROT_OFF);
+	tmp &= ~L2CC_PROT_mskMRWEN;
+	L2C_W_REG(L2CC_PROT_OFF, tmp);
+
+	tmp = L2C_R_REG(L2CC_SETUP_OFF);
+	tmp &= ~L2CC_SETUP_mskPART;
+	L2C_W_REG(L2CC_SETUP_OFF, tmp);
+
+	tmp = L2C_R_REG(L2CC_CTRL_OFF);
+	tmp |= L2CC_CTRL_mskEN;
+	L2C_W_REG(L2CC_CTRL_OFF, tmp);
+
+	return 0;
+}
+
+subsys_initcall(atl2c_of_init);
-- 
1.7.9.5
