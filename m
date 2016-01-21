From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] sh: fix smp_store_mb for !SMP
Date: Thu, 21 Jan 2016 12:29:22 +0200
Message-ID: <1453371795-32669-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-arch.vger.kernel.org

sh variant of smp_store_mb() calls xchg() on !SMP which is stronger than
implied by both the name and the documentation.

commit 90a3ccb0be538a914e6a5c51ae919762261563ad ("sh: define __smp_xxx,
fix smp_store_mb for !SMP") was supposed to fix it but
left the bug in place.

Drop smp_store_mb, so that code in asm-generic/barrier.h
will define it correctly depending on CONFIG_SMP.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

I put this in my tree as that's where the original commit
came through, but if anyone else prefers to merge it, pls
let me know.

 arch/sh/include/asm/barrier.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/include/asm/barrier.h b/arch/sh/include/asm/barrier.h
index f887c64..8a84e05 100644
--- a/arch/sh/include/asm/barrier.h
+++ b/arch/sh/include/asm/barrier.h
@@ -33,7 +33,6 @@
 #endif
 
 #define __smp_store_mb(var, value) do { (void)xchg(&var, value); } while (0)
-#define smp_store_mb(var, value) __smp_store_mb(var, value)
 
 #include <asm-generic/barrier.h>
 
-- 
MST
