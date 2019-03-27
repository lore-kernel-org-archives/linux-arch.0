Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41155 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfC0FBo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Mar 2019 01:01:44 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v13 10/11] gpio: 74x164: Utilize the for_each_set_clump8 macro
Date: Wed, 27 Mar 2019 14:02:39 +0900
Message-ID: <645f16f1d1ad3f215e34a82f457e06725fcf8f56.1553661964.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1553661964.git.vilhelm.gray@gmail.com>
References: <cover.1553661964.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc: akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, preid@electromag.com.au, William Breathitt Gray <vilhelm.gray@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>
Message-ID: <20190327050239.Y3D3SZXFJ5UmkkINzLM3VrIjtnpnAd1WpXIBKv85tyc@z>

Replace verbose implementation in set_multiple callback with
for_each_set_clump8 macro to simplify code and improve clarity.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Reid <preid@electromag.com.au>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-74x164.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
index fb7b620763a2..0bbf1162bb31 100644
--- a/drivers/gpio/gpio-74x164.c
+++ b/drivers/gpio/gpio-74x164.c
@@ -9,6 +9,7 @@
  *  published by the Free Software Foundation.
  */
 
+#include <linux/bitops.h>
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/spi/spi.h>
@@ -75,20 +76,18 @@ static void gen_74x164_set_multiple(struct gpio_chip *gc, unsigned long *mask,
 				    unsigned long *bits)
 {
 	struct gen_74x164_chip *chip = gpiochip_get_data(gc);
-	unsigned int i, idx, shift;
-	u8 bank, bankmask;
+	unsigned long offset;
+	unsigned long bankmask;
+	size_t bank;
+	unsigned long bitmask;
 
 	mutex_lock(&chip->lock);
-	for (i = 0, bank = chip->registers - 1; i < chip->registers;
-	     i++, bank--) {
-		idx = i / sizeof(*mask);
-		shift = i % sizeof(*mask) * BITS_PER_BYTE;
-		bankmask = mask[idx] >> shift;
-		if (!bankmask)
-			continue;
+	for_each_set_clump8(offset, bankmask, mask, chip->registers * 8) {
+		bank = (chip->registers - 1) - (offset / 8);
+		bitmask = bitmap_get_value8(bits, offset) & bankmask;
 
 		chip->buffer[bank] &= ~bankmask;
-		chip->buffer[bank] |= bankmask & (bits[idx] >> shift);
+		chip->buffer[bank] |= bitmask;
 	}
 	__gen_74x164_write_config(chip);
 	mutex_unlock(&chip->lock);
-- 
2.21.0
