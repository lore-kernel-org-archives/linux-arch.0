From: Mark Salter <msalter@redhat.com>
Subject: [PATCH 23/24] C6X: miscellaneous low-level SoC support
Date: Mon,  8 Aug 2011 17:44:38 -0400
Message-ID: <1312839879-13592-24-git-send-email-msalter@redhat.com>
References: <1312839879-13592-1-git-send-email-msalter@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58889 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752808Ab1HHVoy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 8 Aug 2011 17:44:54 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p78LisQJ018768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Mon, 8 Aug 2011 17:44:54 -0400
Received: from deneb.redhat.com (ovpn-113-62.phx2.redhat.com [10.3.113.62])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p78Liing010873
	for <linux-arch@vger.kernel.org>; Mon, 8 Aug 2011 17:44:54 -0400
In-Reply-To: <1312839879-13592-1-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 arch/c6x/platforms/emif.c |   80 ++++++++++++++++++++++++++
 arch/c6x/platforms/emif.h |   45 +++++++++++++++
 arch/c6x/platforms/psc.c  |  138 +++++++++++++++++++++++++++++++++++++++++++++
 arch/c6x/platforms/psc.h  |   33 +++++++++++
 4 files changed, 296 insertions(+), 0 deletions(-)
 create mode 100644 arch/c6x/platforms/emif.c
 create mode 100644 arch/c6x/platforms/emif.h
 create mode 100644 arch/c6x/platforms/psc.c
 create mode 100644 arch/c6x/platforms/psc.h

diff --git a/arch/c6x/platforms/emif.c b/arch/c6x/platforms/emif.c
new file mode 100644
index 0000000..a736419
--- /dev/null
+++ b/arch/c6x/platforms/emif.c
@@ -0,0 +1,80 @@
+/*
+ *  Power/Sleep Controller
+ *
+ *  Copyright (C) 2011 Texas Instruments Incorporated
+ *  Author: Mark Salter <msalter@redhat.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <asm/machdep.h>
+#include <asm/soc.h>
+#include "emif.h"
+
+#define EMIFA_MIDR		0x00
+#define EMIFA_STAT		0x04
+#define EMIFA_BPRIO		0x20
+#define EMIFA_CE2CFG		0x80
+#define EMIFA_CE3CFG		0x84
+#define EMIFA_CE4CFG		0x88
+#define EMIFA_CE5CFG		0x8C
+#define EMIFA_AWCC		0xA0
+#define EMIFA_INTRAW		0xC0
+#define EMIFA_INTMSK		0xC4
+#define EMIFA_INTMSKSET		0xC8
+#define EMIFA_INTMSKCLR		0xCC
+
+static void __iomem *emifa_base;
+
+static inline void emifa_write(int offset, unsigned int val)
+{
+	soc_writel(val, emifa_base + offset);
+}
+
+static inline unsigned int emifa_read(int offset)
+{
+	return soc_readl(emifa_base + offset);
+}
+
+
+void emif_config_ce(int ce, u32 val)
+{
+	u32 reg;
+
+	switch (ce) {
+	case 2:
+		reg = EMIFA_CE2CFG;
+		break;
+	case 3:
+		reg = EMIFA_CE3CFG;
+		break;
+	case 4:
+		reg = EMIFA_CE4CFG;
+		break;
+	case 5:
+		reg = EMIFA_CE5CFG;
+		break;
+	default:
+		return;
+	}
+	emifa_write(reg, val);
+}
+
+void emif_set_burst_prio(u32 val)
+{
+	emifa_write(EMIFA_BPRIO, val - 1);
+}
+
+int emif_init(u32 base_addr)
+{
+	emifa_base = ioremap(base_addr, 0x100);
+	if (!emifa_base)
+		return -1;
+
+	soc_dev_enable(SOC_DEV_EMIF, 0);
+
+	return 0;
+}
diff --git a/arch/c6x/platforms/emif.h b/arch/c6x/platforms/emif.h
new file mode 100644
index 0000000..14785db
--- /dev/null
+++ b/arch/c6x/platforms/emif.h
@@ -0,0 +1,45 @@
+/*
+ *  C6X EMIF Controller
+ *
+ *  Copyright (C) 2011 Texas Instruments Incorporated
+ *  Author: Mark Salter <msalter@redhat.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+#ifndef _C6X_EMIF_H
+#define _C6X_EMIF_H
+
+/* Layout of CEnCFG register for Sync mode */
+#define EMIFA_CFG_SYNC		BIT(31)
+#define EMIFA_CFG_RD_BE_EN	BIT(10)
+#define EMIFA_CFG_CE_EXT	BIT(9)
+#define EMIFA_CFG_R_ENABLE	BIT(8)
+#define EMIFA_CFG_W_LTNCY(n)	(((n) & 3) << 6)
+#define EMIFA_CFG_R_LTNCY(n)	(((n) & 3) << 2)
+#define EMIFA_CFG_WIDTH_8	0
+#define EMIFA_CFG_WIDTH_16	1
+#define EMIFA_CFG_WIDTH_32	2
+#define EMIFA_CFG_WIDTH_64	3
+
+/* Layout of CEnCFG register for Async mode */
+#define EMIFA_CFG_ASYNC		(0 << 31)
+#define EMIFA_CFG_SS		BIT(30)
+#define EMIFA_CFG_BWEM		BIT(29)
+#define EMIFA_CFG_AE		BIT(28)
+#define EMIFA_CFG_W_SETUP(n)	((((n) - 1) & 0x0f) << 24)
+#define EMIFA_CFG_W_STROBE(n)	((((n) - 1) & 0x3f) << 18)
+#define EMIFA_CFG_W_HOLD(n)	((((n) - 1) & 0x07) << 15)
+#define EMIFA_CFG_R_SETUP(n)	((((n) - 1) & 0x0f) << 11)
+#define EMIFA_CFG_R_STROBE(n)	((((n) - 1) & 0x3f) << 5)
+#define EMIFA_CFG_R_HOLD(n)	((((n) - 1) & 0x07) << 2)
+/* Bus width same as Sync mode */
+
+
+extern int emif_init(u32 base_addr);
+
+extern void emif_config_ce(int ce, u32 val);
+extern void emif_set_burst_prio(u32 val);
+
+#endif /* _C6X_EMIF_H */
diff --git a/arch/c6x/platforms/psc.c b/arch/c6x/platforms/psc.c
new file mode 100644
index 0000000..688d9db
--- /dev/null
+++ b/arch/c6x/platforms/psc.c
@@ -0,0 +1,138 @@
+/*
+ *  Power/Sleep Controller
+ *
+ *  Copyright (C) 2011 Texas Instruments Incorporated
+ *  Author: Mark Salter <msalter@redhat.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+#include <linux/clkdev.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <asm/machdep.h>
+#include <asm/soc.h>
+#include "psc.h"
+
+#define PSC_PTCMD	0x0120
+#define PSC_PTSTAT	0x0128
+
+#define PSC_PDSTAT0	0x0200
+#define PSC_PDCTL0	0x0300
+
+#define PSC_MDSTAT0	0x0800
+#define PSC_MDCTL0	0x0a00
+
+#define PD_NEXT_DISABLE       2
+#define PD_NEXT_ENABLE        3
+
+#define MD_NEXT_SWRST_DISABLE	0
+#define MD_NEXT_SYNCRST		1
+#define MD_NEXT_DISABLE		2
+#define MD_NEXT_ENABLE		3
+#define MD_NEXT_MASK		0x1f
+
+#define LRSTZ	0x100
+
+static inline void psc_write(struct psc_data *data, int offset,
+			     unsigned int val)
+{
+	__raw_writel(val, data->base + offset);
+}
+
+static inline unsigned int psc_read(struct psc_data *data, int offset)
+{
+	return __raw_readl(data->base + offset);
+}
+
+static void __wait_for_gostat(struct psc_data *data, int domain_mask)
+{
+	while (psc_read(data, PSC_PTSTAT) & domain_mask)
+		;
+}
+
+void psc_domain_on(struct psc_data *data, int domain)
+{
+	int reg = PSC_PDCTL0 + (domain * 4);
+
+	if (domain < 0 || domain >= data->num_domains)
+		return;
+
+	__wait_for_gostat(data, 1 << domain);
+	psc_write(data, reg, psc_read(data, reg) | 1);
+}
+
+void psc_domain_off(struct psc_data *data, int domain)
+{
+	int reg = PSC_PDCTL0 + (domain * 4);
+
+	if (domain < 0 || domain >= data->num_domains)
+		return;
+
+	__wait_for_gostat(data, 1 << domain);
+	psc_write(data, reg, psc_read(data, reg) & ~1);
+}
+
+void psc_transition_domains(struct psc_data *data, int domain_mask)
+{
+	domain_mask &= (1 << data->num_domains) - 1;
+	if (domain_mask == 0)
+		return;
+
+	__wait_for_gostat(data, domain_mask);
+	psc_write(data, PSC_PTCMD, domain_mask);
+}
+
+void psc_module_on(struct psc_data *data, int module)
+{
+	u32 reg, val;
+
+	if (module < 0 || module >= data->num_modules)
+		return;
+
+	__wait_for_gostat(data, 1 << data->module_domains[module]);
+
+	reg = PSC_MDCTL0 + (module * 4);
+	val = psc_read(data, reg) & ~MD_NEXT_MASK;
+	psc_write(data, reg, val | MD_NEXT_ENABLE);
+}
+
+void psc_module_off(struct psc_data *data, int module)
+{
+	u32 reg, val;
+
+	if (module < 0 || module >= data->num_modules)
+		return;
+
+	__wait_for_gostat(data, 1 << data->module_domains[module]);
+
+	reg = PSC_MDCTL0 + (module * 4);
+	val = psc_read(data, reg) & ~MD_NEXT_MASK;
+	psc_write(data, reg, val | MD_NEXT_DISABLE);
+}
+
+void psc_module_reset(struct psc_data *data, int module)
+{
+	int reg = PSC_MDCTL0 + module * 4;
+
+	if (module < 0 || module >= data->num_modules)
+		return;
+
+	psc_write(data, reg, psc_read(data, reg) & ~LRSTZ);
+}
+
+void psc_module_reset_release(struct psc_data *data, int module)
+{
+	int reg = PSC_MDCTL0 + module * 4;
+
+	if (module < 0 || module >= data->num_modules)
+		return;
+
+	psc_write(data, reg, psc_read(data, reg) | LRSTZ);
+}
+
+void psc_init(struct psc_data *data)
+{
+	data->base = ioremap(data->phys_base, 0x1000);
+}
diff --git a/arch/c6x/platforms/psc.h b/arch/c6x/platforms/psc.h
new file mode 100644
index 0000000..94bd3ff
--- /dev/null
+++ b/arch/c6x/platforms/psc.h
@@ -0,0 +1,33 @@
+/*
+ *  C6X Power/Sleep Controller
+ *
+ *  Copyright (C) 2011 Texas Instruments Incorporated
+ *  Author: Mark Salter <msalter@redhat.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+#ifndef _C6X_PSC_H
+#define _C6X_PSC_H
+
+#define MAX_PSC_MODULES 16
+
+struct psc_data {
+	u32		phys_base;
+	void __iomem	*base;
+	int		num_domains;
+	int		num_modules;
+	u8		module_domains[MAX_PSC_MODULES];
+};
+
+extern void psc_init(struct psc_data *data);
+extern void psc_domain_on(struct psc_data *data, int domain);
+extern void psc_domain_off(struct psc_data *data, int domain);
+extern void psc_transition_domains(struct psc_data *data, int domain_mask);
+extern void psc_module_on(struct psc_data *data, int module);
+extern void psc_module_off(struct psc_data *data, int module);
+extern void psc_module_reset(struct psc_data *data, int module);
+extern void psc_module_reset_release(struct psc_data *data, int module);
+
+#endif /* _C6X_PSC_H */
-- 
1.7.6
