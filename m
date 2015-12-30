From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 26/34] tile: define __smp_XXX
Date: Wed, 30 Dec 2015 15:26:05 +0200
Message-ID: <1451473761-30019-27-git-send-email-mst@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1451473761-30019-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Chris Metcalf <cmetcalf@ezchip.com>
List-Id: linux-arch.vger.kernel.org

This defines __smp_XXX barriers for tile,
for use by virtualization.

Some smp_XXX barriers are removed as they are
defined correctly by asm-generic/barriers.h

Note: for 32 bit, keep smp_mb__after_atomic around since it's faster
than the generic implementation.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/tile/include/asm/barrier.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/tile/include/asm/barrier.h b/arch/tile/include/asm/barrier.h
index 96a42ae..d552228 100644
--- a/arch/tile/include/asm/barrier.h
+++ b/arch/tile/include/asm/barrier.h
@@ -79,11 +79,12 @@ mb_incoherent(void)
  * But after the word is updated, the routine issues an "mf" before returning,
  * and since it's a function call, we don't even need a compiler barrier.
  */
-#define smp_mb__before_atomic()	smp_mb()
-#define smp_mb__after_atomic()	do { } while (0)
+#define __smp_mb__before_atomic()	__smp_mb()
+#define __smp_mb__after_atomic()	do { } while (0)
+#define smp_mb__after_atomic()	__smp_mb__after_atomic()
 #else /* 64 bit */
-#define smp_mb__before_atomic()	smp_mb()
-#define smp_mb__after_atomic()	smp_mb()
+#define __smp_mb__before_atomic()	__smp_mb()
+#define __smp_mb__after_atomic()	__smp_mb()
 #endif
 
 #include <asm-generic/barrier.h>
-- 
MST
