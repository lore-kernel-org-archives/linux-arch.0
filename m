From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v7 8/8] gpio: pcie-idio-24: Utilize for_each_set_clump8 macro
Date: Sat, 12 Jan 2019 10:50:14 +0900
Message-ID: <1c82bec73e574b11504c1244d6f3d099a1cbb66c.1547257386.git.vilhelm.gray@gmail.com>
References: <cover.1547257386.git.vilhelm.gray@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1547257386.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org
Cc: akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk, William Breathitt Gray <vilhelm.gray@gmail.com>
List-Id: linux-arch.vger.kernel.org

Replace verbose implementation in get_multiple/set_multiple callbacks
with for_each_set_clump8 macro to simplify code and improve clarity.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-pcie-idio-24.c | 109 ++++++++++++-------------------
 1 file changed, 40 insertions(+), 69 deletions(-)

diff --git a/drivers/gpio/gpio-pcie-idio-24.c b/drivers/gpio/gpio-pcie-idio-24.c
index 52f1647a46fd..1cfe39fb8e9e 100644
--- a/drivers/gpio/gpio-pcie-idio-24.c
+++ b/drivers/gpio/gpio-pcie-idio-24.c
@@ -198,52 +198,34 @@ static int idio_24_gpio_get_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
-	size_t i;
-	const unsigned int gpio_reg_size = 8;
-	unsigned int bits_offset;
-	size_t word_index;
-	unsigned int word_offset;
-	unsigned long word_mask;
-	const unsigned long port_mask = GENMASK(gpio_reg_size - 1, 0);
-	unsigned long port_state;
+	unsigned int offset;
+	unsigned long gpio_mask;
 	void __iomem *ports[] = {
 		&idio24gpio->reg->out0_7, &idio24gpio->reg->out8_15,
 		&idio24gpio->reg->out16_23, &idio24gpio->reg->in0_7,
 		&idio24gpio->reg->in8_15, &idio24gpio->reg->in16_23,
 	};
+	size_t index;
+	unsigned long port_state;
 	const unsigned long out_mode_mask = BIT(1);
 
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	/* get bits are evaluated a gpio port register at a time */
-	for (i = 0; i < ARRAY_SIZE(ports) + 1; i++) {
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
+	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+		index = offset / 8;
 
 		/* read bits from current gpio port (port 6 is TTL GPIO) */
-		if (i < 6)
-			port_state = ioread8(ports[i]);
+		if (index < 6)
+			port_state = ioread8(ports[index]);
 		else if (ioread8(&idio24gpio->reg->ctl) & out_mode_mask)
 			port_state = ioread8(&idio24gpio->reg->ttl_out0_7);
 		else
 			port_state = ioread8(&idio24gpio->reg->ttl_in0_7);
 
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= (port_state << word_offset) & word_mask;
+		port_state &= gpio_mask;
+
+		bitmap_set_value8(bits, port_state, offset);
 	}
 
 	return 0;
@@ -294,59 +276,48 @@ static void idio_24_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
-	size_t i;
-	unsigned long bits_offset;
+	unsigned int offset;
 	unsigned long gpio_mask;
-	const unsigned int gpio_reg_size = 8;
-	const unsigned long port_mask = GENMASK(gpio_reg_size, 0);
-	unsigned long flags;
-	unsigned int out_state;
 	void __iomem *ports[] = {
 		&idio24gpio->reg->out0_7, &idio24gpio->reg->out8_15,
 		&idio24gpio->reg->out16_23
 	};
+	size_t index;
+	unsigned int bitmask;
+	unsigned long flags;
+	unsigned int out_state;
 	const unsigned long out_mode_mask = BIT(1);
-	const unsigned int ttl_offset = 48;
-	const size_t ttl_i = BIT_WORD(ttl_offset);
-	const unsigned int word_offset = ttl_offset % BITS_PER_LONG;
-	const unsigned long ttl_mask = (mask[ttl_i] >> word_offset) & port_mask;
-	const unsigned long ttl_bits = (bits[ttl_i] >> word_offset) & ttl_mask;
-
-	/* set bits are processed a gpio port register at a time */
-	for (i = 0; i < ARRAY_SIZE(ports); i++) {
-		/* gpio offset in bits array */
-		bits_offset = i * gpio_reg_size;
-
-		/* check if any set bits for current port */
-		gpio_mask = (*mask >> bits_offset) & port_mask;
-		if (!gpio_mask) {
-			/* no set bits for this port so move on to next port */
-			continue;
-		}
 
-		raw_spin_lock_irqsave(&idio24gpio->lock, flags);
+	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+		index = offset / 8;
 
-		/* process output lines */
-		out_state = ioread8(ports[i]) & ~gpio_mask;
-		out_state |= (*bits >> bits_offset) & gpio_mask;
-		iowrite8(out_state, ports[i]);
+		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
 
-		raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
-	}
+		raw_spin_lock_irqsave(&idio24gpio->lock, flags);
 
-	/* check if setting TTL lines and if they are in output mode */
-	if (!ttl_mask || !(ioread8(&idio24gpio->reg->ctl) & out_mode_mask))
-		return;
+		/* read bits from current gpio port (port 6 is TTL GPIO) */
+		if (index < 6) {
+			out_state = ioread8(ports[index]);
+		} else if (ioread8(&idio24gpio->reg->ctl) & out_mode_mask) {
+			out_state = ioread8(&idio24gpio->reg->ttl_out0_7);
+		} else {
+			/* skip TTL GPIO if set for input */
+			raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
+			continue;
+		}
 
-	/* handle TTL output */
-	raw_spin_lock_irqsave(&idio24gpio->lock, flags);
+		/* set requested bit states */
+		out_state &= ~gpio_mask;
+		out_state |= bitmask;
 
-	/* process output lines */
-	out_state = ioread8(&idio24gpio->reg->ttl_out0_7) & ~ttl_mask;
-	out_state |= ttl_bits;
-	iowrite8(out_state, &idio24gpio->reg->ttl_out0_7);
+		/* write bits for current gpio port (port 6 is TTL GPIO) */
+		if (index < 6)
+			iowrite8(out_state, ports[index]);
+		else
+			iowrite8(out_state, &idio24gpio->reg->ttl_out0_7);
 
-	raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
+		raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
+	}
 }
 
 static void idio_24_irq_ack(struct irq_data *data)
-- 
2.20.1
