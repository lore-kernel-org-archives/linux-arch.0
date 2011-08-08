From: Mark Salter <msalter@redhat.com>
Subject: [PATCH 22/24] C6X: specific board support
Date: Mon,  8 Aug 2011 17:44:37 -0400
Message-ID: <1312839879-13592-23-git-send-email-msalter@redhat.com>
References: <1312839879-13592-1-git-send-email-msalter@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6001 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752788Ab1HHVoy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 8 Aug 2011 17:44:54 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p78LisxG006502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Mon, 8 Aug 2011 17:44:54 -0400
Received: from deneb.redhat.com (ovpn-113-62.phx2.redhat.com [10.3.113.62])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p78Liinf010873
	for <linux-arch@vger.kernel.org>; Mon, 8 Aug 2011 17:44:54 -0400
In-Reply-To: <1312839879-13592-1-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 arch/c6x/platforms/board-dsk6455.c |  102 ++++++++++++++++++++++++++++++++++++
 arch/c6x/platforms/board-evm6457.c |   51 ++++++++++++++++++
 arch/c6x/platforms/board-evm6472.c |   51 ++++++++++++++++++
 arch/c6x/platforms/board-evm6474.c |   53 +++++++++++++++++++
 4 files changed, 257 insertions(+), 0 deletions(-)
 create mode 100644 arch/c6x/platforms/board-dsk6455.c
 create mode 100644 arch/c6x/platforms/board-evm6457.c
 create mode 100644 arch/c6x/platforms/board-evm6472.c
 create mode 100644 arch/c6x/platforms/board-evm6474.c

diff --git a/arch/c6x/platforms/board-dsk6455.c b/arch/c6x/platforms/board-dsk6455.c
new file mode 100644
index 0000000..62c9935
--- /dev/null
+++ b/arch/c6x/platforms/board-dsk6455.c
@@ -0,0 +1,102 @@
+/*
+ *  linux/arch/c6x/platforms/board-dsk6455.c
+ *
+ *  Port on Texas Instruments TMS320C6x architecture
+ *
+ *  Copyright (C) 2008, 2009, 2010, 2011 Texas Instruments Incorporated
+ *  Author: Aurelien Jacquiot (aurelien.jacquiot@virtuallogix.com)
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+#include <linux/of_platform.h>
+#include <linux/of_fdt.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+
+#include <asm/machdep.h>
+#include <asm/soc.h>
+#include "emif.h"
+#include "soc-6455.h"
+
+
+static void __init dsk6455_setup_arch(void)
+{
+	c6455_setup_arch();
+
+	/* CPLD */
+	emif_config_ce(2, EMIFA_CFG_ASYNC |
+		       EMIFA_CFG_W_SETUP(1)   |
+		       EMIFA_CFG_W_STROBE(10) |
+		       EMIFA_CFG_W_HOLD(1)    |
+		       EMIFA_CFG_R_SETUP(1)   |
+		       EMIFA_CFG_R_STROBE(10) |
+		       EMIFA_CFG_R_HOLD(1)    |
+		       EMIFA_CFG_WIDTH_8);
+
+	/* NOR Flash */
+	emif_config_ce(3, EMIFA_CFG_ASYNC |
+		       EMIFA_CFG_W_SETUP(1)   |
+		       EMIFA_CFG_W_STROBE(10) |
+		       EMIFA_CFG_W_HOLD(1)    |
+		       EMIFA_CFG_R_SETUP(1)   |
+		       EMIFA_CFG_R_STROBE(10) |
+		       EMIFA_CFG_R_HOLD(1)    |
+		       EMIFA_CFG_WIDTH_8);
+
+	/* Daughter Card */
+	emif_config_ce(4, EMIFA_CFG_ASYNC |
+		       EMIFA_CFG_W_SETUP(1)   |
+		       EMIFA_CFG_W_STROBE(10) |
+		       EMIFA_CFG_W_HOLD(1)    |
+		       EMIFA_CFG_R_SETUP(1)   |
+		       EMIFA_CFG_R_STROBE(10) |
+		       EMIFA_CFG_R_HOLD(1)    |
+		       EMIFA_CFG_WIDTH_32);
+
+	/* Daughter Card */
+	emif_config_ce(5, EMIFA_CFG_ASYNC |
+		       EMIFA_CFG_W_SETUP(1)   |
+		       EMIFA_CFG_W_STROBE(10) |
+		       EMIFA_CFG_W_HOLD(1)    |
+		       EMIFA_CFG_R_SETUP(1)   |
+		       EMIFA_CFG_R_STROBE(10) |
+		       EMIFA_CFG_R_HOLD(1)    |
+		       EMIFA_CFG_WIDTH_32);
+
+	/* Raise priority of waiting bus commands after 255 transfers */
+	emif_set_burst_prio(255);
+}
+
+static struct of_device_id dsk6455_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "soc", },
+	{ .compatible = "simple-bus", },
+	{ .compatible = "ti,c64x+emac", },
+	{},
+};
+
+static int __init dsk6455_publish_devices(void)
+{
+	of_platform_bus_probe(NULL, dsk6455_ids, NULL);
+
+	return 0;
+}
+machine_device_initcall(dsk6455, dsk6455_publish_devices);
+
+static int __init dsk6455_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "spectrum-digital,dsk6455"))
+		return 0;
+
+	return 1;
+}
+
+define_machine(dsk6455) {
+	.name			= "DSK6455",
+	.probe			= dsk6455_probe,
+	.setup_arch		= dsk6455_setup_arch,
+};
diff --git a/arch/c6x/platforms/board-evm6457.c b/arch/c6x/platforms/board-evm6457.c
new file mode 100644
index 0000000..a3de421
--- /dev/null
+++ b/arch/c6x/platforms/board-evm6457.c
@@ -0,0 +1,51 @@
+/*
+ *  linux/arch/c6x/platforms/board-evm6457.c
+ *
+ *  Port on Texas Instruments TMS320C6x architecture
+ *
+ *  Copyright (C) 2008, 2009, 2010, 2011 Texas Instruments Incorporated
+ *  Author: Aurelien Jacquiot (aurelien.jacquiot@virtuallogix.com)
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+#include <linux/of_platform.h>
+#include <linux/of_fdt.h>
+
+#include <asm/machdep.h>
+#include <asm/soc.h>
+
+#include "soc-6457.h"
+
+static struct of_device_id evm6457_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "soc", },
+	{ .compatible = "simple-bus", },
+	{ .compatible = "ti,c64x+emac", },
+	{},
+};
+
+static int __init evm6457_publish_devices(void)
+{
+	of_platform_bus_probe(NULL, evm6457_ids, NULL);
+
+	return 0;
+}
+machine_device_initcall(evmc6457, evm6457_publish_devices);
+
+static int __init evmc6457_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "einfochips,evmc6457"))
+		return 0;
+
+	return 1;
+}
+
+define_machine(evmc6457) {
+	.name			= "EVMC6457",
+	.probe			= evmc6457_probe,
+	.setup_arch		= c6457_setup_arch,
+};
diff --git a/arch/c6x/platforms/board-evm6472.c b/arch/c6x/platforms/board-evm6472.c
new file mode 100644
index 0000000..64fbd4e
--- /dev/null
+++ b/arch/c6x/platforms/board-evm6472.c
@@ -0,0 +1,51 @@
+/*
+ *  linux/arch/c6x/platforms/board-evm6472.c
+ *
+ *  Port on Texas Instruments TMS320C6x architecture
+ *
+ *  Copyright (C) 2008, 2009, 2010, 2011 Texas Instruments Incorporated
+ *  Author: Aurelien Jacquiot (aurelien.jacquiot@virtuallogix.com)
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+#include <linux/of_platform.h>
+#include <linux/of_fdt.h>
+
+#include <asm/machdep.h>
+#include <asm/soc.h>
+
+#include "soc-6472.h"
+
+static struct of_device_id evm6472_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "soc", },
+	{ .compatible = "simple-bus", },
+	{ .compatible = "ti,c64x+emac", },
+	{},
+};
+
+static int __init evm6472_publish_devices(void)
+{
+	of_platform_bus_probe(NULL, evm6472_ids, NULL);
+
+	return 0;
+}
+machine_device_initcall(evmc6472, evm6472_publish_devices);
+
+static int __init evmc6472_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "einfochips,evmc6472"))
+		return 0;
+
+	return 1;
+}
+
+define_machine(evmc6472) {
+	.name			= "EVMC6472",
+	.probe			= evmc6472_probe,
+	.setup_arch		= c6472_setup_arch,
+};
diff --git a/arch/c6x/platforms/board-evm6474.c b/arch/c6x/platforms/board-evm6474.c
new file mode 100644
index 0000000..39d8b0f
--- /dev/null
+++ b/arch/c6x/platforms/board-evm6474.c
@@ -0,0 +1,53 @@
+/*
+ * Copyright (C) 2010, 2011 Texas Instruments Incorporated
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/of_platform.h>
+#include <linux/of_fdt.h>
+#include <linux/interrupt.h>
+
+#include <asm/machdep.h>
+#include <asm/soc.h>
+
+#include "soc-6474.h"
+
+
+static struct of_device_id evm6474_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "soc", },
+	{ .compatible = "simple-bus", },
+	{ .compatible = "ti,c64x+emac", },
+	{},
+};
+
+static int __init evm6474_publish_devices(void)
+{
+	of_platform_bus_probe(NULL, evm6474_ids, NULL);
+
+	return 0;
+}
+machine_device_initcall(evmc6474, evm6474_publish_devices);
+
+static int __init evmc6474_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "spectrum-digital,evmc6474"))
+		return 0;
+
+	return 1;
+}
+
+define_machine(evmc6474) {
+	.name			= "EVMC6474",
+	.probe			= evmc6474_probe,
+	.setup_arch		= c6474_setup_arch,
+};
-- 
1.7.6
