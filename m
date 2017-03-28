From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/2] vmlinux.lds: Add __clkevt_of_table to kernel
Date: Tue, 28 Mar 2017 17:14:00 +0200
Message-ID: <1490714040-30474-2-git-send-email-daniel.lezcano@linaro.org>
References: <20170328151230.GG2123@mai>
 <1490714040-30474-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37055 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752159AbdC1PO1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Mar 2017 11:14:27 -0400
Received: by mail-wm0-f53.google.com with SMTP id x124so1410250wmf.0
        for <linux-arch@vger.kernel.org>; Tue, 28 Mar 2017 08:14:26 -0700 (PDT)
In-Reply-To: <1490714040-30474-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, mingo@kernel.org
Cc: al.kochet@gmail.com, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>

From: Alexander Kochetkov <al.kochet@gmail.com>

The code introduced by commit 0c8893c9095d ("clockevents: Add a
clkevt-of mechanism like clksrc-of") refer to __clkevt_of_table
what doesn't exist in the vmlinux. As a result kernel build
failed with error: "clkevt-probe.c:63: undefined reference to
`__clkevt_of_table’"

Fixes: 0c8893c9095d ("clockevents: Add a clkevt-of mechanism like clksrc-of")
Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/asm-generic/vmlinux.lds.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 0968d13..8c6b525 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -173,6 +173,7 @@
 	KEEP(*(__##name##_of_table_end))
 
 #define CLKSRC_OF_TABLES()	OF_TABLE(CONFIG_CLKSRC_OF, clksrc)
+#define CLKEVT_OF_TABLES()	OF_TABLE(CONFIG_CLKEVT_OF, clkevt)
 #define IRQCHIP_OF_MATCH_TABLE() OF_TABLE(CONFIG_IRQCHIP, irqchip)
 #define CLK_OF_TABLES()		OF_TABLE(CONFIG_COMMON_CLK, clk)
 #define IOMMU_OF_TABLES()	OF_TABLE(CONFIG_OF_IOMMU, iommu)
@@ -559,6 +560,7 @@
 	CLK_OF_TABLES()							\
 	RESERVEDMEM_OF_TABLES()						\
 	CLKSRC_OF_TABLES()						\
+	CLKEVT_OF_TABLES()						\
 	IOMMU_OF_TABLES()						\
 	CPU_METHOD_OF_TABLES()						\
 	CPUIDLE_METHOD_OF_TABLES()					\
-- 
2.7.4
