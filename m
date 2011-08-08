From: Mark Salter <msalter@redhat.com>
Subject: [PATCH 20/24] C6X: general machine and SoC support
Date: Mon,  8 Aug 2011 17:44:35 -0400
Message-ID: <1312839879-13592-21-git-send-email-msalter@redhat.com>
References: <1312839879-13592-1-git-send-email-msalter@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44511 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752711Ab1HHVox (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 8 Aug 2011 17:44:53 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p78LirI5027243
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Mon, 8 Aug 2011 17:44:53 -0400
Received: from deneb.redhat.com (ovpn-113-62.phx2.redhat.com [10.3.113.62])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p78Liind010873
	for <linux-arch@vger.kernel.org>; Mon, 8 Aug 2011 17:44:53 -0400
In-Reply-To: <1312839879-13592-1-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 arch/c6x/include/asm/machdep.h |  106 +++++++++++++++++++++++++
 arch/c6x/include/asm/soc.h     |  110 ++++++++++++++++++++++++++
 arch/c6x/kernel/soc.c          |  169 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 385 insertions(+), 0 deletions(-)
 create mode 100644 arch/c6x/include/asm/machdep.h
 create mode 100644 arch/c6x/include/asm/soc.h
 create mode 100644 arch/c6x/kernel/soc.c

diff --git a/arch/c6x/include/asm/machdep.h b/arch/c6x/include/asm/machdep.h
new file mode 100644
index 0000000..b8bfe0b
--- /dev/null
+++ b/arch/c6x/include/asm/machdep.h
@@ -0,0 +1,106 @@
+/*
+ *  Copyright (C) 2011 Texas Instruments Incorporated
+ *
+ *  Mostly taken from PowerPC.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+#ifndef _ASM_C6X_MACHDEP_H
+#define _ASM_C6X_MACHDEP_H
+
+struct pt_regs;
+
+struct machdep_calls {
+	char		*name;
+	int		(*probe)(void);
+	void		(*setup_arch)(void);
+	void		(*init_IRQ)(void);
+	void		(*time_init)(void);
+	void		(*restart)(void);
+	void		(*halt)(void);
+	void		(*power_off)(void);
+	int		(*nmi_handler)(struct pt_regs *regs);
+};
+
+extern struct machdep_calls __machine_desc_start;
+extern struct machdep_calls __machine_desc_end;
+
+/*
+ * c6x_md contains a copy of the machine description structure for the
+ * current platform. machine_id contains the initial address where the
+ * description was found during boot.
+ */
+extern struct machdep_calls c6x_md;
+extern struct machdep_calls *machine_id;
+
+#define __machine_desc __attribute__((__section__(".machine.desc")))
+
+#define define_machine(name)					\
+	extern struct machdep_calls mach_##name;		\
+	EXPORT_SYMBOL(mach_##name);				\
+	struct machdep_calls mach_##name __machine_desc =
+
+#define machine_is(name) \
+	({ \
+		extern struct machdep_calls mach_##name \
+			__attribute__((weak));		 \
+		machine_id == &mach_##name; \
+	})
+
+#define __define_machine_initcall(mach, level, fn, id) \
+	static int __init __machine_initcall_##mach##_##fn(void) \
+	{							 \
+		if (machine_is(mach))				 \
+			return fn();				 \
+		return 0;					 \
+	}							 \
+	__define_initcall(level, __machine_initcall_##mach##_##fn, id);
+
+#define machine_core_initcall(mach, fn)	\
+	__define_machine_initcall(mach, "1", fn, 1)
+
+#define machine_core_initcall_sync(mach, fn) \
+	__define_machine_initcall(mach, "1s", fn, 1s)
+
+#define machine_postcore_initcall(mach, fn) \
+	__define_machine_initcall(mach, "2", fn, 2)
+
+#define machine_postcore_initcall_sync(mach, fn) \
+	__define_machine_initcall(mach, "2s", fn, 2s)
+
+#define machine_arch_initcall(mach, fn) \
+	__define_machine_initcall(mach, "3", fn, 3)
+
+#define machine_arch_initcall_sync(mach, fn) \
+	__define_machine_initcall(mach, "3s", fn, 3s)
+
+#define machine_subsys_initcall(mach, fn) \
+	__define_machine_initcall(mach, "4", fn, 4)
+
+#define machine_subsys_initcall_sync(mach, fn) \
+	__define_machine_initcall(mach, "4s", fn, 4s)
+
+#define machine_fs_initcall(mach, fn) \
+	__define_machine_initcall(mach, "5", fn, 5)
+
+#define machine_fs_initcall_sync(mach, fn) \
+	__define_machine_initcall(mach, "5s", fn, 5s)
+
+#define machine_rootfs_initcall(mach, fn) \
+	__define_machine_initcall(mach, "rootfs", fn, rootfs)
+
+#define machine_device_initcall(mach, fn) \
+	__define_machine_initcall(mach, "6", fn, 6)
+
+#define machine_device_initcall_sync(mach, fn) \
+	__define_machine_initcall(mach, "6s", fn, 6s)
+
+#define machine_late_initcall(mach, fn) \
+	__define_machine_initcall(mach, "7", fn, 7)
+
+#define machine_late_initcall_sync(mach, fn) \
+	__define_machine_initcall(mach, "7s", fn, 7s)
+
+#endif /* _ASM_C6X_MACHDEP_H */
diff --git a/arch/c6x/include/asm/soc.h b/arch/c6x/include/asm/soc.h
new file mode 100644
index 0000000..9cd3e92
--- /dev/null
+++ b/arch/c6x/include/asm/soc.h
@@ -0,0 +1,110 @@
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
index 0000000..2e60725
--- /dev/null
+++ b/arch/c6x/kernel/soc.c
@@ -0,0 +1,169 @@
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
+#include <asm/machdep.h>
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
