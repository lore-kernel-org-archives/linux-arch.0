From: Lennert Buytenhek <buytenh-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>
Subject: [PATCH 1/7] introduce mbus DRAM target info abstraction
Date: Fri, 7 Mar 2008 11:20:58 +0100
Message-ID: <20080307102058.GA11977@xi.wantstofly.org>
References: <20080307101913.GA11918@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080307101913.GA11918-mfnYTeDhw6uOVk/H6u/4e9i2O/JbrIOy@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Saeed Bishara <saeed-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Dale Farnsworth <dale-1viX+2+OPRFcxvNqPlePQg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Tzachi Perelstein <tzachi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nicolas Pitre <nico-mo2vmkxb4K0@public.gmane.org>

Introduce struct mbus_dram_target_info, which will be used for
passing information about the mbus target ID of the DDR unit, and
mbus target attribute, base address and size for each of the DRAM
chip selects from the platform code to peripheral drivers.

Signed-off-by: Lennert Buytenhek <buytenh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

Index: linux-2.6.25-rc4/include/linux/mbus.h
===================================================================
--- /dev/null
+++ linux-2.6.25-rc4/include/linux/mbus.h
@@ -0,0 +1,36 @@
+/*
+ * Marvell MBUS common definitions.
+ *
+ * Copyright (C) 2008 Marvell Semiconductor
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __LINUX_MBUS_H
+#define __LINUX_MBUS_H
+
+struct mbus_dram_target_info
+{
+	/*
+	 * The 4-bit MBUS target ID of the DRAM controller.
+	 */
+	u8		mbus_dram_target_id;
+
+	/*
+	 * The base address, size, and MBUS attribute ID for each
+	 * of the possible DRAM chip selects.  Peripherals are
+	 * required to support at least 4 decode windows.
+	 */
+	int		num_cs;
+	struct mbus_dram_window {
+		u8	cs_index;
+		u8	mbus_attr;
+		u32	base;
+		u32	size;
+	} cs[4];
+};
+
+
+#endif
--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
