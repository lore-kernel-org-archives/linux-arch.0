From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 10/37] x86, lmb: Add lmb_to_bootmem()
Date: Fri, 14 May 2010 12:45:36 -0700
Message-ID: <1273866363-14249-11-git-send-email-yinghai@kernel.org>
References: <1273866363-14249-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1273866363-14249-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-arch.vger.kernel.org

lmb_to_bootmem() will reserve lmb.reserved.region in bootmem after bootmem is
set up.

We can use it to with all arches that support lmb later.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/include/asm/lmb.h |    1 +
 arch/x86/mm/lmb.c          |   31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/lmb.h b/arch/x86/include/asm/lmb.h
index aa3a66e..2f06714 100644
--- a/arch/x86/include/asm/lmb.h
+++ b/arch/x86/include/asm/lmb.h
@@ -4,5 +4,6 @@
 #define ARCH_DISCARD_LMB
 
 u64 lmb_find_area_size(u64 start, u64 *sizep, u64 align);
+void lmb_to_bootmem(u64 start, u64 end);
 
 #endif
diff --git a/arch/x86/mm/lmb.c b/arch/x86/mm/lmb.c
index 9d26eed..37a05e2 100644
--- a/arch/x86/mm/lmb.c
+++ b/arch/x86/mm/lmb.c
@@ -86,3 +86,34 @@ u64 __init lmb_find_area_size(u64 start, u64 *sizep, u64 align)
 	return LMB_ERROR;
 }
 
+#ifndef CONFIG_NO_BOOTMEM
+void __init lmb_to_bootmem(u64 start, u64 end)
+{
+	int i, count;
+	u64 final_start, final_end;
+
+	/* Take out region array itself */
+	if (lmb.reserved.regions != lmb_reserved_init_regions)
+		lmb_free(__pa(lmb.reserved.regions), sizeof(struct lmb_region) * lmb.reserved.max);
+
+	count  = lmb.reserved.cnt;
+	pr_info("(%d early reservations) ==> bootmem [%010llx - %010llx]\n", count, start, end);
+	for (i = 0; i < count; i++) {
+		struct lmb_region *r = &lmb.reserved.regions[i];
+		pr_info("  #%d [%010llx - %010llx] ", i, (u64)r->base, (u64)r->base + r->size);
+		final_start = max(start, r->base);
+		final_end = min(end, r->base + r->size);
+		if (final_start >= final_end) {
+			pr_cont("\n");
+			continue;
+		}
+		pr_cont(" ==> [%010llx - %010llx]\n", final_start, final_end);
+		reserve_bootmem_generic(final_start, final_end - final_start, BOOTMEM_DEFAULT);
+	}
+	/* Clear them to avoid misusing ? */
+	memset(&lmb.reserved.regions[0], 0, sizeof(struct lmb_region) * lmb.reserved.max);
+	lmb.reserved.regions = NULL;
+	lmb.reserved.max = 0;
+	lmb.reserved.cnt = 0;
+}
+#endif
-- 
1.6.4.2
