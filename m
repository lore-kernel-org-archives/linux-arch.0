From: "H. Peter Anvin" <hpa@linux.intel.com>
Subject: [PATCH 3/5] x86, cpu: Remove gcc 3.x workarounds in <asm/cpufeature.h>
Date: Mon, 13 Sep 2010 13:14:38 -0700
Message-ID: <1284408880-14414-4-git-send-email-hpa@linux.intel.com>
References: <1284408880-14414-1-git-send-email-hpa@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1284408880-14414-1-git-send-email-hpa@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Russell King <linux@arm.linux.org.uk>, Mike Frysinger <vapier@gentoo.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, "H. Peter Anvin" <hpa@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

We no longer support gcc 3.x, so remove the workaround for it.

Signed-off-by: H. Peter Anvin <hpa@linux.intel.com>
---
 arch/x86/include/asm/cpufeature.h |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 781a50b..830a94f 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -345,7 +345,6 @@ static __always_inline __pure bool __static_cpu_has(u16 bit)
 #endif
 }
 
-#if __GNUC__ >= 4
 #define static_cpu_has(bit)					\
 (								\
 	__builtin_constant_p(boot_cpu_has(bit)) ?		\
@@ -354,12 +353,6 @@ static __always_inline __pure bool __static_cpu_has(u16 bit)
 		__static_cpu_has(bit) :				\
 		boot_cpu_has(bit)				\
 )
-#else
-/*
- * gcc 3.x is too stupid to do the static test; fall back to dynamic.
- */
-#define static_cpu_has(bit) boot_cpu_has(bit)
-#endif
 
 #endif /* defined(__KERNEL__) && !defined(__ASSEMBLY__) */
 
-- 
1.7.2.1
