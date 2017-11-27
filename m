From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v2 32/35] asm-generic/io.h: move ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of ifndef CONFIG_MMU
Date: Mon, 27 Nov 2017 20:28:19 +0800
Message-ID: <44e31de43dab9abecdc08f9a87244205f054cfa6.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <cover.1511785528.git.green.hu@gmail.com>
In-Reply-To: <cover.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime@andestech.com>

It allows some architectures to use this generic macro instead of
defining theirs.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 include/asm-generic/io.h |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index b4531e3..7c6a39e 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -852,7 +852,16 @@ static inline void __iomem *__ioremap(phys_addr_t offset, size_t size,
 }
 #endif
 
+#ifndef iounmap
+#define iounmap iounmap
+
+static inline void iounmap(void __iomem *addr)
+{
+}
+#endif
+#endif /* CONFIG_MMU */
 #ifndef ioremap_nocache
+void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
 #define ioremap_nocache ioremap_nocache
 static inline void __iomem *ioremap_nocache(phys_addr_t offset, size_t size)
 {
@@ -884,15 +893,6 @@ static inline void __iomem *ioremap_wt(phys_addr_t offset, size_t size)
 }
 #endif
 
-#ifndef iounmap
-#define iounmap iounmap
-
-static inline void iounmap(void __iomem *addr)
-{
-}
-#endif
-#endif /* CONFIG_MMU */
-
 #ifdef CONFIG_HAS_IOPORT_MAP
 #ifndef CONFIG_GENERIC_IOMAP
 #ifndef ioport_map
-- 
1.7.9.5
