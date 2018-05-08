From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2 4/7] gpio: gpio-mm: Utilize for_each_set_port_word macro
Date: Tue,  8 May 2018 09:27:24 -0400
Message-ID: <eacf1b8619b82f17063364e8701d0d7d0ab800ed.1525785532.git.vilhelm.gray@gmail.com>
References: <cover.1525785532.git.vilhelm.gray@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1525785532.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, William Breathitt Gray <vilhelm.gray@gmail.com>
List-Id: linux-arch.vger.kernel.org

Replace boilerplate code in get_multiple/set_multiple callbacks with
for_each_set_port_word macro to simplify code and improve clarity.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-gpio-mm.c | 67 +++++++++----------------------------
 1 file changed, 16 insertions(+), 51 deletions(-)

diff --git a/drivers/gpio/gpio-gpio-mm.c b/drivers/gpio/gpio-gpio-mm.c
index b56ff2efbf36..0ede33e7e251 100644
--- a/drivers/gpio/gpio-gpio-mm.c
+++ b/drivers/gpio/gpio-gpio-mm.c
@@ -172,46 +172,23 @@ static int gpiomm_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	return !!(port_state & mask);
 }
 
+static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
+
 static int gpiomm_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	unsigned long *bits)
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
 	size_t i;
-	static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
-	const unsigned int gpio_reg_size = 8;
-	unsigned int bits_offset;
-	size_t word_index;
-	unsigned int word_offset;
-	unsigned long word_mask;
-	const unsigned long port_mask = GENMASK(gpio_reg_size - 1, 0);
+	size_t word;
+	unsigned int offset;
 	unsigned long port_state;
 
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	/* get bits are evaluated a gpio port register at a time */
-	for (i = 0; i < ARRAY_SIZE(ports); i++) {
-		/* gpio offset in bits array */
-		bits_offset = i * gpio_reg_size;
-
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
+	for_each_set_port_word(i, word, offset, mask, ARRAY_SIZE(ports), 8) {
 		port_state = inb(gpiommgpio->base + ports[i]);
-
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= port_state << word_offset;
+		bits[word] |= port_state << offset;
 	}
 
 	return 0;
@@ -242,37 +219,25 @@ static void gpiomm_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-	unsigned int i;
-	const unsigned int gpio_reg_size = 8;
-	unsigned int port;
-	unsigned int out_port;
+	size_t i;
+	size_t word;
+	unsigned int offset;
+	unsigned int iomask;
 	unsigned int bitmask;
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
-		out_port = (port > 2) ? port + 1 : port;
-		bitmask = mask[BIT_WORD(i)] & bits[BIT_WORD(i)];
+	for_each_set_port_word(i, word, offset, mask, ARRAY_SIZE(ports), 8) {
+		iomask = mask[word] >> offset;
+		bitmask = iomask & (bits[word] >> offset);
 
 		spin_lock_irqsave(&gpiommgpio->lock, flags);
 
 		/* update output state data and set device gpio register */
-		gpiommgpio->out_state[port] &= ~mask[BIT_WORD(i)];
-		gpiommgpio->out_state[port] |= bitmask;
-		outb(gpiommgpio->out_state[port], gpiommgpio->base + out_port);
+		gpiommgpio->out_state[i] &= ~iomask;
+		gpiommgpio->out_state[i] |= bitmask;
+		outb(gpiommgpio->out_state[i], gpiommgpio->base + ports[i]);
 
 		spin_unlock_irqrestore(&gpiommgpio->lock, flags);
-
-		/* prepare for next gpio register set */
-		mask[BIT_WORD(i)] >>= gpio_reg_size;
-		bits[BIT_WORD(i)] >>= gpio_reg_size;
 	}
 }
 
-- 
2.17.0
