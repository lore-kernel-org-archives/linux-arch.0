From: Alexander Kochetkov <al.kochet@gmail.com>
Subject: [PATCH] vmlinux.lds: add __clkevt_of_table to kernel
Date: Wed, 22 Mar 2017 17:29:06 +0300
Message-ID: <1490192947-21465-1-git-send-email-al.kochet@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32869 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759029AbdCVOhT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Mar 2017 10:37:19 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alexander Kochetkov <al.kochet@gmail.com>

The code introduced by commit 0c8893c9095d ("clockevents: Add a
clkevt-of mechanism like clksrc-of") refer to __clkevt_of_table
what doesn't exist in the vmlinux. As a result kernel build
failed with error: "clkevt-probe.c:63: undefined reference to
`__clkevt_of_table’"

Fixes: 0c8893c9095d ("clockevents: Add a clkevt-of mechanism like clksrc-of")
Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 include/asm-generic/vmlinux.lds.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 2456397..42afee3 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -173,6 +173,7 @@
 	*(__##name##_of_table_end)
 
 #define CLKSRC_OF_TABLES()	OF_TABLE(CONFIG_CLKSRC_OF, clksrc)
+#define CLKEVT_OF_TABLES()	OF_TABLE(CONFIG_CLKEVT_OF, clkevt)
 #define IRQCHIP_OF_MATCH_TABLE() OF_TABLE(CONFIG_IRQCHIP, irqchip)
 #define CLK_OF_TABLES()		OF_TABLE(CONFIG_COMMON_CLK, clk)
 #define IOMMU_OF_TABLES()	OF_TABLE(CONFIG_OF_IOMMU, iommu)
@@ -539,6 +540,7 @@
 	CLK_OF_TABLES()							\
 	RESERVEDMEM_OF_TABLES()						\
 	CLKSRC_OF_TABLES()						\
+	CLKEVT_OF_TABLES()						\
 	IOMMU_OF_TABLES()						\
 	CPU_METHOD_OF_TABLES()						\
 	CPUIDLE_METHOD_OF_TABLES()					\
-- 
1.7.9.5
