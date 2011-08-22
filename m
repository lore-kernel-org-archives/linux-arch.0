From: Mark Salter <msalter@redhat.com>
Subject: [PATCH 20/24] C6X: general SoC support
Date: Mon, 22 Aug 2011 16:09:41 -0400
Message-ID: <1314043785-2880-21-git-send-email-msalter@redhat.com>
References: <1314043785-2880-1-git-send-email-msalter@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:7485 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753629Ab1HVULL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Aug 2011 16:11:11 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7MKBBRT006675
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Mon, 22 Aug 2011 16:11:11 -0400
In-Reply-To: <1314043785-2880-1-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Mark Salter <msalter@redhat.com>

This patch provides a soc_ops struct which provides hooks for SoC functionality
which doesn't fit well into other places. For instance, all SoCs have a silicon
revision but each requires different ways to get at that revision.

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 arch/c6x/include/asm/soc.h |  126 +++++++++++++++++++++++++++++++++
 arch/c6x/kernel/soc.c      |  168 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 294 insertions(+), 0 deletions(-)
 create mode 100644 arch/c6x/include/asm/soc.h
 create mode 100644 arch/c6x/kernel/soc.c

diff --git a/arch/c6x/include/asm/soc.h b/arch/c6x/include/asm/soc.h
new file mode 100644
index 0000000..72719aa
--- /dev/null
+++ b/arch/c6x/include/asm/soc.h
@@ -0,0 +1,126 @@
+/*
+ * Miscellaneous SoC-specific hooks.
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated
+ *
+ * Author: Mark Salter <msalter@redhat.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+#ifndef _ASM_C6X_SOC_H
+#define _ASM_C6X_SOC_H
+
+/*
+ * IDs of devices that may be enabled/disabled through SoC-specific registers.
+ * Any given SoC will only support a subset of these.
+ */
+enum soc_device_id {
+	SOC_DEV_TCP = 0,
+	SOC_DEV_VCP,
+	SOC_DEV_EMAC,
+	SOC_DEV_TIMER,
+	SOC_DEV_GPIO,
+	SOC_DEV_I2C,
+	SOC_DEV_MCBSP,
+	SOC_DEV_HPI,
+	SOC_DEV_PCI,
+	SOC_DEV_UTOPIA,
+	SOC_DEV_SRIO,
+	SOC_DEV_EMIF,
+	SOC_DEV_DDR2,
+	SOC_DEV_TSIP,
+
+	SOC_DEV_MAX
+};
+
+/* MACSEL values */
+#define MACSEL_UNKNOWN	0
+#define MACSEL_DISABLED	1  /* SoCs may have EMAC disabled with input pin */
+#define MACSEL_MII	2
+#define MACSEL_RMII	3
+#define MACSEL_GMII	4
+#define MACSEL_RGMII	5
+#define MACSEL_S3MII	6
+#define MACSEL_SGMII	7
+
+struct soc_ops {
+	const char *compat;
+	const char *name;
+
+	/* Setup function called by setup_arch() */
+	void		(*setup_arch)(void);
+
+	/* Return silicon rev and optionally, a string representation */
+	unsigned int	(*silicon_rev)(char **rev_str);
+
+	/* IRQ initialization */
+	void		(*init_IRQ)(void);
+
+	/* timer initialization */
+	void		(*time_init)(void);
+
+	/* Return active exception event or -1 if none */
+	int		(*get_exception)(void);
+
+	/* Assert an event */
+	void		(*assert_event)(unsigned int evt);
+
+	/* Get MAC config for given EMAC */
+	int		(*macsel)(unsigned int mac_index);
+
+	/* Get MAC address for given EMAC */
+	int		(*mac_addr)(unsigned int mac_index, u8 *addr);
+
+	/* Boot/reset cores */
+	void		(*boot_core)(int corenum);
+	void		(*reset_core)(int corenum);
+
+	/* Enable/disable power/clocks/buffers for SoC devices */
+	void		(*dev_enable)(enum soc_device_id id, int index);
+	void		(*dev_disable)(enum soc_device_id id, int index);
+
+	/* Chip-level RMII reset for EMAC modules */
+	void		(*rmii_reset_ctl)(int index, int assert);
+};
+
+extern struct soc_ops soc_ops;
+
+#define __soc_ops __attribute__((__section__(".soc.ops")))
+
+#define define_soc(name)					\
+	extern struct soc_ops soc_ops_##name;			\
+	struct soc_ops soc_ops_##name __soc_ops =
+
+extern struct soc_ops __soc_ops_start;
+extern struct soc_ops __soc_ops_end;
+
+/*
+ * This is used to translate soc_devive_ id into SoC-specific id.
+ */
+extern int soc_dev_table[SOC_DEV_MAX];
+#define SOC_DEVCONFIG_SUPPORT(a, b) soc_dev_table[SOC_DEV_##a] = (b)
+
+
+extern unsigned int soc_silicon_rev(char **rev_str);
+extern void soc_init_IRQ(void);
+extern void soc_time_init(void);
+extern int soc_get_exception(void);
+extern void soc_assert_event(unsigned int event);
+extern int soc_macsel(unsigned int index);
+extern int soc_mac_addr(unsigned int index, u8 *addr);
+extern void soc_boot_core(int corenum);
+extern void soc_reset_core(int corenum);
+extern void soc_dev_enable(enum soc_device_id id, unsigned int index);
+extern void soc_dev_disable(enum soc_device_id id, unsigned int index);
+extern void soc_rmii_reset_ctl(int index, int assert);
+extern void soc_arch_init(void);
+
+/*
+ * for mmio on SoC devices. regs are always same byte order as cpu.
+ */
+#define soc_readl(addr)    __raw_readl(addr)
+#define soc_writel(b, addr) __raw_writel((b), (addr))
+
+#endif /* _ASM_C6X_SOC_H */
diff --git a/arch/c6x/kernel/soc.c b/arch/c6x/kernel/soc.c
new file mode 100644
index 0000000..6effec1
--- /dev/null
+++ b/arch/c6x/kernel/soc.c
@@ -0,0 +1,168 @@
+/*
+ *  Miscellaneous SoC-specific hooks.
+ *
+ *  Copyright (C) 2011 Texas Instruments Incorporated
+ *  Author: Mark Salter <msalter@redhat.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+#include <linux/module.h>
+#include <linux/ctype.h>
+#include <asm/system.h>
+#include <asm/setup.h>
+#include <asm/soc.h>
+
+struct soc_ops soc_ops;
+
+unsigned int soc_silicon_rev(char **rev_str)
+{
+	if (!soc_ops.silicon_rev) {
+		if (rev_str)
+			*rev_str = "unknown";
+		return 0;
+	}
+	return soc_ops.silicon_rev(rev_str);
+}
+EXPORT_SYMBOL(soc_silicon_rev);
+
+void soc_init_IRQ(void)
+{
+	if (soc_ops.init_IRQ)
+		soc_ops.init_IRQ();
+}
+
+void soc_time_init(void)
+{
+	if (soc_ops.time_init)
+		soc_ops.time_init();
+}
+
+int soc_get_exception(void)
+{
+	if (!soc_ops.get_exception)
+		return -1;
+	return soc_ops.get_exception();
+}
+
+void soc_assert_event(unsigned int evt)
+{
+	if (soc_ops.assert_event)
+		soc_ops.assert_event(evt);
+}
+
+int soc_macsel(unsigned int index)
+{
+	if (!soc_ops.macsel)
+		return MACSEL_MII;
+
+	return soc_ops.macsel(index);
+}
+EXPORT_SYMBOL(soc_macsel);
+
+static u8 cmdline_mac[6];
+
+static int __init get_mac_addr_from_cmdline(char *str)
+{
+	int count, i, val;
+
+	for (count = 0; count < 6 && *str; count++, str += 3) {
+		if (!isxdigit(str[0]) || !isxdigit(str[1]))
+			return 0;
+		if (str[2] != ((count < 5) ? ':' : '\0'))
+			return 0;
+
+		for (i = 0, val = 0; i < 2; i++) {
+			val = val << 4;
+			val |= isdigit(str[i]) ?
+				str[i] - '0' : toupper(str[i]) - 'A' + 10;
+		}
+		cmdline_mac[count] = val;
+	}
+	return 1;
+}
+__setup("emac_addr=", get_mac_addr_from_cmdline);
+
+int soc_mac_addr(unsigned int index, u8 *addr)
+{
+	int i, found = 0;
+
+	for (i = 0; i < 6; i++) {
+		if (cmdline_mac[i]) {
+			found = 1;
+			break;
+		}
+	}
+
+	if (found) {
+		/* cmdline overrides hardware MAC */
+		memcpy(addr, cmdline_mac, 6);
+
+		/* adjust for specific EMAC device */
+		addr[5] += index * c6x_num_cores;
+		return 1;
+	}
+
+	if (!soc_ops.mac_addr)
+		return 0;
+
+	found = soc_ops.mac_addr(index, addr);
+	if (!found && index) {
+		/* try basing address off index 0 address */
+		found = soc_ops.mac_addr(0, addr);
+		if (!found)
+			return 0;
+		addr[5] += index * c6x_num_cores;
+	}
+
+	return found;
+}
+EXPORT_SYMBOL(soc_mac_addr);
+
+void soc_boot_core(int corenum)
+{
+	if (!soc_ops.boot_core ||
+	    corenum < 0 || corenum >= c6x_num_cores ||
+	    corenum == get_coreid())
+		return;
+
+	printk(KERN_INFO "Booting core %d\n", corenum);
+	soc_ops.boot_core(corenum);
+}
+
+void soc_reset_core(int corenum)
+{
+	if (!soc_ops.reset_core ||
+	    corenum < 0 || corenum >= c6x_num_cores ||
+	    corenum == get_coreid())
+		return;
+
+	printk(KERN_INFO "Resetting core %d\n", corenum);
+	soc_ops.reset_core(corenum);
+}
+
+int soc_dev_table[SOC_DEV_MAX];
+
+void soc_dev_enable(enum soc_device_id id, unsigned int index)
+{
+	if (!soc_ops.dev_enable)
+		return;
+
+	soc_ops.dev_enable(soc_dev_table[id], index);
+}
+
+void soc_dev_disable(enum soc_device_id id, unsigned int index)
+{
+	if (!soc_ops.dev_disable)
+		return;
+
+	soc_ops.dev_disable(soc_dev_table[id], index);
+}
+
+void soc_rmii_reset_ctl(int index, int assert)
+{
+	if (!soc_ops.rmii_reset_ctl)
+		return;
+	soc_ops.rmii_reset_ctl(index, assert);
+}
-- 
1.7.6
