Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44293 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932886AbdLRHNg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Dec 2017 02:13:36 -0500
From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v4 23/36] nds32: Generic timers support
Date: Mon, 18 Dec 2017 14:46:35 +0800
Message-ID: <7b0f7bd08ce930e671bd409cee49782121563fb7.1513577007.git.green.hu@gmail.com>
In-Reply-To: <cover.1513577007.git.green.hu@gmail.com>
References: <cover.1513577007.git.green.hu@gmail.com>
In-Reply-To: <cover.1513577007.git.green.hu@gmail.com>
References: <cover.1513577007.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, pombredanne@nexb.com
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>
Message-ID: <20171218064635.O7BceXOvXUTKOEVTcXD_Y504C3SuTo1awpGl0v0ngxw@z>

From: Greentime Hu <greentime@andestech.com>

This patch adds support for timer.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/nds32/kernel/time.c |   11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 arch/nds32/kernel/time.c

diff --git a/arch/nds32/kernel/time.c b/arch/nds32/kernel/time.c
new file mode 100644
index 0000000..ac9d78c
--- /dev/null
+++ b/arch/nds32/kernel/time.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/clocksource.h>
+#include <linux/clk-provider.h>
+
+void __init time_init(void)
+{
+	of_clk_init(NULL);
+	timer_probe();
+}
-- 
1.7.9.5
