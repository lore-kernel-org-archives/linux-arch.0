From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 1/1] gpio: lib: Add gpio_is_enabled() to get pin mode
Date: Wed, 2 Nov 2016 17:47:17 +0530
Message-ID: <1478089037-26441-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linus.walleij@linaro.org, gnurou@gmail.com, arnd@arndb.de
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-arch.vger.kernel.org

Many of devices/SoCs supports the GPIO and special IO function
from their pins. On such cases, there is always configuration
bits to select the mode of pin as GPIO or as the special IO mode.
The functional modes are selected by pinmux option.

When device booted and reach to kernel, it is not possible to get
the current configuration of pin whether it is in GPIO mode or
in special IO mode without configurations.

Add APIs to return the current mode of pins without requesting it
as GPIO to find out the current mode.
This helps on dumping the pin configuration from debug/test utility
to get the current mode GPIO or functional mode.

The typical utility looks as:
pin_dump(pin)
{
	if(gpio_is_enabled(pin)) {
		dump direction using get_direction()
	} else {
		dump pinmux option and its configurations.
	}
}

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpiolib.c        | 22 ++++++++++++++++++++++
 include/asm-generic/gpio.h    |  4 ++++
 include/linux/gpio/consumer.h |  8 ++++++++
 include/linux/gpio/driver.h   |  5 +++++
 4 files changed, 39 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 93ed0e0..4cba61d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2356,6 +2356,28 @@ int gpiod_is_active_low(const struct gpio_desc *desc)
 }
 EXPORT_SYMBOL_GPL(gpiod_is_active_low);
 
+/**
+ * gpiod_is_enabled - Finds whether pin is in GPIO mode or in functional mode.
+ * @desc: the gpio descriptor to check.
+ *
+ * Returns 1 if the GPIO mode is enabled of pin, 0 if it is in functional mode
+ * or negative error if any failure.
+ */
+int gpiod_is_enabled(const struct gpio_desc *desc)
+{
+	struct gpio_chip *chip;
+
+	VALIDATE_DESC(desc);
+	chip = desc->gdev->chip;
+	if (!chip->is_enabled) {
+		gpiod_dbg(desc, "%s: missing is_enabled() ops\n", __func__);
+		return -ENOTSUPP;
+	}
+
+	return chip->is_enabled(chip, gpio_chip_hwgpio(desc));
+}
+EXPORT_SYMBOL_GPL(gpiod_is_enabled);
+
 /* I/O calls are only valid after configuration completed; the relevant
  * "is this a valid GPIO" error checks should already have been done.
  *
diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index 8ca627d..90d15cb 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -89,6 +89,10 @@ static inline void gpio_set_value_cansleep(unsigned gpio, int value)
 	return gpiod_set_raw_value_cansleep(gpio_to_desc(gpio), value);
 }
 
+static inline int gpio_is_enabled(unsigned gpio)
+{
+	return gpiod_is_enabled(gpio_to_desc(gpio));
+}
 
 /* A platform's <asm/gpio.h> code may want to inline the I/O calls when
  * the GPIO is constant and refers to some always-present controller,
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index fb0fde6..9f9e1d3 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -124,6 +124,7 @@ int gpiod_set_debounce(struct gpio_desc *desc, unsigned debounce);
 
 int gpiod_is_active_low(const struct gpio_desc *desc);
 int gpiod_cansleep(const struct gpio_desc *desc);
+int gpiod_is_enabled(const struct gpio_desc *desc);
 
 int gpiod_to_irq(const struct gpio_desc *desc);
 
@@ -389,6 +390,13 @@ static inline int gpiod_cansleep(const struct gpio_desc *desc)
 	return 0;
 }
 
+static inline int gpiod_is_enabled(const struct gpio_desc *desc)
+{
+	/* GPIO can never have been requested */
+	WARN_ON(1);
+	return 0;
+}
+
 static inline int gpiod_to_irq(const struct gpio_desc *desc)
 {
 	/* GPIO can never have been requested */
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 2dfcf25..7b67b06 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -60,6 +60,9 @@ enum single_ended_mode {
  *	with LINE_MODE_OPEN_SOURCE as mode argument.
  * @to_irq: optional hook supporting non-static gpio_to_irq() mappings;
  *	implementation may not sleep
+ * @is_enabled: optional hook for finding whether pin is in GPIO mode or in
+ *	functional mode. returns value for pin mode "offset", 0 for functional,
+ *	1 for GPIO mode or negative error.
  * @dbg_show: optional routine to show contents in debugfs; default code
  *	will be used when this is omitted, but custom code can show extra
  *	state (such as pullup/pulldown configuration).
@@ -159,6 +162,8 @@ struct gpio_chip {
 
 	int			(*to_irq)(struct gpio_chip *chip,
 						unsigned offset);
+	int			(*is_enabled)(struct gpio_chip *chip,
+						unsigned offset);
 
 	void			(*dbg_show)(struct seq_file *s,
 						struct gpio_chip *chip);
-- 
2.1.4

