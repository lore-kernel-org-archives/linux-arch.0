From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH 2/9] gpiolib: use gpio_chips list in gpiolib_sysfs_init
Date: Sun,  3 Feb 2013 01:29:25 +0900
Message-ID: <1359822572-26009-4-git-send-email-acourbot@nvidia.com>
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

Use the small list of GPIO chips instead of parsing the whole GPIO
number space.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpio/gpiolib.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 0050766..4ceb4a7 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -973,7 +973,7 @@ static int __init gpiolib_sysfs_init(void)
 {
 	int		status;
 	unsigned long	flags;
-	unsigned	gpio;
+	struct gpio_chip *chip;
 
 	status = class_register(&gpio_class);
 	if (status < 0)
@@ -986,10 +986,7 @@ static int __init gpiolib_sysfs_init(void)
 	 * registered, and so arch_initcall() can always gpio_export().
 	 */
 	spin_lock_irqsave(&gpio_lock, flags);
-	for (gpio = 0; gpio < ARCH_NR_GPIOS; gpio++) {
-		struct gpio_chip	*chip;
-
-		chip = gpio_desc[gpio].chip;
+	list_for_each_entry(chip, &gpio_chips, list) {
 		if (!chip || chip->exported)
 			continue;
 
-- 
1.8.1.1
