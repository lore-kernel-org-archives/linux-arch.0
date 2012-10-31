From: James Hogan <james.hogan@imgtec.com>
Subject: [RFC PATCH v1 13/40] metag: Device tree
Date: Wed, 31 Oct 2012 16:13:54 +0000
Message-ID: <1351700061-7203-14-git-send-email-james.hogan@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:49761 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423159Ab2JaQO4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Oct 2012 12:14:56 -0400
In-Reply-To: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: James Hogan <james.hogan@imgtec.com>

Add device tree files to arch/metag.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
---
 arch/metag/Kconfig                |   13 +++++
 arch/metag/Makefile               |    9 +++
 arch/metag/boot/dtb/Makefile      |   32 ++++++++++++
 arch/metag/boot/dts/skeleton.dts  |   10 ++++
 arch/metag/boot/dts/skeleton.dtsi |   14 +++++
 arch/metag/include/asm/prom.h     |   23 +++++++++
 arch/metag/kernel/Makefile        |    2 +
 arch/metag/kernel/devtree.c       |  100 +++++++++++++++++++++++++++++++++++++
 8 files changed, 203 insertions(+), 0 deletions(-)
 create mode 100644 arch/metag/boot/dtb/Makefile
 create mode 100644 arch/metag/boot/dts/skeleton.dts
 create mode 100644 arch/metag/boot/dts/skeleton.dtsi
 create mode 100644 arch/metag/include/asm/prom.h
 create mode 100644 arch/metag/kernel/devtree.c

diff --git a/arch/metag/Kconfig b/arch/metag/Kconfig
index 3a19cb6..5141108 100644
--- a/arch/metag/Kconfig
+++ b/arch/metag/Kconfig
@@ -210,6 +210,19 @@ config META_PERFCOUNTER_IRQS
 
 menu "Boot options"
 
+config METAG_BUILTIN_DTB
+	bool "Embed DTB in kernel image"
+	default y
+	help
+	  Embeds a device tree binary in the kernel image.
+
+config METAG_BUILTIN_DTB_NAME
+	string "Built in DTB"
+	depends on METAG_BUILTIN_DTB
+	help
+	  Set the name of the DTB to embed (leave blank to pick one
+	  automatically based on kernel configuration).
+
 config METAG_CMDLINE_BOOL
 	bool "Built-in kernel command line"
 	---help---
diff --git a/arch/metag/Makefile b/arch/metag/Makefile
index 7fd59be..aae38f6 100644
--- a/arch/metag/Makefile
+++ b/arch/metag/Makefile
@@ -22,6 +22,8 @@ CHECKFLAGS	+= -D__metag__ $(CHECKFLAGS-y)
 
 KBUILD_DEFCONFIG := meta2_defconfig
 
+core-y += arch/metag/boot/dtb/
+
 sflags-$(CONFIG_META12) += -mmetac=1.2
 
 ifeq ($(CONFIG_META12),y)
@@ -75,6 +77,12 @@ all: vmlinux.bin
 $(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
+%.dtb %.dtb.S %.dtb.o:
+	$(Q)$(MAKE) $(build)=$(boot)/dtb $(boot)/dtb/$@
+
+dtbs:
+	$(Q)$(MAKE) $(build)=$(boot)/dtb $(boot)/dtb/$@
+
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
@@ -87,4 +95,5 @@ define archhelp
   @echo '  uImage.lzma	- Kernel-only image for U-Boot (lzma)'
   @echo '  uImage.xz	- Kernel-only image for U-Boot (xz)'
   @echo '  uImage.lzo	- Kernel-only image for U-Boot (lzo)'
+  @echo '  dtbs		- Build device tree blobs for enabled boards'
 endef
diff --git a/arch/metag/boot/dtb/Makefile b/arch/metag/boot/dtb/Makefile
new file mode 100644
index 0000000..c84e1fc
--- /dev/null
+++ b/arch/metag/boot/dtb/Makefile
@@ -0,0 +1,32 @@
+dtb-y += skeleton.dtb
+dtb-y += tz1090_generic.dtb
+dtb-y += tz1090_01ry.dtb
+dtb-y += tz1090_01sp.dtb
+dtb-y += tz1090_01tt.dtb
+dtb-y += tz1090_01xk.dtb
+
+# Built-in dtb
+builtindtb-y := skeleton
+builtindtb-$(CONFIG_SOC_COMET) := tz1090_generic
+builtindtb-$(CONFIG_COMET_BUB) := tz1090_01ry
+builtindtb-$(CONFIG_TZ1090_01XX) := tz1090_01sp
+builtindtb-$(CONFIG_POLARIS) := tz1090_01xk
+
+ifeq ($(CONFIG_METAG_BUILTIN_DTB),y)
+ifneq '$(CONFIG_METAG_BUILTIN_DTB_NAME)' '""'
+BUILTIN_DTB := $(patsubst "%",%,$(CONFIG_METAG_BUILTIN_DTB_NAME)).dtb.o
+else
+BUILTIN_DTB := $(patsubst "%",%,$(builtindtb-y)).dtb.o
+endif
+else
+BUILTIN_DTB :=
+endif
+obj-y += $(BUILTIN_DTB)
+
+clean-files += $(obj)/$(dtb-y) $(obj)/*.dtb.S $(obj)/*.dtb.o
+
+# Rule to build device tree blobs
+$(obj)/%.dtb: $(src)/../dts/%.dts FORCE
+	$(call if_changed_dep,dtc)
+
+$(obj)/dtbs: $(addprefix $(obj)/, $(dtb-y))
diff --git a/arch/metag/boot/dts/skeleton.dts b/arch/metag/boot/dts/skeleton.dts
new file mode 100644
index 0000000..7244d1f
--- /dev/null
+++ b/arch/metag/boot/dts/skeleton.dts
@@ -0,0 +1,10 @@
+/*
+ * Copyright (C) 2012 Imagination Technologies Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+/include/ "skeleton.dtsi"
diff --git a/arch/metag/boot/dts/skeleton.dtsi b/arch/metag/boot/dts/skeleton.dtsi
new file mode 100644
index 0000000..78229ea
--- /dev/null
+++ b/arch/metag/boot/dts/skeleton.dtsi
@@ -0,0 +1,14 @@
+/*
+ * Skeleton device tree; the bare minimum needed to boot; just include and
+ * add a compatible value.  The bootloader will typically populate the memory
+ * node.
+ */
+
+/ {
+	compatible = "img,meta";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	chosen { };
+	aliases { };
+	memory { device_type = "memory"; reg = <0 0>; };
+};
diff --git a/arch/metag/include/asm/prom.h b/arch/metag/include/asm/prom.h
new file mode 100644
index 0000000..d881396
--- /dev/null
+++ b/arch/metag/include/asm/prom.h
@@ -0,0 +1,23 @@
+/*
+ *  arch/metag/include/asm/prom.h
+ *
+ *  Copyright (C) 2012 Imagination Technologies Ltd.
+ *
+ *  Based on ARM version:
+ *  Copyright (C) 2009 Canonical Ltd. <jeremy.kerr@canonical.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#ifndef __ASM_METAG_PROM_H
+#define __ASM_METAG_PROM_H
+
+#include <asm/setup.h>
+#define HAVE_ARCH_DEVTREE_FIXUPS
+
+extern struct machine_desc *setup_machine_fdt(void *dt);
+extern void metag_dt_memblock_reserve(void);
+
+#endif /* __ASM_METAG_PROM_H */
diff --git a/arch/metag/kernel/Makefile b/arch/metag/kernel/Makefile
index 0391546..5482817 100644
--- a/arch/metag/kernel/Makefile
+++ b/arch/metag/kernel/Makefile
@@ -8,11 +8,13 @@ extra-y	+= vmlinux.lds
 obj-y	+= cachepart.o
 obj-y	+= clock.o
 obj-y	+= core_reg.o
+obj-y	+= devtree.o
 obj-y	+= dma.o
 obj-y	+= hw_breakpoints.o
 obj-y	+= irq.o
 obj-y	+= irq_external.o
 obj-y	+= kick.o
+obj-y	+= machines.o
 obj-y	+= process.o
 obj-y	+= ptrace.o
 obj-y	+= setup.o
diff --git a/arch/metag/kernel/devtree.c b/arch/metag/kernel/devtree.c
new file mode 100644
index 0000000..251819c
--- /dev/null
+++ b/arch/metag/kernel/devtree.c
@@ -0,0 +1,100 @@
+/*
+ *  linux/arch/metag/kernel/devtree.c
+ *
+ *  Copyright (C) 2012 Imagination Technologies Ltd.
+ *
+ *  Based on ARM version:
+ *  Copyright (C) 2009 Canonical Ltd. <jeremy.kerr@canonical.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/export.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/bootmem.h>
+#include <linux/memblock.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+
+#include <asm/setup.h>
+#include <asm/page.h>
+#include <asm/mach/arch.h>
+
+void __init early_init_dt_add_memory_arch(u64 base, u64 size)
+{
+	pr_err("%s(%llx, %llx)\n",
+	       __func__, base, size);
+}
+
+void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
+{
+	return alloc_bootmem_align(size, align);
+}
+
+/**
+ * setup_machine_fdt - Machine setup when an dtb was passed to the kernel
+ * @dt:		virtual address pointer to dt blob
+ *
+ * If a dtb was passed to the kernel, then use it to choose the correct
+ * machine_desc and to setup the system.
+ */
+struct machine_desc * __init setup_machine_fdt(void *dt)
+{
+	struct boot_param_header *devtree = dt;
+	struct machine_desc *mdesc, *mdesc_best = NULL;
+	unsigned int score, mdesc_score = ~1;
+	unsigned long dt_root;
+	const char *model;
+
+	/* check device tree validity */
+	if (be32_to_cpu(devtree->magic) != OF_DT_HEADER)
+		return NULL;
+
+	/* Search the mdescs for the 'best' compatible value match */
+	initial_boot_params = devtree;
+	dt_root = of_get_flat_dt_root();
+
+	for_each_machine_desc(mdesc) {
+		score = of_flat_dt_match(dt_root, mdesc->dt_compat);
+		if (score > 0 && score < mdesc_score) {
+			mdesc_best = mdesc;
+			mdesc_score = score;
+		}
+	}
+	if (!mdesc_best) {
+		const char *prop;
+		long size;
+
+		pr_err("\nError: unrecognized/unsupported device tree compatible list:\n[ ");
+
+		prop = of_get_flat_dt_prop(dt_root, "compatible", &size);
+		if (prop) {
+			while (size > 0) {
+				printk("'%s' ", prop);
+				size -= strlen(prop) + 1;
+				prop += strlen(prop) + 1;
+			}
+		}
+		printk("]\n\n");
+
+		dump_machine_table(); /* does not return */
+	}
+
+	model = of_get_flat_dt_prop(dt_root, "model", NULL);
+	if (!model)
+		model = of_get_flat_dt_prop(dt_root, "compatible", NULL);
+	if (!model)
+		model = "<unknown>";
+	pr_info("Machine: %s, model: %s\n", mdesc_best->name, model);
+
+	/* Retrieve various information from the /chosen node */
+	of_scan_flat_dt(early_init_dt_scan_chosen, boot_command_line);
+
+	return mdesc_best;
+}
-- 
1.7.7.6
