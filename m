Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn1bbn0100.outbound.protection.outlook.com ([157.56.111.100]:6901
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754593AbcESPLA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 May 2016 11:11:00 -0400
From: =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
Subject: [PATCH v3 1/8] asm-generic/io.h: allow barriers in io{read,write}{16,32}be
Date: Thu, 19 May 2016 18:10:43 +0300
Message-ID: <1463670643-2527-1-git-send-email-horia.geanta@nxp.com>
In-Reply-To: <1463670405-1059-1-git-send-email-horia.geanta@nxp.com>
References: <1463670405-1059-1-git-send-email-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20160519151043.AAoJiutcUFhYxHtIqITNat4dEfS6sUI-5bFWD7rlVpo@z>

While reviewing the addition of io{read,write}64be accessors, Arnd

-finds a potential problem:
"If an architecture overrides readq/writeq to have barriers but does
not override ioread64be/iowrite64be, this will lack the barriers and
behave differently from the little-endian version. I think the only
affected architecture is ARC, since ARM and ARM64 both override the
big-endian accessors to have the correct barriers, and all others
don't use barriers at all."

-suggests a fix for the same problem in existing code (16/32-bit
accessors); the fix leads "to a double-swap on architectures that
don't override the io{read,write}{16,32}be accessors, but it will
work correctly on all architectures without them having to override
these accessors."

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 include/asm-generic/io.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index eed3bbe88c8a..b79fb2c248a1 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -613,7 +613,7 @@ static inline void iowrite32(u32 value, volatile void __iomem *addr)
 #define ioread16be ioread16be
 static inline u16 ioread16be(const volatile void __iomem *addr)
 {
-	return __be16_to_cpu(__raw_readw(addr));
+	return swab16(readw(addr));
 }
 #endif
 
@@ -621,7 +621,7 @@ static inline u16 ioread16be(const volatile void __iomem *addr)
 #define ioread32be ioread32be
 static inline u32 ioread32be(const volatile void __iomem *addr)
 {
-	return __be32_to_cpu(__raw_readl(addr));
+	return swab32(readl(addr));
 }
 #endif
 
@@ -629,7 +629,7 @@ static inline u32 ioread32be(const volatile void __iomem *addr)
 #define iowrite16be iowrite16be
 static inline void iowrite16be(u16 value, void volatile __iomem *addr)
 {
-	__raw_writew(__cpu_to_be16(value), addr);
+	writew(swab16(value), addr);
 }
 #endif
 
@@ -637,7 +637,7 @@ static inline void iowrite16be(u16 value, void volatile __iomem *addr)
 #define iowrite32be iowrite32be
 static inline void iowrite32be(u32 value, volatile void __iomem *addr)
 {
-	__raw_writel(__cpu_to_be32(value), addr);
+	writel(swab32(value), addr);
 }
 #endif
 
-- 
2.4.4

