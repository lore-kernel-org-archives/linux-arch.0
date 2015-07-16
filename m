Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:39837 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750769AbbGPPdM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Jul 2015 11:33:12 -0400
From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 6/7] include/llist: use linux/atomic.h instead of asm/cmpxchg.h
Date: Thu, 16 Jul 2015 16:32:37 +0100
Message-ID: <1437060758-10381-7-git-send-email-will.deacon@arm.com>
In-Reply-To: <1437060758-10381-1-git-send-email-will.deacon@arm.com>
References: <1437060758-10381-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Waiman.Long@hp.com, peterz@infradead.org, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com, Will Deacon <will.deacon@arm.com>
Message-ID: <20150716153237.6q1lA_xUAwIJGSvMljPTonReCj9JFtdUuu7Vy0XwsDo@z>

Including an asm/ header directly is best avoided, so use linux/atomic.h
instead of asm/cmpxchg.h in linux/llist.h.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/linux/llist.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/llist.h b/include/linux/llist.h
index fbf10a0bc095..fd4ca0b4fe0f 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -55,8 +55,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#include <linux/atomic.h>
 #include <linux/kernel.h>
-#include <asm/cmpxchg.h>
 
 struct llist_head {
 	struct llist_node *first;
-- 
2.1.4

