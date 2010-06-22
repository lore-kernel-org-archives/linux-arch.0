From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 01/25] lmb: lmb_find_base() should return LMB_ERROR on failing path
Date: Tue, 22 Jun 2010 10:26:30 -0700
Message-ID: <1277227614-11581-2-git-send-email-yinghai@kernel.org>
References: <1277227614-11581-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1277227614-11581-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-arch.vger.kernel.org

all callees assume it return LMB_ERROR when it fail to find a range

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 lib/lmb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 2421b2a..13d1a04 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -154,7 +154,7 @@ static phys_addr_t __init lmb_find_base(phys_addr_t size, phys_addr_t align,
 		if (found != LMB_ERROR)
 			return found;
 	}
-	return 0;
+	return LMB_ERROR;
 }
 
 static void lmb_remove_region(struct lmb_type *type, unsigned long r)
-- 
1.6.4.2
