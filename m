From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH 3/9] gpiolib: use gpio_chips list in gpiochip_find
Date: Sun,  3 Feb 2013 01:29:26 +0900
Message-ID: <1359822572-26009-5-git-send-email-acourbot@nvidia.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, gnurou@gmail.com, Alexandre Courbot <acourbot@nvidia.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Using the GPIO chips list is much faster than parsing the entire GPIO
number space.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpio/gpiolib.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 4ceb4a7..92f9ee4 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1194,20 +1194,17 @@ struct gpio_chip *gpiochip_find(void *data,
 				int (*match)(struct gpio_chip *chip,
 					     void *data))
 {
-	struct gpio_chip *chip = NULL;
+	struct gpio_chip *chip;
 	unsigned long flags;
-	int i;
 
 	spin_lock_irqsave(&gpio_lock, flags);
-	for (i = 0; i < ARCH_NR_GPIOS; i++) {
-		if (!gpio_desc[i].chip)
-			continue;
-
-		if (match(gpio_desc[i].chip, data)) {
-			chip = gpio_desc[i].chip;
+	list_for_each_entry(chip, &gpio_chips, list)
+		if (match(chip, data))
 			break;
-		}
-	}
+
+	/* No match? */
+	if (&chip->list == &gpio_chips)
+		chip = NULL;
 	spin_unlock_irqrestore(&gpio_lock, flags);
 
 	return chip;
-- 
1.8.1.1
