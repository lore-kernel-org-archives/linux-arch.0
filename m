Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45155 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933130AbeAOF4F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jan 2018 00:56:05 -0500
From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v6 25/36] nds32: Generic timers support
Date: Mon, 15 Jan 2018 13:53:33 +0800
Message-ID: <ff6346e073ae38aa96a031420f57aad3d1057ddf.1515766253.git.green.hu@gmail.com>
In-Reply-To: <cover.1515766253.git.green.hu@gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com>
In-Reply-To: <cover.1515766253.git.green.hu@gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>
Message-ID: <20180115055333.-tGFCHzfBzC8y2S6W_liQhXB0pd3LiuCLYvbE_Ury0c@z>

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
