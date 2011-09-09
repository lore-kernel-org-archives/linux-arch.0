From: Richard Kuo <rkuo@codeaurora.org>
Subject: [patch v3 08/36] Hexagon: Add delay functions
Date: Thu, 08 Sep 2011 20:08:55 -0500
Message-ID: <20110909010915.450346603@codeaurora.org>
References: <20110909010847.294039464@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=delay.diff
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Added read_current_timer elsewhere.

udelay is based off of __vmgettime() which returns processor ticks.

Removed __delay and CONFIG_GENERIC_CALIBRATE_DELAY.

Signed-off-by: Richard Kuo <rkuo@codeaurora.org>

---
 arch/hexagon/include/asm/delay.h |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

Index: linux-hexagon-kernel/arch/hexagon/include/asm/delay.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-hexagon-kernel/arch/hexagon/include/asm/delay.h	2011-09-07 13:00:30.900646743 -0500
@@ -0,0 +1,28 @@
+/*
+ * Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+
+#ifndef _ASM_DELAY_H
+#define _ASM_DELAY_H
+
+#include <asm/param.h>
+
+extern void __udelay(unsigned long usecs);
+
+#define udelay(usecs) __udelay((usecs))
+
+#endif /* _ASM_DELAY_H */

--

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
