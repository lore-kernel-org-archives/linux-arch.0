From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 8/8] kernel: Fix sparse warning for ACCESS_ONCE
Date: Thu, 15 Jan 2015 09:58:34 +0100
Message-ID: <1421312314-72330-9-git-send-email-borntraeger@de.ibm.com>
References: <1421312314-72330-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1421312314-72330-1-git-send-email-borntraeger@de.ibm.com>
Sender: owner-linux-mm@kvack.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, xen-devel@lists.xenproject.org, linux-mm@kvack.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

Commit a91ed664749c ("kernel: tighten rules for ACCESS ONCE") results in
sparse warnings like "Using plain integer as NULL pointer" - Let's add a
type cast to the dummy assignment.
To avoid warnings lik "sparse: warning: cast to restricted __hc32" we also
use __force on that cast.

Fixes: a91ed664749c ("kernel: tighten rules for ACCESS ONCE")
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 5e186bf..7bebf05 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -461,7 +461,7 @@ static __always_inline void __assign_once_size(volatile void *p, void *res, int
  * If possible use READ_ONCE/ASSIGN_ONCE instead.
  */
 #define __ACCESS_ONCE(x) ({ \
-	 __maybe_unused typeof(x) __var = 0; \
+	 __maybe_unused typeof(x) __var = (__force typeof(x)) 0; \
 	(volatile typeof(x) *)&(x); })
 #define ACCESS_ONCE(x) (*__ACCESS_ONCE(x))
 
-- 
1.9.3

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
