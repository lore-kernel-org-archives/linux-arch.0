From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RFC 2/5] gpiolib: export descriptor-based GPIO interface
Date: Wed, 04 Sep 2013 13:58:14 -0600
Message-ID: <522790D6.6080803@wwwdotorg.org>
References: <1378294169-22661-1-git-send-email-acourbot@nvidia.com> <1378294169-22661-3-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1378294169-22661-3-git-send-email-acourbot@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, gnurou@gmail.com, linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 09/04/2013 05:29 AM, Alexandre Courbot wrote:
> This patch exports the gpiod_* family of API functions, a safer
> alternative to the legacy gpio interface. Differences between the gpiod
> and gpio APIs are:
> 
> - gpio works with integers, whereas gpiod operates on opaque handlers
>   which cannot be forged or used before proper acquisition
> - gpiod get/set functions are aware of the active low state of a GPIO
> - gpio consumers should now include <linux/gpio/consumer.h> to access
>   the new interface, whereas chips drivers will use
>   <linux/gpio/driver.h>
> 
> The legacy gpio API is now built as inline functions on top of gpiod.
> 

> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h

> +struct gpio_chip {

> +	int			(*get_direction)(struct gpio_chip *chip,
> +						unsigned offset);
> +	int			(*direction_input)(struct gpio_chip *chip,
> +						unsigned offset);
> +	int			(*get)(struct gpio_chip *chip,
> +						unsigned offset);
> +	int			(*direction_output)(struct gpio_chip *chip,
> +						unsigned offset, int value);
> +	int			(*set_debounce)(struct gpio_chip *chip,
> +						unsigned offset,
> +						unsigned debounce);
> +
> +	void			(*set)(struct gpio_chip *chip,
> +						unsigned offset, int value);
> +

Minor nit: It might be nice to sort/group these entries more cohesively,
i.e. get_direction, direction_input, direction_output, get, set,
set_debounce?
