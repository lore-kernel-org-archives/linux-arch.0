From: "William Breathitt Gray" <vilhelm.gray@gmail.com>
Subject: [PATCH v17 12/14] gpio: pisosr: Utilize the for_each_set_clump8 macro
Date: Wed,  9 Oct 2019 11:27:10 -0400
Message-ID: <21651.3480337866$1570931115@news.gmane.org>
References: <cover.1570633189.git.vilhelm.gray@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1570633189.git.vilhelm.gray@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "preid@electromag.com.au" <preid@electromag.com.au>, "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "morten.tiljeset@prevas.dk" <morten.tiljeset@prevas.dk>, "sean.nyekjaer@prevas.dk" <sean.nyekjaer@prevas.dk>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "lukas@wunner.de" <lukas@wunner.de>, "geert@linux-m68k.org" <geert@linux-m68k.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

Replace verbose implementation in get_multiple callback with
for_each_set_clump8 macro to simplify code and improve clarity.

Cc: Morten Hein Tiljeset <morten.tiljeset@prevas.dk>
Cc: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-pisosr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-pisosr.c b/drivers/gpio/gpio-pisosr.c
index f809a5a8e9eb..9ab2c044ef52 100644
--- a/drivers/gpio/gpio-pisosr.c
+++ b/drivers/gpio/gpio-pisosr.c
@@ -96,16 +96,16 @@ static int pisosr_gpio_get_multiple(struct gpio_chip *chip,
 				    unsigned long *mask, unsigned long *bits)
 {
 	struct pisosr_gpio *gpio = gpiochip_get_data(chip);
-	unsigned int nbytes = DIV_ROUND_UP(chip->ngpio, 8);
-	unsigned int i, j;
+	unsigned long offset;
+	unsigned long gpio_mask;
+	unsigned long buffer_state;
 
 	pisosr_gpio_refresh(gpio);
 
 	bitmap_zero(bits, chip->ngpio);
-	for (i = 0; i < nbytes; i++) {
-		j = i / sizeof(unsigned long);
-		bits[j] |= ((unsigned long) gpio->buffer[i])
-			   << (8 * (i % sizeof(unsigned long)));
+	for_each_set_clump8(offset, gpio_mask, mask, chip->ngpio) {
+		buffer_state = gpio->buffer[offset / 8] & gpio_mask;
+		bitmap_set_value8(bits, buffer_state, offset);
 	}
 
 	return 0;
-- 
2.23.0
