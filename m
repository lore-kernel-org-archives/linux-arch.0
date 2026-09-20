Received: from mta0.migadu.com (out-18.mta0.migadu.com [91.218.175.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096B6352037
	for <linux-arch@vger.kernel.org>; Sun, 20 Sep 2026 01:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789868651; cv=none; b=Dkwh5sNWgRz0okpdHN1tyA264upEqLlfWBN+c+DHIwNZNyQhffNoNyDJq3VbMMTNl8rMHYbtfjAi9l94aqWC4vTwKz4Mi6TrnzI+C42wGijIU5ggFmY4nTWJiHLP91yV+pUH6XTo8+zc6Qkx07bCL3ZGt5e/HrJv474xoF3mG00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789868651; c=relaxed/simple;
	bh=hMzUJFmtAt/DEQg8/nIuJR2E2yIQzqBmNStsr9v2FW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qs0AWHbeTInpkbqFD7FeLQAXUuodf3QV71Y37Tt6XfY09nYJdxw9tWxQsinsKAqZkSeOYF5MOnoLp8o7muZRwWlvrcCY+PseVvRwVNPRLKlnfanKKJVjEhjNmD6nHj85lSxoGAu9G+YHDgal6Vqw0grn4hp4RwBkbSS8kWroGTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fVW8QFVc; arc=none smtp.client-ip=91.218.175.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fVW8QFVc"
X-Envelope-To: linux-arch@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hMzUJFmtAt/DEQg8/nIuJR2E2yIQzqBmNStsr9v2FW0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789868647; v=1; x=1790473447;
 b=fVW8QFVcpcjx1uT9H2pAlIY7rSGcd+kEWp4902AMYYthYtG+Jvvy8yuXeSmOWgAHPnfb66z1
 j120FZXbLfuUf3j4nXzTpPh6YBNhTrpylCQJ4b8ptmA/JPPZZAdgTTbx6G72Vlgcx+1bCSGVpkI
 U219+tJIVacGcmAX32zN2wjQ=
X-Envelope-To: linux-arch@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1c465c973ef91055;
	Sun, 20 Sep 2026 01:44:07 +0000
X-Mizu-Trace-ID: 1c465c973ef91055
X-Migadu-Flow: FLOW_OUT
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Subject: [PATCH v2 2/3] riscv: use generic MMIO accessors
Date: Sun, 20 Sep 2026 09:43:50 +0800
Message-ID: <20260920014357.7069-2-qingfang.deng@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260920014357.7069-1-qingfang.deng@linux.dev>
References: <20260920014357.7069-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V implements its raw MMIO loads and stores in inline assembly and
duplicates the generic ordered and relaxed accessors.

Use asm-generic/mmio.h for these accessors and retain the RISC-V barrier
hooks. This preserves the ordering and MMIOWB tracking while allowing
the compiler to emit the native-width loads and stores.

Assisted-by: Codex:gpt-6-astra
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
v2: split asm-generic/io.h to fix M-mode build

v1: https://lore.kernel.org/linux-riscv/20250530032252.3092502-1-dqfext@gmail.com/
---
 arch/riscv/include/asm/mmio.h | 123 +---------------------------------
 1 file changed, 3 insertions(+), 120 deletions(-)

diff --git a/arch/riscv/include/asm/mmio.h b/arch/riscv/include/asm/mmio.h
index 06cadfd7a237..715470551c42 100644
--- a/arch/riscv/include/asm/mmio.h
+++ b/arch/riscv/include/asm/mmio.h
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * {read,write}{b,w,l,q} based on arch/arm64/include/asm/io.h
- *   which was based on arch/arm/include/io.h
+ * RISC-V memory-mapped I/O ordering.
  *
  * Copyright (C) 1996-2000 Russell King
  * Copyright (C) 2012 ARM Ltd.
@@ -11,92 +10,7 @@
 #ifndef _ASM_RISCV_MMIO_H
 #define _ASM_RISCV_MMIO_H
 
-#include <linux/types.h>
 #include <asm/fence.h>
-#include <asm/mmiowb.h>
-
-/* Generic IO read/write.  These perform native-endian accesses. */
-#define __raw_writeb __raw_writeb
-static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
-{
-	asm volatile("sb %0, 0(%1)" : : "r" (val), "r" (addr));
-}
-
-#define __raw_writew __raw_writew
-static inline void __raw_writew(u16 val, volatile void __iomem *addr)
-{
-	asm volatile("sh %0, 0(%1)" : : "r" (val), "r" (addr));
-}
-
-#define __raw_writel __raw_writel
-static inline void __raw_writel(u32 val, volatile void __iomem *addr)
-{
-	asm volatile("sw %0, 0(%1)" : : "r" (val), "r" (addr));
-}
-
-#ifdef CONFIG_64BIT
-#define __raw_writeq __raw_writeq
-static inline void __raw_writeq(u64 val, volatile void __iomem *addr)
-{
-	asm volatile("sd %0, 0(%1)" : : "r" (val), "r" (addr));
-}
-#endif
-
-#define __raw_readb __raw_readb
-static inline u8 __raw_readb(const volatile void __iomem *addr)
-{
-	u8 val;
-
-	asm volatile("lb %0, 0(%1)" : "=r" (val) : "r" (addr));
-	return val;
-}
-
-#define __raw_readw __raw_readw
-static inline u16 __raw_readw(const volatile void __iomem *addr)
-{
-	u16 val;
-
-	asm volatile("lh %0, 0(%1)" : "=r" (val) : "r" (addr));
-	return val;
-}
-
-#define __raw_readl __raw_readl
-static inline u32 __raw_readl(const volatile void __iomem *addr)
-{
-	u32 val;
-
-	asm volatile("lw %0, 0(%1)" : "=r" (val) : "r" (addr));
-	return val;
-}
-
-#ifdef CONFIG_64BIT
-#define __raw_readq __raw_readq
-static inline u64 __raw_readq(const volatile void __iomem *addr)
-{
-	u64 val;
-
-	asm volatile("ld %0, 0(%1)" : "=r" (val) : "r" (addr));
-	return val;
-}
-#endif
-
-/*
- * Unordered I/O memory access primitives.  These are even more relaxed than
- * the relaxed versions, as they don't even order accesses between successive
- * operations to the I/O regions.
- */
-#define readb_cpu(c)		({ u8  __r = __raw_readb(c); __r; })
-#define readw_cpu(c)		({ u16 __r = le16_to_cpu((__force __le16)__raw_readw(c)); __r; })
-#define readl_cpu(c)		({ u32 __r = le32_to_cpu((__force __le32)__raw_readl(c)); __r; })
-
-#define writeb_cpu(v, c)	((void)__raw_writeb((v), (c)))
-#define writew_cpu(v, c)	((void)__raw_writew((__force u16)cpu_to_le16(v), (c)))
-#define writel_cpu(v, c)	((void)__raw_writel((__force u32)cpu_to_le32(v), (c)))
-
-#ifdef CONFIG_64BIT
-#define readq_cpu(c)		({ u64 __r = le64_to_cpu((__force __le64)__raw_readq(c)); __r; })
-#define writeq_cpu(v, c)	((void)__raw_writeq((__force u64)cpu_to_le64(v), (c)))
-#endif
 
 /*
  * Relaxed I/O memory access primitives. These follow the Device memory
@@ -105,27 +19,7 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
  * write) with all other I/O memory accesses to the same peripheral. Since the
  * platform specification defines that all I/O regions are strongly ordered on
  * channel 0, no explicit fences are required to enforce this ordering.
- */
-/* FIXME: These are now the same as asm-generic */
-#define __io_rbr()		do {} while (0)
-#define __io_rar()		do {} while (0)
-#define __io_rbw()		do {} while (0)
-#define __io_raw()		do {} while (0)
-
-#define readb_relaxed(c)	({ u8  __v; __io_rbr(); __v = readb_cpu(c); __io_rar(); __v; })
-#define readw_relaxed(c)	({ u16 __v; __io_rbr(); __v = readw_cpu(c); __io_rar(); __v; })
-#define readl_relaxed(c)	({ u32 __v; __io_rbr(); __v = readl_cpu(c); __io_rar(); __v; })
-
-#define writeb_relaxed(v, c)	({ __io_rbw(); writeb_cpu((v), (c)); __io_raw(); })
-#define writew_relaxed(v, c)	({ __io_rbw(); writew_cpu((v), (c)); __io_raw(); })
-#define writel_relaxed(v, c)	({ __io_rbw(); writel_cpu((v), (c)); __io_raw(); })
-
-#ifdef CONFIG_64BIT
-#define readq_relaxed(c)	({ u64 __v; __io_rbr(); __v = readq_cpu(c); __io_rar(); __v; })
-#define writeq_relaxed(v, c)	({ __io_rbw(); writeq_cpu((v), (c)); __io_raw(); })
-#endif
-
-/*
+ *
  * I/O memory access primitives.  Reads are ordered relative to any following
  * Normal memory read and delay() loop.  Writes are ordered relative to any
  * prior Normal memory write.  The memory barriers here are necessary as RISC-V
@@ -136,17 +30,6 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 #define __io_bw()	RISCV_FENCE(w, o)
 #define __io_aw()	mmiowb_set_pending()
 
-#define readb(c)	({ u8  __v; __io_br(); __v = readb_cpu(c); __io_ar(__v); __v; })
-#define readw(c)	({ u16 __v; __io_br(); __v = readw_cpu(c); __io_ar(__v); __v; })
-#define readl(c)	({ u32 __v; __io_br(); __v = readl_cpu(c); __io_ar(__v); __v; })
-
-#define writeb(v, c)	({ __io_bw(); writeb_cpu((v), (c)); __io_aw(); })
-#define writew(v, c)	({ __io_bw(); writew_cpu((v), (c)); __io_aw(); })
-#define writel(v, c)	({ __io_bw(); writel_cpu((v), (c)); __io_aw(); })
-
-#ifdef CONFIG_64BIT
-#define readq(c)	({ u64 __v; __io_br(); __v = readq_cpu(c); __io_ar(__v); __v; })
-#define writeq(v, c)	({ __io_bw(); writeq_cpu((v), (c)); __io_aw(); })
-#endif
+#include <asm-generic/mmio.h>
 
 #endif /* _ASM_RISCV_MMIO_H */
-- 
2.43.0

