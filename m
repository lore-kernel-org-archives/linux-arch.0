From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 2/5] clk: Prepare to remove asm-generic/clkdev.h
Date: Tue,  2 Jan 2018 17:35:13 -0800
Message-ID: <20180103013516.18844-3-sboyd@codeaurora.org>
References: <20180103013516.18844-1-sboyd@codeaurora.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49586 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbeACBfU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Jan 2018 20:35:20 -0500
In-Reply-To: <20180103013516.18844-1-sboyd@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arch@vger.kernel.org, Russell King <linux@armlinux.org.uk>

Now that all the users of asm/clkdev.h have been replaced with
the generic file we can get rid of the asm-generic file as well
and implement that code directly where it's used.

We only have one caller of __clkdev_alloc(), in clkdev.c so we
can easily remove that and drop the include of asm/clkdev.h in
linux/clkdev.h by putting the __clk_get/__clk_put inlines in
their respective location.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/clkdev.c   | 2 +-
 include/linux/clkdev.h | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 6b2f29df3f70..7513411140b6 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -256,7 +256,7 @@ vclkdev_alloc(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
 {
 	struct clk_lookup_alloc *cla;
 
-	cla = __clkdev_alloc(sizeof(*cla));
+	cla = kzalloc(sizeof(*cla), GFP_KERNEL);
 	if (!cla)
 		return NULL;
 
diff --git a/include/linux/clkdev.h b/include/linux/clkdev.h
index 2eabc862abdb..ef98ee8c6358 100644
--- a/include/linux/clkdev.h
+++ b/include/linux/clkdev.h
@@ -12,7 +12,7 @@
 #ifndef __CLKDEV_H
 #define __CLKDEV_H
 
-#include <asm/clkdev.h>
+#include <linux/slab.h>
 
 struct clk;
 struct clk_hw;
@@ -55,6 +55,9 @@ int clk_hw_register_clkdev(struct clk_hw *, const char *, const char *);
 #ifdef CONFIG_COMMON_CLK
 int __clk_get(struct clk *clk);
 void __clk_put(struct clk *clk);
+#else
+static inline int __clk_get(struct clk *clk) { return 1; }
+static inline void __clk_put(struct clk *clk) { }
 #endif
 
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
