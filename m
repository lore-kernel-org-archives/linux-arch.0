Received: from mta1.migadu.com (out-63.mta1.migadu.com [95.215.58.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7000535200A
	for <linux-arch@vger.kernel.org>; Sun, 20 Sep 2026 01:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789868657; cv=none; b=H1ZFDZNXCzdQeEJaSCR7RDR3xKNRZX3Le2R0kiK5mTfpdUD2BiFBC64CmnEffpzl6CAjBwiDCdgpsJRl2Tbx3YYwRWIG2UeujgIPm7HpWnDZn0cI0oZEm5sfUyJ9bdRU25nBiCerejgbFG2CZx47wwNwZD8R+Lzlu/6wXEsOhNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789868657; c=relaxed/simple;
	bh=uhFrnOJQrVcts7+mbJYO8uPHkN/h18B5/Sljmky4Xtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nk+KpiyTIDewALYsupmj5DlqBLF2HJFIUby29GPru1n/tGS64jputO7IiyI9NRZndM1BZDxnult+wDHKIKQaAF22UGLJibsAXJUFXXjdZKkTtq+AWbAuQgB3i4rMR8QpFQkjBW+w6LrYk31alSaeQTdqwNJ2oVv41NvhtkVpcX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=thC3MB5F; arc=none smtp.client-ip=95.215.58.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="thC3MB5F"
X-Envelope-To: linux-arch@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uhFrnOJQrVcts7+mbJYO8uPHkN/h18B5/Sljmky4Xtw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789868653; v=1; x=1790473453;
 b=thC3MB5FexUQeXCx24/aOCBMWfBAk6ZXzPtDtB3ZhFRnbSFE17wMC2A8Lp20gmKwpmmLj750
 AL8hQtOL1H67KF5vFmA52/qzzFiWtT4/u/FFInoM8TH78fbGwbOqcj4Sog1lh4G7rIRHN1ZDqf8
 LRusZ7hG4dcimMwakUyFhXDk=
X-Envelope-To: linux-arch@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6661032fce2597bd;
	Sun, 20 Sep 2026 01:44:13 +0000
X-Mizu-Trace-ID: 6661032fce2597bd
X-Migadu-Flow: FLOW_OUT
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Vikram Sethi <vsethi@nvidia.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: use generic MMIO accessors
Date: Sun, 20 Sep 2026 09:43:51 +0800
Message-ID: <20260920014357.7069-3-qingfang.deng@linux.dev>
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

Use the generic raw write accessors in place of the inline assembly
stores. Include asm-generic/mmio.h after the arm64 ordering hooks so
these accessors are also available to the write-combining helpers
before asm-generic/io.h is included.

Retain the raw read overrides when either the Cortex-A57 erratum 832075
or NVIDIA Olympus erratum 1027 workaround is configured. This preserves
the alternative-patched load-acquire instructions and pre-load barriers.
Use generic raw reads when neither workaround is enabled.

Assisted-by: Codex:gpt-6-astra
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
v2: new patch
---
 arch/arm64/include/asm/io.h | 37 ++++++-------------------------------
 1 file changed, 6 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 49a7002661a9..2fdac25bc31b 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -19,37 +19,9 @@
 #include <asm/cpufeature.h>
 #include <asm/rsi.h>
 
-/*
- * Generic IO read/write.  These perform native-endian accesses.
- */
-#define __raw_writeb __raw_writeb
-static __always_inline void __raw_writeb(u8 val, volatile void __iomem *addr)
-{
-	volatile u8 __iomem *ptr = addr;
-	asm volatile("strb %w0, %1" : : "rZ" (val), "Qo" (*ptr));
-}
-
-#define __raw_writew __raw_writew
-static __always_inline void __raw_writew(u16 val, volatile void __iomem *addr)
-{
-	volatile u16 __iomem *ptr = addr;
-	asm volatile("strh %w0, %1" : : "rZ" (val), "Qo" (*ptr));
-}
-
-#define __raw_writel __raw_writel
-static __always_inline void __raw_writel(u32 val, volatile void __iomem *addr)
-{
-	volatile u32 __iomem *ptr = addr;
-	asm volatile("str %w0, %1" : : "rZ" (val), "Qo" (*ptr));
-}
-
-#define __raw_writeq __raw_writeq
-static __always_inline void __raw_writeq(u64 val, volatile void __iomem *addr)
-{
-	volatile u64 __iomem *ptr = addr;
-	asm volatile("str %x0, %1" : : "rZ" (val), "Qo" (*ptr));
-}
-
+#if defined(CONFIG_ARM64_ERRATUM_832075) || \
+	defined(CONFIG_NVIDIA_OLYMPUS_1027_ERRATUM)
+/* Keep the raw read overrides for the device-load erratum alternatives. */
 #define __raw_readb __raw_readb
 static __always_inline u8 __raw_readb(const volatile void __iomem *addr)
 {
@@ -102,6 +74,7 @@ static __always_inline u64 __raw_readq(const volatile void __iomem *addr)
 		     : "=r" (val) : "r" (addr));
 	return val;
 }
+#endif
 
 /* IO barriers */
 #define __io_ar(v)							\
@@ -125,6 +98,8 @@ static __always_inline u64 __raw_readq(const volatile void __iomem *addr)
 #define __io_br(v)
 #define __io_aw(v)
 
+#include <asm-generic/mmio.h>
+
 /* arm64-specific, don't use in portable drivers */
 #define __iormb(v)		__io_ar(v)
 #define __iowmb()		__io_bw()
-- 
2.43.0

