From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 03/37] lmb: Print new doubled array location info
Date: Fri, 14 May 2010 12:45:29 -0700
Message-ID: <1273866363-14249-4-git-send-email-yinghai@kernel.org>
References: <1273866363-14249-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1273866363-14249-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-arch.vger.kernel.org

so will have more idea where it is,  use lmb_debug to controll it

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 lib/lmb.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index b6725d6..2bdbe87 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -185,8 +185,6 @@ static int lmb_double_array(struct lmb_type *type)
 	phys_addr_t old_size, new_size, addr;
 	int use_slab = slab_is_available();
 
-	pr_debug("lmb: %s array full, doubling...", lmb_type_name(type));
-
 	/* Calculate new doubled size */
 	old_size = type->max * sizeof(struct lmb_region);
 	new_size = old_size << 1;
@@ -214,6 +212,10 @@ static int lmb_double_array(struct lmb_type *type)
 	}
 	new_array = __va(addr);
 
+	if (lmb_debug)
+		pr_info("lmb: %s array is doubled to %ld at %llx - %llx",
+			 lmb_type_name(type), type->max * 2, (u64)addr, (u64)addr + new_size);
+
 	/* Found space, we now need to move the array over before
 	 * we add the reserved region since it may be our reserved
 	 * array itself that is full.
-- 
1.6.4.2
