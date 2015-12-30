From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 06/34] s390: reuse asm-generic/barrier.h
Date: Wed, 30 Dec 2015 15:24:38 +0200
Message-ID: <1451473761-30019-7-git-send-email-mst@redhat.com>
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
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrey Konovalov <andreyknvl@google.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-arch.vger.kernel.org

On s390 read_barrier_depends, smp_read_barrier_depends
smp_store_mb(), smp_mb__before_atomic and smp_mb__after_atomic match the
asm-generic variants exactly. Drop the local definitions and pull in
asm-generic/barrier.h instead.

This is in preparation to refactoring this code area.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/s390/include/asm/barrier.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/barrier.h b/arch/s390/include/asm/barrier.h
index d68e11e..c358c31 100644
--- a/arch/s390/include/asm/barrier.h
+++ b/arch/s390/include/asm/barrier.h
@@ -30,14 +30,6 @@
 #define smp_rmb()			rmb()
 #define smp_wmb()			wmb()
 
-#define read_barrier_depends()		do { } while (0)
-#define smp_read_barrier_depends()	do { } while (0)
-
-#define smp_mb__before_atomic()		smp_mb()
-#define smp_mb__after_atomic()		smp_mb()
-
-#define smp_store_mb(var, value)		do { WRITE_ONCE(var, value); mb(); } while (0)
-
 #define smp_store_release(p, v)						\
 do {									\
 	compiletime_assert_atomic_type(*p);				\
@@ -53,4 +45,6 @@ do {									\
 	___p1;								\
 })
 
+#include <asm-generic/barrier.h>
+
 #endif /* __ASM_BARRIER_H */
-- 
MST
