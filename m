From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2 7/7] gpio: pcie-idio-24: Utilize for_each_set_port_word macro
Date: Tue,  8 May 2018 09:28:17 -0400
Message-ID: <57b9e48b8aa9d80c24c6e21bf3d0383deb95e1e9.1525785532.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-pcie-idio-24.c | 102 +++++++++++--------------------
 1 file changed, 36 insertions(+), 66 deletions(-)

diff --git a/drivers/gpio/gpio-pcie-idio-24.c b/drivers/gpio/gpio-pcie-idio-24.c
index f953541e7890..a0c81724ce4d 100644
--- a/drivers/gpio/gpio-pcie-idio-24.c
+++ b/drivers/gpio/gpio-pcie-idio-24.c
@@ -199,41 +199,21 @@ static int idio_24_gpio_get_multiple(struct gpio_chip *chip,
 {
 	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
 	size_t i;
-	const unsigned int gpio_reg_size = 8;
-	unsigned int bits_offset;
-	size_t word_index;
-	unsigned int word_offset;
-	unsigned long word_mask;
-	const unsigned long port_mask = GENMASK(gpio_reg_size - 1, 0);
-	unsigned long port_state;
+	size_t word;
+	unsigned int offset;
 	void __iomem *ports[] = {
 		&idio24gpio->reg->out0_7, &idio24gpio->reg->out8_15,
 		&idio24gpio->reg->out16_23, &idio24gpio->reg->in0_7,
 		&idio24gpio->reg->in8_15, &idio24gpio->reg->in16_23,
 	};
+	const size_t num_ports = ARRAY_SIZE(ports) + 1;
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
-
+	for_each_set_port_word(i, word, offset, mask, num_ports, 8) {
 		/* read bits from current gpio port (port 6 is TTL GPIO) */
 		if (i < 6)
 			port_state = ioread8(ports[i]);
@@ -243,7 +223,7 @@ static int idio_24_gpio_get_multiple(struct gpio_chip *chip,
 			port_state = ioread8(&idio24gpio->reg->ttl_in0_7);
 
 		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= port_state << word_offset;
+		bits[word] |= port_state << offset;
 	}
 
 	return 0;
@@ -295,58 +275,48 @@ static void idio_24_gpio_set_multiple(struct gpio_chip *chip,
 {
 	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
 	size_t i;
-	unsigned long bits_offset;
-	unsigned long gpio_mask;
-	const unsigned int gpio_reg_size = 8;
-	const unsigned long port_mask = GENMASK(gpio_reg_size, 0);
-	unsigned long flags;
-	unsigned int out_state;
+	size_t word;
+	unsigned int offset;
 	void __iomem *ports[] = {
 		&idio24gpio->reg->out0_7, &idio24gpio->reg->out8_15,
 		&idio24gpio->reg->out16_23
 	};
+	const size_t num_ports = ARRAY_SIZE(ports) + 1;
+	unsigned int iomask;
+	unsigned int bitmask;
+	unsigned long flags;
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
+	unsigned int out_state;
+
+	for_each_set_port_word(i, word, offset, mask, num_ports, 8) {
+		iomask = mask[word] >> offset;
+		bitmask = iomask & (bits[word] >> offset);
+
+		raw_spin_lock_irqsave(&idio24gpio->lock, flags);
+
+		/* read bits from current gpio port (port 6 is TTL GPIO) */
+		if (i < 6) {
+			out_state = ioread8(ports[i]) & ~iomask;
+		} else if (ioread8(&idio24gpio->reg->ctl) & out_mode_mask) {
+			out_state = ioread8(&idio24gpio->reg->ttl_out0_7);
+		} else {
+			/* skip TTL GPIO if set for input */
+			raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
 			continue;
 		}
 
-		raw_spin_lock_irqsave(&idio24gpio->lock, flags);
+		/* set requested bit states */
+		out_state &= ~iomask;
+		out_state |= bitmask;
 
-		/* process output lines */
-		out_state = ioread8(ports[i]) & ~gpio_mask;
-		out_state |= (*bits >> bits_offset) & gpio_mask;
-		iowrite8(out_state, ports[i]);
+		/* write bits for current gpio port (port 6 is TTL GPIO) */
+		if (i < 6)
+			iowrite8(out_state, ports[i]);
+		else
+			iowrite8(out_state, &idio24gpio->reg->ttl_out0_7);
 
 		raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
 	}
-
-	/* check if setting TTL lines and if they are in output mode */
-	if (!ttl_mask || !(ioread8(&idio24gpio->reg->ctl) & out_mode_mask))
-		return;
-
-	/* handle TTL output */
-	raw_spin_lock_irqsave(&idio24gpio->lock, flags);
-
-	/* process output lines */
-	out_state = ioread8(&idio24gpio->reg->ttl_out0_7) & ~ttl_mask;
-	out_state |= ttl_bits;
-	iowrite8(out_state, &idio24gpio->reg->ttl_out0_7);
-
-	raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
 }
 
 static void idio_24_irq_ack(struct irq_data *data)
-- 
2.17.0
