From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 02/23] lmb: Prepare x86 to use lmb to replace early_res
Date: Sat,  3 Jul 2010 23:56:06 -0700
Message-ID: <1278226587-31213-3-git-send-email-yinghai@kernel.org>
References: <1278226587-31213-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1278226587-31213-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-arch.vger.kernel.org

1. expose lmb_debug
2. expose lmb_reserved_init_regions

-v2: drop lmb_add_region() and LMB_ERROR export
-v3: seperate wrong return of lmb_fin_base to another patch
-v4: expose lmb_can_resize to handle x86 EFI that could have more than
      128 entries
-v5: add lmb_dbg, so we can spare some if (lmb_debug) suggested by Ingo.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 include/linux/lmb.h |    6 ++++++
 lib/lmb.c           |    5 +++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/lmb.h b/include/linux/lmb.h
index 6f8c4bd..5124fca 100644
--- a/include/linux/lmb.h
+++ b/include/linux/lmb.h
@@ -39,6 +39,12 @@ struct lmb {
 };
 
 extern struct lmb lmb;
+extern int lmb_debug;
+extern int lmb_can_resize;
+extern struct lmb_region lmb_reserved_init_regions[];
+
+#define lmb_dbg(fmt, ...) \
+	if (lmb_debug) printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
 
 extern void __init lmb_init(void);
 extern void __init lmb_analyze(void);
diff --git a/lib/lmb.c b/lib/lmb.c
index 13d1a04..bbdb1ec 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -22,9 +22,10 @@
 
 struct lmb lmb;
 
-static int lmb_debug, lmb_can_resize;
+int lmb_debug;
+int lmb_can_resize;
 static struct lmb_region lmb_memory_init_regions[INIT_LMB_REGIONS + 1];
-static struct lmb_region lmb_reserved_init_regions[INIT_LMB_REGIONS + 1];
+struct lmb_region lmb_reserved_init_regions[INIT_LMB_REGIONS + 1];
 
 #define LMB_ERROR	(~(phys_addr_t)0)
 
-- 
1.6.4.2
