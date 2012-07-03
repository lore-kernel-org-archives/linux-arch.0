From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] clkdev: Add default clkdev.h
Date: Tue,  3 Jul 2012 16:23:35 +0100
Message-ID: <1341329015-28207-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:57194 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752321Ab2GCPXh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jul 2012 11:23:37 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@arm.linux.org.uk>, mturquette@ti.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

Ease the deployment of clkdev by providing a default asm/clkdev.h which
will be used if the arch does not have an include/asm/clkdev.h.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

The discussion on the previous posting of this patch suggested we should
be merging this via clk (or possibly clkdev).

 include/asm-generic/Kbuild.asm |    4 ++++
 include/asm-generic/clkdev.h   |   26 ++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 include/asm-generic/clkdev.h

diff --git a/include/asm-generic/Kbuild.asm b/include/asm-generic/Kbuild.asm
index c5d2e5d..da121e0 100644
--- a/include/asm-generic/Kbuild.asm
+++ b/include/asm-generic/Kbuild.asm
@@ -13,6 +13,10 @@ ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/include/asm/a.out.h \
 header-y += a.out.h
 endif
 
+ifeq ($(wildcard $(srctree)/arch/$(SRCARCH)/include/asm/clkdev.h),)
+generic-y += clkdev.h
+endif
+
 header-y += auxvec.h
 header-y += bitsperlong.h
 header-y += byteorder.h
diff --git a/include/asm-generic/clkdev.h b/include/asm-generic/clkdev.h
new file mode 100644
index 0000000..7a15bd0
--- /dev/null
+++ b/include/asm-generic/clkdev.h
@@ -0,0 +1,26 @@
+/*
+ *  include/asm-generic/clkdev.h
+ *
+ * Based on the ARM clkdev.h:
+ *  Copyright (C) 2008 Russell King.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Helper for the clk API to assist looking up a struct clk.
+ */
+#ifndef __ASM_CLKDEV_H
+#define __ASM_CLKDEV_H
+
+#include <linux/slab.h>
+
+static inline int __clk_get(clk) { return 1; }
+static inline void __clk_put(clk) { }
+
+static inline struct clk_lookup_alloc *__clkdev_alloc(size_t size)
+{
+	return kzalloc(size, GFP_KERNEL);
+}
+
+#endif
-- 
1.7.10
