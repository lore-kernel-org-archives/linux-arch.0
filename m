From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V6 31/33] csky: fix compile error in linux/bug.h with SMP enabled
Date: Fri, 28 Sep 2018 08:51:28 +0800
Message-ID: <0b20e1e62b23f9963020423e7e9c5ce833313fcc.1538058840.git.ren_guo@c-sky.com>
References: <62098e7d0a7fbdd09f44d7e23333dad258a01bd2.1538058840.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <62098e7d0a7fbdd09f44d7e23333dad258a01bd2.1538058840.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1538058840.git.ren_guo@c-sky.com>
References: <cover.1538058840.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

In linux-4.19 we couldn't include linux/bug.h here when SMP enabled.
It'll cause compile error for bad include.

In file included from ./arch/csky/include/asm/bitops.h:70:0,
                 from ./include/linux/bitops.h:19,
                 from ./include/linux/kernel.h:11,
                 from ./include/asm-generic/bug.h:18,
                 from ./arch/csky/include/asm/bug.h:19,
                 from ./include/linux/bug.h:5,
                 from ./arch/csky/include/asm/cmpxchg.h:6,
                 from ./arch/csky/include/asm/atomic.h:8,
                 from ./include/linux/atomic.h:7,
                 from ./include/linux/rcupdate.h:38,
                 from ./include/linux/init_task.h:5,
                 from init/init_task.c:2:

The asm/bitops.h will lose asm/atomic.h for cycle include.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/cmpxchg.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/csky/include/asm/cmpxchg.h b/arch/csky/include/asm/cmpxchg.h
index 9b63dd7..ad53006 100644
--- a/arch/csky/include/asm/cmpxchg.h
+++ b/arch/csky/include/asm/cmpxchg.h
@@ -2,9 +2,10 @@
 #define __ASM_CSKY_CMPXCHG_H
 
 #ifdef CONFIG_CPU_HAS_LDSTEX
-#include <linux/bug.h>
 #include <asm/barrier.h>
 
+extern void __bad_xchg(volatile void *ptr, int size);
+
 #define __xchg(new, ptr, size)					\
 ({								\
 	__typeof__(ptr) __ptr = (ptr);				\
@@ -25,7 +26,7 @@
 		smp_mb();					\
 		break;						\
 	default:						\
-		BUILD_BUG();					\
+		__bad_xchg(ptr, size), __ret = 0;		\
 	}							\
 	__ret;							\
 })
@@ -56,7 +57,7 @@
 		smp_mb();					\
 		break;						\
 	default:						\
-		BUILD_BUG();					\
+		__bad_xchg(ptr, size), __ret = 0;		\
 	}							\
 	__ret;							\
 })
-- 
2.7.4
