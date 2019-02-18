From: Hugo Lefeuvre <hle@owl.eu.com>
Subject: [PATCH 4/4] lib/iomap: add missing const to mmio_ins* addr arg
Date: Mon, 18 Feb 2019 11:54:51 +0100
Message-ID: <860beee91f5f22a3f8afc75390a488eba095fa85.1550485787.git.hle@owl.eu.com>
References: <cover.1550485787.git.hle@owl.eu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1550485787.git.hle@owl.eu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

mmio_ins* definitions from lib/iomap.c are missing const qualifiers
for the addr argument. This results in compilation warnings when
compiling drivers.

Add missing const qualifiers.

Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
---
 lib/iomap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/iomap.c b/lib/iomap.c
index 8cc3270697e9..2bcc5d9d30b1 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -143,7 +143,7 @@ EXPORT_SYMBOL(iowrite32be);
  * order" (we also don't have IO barriers).
  */
 #ifndef mmio_insb
-static inline void mmio_insb(void __iomem *addr, u8 *dst, int count)
+static inline void mmio_insb(const void __iomem *addr, u8 *dst, int count)
 {
 	while (--count >= 0) {
 		u8 data = __raw_readb(addr);
@@ -151,7 +151,7 @@ static inline void mmio_insb(void __iomem *addr, u8 *dst, int count)
 		dst++;
 	}
 }
-static inline void mmio_insw(void __iomem *addr, u16 *dst, int count)
+static inline void mmio_insw(const void __iomem *addr, u16 *dst, int count)
 {
 	while (--count >= 0) {
 		u16 data = __raw_readw(addr);
@@ -159,7 +159,7 @@ static inline void mmio_insw(void __iomem *addr, u16 *dst, int count)
 		dst++;
 	}
 }
-static inline void mmio_insl(void __iomem *addr, u32 *dst, int count)
+static inline void mmio_insl(const void __iomem *addr, u32 *dst, int count)
 {
 	while (--count >= 0) {
 		u32 data = __raw_readl(addr);
-- 
2.20.1
