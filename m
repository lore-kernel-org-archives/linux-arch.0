Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40585 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752093AbdK0Myh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Nov 2017 07:54:37 -0500
From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v2 21/35] nds32: Generic timers support
Date: Mon, 27 Nov 2017 20:28:08 +0800
Message-ID: <ce3c857996aecb071c6f279a691d3d267448e029.1511785528.git.green.hu@gmail.com>
In-Reply-To: <cover.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
In-Reply-To: <cover.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>
Message-ID: <20171127122808.R20k_qqJctsswU9Wu_DBKB7bYGiI6J3yXRzAJ00Ta_w@z>

From: Greentime Hu <greentime@andestech.com>

This patch adds support for timer.

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
