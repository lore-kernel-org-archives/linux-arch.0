Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36742 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730329AbfDBQNj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Apr 2019 12:13:39 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so4493519wml.1
        for <linux-arch@vger.kernel.org>; Tue, 02 Apr 2019 09:13:38 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 3/7] thermal/drivers/core: Add init section table for self-encapsulation
Date: Tue,  2 Apr 2019 18:12:46 +0200
Message-ID: <20190402161256.11044-3-daniel.lezcano@linaro.org>
In-Reply-To: <20190402161256.11044-1-daniel.lezcano@linaro.org>
References: <20190402161256.11044-1-daniel.lezcano@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
Message-ID: <20190402161246.VeHVnsd8s-TPWOlTCqQdaloi6JHKqiNa40gScBps2ec@z>

Currently the governors are declared in their respective files but they
export their [un]register functions which in turn call the [un]register
the governors core's functions. That implies a cyclic dependency which is
not desirable. There is a way to self-encapsulate the governors by letting
them to declare themselves in a __init section table.

Define the table in the asm generic linker description like the other
tables and provide the specific macros to deal with.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h    | 16 ++++++++++++++++
 include/asm-generic/vmlinux.lds.h | 11 +++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 0df190ed82a7..28d18083e969 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -15,6 +15,22 @@
 /* Initial state of a cooling device during binding */
 #define THERMAL_NO_TARGET -1UL
 
+/* Init section thermal table */
+extern struct thermal_governor * __governor_thermal_table[];
+extern struct thermal_governor * __governor_thermal_table_end[];
+
+#define THERMAL_TABLE_ENTRY(table, name)			\
+        static typeof(name) * __thermal_table_entry_##name	\
+	__used __section(__##table##_thermal_table)		\
+		= &name;
+
+#define THERMAL_GOVERNOR_DECLARE(name)	THERMAL_TABLE_ENTRY(governor, name)
+
+#define for_each_governor_table(__governor)		\
+	for (__governor = __governor_thermal_table;	\
+	     __governor < __governor_thermal_table_end;	\
+	     __governor++)
+
 /*
  * This structure is used to describe the behavior of
  * a certain cooling device on a certain trip point
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f8f6f04c4453..9893a3ed242a 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -239,6 +239,16 @@
 #define ACPI_PROBE_TABLE(name)
 #endif
 
+#ifdef CONFIG_THERMAL
+#define THERMAL_TABLE(name)						\
+        . = ALIGN(8);							\
+        __##name##_thermal_table = .;					\
+        KEEP(*(__##name##_thermal_table))				\
+        __##name##_thermal_table_end = .;
+#else
+#define THERMAL_TABLE(name)
+#endif
+
 #define KERNEL_DTB()							\
 	STRUCT_ALIGN();							\
 	__dtb_start = .;						\
@@ -609,6 +619,7 @@
 	IRQCHIP_OF_MATCH_TABLE()					\
 	ACPI_PROBE_TABLE(irqchip)					\
 	ACPI_PROBE_TABLE(timer)						\
+	THERMAL_TABLE(governor)						\
 	EARLYCON_TABLE()						\
 	LSM_TABLE()
 
-- 
2.17.1
