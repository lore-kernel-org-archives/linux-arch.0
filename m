From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: [PATCH v3 2/6] arm64: Add level-hinted TLB invalidation helper
Date: Mon, 25 May 2020 20:52:56 +0800
Message-ID: <20200525125300.794-3-yezhenyu2@huawei.com>
References: <20200525125300.794-1-yezhenyu2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200525125300.794-1-yezhenyu2@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: catalin.marinas@arm.com, peterz@infradead.org, mark.rutland@arm.com, will@kernel.org, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com
Cc: yezhenyu2@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
List-Id: linux-arch.vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

Add a level-hinted TLB invalidation helper that only gets used if
ARMv8.4-TTL gets detected.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/tlbflush.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index bc3949064725..8adbd6fd8489 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -10,6 +10,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/bitfield.h>
 #include <linux/mm_types.h>
 #include <linux/sched.h>
 #include <asm/cputype.h>
@@ -59,6 +60,34 @@
 		__ta;						\
 	})
 
+#define TLBI_TTL_MASK	GENMASK_ULL(47, 44)
+
+#define __tlbi_level(op, addr, level) do {			\
+	u64 arg = addr;						\
+								\
+	if (cpus_have_const_cap(ARM64_HAS_ARMv8_4_TTL) &&	\
+	    level) {						\
+		u64 ttl = level;				\
+								\
+		switch (PAGE_SIZE) {				\
+		case SZ_4K:					\
+			ttl |= 1 << 2;				\
+			break;					\
+		case SZ_16K:					\
+			ttl |= 2 << 2;				\
+			break;					\
+		case SZ_64K:					\
+			ttl |= 3 << 2;				\
+			break;					\
+		}						\
+								\
+		arg &= ~TLBI_TTL_MASK;				\
+		arg |= FIELD_PREP(TLBI_TTL_MASK, ttl);		\
+	}							\
+								\
+	__tlbi(op,  arg);					\
+} while (0)
+
 /*
  *	TLB Invalidation
  *	================
-- 
2.19.1
