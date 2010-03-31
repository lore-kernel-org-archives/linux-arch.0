From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 04/33] lmb: Seperate __lmb_find_base() from __lmb_alloc_base()
Date: Tue, 30 Mar 2010 19:16:49 -0700
Message-ID: <1270001838-15857-5-git-send-email-yinghai@kernel.org>
References: <1270001838-15857-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1270001838-15857-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-arch.vger.kernel.org

So We can construct one generic __find_lmb_area() later

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 mm/lmb.c |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/mm/lmb.c b/mm/lmb.c
index 65b62dc..392d805 100644
--- a/mm/lmb.c
+++ b/mm/lmb.c
@@ -393,7 +393,7 @@ u64 __init lmb_alloc_base(u64 size, u64 align, u64 max_addr)
 	return alloc;
 }
 
-u64 __init __lmb_alloc_base(u64 size, u64 align, u64 max_addr)
+static u64 __init __lmb_find_base(u64 size, u64 align, u64 max_addr)
 {
 	long i, j;
 	u64 base = 0;
@@ -426,8 +426,6 @@ u64 __init __lmb_alloc_base(u64 size, u64 align, u64 max_addr)
 			j = lmb_overlaps_region(&lmb.reserved, base, size);
 			if (j < 0) {
 				/* this area isn't reserved, take it */
-				if (lmb_add_region(&lmb.reserved, base, size) < 0)
-					return 0;
 				return base;
 			}
 			res_base = lmb.reserved.region[j].base;
@@ -436,7 +434,22 @@ u64 __init __lmb_alloc_base(u64 size, u64 align, u64 max_addr)
 			base = lmb_align_down(res_base - size, align);
 		}
 	}
-	return 0;
+	return -1ULL;
+}
+
+u64 __init __lmb_alloc_base(u64 size, u64 align, u64 max_addr)
+{
+	u64 base;
+
+	base = __lmb_find_base(size, align, max_addr);
+
+	if (base == -1ULL)
+		return 0;
+
+	if (lmb_add_region(&lmb.reserved, base, size) < 0)
+		return 0;
+
+	return base;
 }
 
 /* You must call lmb_analyze() before this. */
-- 
1.6.4.2
