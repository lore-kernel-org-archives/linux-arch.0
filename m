From: James Hogan <james.hogan@imgtec.com>
Subject: [RFC PATCH v1 38/40] metag: add JTAG Debug Adapter (DA) support
Date: Wed, 31 Oct 2012 16:14:19 +0000
Message-ID: <1351700061-7203-39-git-send-email-james.hogan@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:55144 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423219Ab2JaQPX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Oct 2012 12:15:23 -0400
In-Reply-To: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: James Hogan <james.hogan@imgtec.com>

Add basic JTAG Debug Adapter (DA) support so that drivers which
communicate with the DA can detect whether one is actually present
(otherwise the target will halt indefinitely).

Signed-off-by: James Hogan <james.hogan@imgtec.com>
---
 arch/metag/Kconfig                     |    9 ++++++
 arch/metag/configs/meta1_defconfig     |    1 +
 arch/metag/configs/meta2_defconfig     |    1 +
 arch/metag/configs/meta2_smp_defconfig |    1 +
 arch/metag/include/asm/da.h            |   43 ++++++++++++++++++++++++++++++++
 arch/metag/kernel/Makefile             |    1 +
 arch/metag/kernel/da.c                 |   24 +++++++++++++++++
 arch/metag/kernel/setup.c              |    3 ++
 8 files changed, 83 insertions(+), 0 deletions(-)
 create mode 100644 arch/metag/include/asm/da.h
 create mode 100644 arch/metag/kernel/da.c

diff --git a/arch/metag/Kconfig b/arch/metag/Kconfig
index 103b1b2..acf04b6 100644
--- a/arch/metag/Kconfig
+++ b/arch/metag/Kconfig
@@ -214,6 +214,15 @@ config META_PERFCOUNTER_IRQS
 	  When disabled, Performance Counters information will be collected
 	  based on Timer Interrupt.
 
+config METAG_DA
+	bool "DA support"
+	help
+	  Say Y if you plan to use a DA debug adapter with Linux. The presence
+	  of the DA will be detected automatically at boot, so it is safe to say
+	  Y to this option even when booting without a DA.
+
+	  This enables support for services provided by DA JTAG debug adapters.
+
 menu "Boot options"
 
 config METAG_BUILTIN_DTB
diff --git a/arch/metag/configs/meta1_defconfig b/arch/metag/configs/meta1_defconfig
index eb01dde..e943a95 100644
--- a/arch/metag/configs/meta1_defconfig
+++ b/arch/metag/configs/meta1_defconfig
@@ -17,6 +17,7 @@ CONFIG_PARTITION_ADVANCED=y
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_FLATMEM_MANUAL=y
 CONFIG_META12_FPGA=y
+CONFIG_METAG_DA=y
 CONFIG_HZ_100=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
diff --git a/arch/metag/configs/meta2_defconfig b/arch/metag/configs/meta2_defconfig
index 1d28258..2d246f6 100644
--- a/arch/metag/configs/meta2_defconfig
+++ b/arch/metag/configs/meta2_defconfig
@@ -18,6 +18,7 @@ CONFIG_PARTITION_ADVANCED=y
 CONFIG_META_L2C=y
 CONFIG_FLATMEM_MANUAL=y
 CONFIG_META_HALT_ON_PANIC=y
+CONFIG_METAG_DA=y
 CONFIG_HZ_100=y
 CONFIG_DEVTMPFS=y
 # CONFIG_STANDALONE is not set
diff --git a/arch/metag/configs/meta2_smp_defconfig b/arch/metag/configs/meta2_smp_defconfig
index 979107b..a2120ec 100644
--- a/arch/metag/configs/meta2_smp_defconfig
+++ b/arch/metag/configs/meta2_smp_defconfig
@@ -19,6 +19,7 @@ CONFIG_META_L2C=y
 CONFIG_FLATMEM_MANUAL=y
 CONFIG_META_HALT_ON_PANIC=y
 CONFIG_SMP=y
+CONFIG_METAG_DA=y
 CONFIG_HZ_100=y
 CONFIG_DEVTMPFS=y
 # CONFIG_STANDALONE is not set
diff --git a/arch/metag/include/asm/da.h b/arch/metag/include/asm/da.h
new file mode 100644
index 0000000..81bd521
--- /dev/null
+++ b/arch/metag/include/asm/da.h
@@ -0,0 +1,43 @@
+/*
+ * Meta DA JTAG debugger control.
+ *
+ * Copyright 2012 Imagination Technologies Ltd.
+ */
+
+#ifndef _METAG_DA_H_
+#define _METAG_DA_H_
+
+#ifdef CONFIG_METAG_DA
+
+#include <linux/init.h>
+#include <linux/types.h>
+
+extern bool _metag_da_present;
+
+/**
+ * metag_da_enabled() - Find whether a DA is currently enabled.
+ *
+ * Returns:	true if a DA was detected, false if not.
+ */
+static inline bool metag_da_enabled(void)
+{
+	return _metag_da_present;
+}
+
+/**
+ * metag_da_probe() - Try and detect a connected DA.
+ *
+ * This is used at start up to detect whether a DA is active.
+ *
+ * Returns:	0 on detection, -err otherwise.
+ */
+int __init metag_da_probe(void);
+
+#else /* !CONFIG_METAG_DA */
+
+#define metag_da_enabled() false
+#define metag_da_probe() do {} while (0)
+
+#endif
+
+#endif /* _METAG_DA_H_ */
diff --git a/arch/metag/kernel/Makefile b/arch/metag/kernel/Makefile
index 5482817..8d74cfa 100644
--- a/arch/metag/kernel/Makefile
+++ b/arch/metag/kernel/Makefile
@@ -28,6 +28,7 @@ obj-y	+= traps.o
 obj-y	+= user_gateway.o
 
 obj-$(CONFIG_METAG_COREMEM)		+= coremem.o
+obj-$(CONFIG_METAG_DA)			+= da.o
 obj-$(CONFIG_DYNAMIC_FTRACE)		+= ftrace.o
 obj-$(CONFIG_FUNCTION_TRACER)		+= ftrace_stub.o
 obj-$(CONFIG_META_PERFCOUNTER_IRQS)	+= irq_internal.o
diff --git a/arch/metag/kernel/da.c b/arch/metag/kernel/da.c
new file mode 100644
index 0000000..616f02c
--- /dev/null
+++ b/arch/metag/kernel/da.c
@@ -0,0 +1,24 @@
+/*
+ * Meta DA JTAG debugger control.
+ *
+ * Copyright 2012 Imagination Technologies Ltd.
+ */
+
+
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <asm/da.h>
+#define METAG_TRIG_VALUES
+#include <asm/tbx/machine.inc>
+
+bool _metag_da_present;
+
+int __init metag_da_probe(void)
+{
+	_metag_da_present = (readl(T0VECINT_BHALT) == 1);
+	if (_metag_da_present)
+		pr_info("DA present\n");
+	else
+		pr_info("DA not present\n");
+	return 0;
+}
diff --git a/arch/metag/kernel/setup.c b/arch/metag/kernel/setup.c
index 41d6ad9..83e45f3 100644
--- a/arch/metag/kernel/setup.c
+++ b/arch/metag/kernel/setup.c
@@ -37,6 +37,7 @@
 #include <asm/hwthread.h>
 #include <asm/mmzone.h>
 #include <asm/l2cache.h>
+#include <asm/da.h>
 #include <asm/prom.h>
 #include <asm/mach/arch.h>
 #include <asm/core_reg.h>
@@ -182,6 +183,8 @@ void __init setup_arch(char **cmdline_p)
 	PTBISEG p_heap;
 	int heap_id, i;
 
+	metag_da_probe();
+
 	/* try interpreting the argument as a device tree */
 	machine_desc = setup_machine_fdt(original_cmd_line);
 	/* if it doesn't look like a device tree it must be a command line */
-- 
1.7.7.6
