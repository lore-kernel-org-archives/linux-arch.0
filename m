From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH 01/28] asm-generic: atomic64: allow using generic atomic64 on 64bit platforms
Date: Tue,  3 Nov 2015 22:20:32 +0200
Message-ID: <1446582059-17355-2-git-send-email-octavian.purdila@intel.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, thehajime@gmail.com, Octavian Purdila <octavian.purdila@intel.com>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 include/asm-generic/atomic64.h | 2 ++
 include/linux/atomic.h         | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
index d48e78c..d0eb6cd 100644
--- a/include/asm-generic/atomic64.h
+++ b/include/asm-generic/atomic64.h
@@ -12,9 +12,11 @@
 #ifndef _ASM_GENERIC_ATOMIC64_H
 #define _ASM_GENERIC_ATOMIC64_H
 
+#ifndef CONFIG_64BIT
 typedef struct {
 	long long counter;
 } atomic64_t;
+#endif
 
 #define ATOMIC64_INIT(i)	{ (i) }
 
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 00a5763..81814c8 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -451,10 +451,10 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 }
 #endif
 
-#include <asm-generic/atomic-long.h>
 #ifdef CONFIG_GENERIC_ATOMIC64
 #include <asm-generic/atomic64.h>
 #endif
+#include <asm-generic/atomic-long.h>
 
 #ifndef atomic64_andnot
 static inline void atomic64_andnot(long long i, atomic64_t *v)
-- 
2.1.0
