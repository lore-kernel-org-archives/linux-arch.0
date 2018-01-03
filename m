From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 5/5] clk: Move __clk_{get,put}() into private clk.h API
Date: Tue,  2 Jan 2018 17:35:16 -0800
Message-ID: <20180103013516.18844-6-sboyd@codeaurora.org>
References: <20180103013516.18844-1-sboyd@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180103013516.18844-1-sboyd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arch@vger.kernel.org, Russell King <linux@armlinux.org.uk>
List-Id: linux-arch.vger.kernel.org

We can move these APIs into the private header file now that we
don't have any users of the __clk_get() and __clk_put() APIs
outside of clkdev.c and clk.c.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/clk.h      | 4 ++++
 include/linux/clkdev.h | 8 --------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk.h b/drivers/clk/clk.h
index 00b35a13cdf3..70c0ba6336c1 100644
--- a/drivers/clk/clk.h
+++ b/drivers/clk/clk.h
@@ -20,6 +20,8 @@ struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec,
 struct clk *__clk_create_clk(struct clk_hw *hw, const char *dev_id,
 			     const char *con_id);
 void __clk_free_clk(struct clk *clk);
+int __clk_get(struct clk *clk);
+void __clk_put(struct clk *clk);
 #else
 /* All these casts to avoid ifdefs in clkdev... */
 static inline struct clk *
@@ -32,5 +34,7 @@ static struct clk_hw *__clk_get_hw(struct clk *clk)
 {
 	return (struct clk_hw *)clk;
 }
+static inline int __clk_get(struct clk *clk) { return 1; }
+static inline void __clk_put(struct clk *clk) { }
 
 #endif
diff --git a/include/linux/clkdev.h b/include/linux/clkdev.h
index ef98ee8c6358..4890ff033220 100644
--- a/include/linux/clkdev.h
+++ b/include/linux/clkdev.h
@@ -52,12 +52,4 @@ int clk_add_alias(const char *, const char *, const char *, struct device *);
 int clk_register_clkdev(struct clk *, const char *, const char *);
 int clk_hw_register_clkdev(struct clk_hw *, const char *, const char *);
 
-#ifdef CONFIG_COMMON_CLK
-int __clk_get(struct clk *clk);
-void __clk_put(struct clk *clk);
-#else
-static inline int __clk_get(struct clk *clk) { return 1; }
-static inline void __clk_put(struct clk *clk) { }
-#endif
-
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
