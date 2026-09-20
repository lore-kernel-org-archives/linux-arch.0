Received: from mta1.migadu.com (out-52.mta1.migadu.com [95.215.58.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6013515D6
	for <linux-arch@vger.kernel.org>; Sun, 20 Sep 2026 01:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789868648; cv=none; b=Pi8DdSyCYRnNT2N/hk7Hv4pbeumwgCe8Etr52BQsw7GCqWunlGg4fE0Ed7USLtd+CRvGhrobYIZ0hEk275809uKVsTBivJYNEomLEVASXN/l9Qp4rSBVuGG9NeBmW3G4qadckFYRd2c5VvmbqMuIRuFzJy4dXZcvCWGPPPpvm+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789868648; c=relaxed/simple;
	bh=E/sHQy6mL06lwRwR7QNcYotaMnIbA+rEDHBpY+FOTLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QFKycc4UNtG1jeai9Ey3Va5YIrQzVhDczcXt8UzZEYiz9p/sg553JhMazDAkhAnWQgCid2PHZYMsuoMpPq2lT0u764JATu3hQaV8lGauoKxzl5Xvf+qC5XrMqeJbWegKeAZwcegjgw6lhztzM3ohB23GnHn6KVfm/FjZorJD8fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JcHP6bZv; arc=none smtp.client-ip=95.215.58.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JcHP6bZv"
X-Envelope-To: linux-arch@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=E/sHQy6mL06lwRwR7QNcYotaMnIbA+rEDHBpY+FOTLg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789868642; v=1; x=1790473442;
 b=JcHP6bZvNcaWb7qpeHQKKw0fJuRWCUZuBX9jLIFEmk+wIOm88wkc2uazyexiXbBog3kOdDu6
 0o0Gwa+jV2o8S3S/ZwJW+uvcYTc+JyGN4WHewf7Jy6VeN76vjS3Ew7HCsded9Z2qK1C1jxy8z9e
 qU6vvFHc/UPXa7RA/rlsJPxo=
X-Envelope-To: linux-arch@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id cb2278283f0f2d30;
	Sun, 20 Sep 2026 01:44:02 +0000
X-Mizu-Trace-ID: cb2278283f0f2d30
X-Migadu-Flow: FLOW_OUT
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: Qingfang Deng <qingfang.deng@linux.dev>
Subject: [PATCH v2 1/3] asm-generic: split MMIO accessors out of io.h
Date: Sun, 20 Sep 2026 09:43:49 +0800
Message-ID: <20260920014357.7069-1-qingfang.deng@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Low-level architecture headers can need MMIO accessors without the page
and I/O mapping dependencies pulled in by asm-generic/io.h. RISC-V keeps
a separate MMIO header for this reason, including for M-mode timer reads.

Move the raw, ordered and relaxed scalar accessors, their barrier hooks
and MMIO tracing support into asm-generic/mmio.h. Include the new header
from asm-generic/io.h and provide the byte-order and MMIOWB dependencies
needed when it is included directly.

Assisted-by: Codex:gpt-6-astra
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
v2: new patch
---
 include/asm-generic/io.h   | 393 +----------------------------------
 include/asm-generic/mmio.h | 407 +++++++++++++++++++++++++++++++++++++
 2 files changed, 408 insertions(+), 392 deletions(-)
 create mode 100644 include/asm-generic/mmio.h

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index ca5a1ce6f0f8..f6244e649db1 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -11,42 +11,14 @@
 #include <linux/string.h> /* for memset() and memcpy() */
 #include <linux/sizes.h>
 #include <linux/types.h>
-#include <linux/instruction_pointer.h>
 
 #ifdef CONFIG_GENERIC_IOMAP
 #include <asm-generic/iomap.h>
 #endif
 
-#include <asm/mmiowb.h>
+#include <asm-generic/mmio.h>
 #include <asm-generic/pci_iomap.h>
 
-#ifndef __io_br
-#define __io_br()      barrier()
-#endif
-
-/* prevent prefetching of coherent DMA data ahead of a dma-complete */
-#ifndef __io_ar
-#ifdef rmb
-#define __io_ar(v)      rmb()
-#else
-#define __io_ar(v)      barrier()
-#endif
-#endif
-
-/* flush writes to coherent DMA data before possibly triggering a DMA read */
-#ifndef __io_bw
-#ifdef wmb
-#define __io_bw()      wmb()
-#else
-#define __io_bw()      barrier()
-#endif
-#endif
-
-/* serialize device access against a spin_unlock, usually handled there. */
-#ifndef __io_aw
-#define __io_aw()      mmiowb_set_pending()
-#endif
-
 #ifndef __io_pbw
 #define __io_pbw()     __io_bw()
 #endif
@@ -63,369 +35,6 @@
 #define __io_par(v)     __io_ar(v)
 #endif
 
-/*
- * "__DISABLE_TRACE_MMIO__" flag can be used to disable MMIO tracing for
- * specific kernel drivers in case of excessive/unwanted logging.
- *
- * Usage: Add a #define flag at the beginning of the driver file.
- * Ex: #define __DISABLE_TRACE_MMIO__
- *     #include <...>
- *     ...
- */
-#if IS_ENABLED(CONFIG_TRACE_MMIO_ACCESS) && !(defined(__DISABLE_TRACE_MMIO__))
-#include <linux/tracepoint-defs.h>
-
-#define rwmmio_tracepoint_enabled(tracepoint) tracepoint_enabled(tracepoint)
-DECLARE_TRACEPOINT(rwmmio_write);
-DECLARE_TRACEPOINT(rwmmio_post_write);
-DECLARE_TRACEPOINT(rwmmio_read);
-DECLARE_TRACEPOINT(rwmmio_post_read);
-
-void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
-		    unsigned long caller_addr, unsigned long caller_addr0);
-void log_post_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
-			 unsigned long caller_addr, unsigned long caller_addr0);
-void log_read_mmio(u8 width, const volatile void __iomem *addr,
-		   unsigned long caller_addr, unsigned long caller_addr0);
-void log_post_read_mmio(u64 val, u8 width, const volatile void __iomem *addr,
-			unsigned long caller_addr, unsigned long caller_addr0);
-
-#else
-
-#define rwmmio_tracepoint_enabled(tracepoint) false
-static inline void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
-				  unsigned long caller_addr, unsigned long caller_addr0) {}
-static inline void log_post_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
-				       unsigned long caller_addr, unsigned long caller_addr0) {}
-static inline void log_read_mmio(u8 width, const volatile void __iomem *addr,
-				 unsigned long caller_addr, unsigned long caller_addr0) {}
-static inline void log_post_read_mmio(u64 val, u8 width, const volatile void __iomem *addr,
-				      unsigned long caller_addr, unsigned long caller_addr0) {}
-
-#endif /* CONFIG_TRACE_MMIO_ACCESS */
-
-/*
- * __raw_{read,write}{b,w,l,q}() access memory in native endianness.
- *
- * On some architectures memory mapped IO needs to be accessed differently.
- * On the simple architectures, we just read/write the memory location
- * directly.
- */
-
-#ifndef __raw_readb
-#define __raw_readb __raw_readb
-static inline u8 __raw_readb(const volatile void __iomem *addr)
-{
-	return *(const volatile u8 __force *)addr;
-}
-#endif
-
-#ifndef __raw_readw
-#define __raw_readw __raw_readw
-static inline u16 __raw_readw(const volatile void __iomem *addr)
-{
-	return *(const volatile u16 __force *)addr;
-}
-#endif
-
-#ifndef __raw_readl
-#define __raw_readl __raw_readl
-static inline u32 __raw_readl(const volatile void __iomem *addr)
-{
-	return *(const volatile u32 __force *)addr;
-}
-#endif
-
-#ifdef CONFIG_64BIT
-#ifndef __raw_readq
-#define __raw_readq __raw_readq
-static inline u64 __raw_readq(const volatile void __iomem *addr)
-{
-	return *(const volatile u64 __force *)addr;
-}
-#endif
-#endif /* CONFIG_64BIT */
-
-#ifndef __raw_writeb
-#define __raw_writeb __raw_writeb
-static inline void __raw_writeb(u8 value, volatile void __iomem *addr)
-{
-	*(volatile u8 __force *)addr = value;
-}
-#endif
-
-#ifndef __raw_writew
-#define __raw_writew __raw_writew
-static inline void __raw_writew(u16 value, volatile void __iomem *addr)
-{
-	*(volatile u16 __force *)addr = value;
-}
-#endif
-
-#ifndef __raw_writel
-#define __raw_writel __raw_writel
-static inline void __raw_writel(u32 value, volatile void __iomem *addr)
-{
-	*(volatile u32 __force *)addr = value;
-}
-#endif
-
-#ifdef CONFIG_64BIT
-#ifndef __raw_writeq
-#define __raw_writeq __raw_writeq
-static inline void __raw_writeq(u64 value, volatile void __iomem *addr)
-{
-	*(volatile u64 __force *)addr = value;
-}
-#endif
-#endif /* CONFIG_64BIT */
-
-/*
- * {read,write}{b,w,l,q}() access little endian memory and return result in
- * native endianness.
- */
-
-#ifndef readb
-#define readb readb
-static inline u8 readb(const volatile void __iomem *addr)
-{
-	u8 val;
-
-	if (rwmmio_tracepoint_enabled(rwmmio_read))
-		log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
-	__io_br();
-	val = __raw_readb(addr);
-	__io_ar(val);
-	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
-		log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
-	return val;
-}
-#endif
-
-#ifndef readw
-#define readw readw
-static inline u16 readw(const volatile void __iomem *addr)
-{
-	u16 val;
-
-	if (rwmmio_tracepoint_enabled(rwmmio_read))
-		log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
-	__io_br();
-	val = __le16_to_cpu((__le16 __force)__raw_readw(addr));
-	__io_ar(val);
-	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
-		log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
-	return val;
-}
-#endif
-
-#ifndef readl
-#define readl readl
-static inline u32 readl(const volatile void __iomem *addr)
-{
-	u32 val;
-
-	if (rwmmio_tracepoint_enabled(rwmmio_read))
-		log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
-	__io_br();
-	val = __le32_to_cpu((__le32 __force)__raw_readl(addr));
-	__io_ar(val);
-	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
-		log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
-	return val;
-}
-#endif
-
-#ifdef CONFIG_64BIT
-#ifndef readq
-#define readq readq
-static inline u64 readq(const volatile void __iomem *addr)
-{
-	u64 val;
-
-	if (rwmmio_tracepoint_enabled(rwmmio_read))
-		log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
-	__io_br();
-	val = __le64_to_cpu((__le64 __force)__raw_readq(addr));
-	__io_ar(val);
-	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
-		log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
-	return val;
-}
-#endif
-#endif /* CONFIG_64BIT */
-
-#ifndef writeb
-#define writeb writeb
-static inline void writeb(u8 value, volatile void __iomem *addr)
-{
-	if (rwmmio_tracepoint_enabled(rwmmio_write))
-		log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
-	__io_bw();
-	__raw_writeb(value, addr);
-	__io_aw();
-	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
-		log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
-}
-#endif
-
-#ifndef writew
-#define writew writew
-static inline void writew(u16 value, volatile void __iomem *addr)
-{
-	if (rwmmio_tracepoint_enabled(rwmmio_write))
-		log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
-	__io_bw();
-	__raw_writew((u16 __force)cpu_to_le16(value), addr);
-	__io_aw();
-	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
-		log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
-}
-#endif
-
-#ifndef writel
-#define writel writel
-static inline void writel(u32 value, volatile void __iomem *addr)
-{
-	if (rwmmio_tracepoint_enabled(rwmmio_write))
-		log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
-	__io_bw();
-	__raw_writel((u32 __force)__cpu_to_le32(value), addr);
-	__io_aw();
-	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
-		log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
-}
-#endif
-
-#ifdef CONFIG_64BIT
-#ifndef writeq
-#define writeq writeq
-static inline void writeq(u64 value, volatile void __iomem *addr)
-{
-	if (rwmmio_tracepoint_enabled(rwmmio_write))
-		log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
-	__io_bw();
-	__raw_writeq((u64 __force)__cpu_to_le64(value), addr);
-	__io_aw();
-	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
-		log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
-}
-#endif
-#endif /* CONFIG_64BIT */
-
-/*
- * {read,write}{b,w,l,q}_relaxed() are like the regular version, but
- * are not guaranteed to provide ordering against spinlocks or memory
- * accesses.
- */
-#ifndef readb_relaxed
-#define readb_relaxed readb_relaxed
-static inline u8 readb_relaxed(const volatile void __iomem *addr)
-{
-	u8 val;
-
-	if (rwmmio_tracepoint_enabled(rwmmio_read))
-		log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
-	val = __raw_readb(addr);
-	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
-		log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
-	return val;
-}
-#endif
-
-#ifndef readw_relaxed
-#define readw_relaxed readw_relaxed
-static inline u16 readw_relaxed(const volatile void __iomem *addr)
-{
-	u16 val;
-
-	if (rwmmio_tracepoint_enabled(rwmmio_read))
-		log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
-	val = __le16_to_cpu((__le16 __force)__raw_readw(addr));
-	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
-		log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
-	return val;
-}
-#endif
-
-#ifndef readl_relaxed
-#define readl_relaxed readl_relaxed
-static inline u32 readl_relaxed(const volatile void __iomem *addr)
-{
-	u32 val;
-
-	if (rwmmio_tracepoint_enabled(rwmmio_read))
-		log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
-	val = __le32_to_cpu((__le32 __force)__raw_readl(addr));
-	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
-		log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
-	return val;
-}
-#endif
-
-#if defined(readq) && !defined(readq_relaxed)
-#define readq_relaxed readq_relaxed
-static inline u64 readq_relaxed(const volatile void __iomem *addr)
-{
-	u64 val;
-
-	if (rwmmio_tracepoint_enabled(rwmmio_read))
-		log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
-	val = __le64_to_cpu((__le64 __force)__raw_readq(addr));
-	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
-		log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
-	return val;
-}
-#endif
-
-#ifndef writeb_relaxed
-#define writeb_relaxed writeb_relaxed
-static inline void writeb_relaxed(u8 value, volatile void __iomem *addr)
-{
-	if (rwmmio_tracepoint_enabled(rwmmio_write))
-		log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
-	__raw_writeb(value, addr);
-	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
-		log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
-}
-#endif
-
-#ifndef writew_relaxed
-#define writew_relaxed writew_relaxed
-static inline void writew_relaxed(u16 value, volatile void __iomem *addr)
-{
-	if (rwmmio_tracepoint_enabled(rwmmio_write))
-		log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
-	__raw_writew((u16 __force)cpu_to_le16(value), addr);
-	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
-		log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
-}
-#endif
-
-#ifndef writel_relaxed
-#define writel_relaxed writel_relaxed
-static inline void writel_relaxed(u32 value, volatile void __iomem *addr)
-{
-	if (rwmmio_tracepoint_enabled(rwmmio_write))
-		log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
-	__raw_writel((u32 __force)__cpu_to_le32(value), addr);
-	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
-		log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
-}
-#endif
-
-#if defined(writeq) && !defined(writeq_relaxed)
-#define writeq_relaxed writeq_relaxed
-static inline void writeq_relaxed(u64 value, volatile void __iomem *addr)
-{
-	if (rwmmio_tracepoint_enabled(rwmmio_write))
-		log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
-	__raw_writeq((u64 __force)__cpu_to_le64(value), addr);
-	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
-		log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
-}
-#endif
-
 /*
  * {read,write}s{b,w,l,q}() repeatedly access the same memory address in
  * native endianness in 8-, 16-, 32- or 64-bit chunks (@count times).
diff --git a/include/asm-generic/mmio.h b/include/asm-generic/mmio.h
new file mode 100644
index 000000000000..7a79aa16376f
--- /dev/null
+++ b/include/asm-generic/mmio.h
@@ -0,0 +1,407 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Generic memory-mapped I/O accessors.
+ *
+ * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+#ifndef __ASM_GENERIC_MMIO_H
+#define __ASM_GENERIC_MMIO_H
+
+#include <linux/instruction_pointer.h>
+#include <linux/types.h>
+
+#include <asm/byteorder.h>
+#include <asm/mmiowb.h>
+
+#ifndef __io_br
+#define __io_br()      barrier()
+#endif
+
+/* prevent prefetching of coherent DMA data ahead of a dma-complete */
+#ifndef __io_ar
+#ifdef rmb
+#define __io_ar(v)      rmb()
+#else
+#define __io_ar(v)      barrier()
+#endif
+#endif
+
+/* flush writes to coherent DMA data before possibly triggering a DMA read */
+#ifndef __io_bw
+#ifdef wmb
+#define __io_bw()      wmb()
+#else
+#define __io_bw()      barrier()
+#endif
+#endif
+
+/* serialize device access against a spin_unlock, usually handled there. */
+#ifndef __io_aw
+#define __io_aw()      mmiowb_set_pending()
+#endif
+
+/*
+ * "__DISABLE_TRACE_MMIO__" flag can be used to disable MMIO tracing for
+ * specific kernel drivers in case of excessive/unwanted logging.
+ *
+ * Usage: Add a #define flag at the beginning of the driver file.
+ * Ex: #define __DISABLE_TRACE_MMIO__
+ *     #include <...>
+ *     ...
+ */
+#if IS_ENABLED(CONFIG_TRACE_MMIO_ACCESS) && !(defined(__DISABLE_TRACE_MMIO__))
+#include <linux/tracepoint-defs.h>
+
+#define rwmmio_tracepoint_enabled(tracepoint) tracepoint_enabled(tracepoint)
+DECLARE_TRACEPOINT(rwmmio_write);
+DECLARE_TRACEPOINT(rwmmio_post_write);
+DECLARE_TRACEPOINT(rwmmio_read);
+DECLARE_TRACEPOINT(rwmmio_post_read);
+
+void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
+		    unsigned long caller_addr, unsigned long caller_addr0);
+void log_post_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
+			 unsigned long caller_addr, unsigned long caller_addr0);
+void log_read_mmio(u8 width, const volatile void __iomem *addr,
+		   unsigned long caller_addr, unsigned long caller_addr0);
+void log_post_read_mmio(u64 val, u8 width, const volatile void __iomem *addr,
+			unsigned long caller_addr, unsigned long caller_addr0);
+
+#else
+
+#define rwmmio_tracepoint_enabled(tracepoint) false
+static inline void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
+				  unsigned long caller_addr, unsigned long caller_addr0) {}
+static inline void log_post_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
+				       unsigned long caller_addr, unsigned long caller_addr0) {}
+static inline void log_read_mmio(u8 width, const volatile void __iomem *addr,
+				 unsigned long caller_addr, unsigned long caller_addr0) {}
+static inline void log_post_read_mmio(u64 val, u8 width, const volatile void __iomem *addr,
+				      unsigned long caller_addr, unsigned long caller_addr0) {}
+
+#endif /* CONFIG_TRACE_MMIO_ACCESS */
+
+/*
+ * __raw_{read,write}{b,w,l,q}() access memory in native endianness.
+ *
+ * On some architectures memory mapped IO needs to be accessed differently.
+ * On the simple architectures, we just read/write the memory location
+ * directly.
+ */
+
+#ifndef __raw_readb
+#define __raw_readb __raw_readb
+static inline u8 __raw_readb(const volatile void __iomem *addr)
+{
+	return *(const volatile u8 __force *)addr;
+}
+#endif
+
+#ifndef __raw_readw
+#define __raw_readw __raw_readw
+static inline u16 __raw_readw(const volatile void __iomem *addr)
+{
+	return *(const volatile u16 __force *)addr;
+}
+#endif
+
+#ifndef __raw_readl
+#define __raw_readl __raw_readl
+static inline u32 __raw_readl(const volatile void __iomem *addr)
+{
+	return *(const volatile u32 __force *)addr;
+}
+#endif
+
+#ifdef CONFIG_64BIT
+#ifndef __raw_readq
+#define __raw_readq __raw_readq
+static inline u64 __raw_readq(const volatile void __iomem *addr)
+{
+	return *(const volatile u64 __force *)addr;
+}
+#endif
+#endif /* CONFIG_64BIT */
+
+#ifndef __raw_writeb
+#define __raw_writeb __raw_writeb
+static inline void __raw_writeb(u8 value, volatile void __iomem *addr)
+{
+	*(volatile u8 __force *)addr = value;
+}
+#endif
+
+#ifndef __raw_writew
+#define __raw_writew __raw_writew
+static inline void __raw_writew(u16 value, volatile void __iomem *addr)
+{
+	*(volatile u16 __force *)addr = value;
+}
+#endif
+
+#ifndef __raw_writel
+#define __raw_writel __raw_writel
+static inline void __raw_writel(u32 value, volatile void __iomem *addr)
+{
+	*(volatile u32 __force *)addr = value;
+}
+#endif
+
+#ifdef CONFIG_64BIT
+#ifndef __raw_writeq
+#define __raw_writeq __raw_writeq
+static inline void __raw_writeq(u64 value, volatile void __iomem *addr)
+{
+	*(volatile u64 __force *)addr = value;
+}
+#endif
+#endif /* CONFIG_64BIT */
+
+/*
+ * {read,write}{b,w,l,q}() access little endian memory and return result in
+ * native endianness.
+ */
+
+#ifndef readb
+#define readb readb
+static inline u8 readb(const volatile void __iomem *addr)
+{
+	u8 val;
+
+	if (rwmmio_tracepoint_enabled(rwmmio_read))
+		log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
+	__io_br();
+	val = __raw_readb(addr);
+	__io_ar(val);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
+		log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
+	return val;
+}
+#endif
+
+#ifndef readw
+#define readw readw
+static inline u16 readw(const volatile void __iomem *addr)
+{
+	u16 val;
+
+	if (rwmmio_tracepoint_enabled(rwmmio_read))
+		log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
+	__io_br();
+	val = __le16_to_cpu((__le16 __force)__raw_readw(addr));
+	__io_ar(val);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
+		log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
+	return val;
+}
+#endif
+
+#ifndef readl
+#define readl readl
+static inline u32 readl(const volatile void __iomem *addr)
+{
+	u32 val;
+
+	if (rwmmio_tracepoint_enabled(rwmmio_read))
+		log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
+	__io_br();
+	val = __le32_to_cpu((__le32 __force)__raw_readl(addr));
+	__io_ar(val);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
+		log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
+	return val;
+}
+#endif
+
+#ifdef CONFIG_64BIT
+#ifndef readq
+#define readq readq
+static inline u64 readq(const volatile void __iomem *addr)
+{
+	u64 val;
+
+	if (rwmmio_tracepoint_enabled(rwmmio_read))
+		log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
+	__io_br();
+	val = __le64_to_cpu((__le64 __force)__raw_readq(addr));
+	__io_ar(val);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
+		log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
+	return val;
+}
+#endif
+#endif /* CONFIG_64BIT */
+
+#ifndef writeb
+#define writeb writeb
+static inline void writeb(u8 value, volatile void __iomem *addr)
+{
+	if (rwmmio_tracepoint_enabled(rwmmio_write))
+		log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
+	__io_bw();
+	__raw_writeb(value, addr);
+	__io_aw();
+	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
+		log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
+}
+#endif
+
+#ifndef writew
+#define writew writew
+static inline void writew(u16 value, volatile void __iomem *addr)
+{
+	if (rwmmio_tracepoint_enabled(rwmmio_write))
+		log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
+	__io_bw();
+	__raw_writew((u16 __force)cpu_to_le16(value), addr);
+	__io_aw();
+	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
+		log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
+}
+#endif
+
+#ifndef writel
+#define writel writel
+static inline void writel(u32 value, volatile void __iomem *addr)
+{
+	if (rwmmio_tracepoint_enabled(rwmmio_write))
+		log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
+	__io_bw();
+	__raw_writel((u32 __force)__cpu_to_le32(value), addr);
+	__io_aw();
+	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
+		log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
+}
+#endif
+
+#ifdef CONFIG_64BIT
+#ifndef writeq
+#define writeq writeq
+static inline void writeq(u64 value, volatile void __iomem *addr)
+{
+	if (rwmmio_tracepoint_enabled(rwmmio_write))
+		log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
+	__io_bw();
+	__raw_writeq((u64 __force)__cpu_to_le64(value), addr);
+	__io_aw();
+	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
+		log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
+}
+#endif
+#endif /* CONFIG_64BIT */
+
+/*
+ * {read,write}{b,w,l,q}_relaxed() are like the regular version, but
+ * are not guaranteed to provide ordering against spinlocks or memory
+ * accesses.
+ */
+#ifndef readb_relaxed
+#define readb_relaxed readb_relaxed
+static inline u8 readb_relaxed(const volatile void __iomem *addr)
+{
+	u8 val;
+
+	if (rwmmio_tracepoint_enabled(rwmmio_read))
+		log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
+	val = __raw_readb(addr);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
+		log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
+	return val;
+}
+#endif
+
+#ifndef readw_relaxed
+#define readw_relaxed readw_relaxed
+static inline u16 readw_relaxed(const volatile void __iomem *addr)
+{
+	u16 val;
+
+	if (rwmmio_tracepoint_enabled(rwmmio_read))
+		log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
+	val = __le16_to_cpu((__le16 __force)__raw_readw(addr));
+	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
+		log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
+	return val;
+}
+#endif
+
+#ifndef readl_relaxed
+#define readl_relaxed readl_relaxed
+static inline u32 readl_relaxed(const volatile void __iomem *addr)
+{
+	u32 val;
+
+	if (rwmmio_tracepoint_enabled(rwmmio_read))
+		log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
+	val = __le32_to_cpu((__le32 __force)__raw_readl(addr));
+	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
+		log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
+	return val;
+}
+#endif
+
+#if defined(readq) && !defined(readq_relaxed)
+#define readq_relaxed readq_relaxed
+static inline u64 readq_relaxed(const volatile void __iomem *addr)
+{
+	u64 val;
+
+	if (rwmmio_tracepoint_enabled(rwmmio_read))
+		log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
+	val = __le64_to_cpu((__le64 __force)__raw_readq(addr));
+	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
+		log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
+	return val;
+}
+#endif
+
+#ifndef writeb_relaxed
+#define writeb_relaxed writeb_relaxed
+static inline void writeb_relaxed(u8 value, volatile void __iomem *addr)
+{
+	if (rwmmio_tracepoint_enabled(rwmmio_write))
+		log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
+	__raw_writeb(value, addr);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
+		log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
+}
+#endif
+
+#ifndef writew_relaxed
+#define writew_relaxed writew_relaxed
+static inline void writew_relaxed(u16 value, volatile void __iomem *addr)
+{
+	if (rwmmio_tracepoint_enabled(rwmmio_write))
+		log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
+	__raw_writew((u16 __force)cpu_to_le16(value), addr);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
+		log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
+}
+#endif
+
+#ifndef writel_relaxed
+#define writel_relaxed writel_relaxed
+static inline void writel_relaxed(u32 value, volatile void __iomem *addr)
+{
+	if (rwmmio_tracepoint_enabled(rwmmio_write))
+		log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
+	__raw_writel((u32 __force)__cpu_to_le32(value), addr);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
+		log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
+}
+#endif
+
+#if defined(writeq) && !defined(writeq_relaxed)
+#define writeq_relaxed writeq_relaxed
+static inline void writeq_relaxed(u64 value, volatile void __iomem *addr)
+{
+	if (rwmmio_tracepoint_enabled(rwmmio_write))
+		log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
+	__raw_writeq((u64 __force)__cpu_to_le64(value), addr);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
+		log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
+}
+#endif
+
+#endif /* __ASM_GENERIC_MMIO_H */
-- 
2.43.0

