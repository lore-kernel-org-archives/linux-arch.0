Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41336 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934114AbeBMJMq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Feb 2018 04:12:46 -0500
From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v7 26/37] nds32: Generic timers support
Date: Tue, 13 Feb 2018 17:09:30 +0800
Message-ID: <adcd5e930b91ae91d975cd0db3a0f2e2b142f42d.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>
Message-ID: <20180213090930.giI1nwg0StFP6XlJhmxJJDuY2MahC-_3p8m4NAnbNSI@z>

This patch adds support for timer.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/nds32/kernel/time.c | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 arch/nds32/kernel/time.c

diff --git a/arch/nds32/kernel/time.c b/arch/nds32/kernel/time.c
new file mode 100644
index 000000000000..ac9d78ce3a81
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
2.16.1
