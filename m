Return-Path: <SRS0=kGHj=6H=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:43648 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727860AbgDWN7j (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Apr 2020 09:59:39 -0400
From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: [PATCH v2 2/6] arm64: Add level-hinted TLB invalidation helper
Date: Thu, 23 Apr 2020 21:56:52 +0800
Message-ID: <20200423135656.2712-3-yezhenyu2@huawei.com>
In-Reply-To: <20200423135656.2712-1-yezhenyu2@huawei.com>
References: <20200423135656.2712-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org, mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com
Cc: yezhenyu2@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
Message-ID: <20200423135652.OBKjIdnCL95_ddZySETYRyrBI3EkTmBRKqknx5w8Fkw@z>

From: Marc Zyngier <maz@kernel.org>

Add a level-hinted TLB invalidation helper that only gets used if
ARMv8.4-TTL gets detected.

When ARMv8.4-TTL is implemented, the operand for TLBIs looks like
below:

* +----------+-------+----------------------+
* |   ASID   |  TTL  |        BADDR         |
* +----------+-------+----------------------+
* |63      48|47   44|43                   0|

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 arch/arm64/include/asm/tlbflush.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index bc3949064725..5f9f189bc6d2 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -10,6 +10,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/bitfield.h>
 #include <linux/mm_types.h>
 #include <linux/sched.h>
 #include <asm/cputype.h>
@@ -59,6 +60,35 @@
 		__ta;						\
 	})
 
+#define TLBI_TTL_MASK	GENMASK_ULL(47, 44)
+
+#define __tlbi_level(op, addr, level)					\
+	do {								\
+		u64 arg = addr;						\
+									\
+		if (cpus_have_const_cap(ARM64_HAS_ARMv8_4_TTL) &&	\
+		    level) {						\
+			u64 ttl = level;				\
+									\
+			switch (PAGE_SIZE) {				\
+			case SZ_4K:					\
+				ttl |= 1 << 2;				\
+				break;					\
+			case SZ_16K:					\
+				ttl |= 2 << 2;				\
+				break;					\
+			case SZ_64K:					\
+				ttl |= 3 << 2;				\
+				break;					\
+			}						\
+									\
+			arg &= ~TLBI_TTL_MASK;				\
+			arg |= FIELD_PREP(TLBI_TTL_MASK, ttl);		\
+		}							\
+									\
+		__tlbi(op,  arg);					\
+	} while (0)
+
 /*
  *	TLB Invalidation
  *	================
-- 
2.19.1
