From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 1/5] blackfin: Use generic clkdev.h header
Date: Tue,  2 Jan 2018 17:35:12 -0800
Message-ID: <20180103013516.18844-2-sboyd@codeaurora.org>
References: <20180103013516.18844-1-sboyd@codeaurora.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49570 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750873AbeACBfU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Jan 2018 20:35:20 -0500
In-Reply-To: <20180103013516.18844-1-sboyd@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arch@vger.kernel.org

The generic header file is equivalent to the blackfin version, so
just use the generic one.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/blackfin/include/asm/Kbuild   |  1 +
 arch/blackfin/include/asm/clkdev.h | 17 -----------------
 2 files changed, 1 insertion(+), 17 deletions(-)
 delete mode 100644 arch/blackfin/include/asm/clkdev.h

diff --git a/arch/blackfin/include/asm/Kbuild b/arch/blackfin/include/asm/Kbuild
index fe736973630f..40e44231743f 100644
--- a/arch/blackfin/include/asm/Kbuild
+++ b/arch/blackfin/include/asm/Kbuild
@@ -1,4 +1,5 @@
 generic-y += bugs.h
+generic-y += clkdev.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/blackfin/include/asm/clkdev.h b/arch/blackfin/include/asm/clkdev.h
deleted file mode 100644
index ded0209348c7..000000000000
--- a/arch/blackfin/include/asm/clkdev.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_CLKDEV__H_
-#define __ASM_CLKDEV__H_
-
-#include <linux/slab.h>
-
-static inline struct clk_lookup_alloc *__clkdev_alloc(size_t size)
-{
-	return kzalloc(size, GFP_KERNEL);
-}
-
-#ifndef CONFIG_COMMON_CLK
-#define __clk_put(clk)
-#define __clk_get(clk) ({ 1; })
-#endif
-
-#endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
