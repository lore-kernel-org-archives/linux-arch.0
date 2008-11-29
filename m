From: Hitoshi Mitake <h.mitake@gmail.com>
Subject: Re: [PATCH 1/1] edac x38: new MC driver module
Date: Sat, 29 Nov 2008 16:47:36 +0900
Message-ID: <20081129164736.0b5a71db.h.mitake@gmail.com>
References: <200811290056.mAT0uTuk028924@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.187]:42729 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbYK2Hrs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 29 Nov 2008 02:47:48 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1176065tic.23
        for <linux-arch@vger.kernel.org>; Fri, 28 Nov 2008 23:47:46 -0800 (PST)
In-Reply-To: <200811290056.mAT0uTuk028924@terminus.zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Luck, Tony" <tony.luck@intel.com>, Russell King <rmk+lkml@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@linux-foundation.org>, Doug Thompson <norsk5@yahoo.com>, dougthompson@xmission.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Fri, 28 Nov 2008 16:56:39 -0800
"H. Peter Anvin" <hpa@zytor.com> wrote:

> The cast is unnecessary; one can argue for a cast to (u32) for clarity, but personally I think writel() is a clear enough especialy given the context.
> 

Thanks for your advice. I removed redundant cat. How is this?

description of this patch
Adding implementation of readq/writeq to x86_32,
and adding config value to x86 architecture to determine existence of readq/writeq

Signed-off-by: Hitoshi Mitake <h.mitake@gmail.com>
---
 arch/x86/Kconfig          |    4 ++++
 arch/x86/include/asm/io.h |   24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ac22bb7..10bd84c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -11,9 +11,13 @@ config 64BIT
 
 config X86_32
 	def_bool !64BIT
+	select ARCH_HAS_READQ
+	select ARCH_HAS_WRITEQ
 
 config X86_64
 	def_bool 64BIT
+	select ARCH_HAS_READQ
+	select ARCH_HAS_WRITEQ
 
 ### Arch settings
 config X86
diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index ac2abc8..ddc67aa 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -4,6 +4,7 @@
 #define ARCH_HAS_IOREMAP_WC
 
 #include <linux/compiler.h>
+#include <asm-generic/int-ll64.h>
 
 #define build_mmio_read(name, size, type, reg, barrier) \
 static inline type name(const volatile void __iomem *addr) \
@@ -57,6 +58,29 @@ build_mmio_write(__writeq, "q", unsigned long, "r", )
 /* Let people know we have them */
 #define readq readq
 #define writeq writeq
+
+#else  /* CONFIG_X86_32 from here */
+
+static inline __u64 readq(const volatile void __iomem *addr)
+{
+	const volatile u32 __iomem *p = addr;
+	u32 l, h;
+
+	l = readl(p);
+	h = readl(p+1);
+
+	return l + ((u64)h << 32);
+}
+
+static inline void writeq(__u64 val, volatile void __iomem *addr)
+{
+	writel(val, addr);
+	writel(val >> 32, addr+4);
+}
+
+#define readq readq
+#define writeq writeq
+
 #endif
 
 extern int iommu_bio_merge;
-- 
1.5.6.5
