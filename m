From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC] smp_store_mb should use smp_mb
Date: Mon, 21 Dec 2015 09:22:18 +0200
Message-ID: <20151221091130-mutt-send-email-mst@redhat.com>
References: <1450347932-16325-1-git-send-email-mst@redhat.com>
 <20151217105238.GA6375@twins.programming.kicks-ass.net>
 <20151217131554-mutt-send-email-mst@redhat.com>
 <20151217135726.GA6344@twins.programming.kicks-ass.net>
 <20151217161124-mutt-send-email-mst@redhat.com>
 <20151217143910.GD6344@twins.programming.kicks-ass.net>
 <20151220105146-mutt-send-email-mst@redhat.com>
 <5676E047.3010808@citrix.com>
 <20151220195944.GT6344@twins.programming.kicks-ass.net>
 <20151221085947-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55800 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949AbbLUHWY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 21 Dec 2015 02:22:24 -0500
Content-Disposition: inline
In-Reply-To: <20151221085947-mutt-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, Jason Wang <jasowang@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>, qemu-devel@nongnu.org, Alexander Duyck <alexander.duyck@gmail.com>, linux-kernel@vger.kernel.org, David Vrabel <david.vrabel@citrix.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org

On some architectures smp_store_mb() calls mb() which is stronger
than implied by both the name and the documentation.

smp_store_mb is only used by core kernel code at the moment, so
we know no one mis-uses it for an MMIO barrier.
Make it call smp_mb consistently before some arch-specific
code uses it as such by mistake.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

Note: I'm guessing an ack from arch maintainers will be needed, but
I'm working on a bigger cleanup moving a bunch of duplicated code
into asm-generic/barrier.h which depends on this, so not Cc'ing
widely yet.

Please Ack if appropriate but do not merge yet.

diff --git a/arch/ia64/include/asm/barrier.h b/arch/ia64/include/asm/barrier.h
index df896a1..425552b 100644
--- a/arch/ia64/include/asm/barrier.h
+++ b/arch/ia64/include/asm/barrier.h
@@ -77,7 +77,7 @@ do {									\
 	___p1;								\
 })
 
-#define smp_store_mb(var, value)	do { WRITE_ONCE(var, value); mb(); } while (0)
+#define smp_store_mb(var, value)	do { WRITE_ONCE(var, value); smp_mb(); } while (0)
 
 /*
  * The group barrier in front of the rsm & ssm are necessary to ensure
diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index 0eca6ef..4f0169e 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -34,7 +34,7 @@
 #define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
 #define wmb()  __asm__ __volatile__ ("sync" : : : "memory")
 
-#define smp_store_mb(var, value)	do { WRITE_ONCE(var, value); mb(); } while (0)
+#define smp_store_mb(var, value)	do { WRITE_ONCE(var, value); smp_mb(); } while (0)
 
 #ifdef __SUBARCH_HAS_LWSYNC
 #    define SMPWMB      LWSYNC
diff --git a/arch/s390/include/asm/barrier.h b/arch/s390/include/asm/barrier.h
index d68e11e..6c1d8b5 100644
--- a/arch/s390/include/asm/barrier.h
+++ b/arch/s390/include/asm/barrier.h
@@ -36,7 +36,7 @@
 #define smp_mb__before_atomic()		smp_mb()
 #define smp_mb__after_atomic()		smp_mb()
 
-#define smp_store_mb(var, value)		do { WRITE_ONCE(var, value); mb(); } while (0)
+#define smp_store_mb(var, value)		do { WRITE_ONCE(var, value); smp_mb(); } while (0)
 
 #define smp_store_release(p, v)						\
 do {									\
diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index b42afad..0f45f93 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -93,7 +93,7 @@
 #endif	/* CONFIG_SMP */
 
 #ifndef smp_store_mb
-#define smp_store_mb(var, value)  do { WRITE_ONCE(var, value); mb(); } while (0)
+#define smp_store_mb(var, value)  do { WRITE_ONCE(var, value); smp_mb(); } while (0)
 #endif
 
 #ifndef smp_mb__before_atomic
