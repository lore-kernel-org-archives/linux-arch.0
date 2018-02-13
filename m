From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v7 01/37] openrisc: add ioremap_nocache declaration before include asm-generic/io.h and sync ioremap prototype with it.
Date: Tue, 13 Feb 2018 17:09:05 +0800
Message-ID: <a5d727ac3c73a02c1ef3eff81be1494b1fad3644.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Cc: green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

A future commit for the nds32 architecture bootstrap("asm-generic/io.h: move
ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of ifndef CONFIG_MMU")
will move the ioremap_nocache out of the CONFIG_MMU ifdef. This means that
in order to suppress re-definition errors we need to setup #define's before
importing asm-generic/io.h.

Also, the change adds a prototype for ioremap where size is size_t so fix that
as well.

Signed-off-by: Greentime Hu <greentime@andestech.com>
Acked-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/io.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
index 7c691399da3f..6709b28a0221 100644
--- a/arch/openrisc/include/asm/io.h
+++ b/arch/openrisc/include/asm/io.h
@@ -29,13 +29,14 @@
 #define PIO_OFFSET		0
 #define PIO_MASK		0
 
+#define ioremap_nocache ioremap_nocache
 #include <asm-generic/io.h>
 #include <asm/pgtable.h>
 
 extern void __iomem *__ioremap(phys_addr_t offset, unsigned long size,
 				pgprot_t prot);
 
-static inline void __iomem *ioremap(phys_addr_t offset, unsigned long size)
+static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
 {
 	return __ioremap(offset, size, PAGE_KERNEL);
 }
-- 
2.16.1
