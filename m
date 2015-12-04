From: tip-bot for Davidlohr Bueso <tipbot@zytor.com>
Subject: [tip:locking/core] lcoking/barriers, arch:
  Use smp barriers in smp_store_release()
Date: Fri, 4 Dec 2015 04:01:37 -0800
Message-ID: <tip-d5a73cadf3fdec95e9518ee5bb91bd0747c42b30@git.kernel.org>
References: <1445975631-17047-3-git-send-email-dave@stgolabs.net>
Reply-To: peterz@infradead.org, heiko.carstens@de.ibm.com,
	  akpm@linux-foundation.org, linux-arch@vger.kernel.org,
	  tony.luck@intel.com, hpa@zytor.com, dave@stgolabs.net,
	  torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	  benh@kernel.crashing.org, dbueso@suse.de, tglx@linutronix.de,
	  paulmck@linux.vnet.ibm.com, mingo@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445975631-17047-3-git-send-email-dave@stgolabs.net>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, dave@stgolabs.net, hpa@zytor.com, tony.luck@intel.com, linux-arch@vger.kernel.org, heiko.carstens@de.ibm.com, akpm@linux-foundation.org, peterz@infradead.org, mingo@kernel.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, dbueso@suse.de, benh@kernel.crashing.org
List-Id: linux-arch.vger.kernel.org

Commit-ID:  d5a73cadf3fdec95e9518ee5bb91bd0747c42b30
Gitweb:     http://git.kernel.org/tip/d5a73cadf3fdec95e9518ee5bb91bd0747c42b30
Author:     Davidlohr Bueso <dave@stgolabs.net>
AuthorDate: Tue, 27 Oct 2015 12:53:49 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 4 Dec 2015 11:39:51 +0100

lcoking/barriers, arch: Use smp barriers in smp_store_release()

With commit b92b8b35a2e ("locking/arch: Rename set_mb() to smp_store_mb()")
it was made clear that the context of this call (and thus set_mb)
is strictly for CPU ordering, as opposed to IO. As such all archs
should use the smp variant of mb(), respecting the semantics and
saving a mandatory barrier on UP.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <linux-arch@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: dave@stgolabs.net
Link: http://lkml.kernel.org/r/1445975631-17047-3-git-send-email-dave@stgolabs.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/ia64/include/asm/barrier.h    | 2 +-
 arch/powerpc/include/asm/barrier.h | 2 +-
 arch/s390/include/asm/barrier.h    | 2 +-
 include/asm-generic/barrier.h      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/ia64/include/asm/barrier.h b/arch/ia64/include/asm/barrier.h
index df896a1..209c4b8 100644
--- a/arch/ia64/include/asm/barrier.h
+++ b/arch/ia64/include/asm/barrier.h
@@ -77,7 +77,7 @@ do {									\
 	___p1;								\
 })
 
-#define smp_store_mb(var, value)	do { WRITE_ONCE(var, value); mb(); } while (0)
+#define smp_store_mb(var, value) do { WRITE_ONCE(var, value); smp_mb(); } while (0)
 
 /*
  * The group barrier in front of the rsm & ssm are necessary to ensure
diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index 0eca6ef..a7af5fb 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -34,7 +34,7 @@
 #define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
 #define wmb()  __asm__ __volatile__ ("sync" : : : "memory")
 
-#define smp_store_mb(var, value)	do { WRITE_ONCE(var, value); mb(); } while (0)
+#define smp_store_mb(var, value) do { WRITE_ONCE(var, value); smp_mb(); } while (0)
 
 #ifdef __SUBARCH_HAS_LWSYNC
 #    define SMPWMB      LWSYNC
diff --git a/arch/s390/include/asm/barrier.h b/arch/s390/include/asm/barrier.h
index d68e11e..7ffd0b1 100644
--- a/arch/s390/include/asm/barrier.h
+++ b/arch/s390/include/asm/barrier.h
@@ -36,7 +36,7 @@
 #define smp_mb__before_atomic()		smp_mb()
 #define smp_mb__after_atomic()		smp_mb()
 
-#define smp_store_mb(var, value)		do { WRITE_ONCE(var, value); mb(); } while (0)
+#define smp_store_mb(var, value)	do { WRITE_ONCE(var, value); smp_mb(); } while (0)
 
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
