From: Domenico Andreoli <domenico.andreoli@linux.com>
Subject: [PATCH 01/11] machine-reset: platform generic handling
Date: Thu, 31 Oct 2013 07:27:09 +0100
Message-ID: <20131031062958.274180101@linux.com>
References: <20131031062708.520968323@linux.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ea0-f173.google.com ([209.85.215.173]:58742 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716Ab3JaGaF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 31 Oct 2013 02:30:05 -0400
Received: by mail-ea0-f173.google.com with SMTP id g10so1140584eak.4
        for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2013 23:30:03 -0700 (PDT)
Content-Disposition: inline; filename=machine-reset-handling.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mips@lvger.kernel.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Ralf Baechle <ralf@linux-mips.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Domenico Andreoli <domenico.andreoli@linux.com>

From: Domenico Andreoli <domenico.andreoli@linux.com>

Code is not commented but it's really simple. The bulk is in
set_machine_reset(), the static data is hidden in get_descr(). The rest
is just a straightforward consequence with the intent to keep it simple.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mips@lvger.kernel.org
Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
---
 include/linux/machine_reset.h |   79 +++++++++++++++++++++++++
 kernel/Makefile               |    1 +
 kernel/machine_reset.c        |  131 ++++++++++++++++++++++++++++++++++++++++++
 kernel/power/Kconfig          |    4 +
 kernel/reboot.c               |    3 +
 5 files changed, 218 insertions(+)

Index: b/include/linux/machine_reset.h
===================================================================
--- /dev/null
+++ b/include/linux/machine_reset.h
@@ -0,0 +1,79 @@
+/*
+ * Machine reset hooks management
+ *
+ * Copyright (C) 2013 Domenico Andreoli <domenico.andreoli@linux.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/reboot.h>
+
+enum reset_func {
+	RESET_RESTART = 0,
+	RESET_HALT,
+	RESET_POWER_OFF_PREPARE,
+	RESET_POWER_OFF,
+	RESET_CRASH_POWER_OFF,
+	RESET_NR_FUNCS,
+};
+
+struct reset_hook {
+	union {
+		void (*restart)(void *dev, enum reboot_mode, const char *cmd);
+		void (*halt)(void *dev);
+		void (*power_off_prepare)(void *dev);
+		void (*power_off)(void *dev);
+		void (*crash_power_off)(void *dev);
+		void (*handler)(void *dev);
+	};
+	void (*release)(void *dev);
+};
+
+static inline
+void reset_hook_init(struct reset_hook *hook)
+{
+	hook->handler = NULL;
+	hook->release = NULL;
+}
+
+#ifdef CONFIG_MACHINE_RESET
+
+void set_machine_reset(enum reset_func, const struct reset_hook *, void *dev);
+void unset_machine_reset(enum reset_func, const struct reset_hook *);
+int isset_machine_reset(enum reset_func, void *dev);
+
+void default_restart(enum reboot_mode, const char *cmd);
+void default_halt(void);
+void default_power_off_prepare(void);
+void default_power_off(void);
+void default_crash_power_off(void);
+
+#else /* CONFIG_MACHINE_RESET */
+
+static inline
+void set_machine_reset(enum reset_func func,
+                       const struct reset_hook *hook, void *dev)
+{
+	if (hook->release)
+		hook->release(dev);
+}
+
+static inline void unset_machine_reset(enum reset_func _f,
+                                       const struct reset_hook *_h) {}
+static inline int isset_machine_reset(enum reset_func _f, void *_d) { return 0; }
+
+static inline void default_restart(enum reboot_mode _m, const char *_c) {}
+static inline void default_halt(void) {}
+static inline void default_power_off_prepare(void) {}
+static inline void default_power_off(void) {}
+static inline void default_crash_power_off(void) {}
+
+#endif /* CONFIG_MACHINE_RESET */
Index: b/kernel/Makefile
===================================================================
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -111,6 +111,7 @@ obj-$(CONFIG_PADATA) += padata.o
 obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
 obj-$(CONFIG_JUMP_LABEL) += jump_label.o
 obj-$(CONFIG_CONTEXT_TRACKING) += context_tracking.o
+obj-$(CONFIG_MACHINE_RESET) += machine_reset.o
 
 $(obj)/configs.o: $(obj)/config_data.h
 
Index: b/kernel/machine_reset.c
===================================================================
--- /dev/null
+++ b/kernel/machine_reset.c
@@ -0,0 +1,131 @@
+/*
+ * Machine reset hooks management
+ *
+ * Copyright (C) 2013 Domenico Andreoli <domenico.andreoli@linux.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/export.h>
+#include <linux/spinlock.h>
+#include <linux/reboot.h>
+#include <linux/machine_reset.h>
+
+struct reset_descr {
+	struct reset_hook hook;
+	void *dev;
+};
+static DEFINE_SPINLOCK(descr_lock);
+
+static struct reset_descr *get_descr(enum reset_func func)
+{
+	static struct reset_descr descr[RESET_NR_FUNCS];
+
+	BUG_ON(func >= RESET_NR_FUNCS);
+	spin_lock(&descr_lock);
+	return &descr[func];
+}
+
+static void put_descr(struct reset_descr *descr)
+{
+	spin_unlock(&descr_lock);
+}
+
+#define RESET_FUNC(_func, _member, _args...)                           \
+{                                                                      \
+	struct reset_descr *descr = get_descr(_func);                  \
+	typeof(descr->hook._member) member = descr->hook._member;      \
+	if (member) {                                                  \
+		pr_debug("machine_reset: %s (%pf)\n", #_func, member); \
+		member(descr->dev , ##_args);                          \
+	}                                                              \
+	put_descr(descr);                                              \
+	pr_emerg("machine_reset: %s: FAILED\n", #_func);               \
+	while (1);                                                     \
+}
+
+void default_restart(enum reboot_mode reboot_mode, const char *cmd)
+{
+	RESET_FUNC(RESET_RESTART, restart, reboot_mode, cmd);
+}
+
+void default_halt(void)
+{
+	RESET_FUNC(RESET_HALT, halt);
+}
+
+void default_power_off_prepare(void)
+{
+	RESET_FUNC(RESET_POWER_OFF_PREPARE, power_off_prepare);
+}
+
+void default_power_off(void)
+{
+	RESET_FUNC(RESET_POWER_OFF, power_off);
+}
+
+void default_crash_power_off(void)
+{
+	RESET_FUNC(RESET_CRASH_POWER_OFF, crash_power_off);
+}
+
+void set_machine_reset(enum reset_func func,
+                       const struct reset_hook *hook, void *new_dev)
+{
+	struct reset_descr *descr;
+	void (*new_handler)(void *) = hook ? hook->handler : NULL;
+	void (*new_release)(void *) = hook ? hook->release : NULL;
+	void (*old_release)(void *) = NULL;
+	void *old_dev;
+
+	descr = get_descr(func);
+	old_release = descr->hook.release;
+	old_dev = descr->dev;
+	reset_hook_init(&descr->hook);
+	descr->hook.handler = new_handler;
+	descr->hook.release = new_release;
+	descr->dev = new_dev;
+	put_descr(descr);
+
+	if (old_release)
+		old_release(old_dev);
+}
+EXPORT_SYMBOL_GPL(set_machine_reset);
+
+void unset_machine_reset(enum reset_func func, const struct reset_hook *hook)
+{
+	struct reset_descr *descr;
+	void (*old_release)(void *) = NULL;
+	void *old_dev;
+
+	BUG_ON(!hook || !hook->handler);
+
+	descr = get_descr(func);
+	if (descr->hook.handler == hook->handler) {
+		old_release = descr->hook.release;
+		old_dev = descr->dev;
+		reset_hook_init(&descr->hook);
+	}
+	put_descr(descr);
+
+	if (old_release)
+		old_release(old_dev);
+}
+EXPORT_SYMBOL_GPL(unset_machine_reset);
+
+int isset_machine_reset(enum reset_func func, void *dev)
+{
+	struct reset_descr *descr = get_descr(func);
+	int ret = descr->hook.handler && (!dev || descr->dev == dev);
+	put_descr(descr);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(isset_machine_reset);
Index: b/kernel/power/Kconfig
===================================================================
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -293,3 +293,7 @@ config PM_GENERIC_DOMAINS_RUNTIME
 config CPU_PM
 	bool
 	depends on SUSPEND || CPU_IDLE
+
+config MACHINE_RESET
+	bool
+	default n
Index: b/kernel/reboot.c
===================================================================
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -12,6 +12,7 @@
 #include <linux/kmod.h>
 #include <linux/kmsg_dump.h>
 #include <linux/reboot.h>
+#include <linux/machine_reset.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
 #include <linux/syscore_ops.h>
@@ -178,6 +179,8 @@ void kernel_power_off(void)
 	kernel_shutdown_prepare(SYSTEM_POWER_OFF);
 	if (pm_power_off_prepare)
 		pm_power_off_prepare();
+	else
+		default_power_off_prepare();
 	migrate_to_reboot_cpu();
 	syscore_shutdown();
 	pr_emerg("Power down\n");
