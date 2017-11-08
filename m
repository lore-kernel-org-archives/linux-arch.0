Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:56457 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754178AbdKHGUx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Nov 2017 01:20:53 -0500
From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH 22/31] nds32: Generic timers support
Date: Wed,  8 Nov 2017 13:55:10 +0800
Message-ID: <33e12422e3ac76495fd9b24b81a2f00ea50d336a.1510118606.git.green.hu@gmail.com>
In-Reply-To: <cover.1510118606.git.green.hu@gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com>
In-Reply-To: <cover.1510118606.git.green.hu@gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>
Message-ID: <20171108055510.5gPLd3qo3EAmrWqmJhrUJ2Cf29rjgtUrri-IC-pMJ9E@z>

From: Greentime Hu <greentime@andestech.com>

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/kernel/time.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 arch/nds32/kernel/time.c

diff --git a/arch/nds32/kernel/time.c b/arch/nds32/kernel/time.c
new file mode 100644
index 0000000..96e2f87
--- /dev/null
+++ b/arch/nds32/kernel/time.c
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/clocksource.h>
+
+void __init time_init(void)
+{
+	timer_probe();
+}
-- 
1.7.9.5
