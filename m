Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f193.google.com ([209.85.219.193]:45517 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388195AbfJEShg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Oct 2019 14:37:36 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v15 06/14] gpio: ws16c48: Utilize for_each_set_clump8 macro
Date: Sat,  5 Oct 2019 14:37:00 -0400
Message-ID: <b91b8d3f195d10187df1ac3a66bb1332887a3575.1570299719.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1570299719.git.vilhelm.gray@gmail.com>
References: <cover.1570299719.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc: akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de, sean.nyekjaer@prevas.dk, morten.tiljeset@prevas.dk, William Breathitt Gray <vilhelm.gray@gmail.com>
Message-ID: <20191005183700.Pq2Ey2y5X9MjiqYtLMfq6JboHwt9PqxM6EvYzhd_qTs@z>

Replace verbose implementation in get_multiple/set_multiple callbacks
with for_each_set_clump8 macro to simplify code and improve clarity.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-ws16c48.c | 73 ++++++++++---------------------------
 1 file changed, 20 insertions(+), 53 deletions(-)

diff --git a/drivers/gpio/gpio-ws16c48.c b/drivers/gpio/gpio-ws16c48.c
index e0ef66b6a237..51aaa5c17fce 100644
--- a/drivers/gpio/gpio-ws16c48.c
+++ b/drivers/gpio/gpio-ws16c48.c
@@ -126,42 +126,19 @@ static int ws16c48_gpio_get_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct ws16c48_gpio *const ws16c48gpio = gpiochip_get_data(chip);
-	const unsigned int gpio_reg_size = 8;
-	size_t i;
-	const size_t num_ports = chip->ngpio / gpio_reg_size;
-	unsigned int bits_offset;
-	size_t word_index;
-	unsigned int word_offset;
-	unsigned long word_mask;
-	const unsigned long port_mask = GENMASK(gpio_reg_size - 1, 0);
+	unsigned long offset;
+	unsigned long gpio_mask;
+	unsigned int port_addr;
 	unsigned long port_state;
 
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	/* get bits are evaluated a gpio port register at a time */
-	for (i = 0; i < num_ports; i++) {
-		/* gpio offset in bits array */
-		bits_offset = i * gpio_reg_size;
+	for_each_set_clump8(offset, gpio_mask, mask, chip->ngpio) {
+		port_addr = ws16c48gpio->base + offset / 8;
+		port_state = inb(port_addr) & gpio_mask;
 
-		/* word index for bits array */
-		word_index = BIT_WORD(bits_offset);
-
-		/* gpio offset within current word of bits array */
-		word_offset = bits_offset % BITS_PER_LONG;
-
-		/* mask of get bits for current gpio within current word */
-		word_mask = mask[word_index] & (port_mask << word_offset);
-		if (!word_mask) {
-			/* no get bits in this port so skip to next one */
-			continue;
-		}
-
-		/* read bits from current gpio port */
-		port_state = inb(ws16c48gpio->base + i);
-
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= (port_state << word_offset) & word_mask;
+		bitmap_set_value8(bits, port_state, offset);
 	}
 
 	return 0;
@@ -195,39 +172,29 @@ static void ws16c48_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct ws16c48_gpio *const ws16c48gpio = gpiochip_get_data(chip);
-	unsigned int i;
-	const unsigned int gpio_reg_size = 8;
-	unsigned int port;
-	unsigned int iomask;
-	unsigned int bitmask;
+	unsigned long offset;
+	unsigned long gpio_mask;
+	size_t index;
+	unsigned int port_addr;
+	unsigned long bitmask;
 	unsigned long flags;
 
-	/* set bits are evaluated a gpio register size at a time */
-	for (i = 0; i < chip->ngpio; i += gpio_reg_size) {
-		/* no more set bits in this mask word; skip to the next word */
-		if (!mask[BIT_WORD(i)]) {
-			i = (BIT_WORD(i) + 1) * BITS_PER_LONG - gpio_reg_size;
-			continue;
-		}
-
-		port = i / gpio_reg_size;
+	for_each_set_clump8(offset, gpio_mask, mask, chip->ngpio) {
+		index = offset / 8;
+		port_addr = ws16c48gpio->base + index;
 
 		/* mask out GPIO configured for input */
-		iomask = mask[BIT_WORD(i)] & ~ws16c48gpio->io_state[port];
-		bitmask = iomask & bits[BIT_WORD(i)];
+		gpio_mask &= ~ws16c48gpio->io_state[index];
+		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
 
 		raw_spin_lock_irqsave(&ws16c48gpio->lock, flags);
 
 		/* update output state data and set device gpio register */
-		ws16c48gpio->out_state[port] &= ~iomask;
-		ws16c48gpio->out_state[port] |= bitmask;
-		outb(ws16c48gpio->out_state[port], ws16c48gpio->base + port);
+		ws16c48gpio->out_state[index] &= ~gpio_mask;
+		ws16c48gpio->out_state[index] |= bitmask;
+		outb(ws16c48gpio->out_state[index], port_addr);
 
 		raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
-
-		/* prepare for next gpio register set */
-		mask[BIT_WORD(i)] >>= gpio_reg_size;
-		bits[BIT_WORD(i)] >>= gpio_reg_size;
 	}
 }
 
-- 
2.23.0
