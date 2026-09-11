Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1854AE130;
	Fri, 11 Sep 2026 19:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154759; cv=none; b=k/VJ8BUut5IO2AQb93JLerrpoWyMnsb6epaWWWMElGGZLtUjP96i2nPdajX6uBIDN7NTiyvYBHKoKCd7+B6TqIRCT+kuJGfC19ctTYW19RSfVhbyMKAig9qDKVAWf5MsJahJQ3rsDwk87f/hPvcfdQmTnfoxqGCn+4KRmBOUm2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154759; c=relaxed/simple;
	bh=PCyYoxWXg7sOin+tmY8Fbun+nm8rOPLv4vut1yRslEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnIxBpoY0ci6vd+yaWRFTYsL/WOjSbnXBs+r6OBlxgzR7twpg/oCNY+DGg9WykMnzQB8OIGM6e/KeN774Yes7jABwJ/nYerHndtx0Cz/7p2KpG7RKCOxVjS9C5MPr3Cwtq2HqGkHSNv/fAc18bHQ6mhCnNiwHyafyxXARCGKrQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.helo=mail.mainlining.org; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.helo=mail.mainlining.org
From: Bradley Morgan <brads@mainlining.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	boqun@kernel.org,
	joelagnelf@nvidia.com,
	rcu@vger.kernel.org,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Arnd Bergmann" <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	"Vineet Gupta" <vgupta@kernel.org>,
	linux-snps-arc@lists.infradead.org,
	"Russell King" <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	"Guo Ren" <guoren@kernel.org>,
	linux-csky@vger.kernel.org,
	"Yoshinori Sato" <ysato@users.sourceforge.jp>,
	"Rich Felker" <dalias@libc.org>,
	"John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org,
	"Chris Zankel" <chris@zankel.net>,
	"Max Filippov" <jcmvbkbc@gmail.com>,
	linux-kernel@vger.kernel.org,
	brads@mainlining.org
Subject: [PATCH 1/6] lib: Add two-byte cmpxchg emulation function
Date: Fri, 11 Sep 2026 19:25:34 +0000
Message-ID: <20260911192540.20983-2-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911192540.20983-1-brads@mainlining.org>
References: <20260911192540.20983-1-brads@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cmpxchg_emu_u8() emulates one-byte cmpxchg() in terms of four-byte
cmpxchg() for the architectures lacking native one-byte atomics.
The same architectures also lack native two-byte cmpxchg(), where
such an operation is not supported and either fails to compile via
BUILD_BUG() or fails to link, because the bad pointer sentinels
these architectures declare are never defined.

Add cmpxchg_emu_u16(), the two-byte sibling. It reads the enclosing
word with READ_ONCE(), splices the two target bytes through a union
and loops on cmpxchg() of the full word until the compare succeeds.
Like cmpxchg_emu_u8() it is fully ordered.

The Kconfig symbol gating this file is renamed from
ARCH_NEED_CMPXCHG_1_EMU to ARCH_NEED_CMPXCHG_1_2_EMU, as it now
selects both the one-byte and the two-byte emulation.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/Kconfig                |  2 +-
 arch/arc/Kconfig            |  2 +-
 arch/arm/Kconfig            |  2 +-
 arch/csky/Kconfig           |  2 +-
 arch/sh/Kconfig             |  2 +-
 arch/xtensa/Kconfig         |  2 +-
 include/linux/cmpxchg-emu.h |  1 +
 lib/Makefile                |  2 +-
 lib/cmpxchg-emu.c           | 35 ++++++++++++++++++++++++++++++++---
 9 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 3bb2e568f5b1..d56064797e09 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1817,7 +1817,7 @@ config CC_HAS_SANE_FUNCTION_ALIGNMENT
 	# strict alignment always, even with -falign-functions.
 	def_bool CC_HAS_MIN_FUNCTION_ALIGNMENT || CC_IS_CLANG
 
-config ARCH_NEED_CMPXCHG_1_EMU
+config ARCH_NEED_CMPXCHG_1_2_EMU
 	bool
 
 config ARCH_WANTS_PRE_LINK_VMLINUX
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 80e61175bf52..0e91d254eccb 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -14,7 +14,7 @@ config ARC
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
-	select ARCH_NEED_CMPXCHG_1_EMU
+	select ARCH_NEED_CMPXCHG_1_2_EMU
 	select ARCH_SUPPORTS_ATOMIC_RMW if ARC_HAS_LLSC
 	select ARCH_32BIT_OFF_T
 	select BUILDTIME_TABLE_SORT
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 408aa58a2a5b..8fef4238d411 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -38,7 +38,7 @@ config ARM
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT if CPU_V7
-	select ARCH_NEED_CMPXCHG_1_EMU if CPU_V6
+	select ARCH_NEED_CMPXCHG_1_2_EMU if CPU_V6
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_CFI
 	select ARCH_SUPPORTS_HUGETLBFS if ARM_LPAE
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 4331313a42ff..5f26e8615d7d 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -37,7 +37,7 @@ config CSKY
 	select ARCH_INLINE_SPIN_UNLOCK_BH if !PREEMPTION
 	select ARCH_INLINE_SPIN_UNLOCK_IRQ if !PREEMPTION
 	select ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE if !PREEMPTION
-	select ARCH_NEED_CMPXCHG_1_EMU
+	select ARCH_NEED_CMPXCHG_1_2_EMU
 	select ARCH_WANT_FRAME_POINTERS if !CPU_CK610 && $(cc-option,-mbacktrace)
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	select COMMON_CLK
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index d60f1d5a94c0..09e556fced01 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -14,7 +14,7 @@ config SUPERH
 	select ARCH_HIBERNATION_POSSIBLE if MMU
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_WANT_IPC_PARSE_VERSION
-	select ARCH_NEED_CMPXCHG_1_EMU
+	select ARCH_NEED_CMPXCHG_1_2_EMU
 	select CPU_NO_EFFICIENT_FFS
 	select DMA_DECLARE_COHERENT
 	select GENERIC_ATOMIC64
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index f2f9cd9cde50..62019fd444d4 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -14,7 +14,7 @@ config XTENSA
 	select ARCH_HAS_DMA_SET_UNCACHED if MMU
 	select ARCH_HAS_STRNCPY_FROM_USER if !KASAN
 	select ARCH_HAS_STRNLEN_USER
-	select ARCH_NEED_CMPXCHG_1_EMU
+	select ARCH_NEED_CMPXCHG_1_2_EMU
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
diff --git a/include/linux/cmpxchg-emu.h b/include/linux/cmpxchg-emu.h
index 998deec67740..fee8171fa05e 100644
--- a/include/linux/cmpxchg-emu.h
+++ b/include/linux/cmpxchg-emu.h
@@ -11,5 +11,6 @@
 #define __LINUX_CMPXCHG_EMU_H
 
 uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new);
+uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new);
 
 #endif /* __LINUX_CMPXCHG_EMU_H */
diff --git a/lib/Makefile b/lib/Makefile
index 43421c39d21b..d0e69312176a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -202,7 +202,7 @@ obj-$(CONFIG_CODE_TAGGING) += codetag.o
 lib-$(CONFIG_GENERIC_BUG) += bug.o
 
 obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
-obj-$(CONFIG_ARCH_NEED_CMPXCHG_1_EMU) += cmpxchg-emu.o
+obj-$(CONFIG_ARCH_NEED_CMPXCHG_1_2_EMU) += cmpxchg-emu.o
 
 obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
 #ensure exported functions have prototypes
diff --git a/lib/cmpxchg-emu.c b/lib/cmpxchg-emu.c
index 27f6f97cb60d..991a5969f471 100644
--- a/lib/cmpxchg-emu.c
+++ b/lib/cmpxchg-emu.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Emulated 1-byte cmpxchg operation for architectures lacking direct
- * support for this size.  This is implemented in terms of 4-byte cmpxchg
- * operations.
+ * Emulated 1-byte and 2-byte cmpxchg operations for architectures lacking
+ * direct support for these sizes.  These are implemented in terms of
+ * 4-byte cmpxchg operations.
  *
  * Copyright (C) 2024 Paul E. McKenney.
  */
@@ -43,3 +43,32 @@ uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
 	return old;
 }
 EXPORT_SYMBOL_GPL(cmpxchg_emu_u8);
+
+union u16_32 {
+	u16 h[2];
+	u32 w;
+};
+
+/* Emulate two-byte cmpxchg() in terms of 4-byte cmpxchg. */
+uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new)
+{
+	u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x3);
+	int i = (((uintptr_t)p) & 0x2) / 2;
+	union u16_32 old32;
+	union u16_32 new32;
+	u32 ret;
+
+	WARN_ON_ONCE(((uintptr_t)p) & 0x1);
+	ret = READ_ONCE(*p32);
+	do {
+		old32.w = ret;
+		if (old32.h[i] != old)
+			return old32.h[i];
+		new32.w = old32.w;
+		new32.h[i] = new;
+		instrument_atomic_read_write(p, 2);
+		ret = data_race(cmpxchg(p32, old32.w, new32.w)); // Overridden above.
+	} while (ret != old32.w);
+	return old;
+}
+EXPORT_SYMBOL_GPL(cmpxchg_emu_u16);
-- 
2.47.3

