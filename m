From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 19/28] arch: conditionally define smp_{mb,rmb,wmb}
Date: Tue, 9 Jun 2015 17:18:19 +0530
Message-ID: <1433850508-26317-20-git-send-email-vgupta@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

That way arches can define the minimal versions and still #include
asm-generic for defaults (vs. defining defaults in arch code)

See new barrier.h in arc for usage !

Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 include/asm-generic/barrier.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index f5c40b0fadc2..270b7c989ea1 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -55,17 +55,42 @@
 #endif
 
 #ifdef CONFIG_SMP
+
+#ifndef smp_mb
 #define smp_mb()	mb()
+#endif
+
+#ifndef smp_rmb
 #define smp_rmb()	rmb()
+#endif
+
+#ifndef smp_wmb
 #define smp_wmb()	wmb()
+#endif
+
+#ifndef smp_read_barrier_depends
 #define smp_read_barrier_depends()	read_barrier_depends()
+#endif
+
 #else
+#ifndef smp_mb
 #define smp_mb()	barrier()
+#endif
+
+#ifndef smp_rmb
 #define smp_rmb()	barrier()
+#endif
+
+#ifndef smp_wmb
 #define smp_wmb()	barrier()
+#endif
+
+#ifndef smp_read_barrier_depends
 #define smp_read_barrier_depends()	do { } while (0)
 #endif
 
+#endif
+
 #ifndef set_mb
 #define set_mb(var, value)  do { (var) = (value); mb(); } while (0)
 #endif
-- 
1.9.1
