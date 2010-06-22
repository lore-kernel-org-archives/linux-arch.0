From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 03/25] lmb: Print new doubled array location info
Date: Tue, 22 Jun 2010 10:26:32 -0700
Message-ID: <1277227614-11581-4-git-send-email-yinghai@kernel.org>
References: <1277227614-11581-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:32406 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758548Ab0FVR20 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Jun 2010 13:28:26 -0400
In-Reply-To: <1277227614-11581-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>

so will have more idea where it is,  use lmb_debug to controll it

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 lib/lmb.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index bbdb1ec..7a6e11a 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -192,8 +192,6 @@ static int lmb_double_array(struct lmb_type *type)
 	if (!lmb_can_resize)
 		return -1;
 
-	pr_debug("lmb: %s array full, doubling...", lmb_type_name(type));
-
 	/* Calculate new doubled size */
 	old_size = type->max * sizeof(struct lmb_region);
 	new_size = old_size << 1;
@@ -221,6 +219,10 @@ static int lmb_double_array(struct lmb_type *type)
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
