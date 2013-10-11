From: Alex Courbot <acourbot@nvidia.com>
Subject: Re: [PATCH v2 3/3] gpiolib: add gpiod_get() and gpiod_put() functions
Date: Fri, 11 Oct 2013 15:31:19 -0700
Message-ID: <52587C37.3070606@nvidia.com>
References: <1381515273-25466-1-git-send-email-acourbot@nvidia.com> <1381515273-25466-4-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17236 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543Ab3JKWbV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Oct 2013 18:31:21 -0400
In-Reply-To: <1381515273-25466-4-git-send-email-acourbot@nvidia.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "gnurou@gmail.com" <gnurou@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

> +#else
> +static struct device_node *of_find_gpio(struct device *dev, const char *id
> +					unsigned int idx, unsigned long flags)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +#endif

... and of course I forgot to fix the main compilation error. Linus, 
would you mind squashing what follows into this patch? Apologies for
the inconvenience.

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 05b9981..e1d1a15 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2172,8 +2172,8 @@ static struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 	return desc;
 }
 #else
-static struct device_node *of_find_gpio(struct device *dev, const char *id
-					unsigned int idx, unsigned long flags)
+static struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
+				      unsigned int idx, unsigned long *flags)
 {
 	return ERR_PTR(-ENODEV);
 }
