From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH v2 2/3] drivers/block/xsysace - use "_rep" accessors with CPU endianess for data
Date: Mon, 24 Jun 2013 12:26:03 +0400
Message-ID: <1372062364-25861-3-git-send-email-abrodkin@synopsys.com>
References: <1372062364-25861-1-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hermes.synopsys.com ([198.182.44.81]:53946 "EHLO
	hermes.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506Ab3FXI0d (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2013 04:26:33 -0400
In-Reply-To: <1372062364-25861-1-git-send-email-abrodkin@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Mischa Jonker <Mischa.Jonker@synopsys.com>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Michal Simek <monstr@monstr.eu>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andy Shevchenko <andy.shevchenko@gmail.com>

Initially different data accessors were used for LE abd BE CPUs:
"ioread16" in "ace_datain_be16" and "ioread16be" in "ace_datain_le16".
The same with writes.

While it worked in some cases (for example on BE PPC) it didn't work in
others (LE ARC).

Mentioned functions access data (by 16-bit chunks) from storage (i.e.
CompactFlash card) via DATABUFREG of Xilinx SystemACE CF controller.
And to interpret data properly CPU needs to access data in DATABUFREG
with native endianess.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>

Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Mischa Jonker <mjonker@synopsys.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/block/xsysace.c |   60 +++++++++++------------------------------------
 1 file changed, 14 insertions(+), 46 deletions(-)

diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
index 64fd3c0..af973aa 100644
--- a/drivers/block/xsysace.c
+++ b/drivers/block/xsysace.c
@@ -244,22 +244,14 @@ static void ace_out_8(struct ace_device *ace, int reg, u16 val)
 
 static void ace_datain_8(struct ace_device *ace)
 {
-	void __iomem *r = ace->baseaddr + 0x40;
-	u8 *dst = ace->data_ptr;
-	int i = ACE_FIFO_SIZE;
-	while (i--)
-		*dst++ = ioread8(r++);
-	ace->data_ptr = dst;
+	ioread8_rep(ace->baseaddr + 0x40, ace->data_ptr, ACE_FIFO_SIZE);
+	ace->data_ptr += ACE_FIFO_SIZE;
 }
 
 static void ace_dataout_8(struct ace_device *ace)
 {
-	void __iomem *r = ace->baseaddr + 0x40;
-	u8 *src = ace->data_ptr;
-	int i = ACE_FIFO_SIZE;
-	while (i--)
-		iowrite8(*src++, r++);
-	ace->data_ptr = src;
+	iowrite8_rep(ace->baseaddr + 0x40, ace->data_ptr, ACE_FIFO_SIZE);
+	ace->data_ptr += ACE_FIFO_SIZE;
 }
 
 static struct ace_reg_ops ace_reg_8_ops = {
@@ -280,22 +272,16 @@ static void ace_out_be16(struct ace_device *ace, int reg, u16 val)
 	iowrite16be(val, ace->baseaddr + reg);
 }
 
-static void ace_datain_be16(struct ace_device *ace)
+static void ace_datain_16(struct ace_device *ace)
 {
-	int i = ACE_FIFO_SIZE / 2;
-	u16 *dst = ace->data_ptr;
-	while (i--)
-		*dst++ = ioread16(ace->baseaddr + 0x40);
-	ace->data_ptr = dst;
+	ioread16_rep(ace->baseaddr + 0x40, ace->data_ptr, ACE_FIFO_SIZE / 2);
+	ace->data_ptr += ACE_FIFO_SIZE;
 }
 
-static void ace_dataout_be16(struct ace_device *ace)
+static void ace_dataout_16(struct ace_device *ace)
 {
-	int i = ACE_FIFO_SIZE / 2;
-	u16 *src = ace->data_ptr;
-	while (i--)
-		iowrite16(*src++, ace->baseaddr + 0x40);
-	ace->data_ptr = src;
+	iowrite16_rep(ace->baseaddr + 0x40, ace->data_ptr, ACE_FIFO_SIZE / 2);
+	ace->data_ptr += ACE_FIFO_SIZE;
 }
 
 /* 16 bit little endian bus attachment */
@@ -309,36 +295,18 @@ static void ace_out_le16(struct ace_device *ace, int reg, u16 val)
 	iowrite16(val, ace->baseaddr + reg);
 }
 
-static void ace_datain_le16(struct ace_device *ace)
-{
-	int i = ACE_FIFO_SIZE / 2;
-	u16 *dst = ace->data_ptr;
-	while (i--)
-		*dst++ = ioread16be(ace->baseaddr + 0x40);
-	ace->data_ptr = dst;
-}
-
-static void ace_dataout_le16(struct ace_device *ace)
-{
-	int i = ACE_FIFO_SIZE / 2;
-	u16 *src = ace->data_ptr;
-	while (i--)
-		iowrite16be(*src++, ace->baseaddr + 0x40);
-	ace->data_ptr = src;
-}
-
 static struct ace_reg_ops ace_reg_be16_ops = {
 	.in = ace_in_be16,
 	.out = ace_out_be16,
-	.datain = ace_datain_be16,
-	.dataout = ace_dataout_be16,
+	.datain = ace_datain_16,
+	.dataout = ace_dataout_16,
 };
 
 static struct ace_reg_ops ace_reg_le16_ops = {
 	.in = ace_in_le16,
 	.out = ace_out_le16,
-	.datain = ace_datain_le16,
-	.dataout = ace_dataout_le16,
+	.datain = ace_datain_16,
+	.dataout = ace_dataout_16,
 };
 
 static inline u16 ace_in(struct ace_device *ace, int reg)
-- 
1.7.10.4
