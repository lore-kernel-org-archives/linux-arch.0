From: Wilson & Cassie <griscruf@comcast.net>
Subject: [PATCH] iomux-mx25: add UART3 and UART5 PAD macros
Date: Wed, 16 Jan 2013 14:07:23 -0500
Message-ID: <835D9903-E12E-44CF-A49A-687CA3205593@comcast.net>
References: <2070846367.78202.1358362878536.JavaMail.root@sz0071a.westchester.pa.mail.comcast.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from qmta04.westchester.pa.mail.comcast.net ([76.96.62.40]:44041
	"EHLO qmta04.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756707Ab3APTOb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 16 Jan 2013 14:14:31 -0500
In-Reply-To: <2070846367.78202.1358362878536.JavaMail.root@sz0071a.westchester.pa.mail.comcast.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lothar Wassmann <LW@KARO-electronics.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-arch@vger.kernel.org

Patch to add macros needed for UART3 and UART5.  I tested UART3 TXD/RXD and UART5 TXD/RXD/RTS/CTS.

Signed-off-by: Wilson Callan <wilson.callan at savantsystems.com>

--- linux-3.8-rc3/arch/arm/mach-imx/iomux-mx25.h.orig	2013-01-09 21:59:55.000000000 -0500
+++ linux-3.8-rc3/arch/arm/mach-imx/iomux-mx25.h	2013-01-16 13:32:55.619008205 -0500
@@ -268,6 +268,7 @@
#define MX25_PAD_CSI_D2__CSPI3_MOSI	IOMUX_PAD(0x318, 0x120, 0x17, 0, 0, NO_PAD_CTRL)

#define MX25_PAD_CSI_D3__CSI_D3		IOMUX_PAD(0x31c, 0x124, 0x10, 0, 0, NO_PAD_CTRL)
+#define MX25_PAD_CSI_D3__UART5_TXD_MUX	IOMUX_PAD(0x31c, 0x124, 0x11, 0, 0, NO_PAD_CTRL)
#define MX25_PAD_CSI_D3__GPIO_1_28	IOMUX_PAD(0x31c, 0x124, 0x15, 0, 0, NO_PAD_CTRL)
#define MX25_PAD_CSI_D3__CSPI3_MISO	IOMUX_PAD(0x31c, 0x124, 0x17, 0x4b4, 1, NO_PAD_CTRL)

@@ -277,6 +278,7 @@
#define MX25_PAD_CSI_D4__CSPI3_SCLK	IOMUX_PAD(0x320, 0x128, 0x17, 0, 0, NO_PAD_CTRL)

#define MX25_PAD_CSI_D5__CSI_D5		IOMUX_PAD(0x324, 0x12c, 0x10, 0, 0, NO_PAD_CTRL)
+#define MX25_PAD_CSI_D5__UART5_CTS	IOMUX_PAD(0x324, 0x12c, 0x11, 0, 0, NO_PAD_CTRL)
#define MX25_PAD_CSI_D5__GPIO_1_30	IOMUX_PAD(0x324, 0x12c, 0x15, 0, 0, NO_PAD_CTRL)
#define MX25_PAD_CSI_D5__CSPI3_RDY	IOMUX_PAD(0x324, 0x12c, 0x17, 0, 0, NO_PAD_CTRL)

@@ -383,16 +385,20 @@
#define KPP_CTL_COL	(PAD_CTL_PKE | PAD_CTL_PUE | PAD_CTL_PUS_100K_UP | PAD_CTL_ODE)

#define MX25_PAD_KPP_ROW0__KPP_ROW0	IOMUX_PAD(0x3a0, 0x1a8, 0x10, 0, 0, KPP_CTL_ROW)
+#define MX25_PAD_KPP_ROW0__UART3_RXD_MUX IOMUX_PAD(0x3a0, 0x1a8, 0x11, 0x568, 1, NO_PAD_CTRL)
#define MX25_PAD_KPP_ROW0__GPIO_2_29	IOMUX_PAD(0x3a0, 0x1a8, 0x15, 0, 0, NO_PAD_CTRL)

#define MX25_PAD_KPP_ROW1__KPP_ROW1	IOMUX_PAD(0x3a4, 0x1ac, 0x10, 0, 0, KPP_CTL_ROW)
+#define MX25_PAD_KPP_ROW1__UART3_TXD_MUX IOMUX_PAD(0x3a4, 0x1ac, 0x11, 0, 0, NO_PAD_CTRL)
#define MX25_PAD_KPP_ROW1__GPIO_2_30	IOMUX_PAD(0x3a4, 0x1ac, 0x15, 0, 0, NO_PAD_CTRL)

#define MX25_PAD_KPP_ROW2__KPP_ROW2	IOMUX_PAD(0x3a8, 0x1b0, 0x10, 0, 0, KPP_CTL_ROW)
+#define MX25_PAD_KPP_ROW2__UART3_RTS IOMUX_PAD(0x3a8, 0x1b0, 0x11, 0x564, 1, NO_PAD_CTRL)
#define MX25_PAD_KPP_ROW2__CSI_D0	IOMUX_PAD(0x3a8, 0x1b0, 0x13, 0x488, 2, NO_PAD_CTRL)
#define MX25_PAD_KPP_ROW2__GPIO_2_31	IOMUX_PAD(0x3a8, 0x1b0, 0x15, 0, 0, NO_PAD_CTRL)

#define MX25_PAD_KPP_ROW3__KPP_ROW3	IOMUX_PAD(0x3ac, 0x1b4, 0x10, 0, 0, KPP_CTL_ROW)
+#define MX25_PAD_KPP_ROW3__UART3_CTS IOMUX_PAD(0x3ac, 0x1b4, 0x11, 0, 0, NO_PAD_CTRL)
#define MX25_PAD_KPP_ROW3__CSI_LD1	IOMUX_PAD(0x3ac, 0x1b4, 0x13, 0x48c, 2, NO_PAD_CTRL)
#define MX25_PAD_KPP_ROW3__GPIO_3_0	IOMUX_PAD(0x3ac, 0x1b4, 0x15, 0, 0, NO_PAD_CTRL)
