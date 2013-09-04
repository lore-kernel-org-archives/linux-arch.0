Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:45461 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755664Ab3IDT4y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 Sep 2013 15:56:54 -0400
Message-ID: <52279082.5010105@wwwdotorg.org>
Date: Wed, 04 Sep 2013 13:56:50 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
Subject: Re: [RFC 4/5] gpiolib: add gpiod_get() and gpiod_put() functions
References: <1378294169-22661-1-git-send-email-acourbot@nvidia.com> <1378294169-22661-5-git-send-email-acourbot@nvidia.com>
In-Reply-To: <1378294169-22661-5-git-send-email-acourbot@nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, gnurou@gmail.com, linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org
Message-ID: <20130904195650.FNBZEnQT0Ng_EjvrLdwRZnWT7x5uqZhpT4Du8PNh-Eo@z>

On 09/04/2013 05:29 AM, Alexandre Courbot wrote:
> Add gpiod_get() and gpiod_put() functions that provide safer handling of
> GPIOs.
> 
> These functions put the GPIO framework in line with the conventions of
> other frameworks in the kernel, and help ensure every GPIO is declared
> properly and valid while it is used.

> diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h

> +struct gpio_desc *__must_check gpiod_get(struct device *dev,
> +					 const char *con_id);
> +void gpiod_put(struct gpio_desc *desc);

It might be nice to add an "int index" parameter to this function. For
example, a bit-banged parallel bus protocol driver might have 1
chip-select GPIO, 1 clock GPIO, and 8 data GPIOs. gpiod_get(dev, "bus",
0)..gpiod_get(dev, "bus", 7) might be nicer than gpiod_get(dev,
"bus0")..gpiod_get(dev, "bus7")? Possibly for client-simplicity,
implement both gpiod_get(dev, con_id) (as an inline wrapper for ...) and
gpiod_get_index(dev, con_id, index)?

In DT terms, this would map to:

cs-gpios = <&gpio 3 0>;
clock-gpios = <&gpio 5 0>;
bus-gpios = <&gpio 10 0 ... &gpio 17 0>;

... and with the mapping table registration mechanism, we could
presumably add "int index" to struct gpiod_lookup.
