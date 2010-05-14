From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 02/37] lmb: Prepare x86 to use lmb to replace early_res
Date: Fri, 14 May 2010 12:45:28 -0700
Message-ID: <1273866363-14249-3-git-send-email-yinghai@kernel.org>
References: <1273866363-14249-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1273866363-14249-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-arch.vger.kernel.org

1. expose lmb_debug
2. expose lmb_reserved_init_regions

-v2: drop lmb_add_region() and LMB_ERROR export
-v3: seperate wrong return of lmb_fin_base to another patch

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 include/linux/lmb.h |    2 ++
 lib/lmb.c           |    4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/lmb.h b/include/linux/lmb.h
index 6f8c4bd..d88c92d 100644
--- a/include/linux/lmb.h
+++ b/include/linux/lmb.h
@@ -39,6 +39,8 @@ struct lmb {
 };
 
 extern struct lmb lmb;
+extern int lmb_debug;
+extern struct lmb_region lmb_reserved_init_regions[];
 
 extern void __init lmb_init(void);
 extern void __init lmb_analyze(void);
diff --git a/lib/lmb.c b/lib/lmb.c
index 0d4e4c0..b6725d6 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -22,9 +22,9 @@
 
 struct lmb lmb;
 
-static int lmb_debug;
+int lmb_debug;
 static struct lmb_region lmb_memory_init_regions[INIT_LMB_REGIONS + 1];
-static struct lmb_region lmb_reserved_init_regions[INIT_LMB_REGIONS + 1];
+struct lmb_region lmb_reserved_init_regions[INIT_LMB_REGIONS + 1];
 
 #define LMB_ERROR	(~(phys_addr_t)0)
 
-- 
1.6.4.2
