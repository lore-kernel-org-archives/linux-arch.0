From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v2 1/4] ARM: fncpy: Rename include guards
Date: Fri, 16 Jun 2017 14:28:05 -0700
Message-ID: <20170616212808.19073-2-f.fainelli@gmail.com>
References: <20170616212808.19073-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170616212808.19073-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Keerthy J <j-keerthy@ti.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>
List-Id: linux-arch.vger.kernel.org

In preparation for allowing a generic fncpy() implementation to live
under include/asm-generic/fncpy.h, rename the current include guards to
be __ASM_ARM_FNCPY_H, this also makes the header file more consistent
with other headers in the same directory.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/include/asm/fncpy.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/fncpy.h b/arch/arm/include/asm/fncpy.h
index de5354746924..86a8fc14cde9 100644
--- a/arch/arm/include/asm/fncpy.h
+++ b/arch/arm/include/asm/fncpy.h
@@ -53,8 +53,8 @@
  * in the file where f is defined.
  */
 
-#ifndef __ASM_FNCPY_H
-#define __ASM_FNCPY_H
+#ifndef __ASM_ARM_FNCPY_H
+#define __ASM_ARM_FNCPY_H
 
 #include <linux/types.h>
 #include <linux/string.h>
@@ -91,4 +91,4 @@
 	__result;							\
 })
 
-#endif /* !__ASM_FNCPY_H */
+#endif /* !__ASM_ARM_FNCPY_H */
-- 
2.9.3
