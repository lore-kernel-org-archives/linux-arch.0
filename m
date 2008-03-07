Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from alephnull.demon.nl ([83.160.184.112]:50055 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756354AbYCGKrc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Mar 2008 05:47:32 -0500
Date: Fri, 7 Mar 2008 11:20:58 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCH 1/7] introduce mbus DRAM target info abstraction
Message-ID: <20080307102058.GA11977@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080307101913.GA11918@xi.wantstofly.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Saeed Bishara <saeed@marvell.com>, Dale Farnsworth <dale@farnsworth.org>, Russell King <linux@arm.linux.org.uk>, Tzachi Perelstein <tzachi@marvell.com>, Nicolas Pitre <nico@cam.org>
Message-ID: <20080307102058.v-NsZXrcSReXgKeWtI9w7TwE44qdOwYwqJO4gg2j-jc@z>

Introduce struct mbus_dram_target_info, which will be used for
passing information about the mbus target ID of the DDR unit, and
mbus target attribute, base address and size for each of the DRAM
chip selects from the platform code to peripheral drivers.

Signed-off-by: Lennert Buytenhek <buytenh@marvell.com>

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
