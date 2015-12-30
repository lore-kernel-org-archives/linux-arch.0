Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55427 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754875AbbL3NYd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Dec 2015 08:24:33 -0500
Date: Wed, 30 Dec 2015 15:24:27 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 04/34] ia64: reuse asm-generic/barrier.h
Message-ID: <1451473761-30019-5-git-send-email-mst@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451473761-30019-1-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrey Konovalov <andreyknvl@google.com>, linux-ia64@vger.kernel.org
Message-ID: <20151230132427.dqf-d8_gw4CfG2Li7rgNfMyrjP8lhFCU7n9ik-SEKHA@z>

On ia64 smp_rmb, smp_wmb, read_barrier_depends, smp_read_barrier_depends
and smp_store_mb() match the asm-generic variants exactly. Drop the
local definitions and pull in asm-generic/barrier.h instead.

This is in preparation to refactoring this code area.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/ia64/include/asm/barrier.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/ia64/include/asm/barrier.h b/arch/ia64/include/asm/barrier.h
index df896a1..2f93348 100644
--- a/arch/ia64/include/asm/barrier.h
+++ b/arch/ia64/include/asm/barrier.h
@@ -48,12 +48,6 @@
 # define smp_mb()	barrier()
 #endif
 
-#define smp_rmb()	smp_mb()
-#define smp_wmb()	smp_mb()
-
-#define read_barrier_depends()		do { } while (0)
-#define smp_read_barrier_depends()	do { } while (0)
-
 #define smp_mb__before_atomic()	barrier()
 #define smp_mb__after_atomic()	barrier()
 
@@ -77,12 +71,12 @@ do {									\
 	___p1;								\
 })
 
-#define smp_store_mb(var, value)	do { WRITE_ONCE(var, value); mb(); } while (0)
-
 /*
  * The group barrier in front of the rsm & ssm are necessary to ensure
  * that none of the previous instructions in the same group are
  * affected by the rsm/ssm.
  */
 
+#include <asm-generic/barrier.h>
+
 #endif /* _ASM_IA64_BARRIER_H */
-- 
MST

