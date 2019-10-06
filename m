Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42905 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfJFPLs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Oct 2019 11:11:48 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v16 10/14] gpio: 74x164: Utilize the for_each_set_clump8 macro
Date: Sun,  6 Oct 2019 11:11:07 -0400
Message-ID: <13f5d24820e5e3a17a64d025f09efc37eda77739.1570374078.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1570374078.git.vilhelm.gray@gmail.com>
References: <cover.1570374078.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc: akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de, sean.nyekjaer@prevas.dk, morten.tiljeset@prevas.dk, William Breathitt Gray <vilhelm.gray@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>
Message-ID: <20191006151107.vVFlxs0jxoR4WuHf_C2nQ5ONjyf09r4cpd2TRoMkegE@z>

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
index e81307f9754e..05637d585152 100644
--- a/drivers/gpio/gpio-74x164.c
+++ b/drivers/gpio/gpio-74x164.c
@@ -6,6 +6,7 @@
  *  Copyright (C) 2010 Miguel Gaio <miguel.gaio@efixo.com>
  */
 
+#include <linux/bitops.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
 #include <linux/module.h>
@@ -72,20 +73,18 @@ static void gen_74x164_set_multiple(struct gpio_chip *gc, unsigned long *mask,
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
+		bank = chip->registers - 1 - offset / 8;
+		bitmask = bitmap_get_value8(bits, offset) & bankmask;
 
 		chip->buffer[bank] &= ~bankmask;
-		chip->buffer[bank] |= bankmask & (bits[idx] >> shift);
+		chip->buffer[bank] |= bitmask;
 	}
 	__gen_74x164_write_config(chip);
 	mutex_unlock(&chip->lock);
-- 
2.23.0
