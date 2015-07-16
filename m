From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 6/7] include/llist: use linux/atomic.h instead of asm/cmpxchg.h
Date: Thu, 16 Jul 2015 16:32:37 +0100
Message-ID: <1437060758-10381-7-git-send-email-will.deacon@arm.com>
References: <1437060758-10381-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437060758-10381-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Waiman.Long@hp.com, peterz@infradead.org, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

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
