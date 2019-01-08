From: guoren@kernel.org
Subject: [PATCH 3/5] csky: fixup CACHEV1 store instruction fast retire
Date: Wed,  9 Jan 2019 00:26:36 +0800
Message-ID: <1546964798-30067-3-git-send-email-guoren@kernel.org>
References: <1546964798-30067-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546964798-30067-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, marc.zyngier@arm.com, arnd@arndb.de
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mhocko@kernel.org, torvalds@linux-foundation.org, linux@roeck-us.net, Guo Ren <ren_guo@c-sky.com>, Lu Baoquan <lu.baoquan@intellif.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

For I/O access, 810/807 store instruction fast retire will cause wrong
primitive. For example:

	stw (clear interrupt source)
	stw (unmask interrupt controller)
	enable interrupt

stw is fast retire instruction. When PC is run at enable interrupt
stage, the clear interrupt source hasn't finished. It will cause another
wrong irq-enter.

So use mb() to prevent above.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Lu Baoquan <lu.baoquan@intellif.com>
---
 arch/csky/include/asm/io.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/csky/include/asm/io.h b/arch/csky/include/asm/io.h
index ecae6b3..c1dfa9c 100644
--- a/arch/csky/include/asm/io.h
+++ b/arch/csky/include/asm/io.h
@@ -15,6 +15,31 @@ extern void iounmap(void *addr);
 extern int remap_area_pages(unsigned long address, phys_addr_t phys_addr,
 		size_t size, unsigned long flags);
 
+/*
+ * I/O memory access primitives. Reads are ordered relative to any
+ * following Normal memory access. Writes are ordered relative to any prior
+ * Normal memory access.
+ *
+ * For CACHEV1 (807, 810), store instruction could fast retire, so we need
+ * another mb() to prevent st fast retire.
+ *
+ * For CACHEV2 (860), store instruction with PAGE_ATTR_NO_BUFFERABLE won't
+ * fast retire.
+ */
+#define readb(c)		({ u8  __v = readb_relaxed(c); rmb(); __v; })
+#define readw(c)		({ u16 __v = readw_relaxed(c); rmb(); __v; })
+#define readl(c)		({ u32 __v = readl_relaxed(c); rmb(); __v; })
+
+#ifdef CONFIG_CPU_HAS_CACHEV2
+#define writeb(v,c)		({ wmb(); writeb_relaxed((v),(c)); })
+#define writew(v,c)		({ wmb(); writew_relaxed((v),(c)); })
+#define writel(v,c)		({ wmb(); writel_relaxed((v),(c)); })
+#else
+#define writeb(v,c)		({ wmb(); writeb_relaxed((v),(c)); mb(); })
+#define writew(v,c)		({ wmb(); writew_relaxed((v),(c)); mb(); })
+#define writel(v,c)		({ wmb(); writel_relaxed((v),(c)); mb(); })
+#endif
+
 #define ioremap_nocache(phy, sz)	ioremap(phy, sz)
 #define ioremap_wc ioremap_nocache
 #define ioremap_wt ioremap_nocache
-- 
2.7.4
