Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36806 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752155AbdFPV2X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Jun 2017 17:28:23 -0400
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v2 3/4] arm64: Provide a fncpy implementation
Date: Fri, 16 Jun 2017 14:28:07 -0700
Message-ID: <20170616212808.19073-4-f.fainelli@gmail.com>
In-Reply-To: <20170616212808.19073-1-f.fainelli@gmail.com>
References: <20170616212808.19073-1-f.fainelli@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Keerthy J <j-keerthy@ti.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>
Message-ID: <20170616212807.qrZ-WB2Xw1PGGii9bLfiUlj_Mt2wH3Q_X-W_jfjwsSc@z>

Utilize the asm-generic/fncpy.h implementation for ARM64 to allow the
use of drivers/misc/sram*.c on these platforms as well.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/include/asm/fncpy.h | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 arch/arm64/include/asm/fncpy.h

diff --git a/arch/arm64/include/asm/fncpy.h b/arch/arm64/include/asm/fncpy.h
new file mode 100644
index 000000000000..578f942f55e4
--- /dev/null
+++ b/arch/arm64/include/asm/fncpy.h
@@ -0,0 +1,6 @@
+#ifndef __ASMARM64_FNCPY_H
+#define __ASMARM64_FNCPY_H
+
+#include <asm-generic/fncpy.h>
+
+#endif /* __ASMARM64_FNCPY_H */
-- 
2.9.3
