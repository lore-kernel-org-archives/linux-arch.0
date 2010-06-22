From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 04/25] lmb: Export LMB_ERROR again
Date: Tue, 22 Jun 2010 10:26:33 -0700
Message-ID: <1277227614-11581-5-git-send-email-yinghai@kernel.org>
References: <1277227614-11581-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1277227614-11581-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-arch.vger.kernel.org

will used by x86 lmb_find_in_range_node and nobootmem replacement

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 include/linux/lmb.h |    1 +
 lib/lmb.c           |    2 --
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/include/linux/lmb.h b/include/linux/lmb.h
index 1e96224..eb8a5a3 100644
--- a/include/linux/lmb.h
+++ b/include/linux/lmb.h
@@ -19,6 +19,7 @@
 #include <asm/lmb.h>
 
 #define INIT_LMB_REGIONS 128
+#define LMB_ERROR	(~(phys_addr_t)0)
 
 struct lmb_region {
 	phys_addr_t base;
diff --git a/lib/lmb.c b/lib/lmb.c
index 7a6e11a..2aaeeec 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -27,8 +27,6 @@ int lmb_can_resize;
 static struct lmb_region lmb_memory_init_regions[INIT_LMB_REGIONS + 1];
 struct lmb_region lmb_reserved_init_regions[INIT_LMB_REGIONS + 1];
 
-#define LMB_ERROR	(~(phys_addr_t)0)
-
 /* inline so we don't get a warning when pr_debug is compiled out */
 static inline const char *lmb_type_name(struct lmb_type *type)
 {
-- 
1.6.4.2
