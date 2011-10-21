From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] gpio: fix build error in include/asm-generic/gpio.h
Date: Fri, 21 Oct 2011 13:39:57 +0200
Message-ID: <201110211339.59280.arnd@arndb.de>
References: <CAO_0yfOa7B4tB1nJg8c_5a612KjNmPh_aMvS=wHhfU_maAvZAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:57403 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754246Ab1JULk1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 21 Oct 2011 07:40:27 -0400
In-Reply-To: <CAO_0yfOa7B4tB1nJg8c_5a612KjNmPh_aMvS=wHhfU_maAvZAg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hamo <hamo.by@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>

On Friday 21 October 2011, Hamo wrote:
> Should call the platform-specific __gpio_{get,set}_value
> instead of generic gpio_{get,set}_value
> 
> Signed-off-by: Yang Bai <hamo.by@gmail.com>
> ---
>  include/asm-generic/gpio.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Arnd Bergmann <arnd@arndb.de>

Grant, can you put that into the gpio tree?

> diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
> index d494001..6acff5d 100644
> --- a/include/asm-generic/gpio.h
> +++ b/include/asm-generic/gpio.h
> @@ -220,13 +220,13 @@ static inline int gpio_cansleep(unsigned gpio)
>  static inline int gpio_get_value_cansleep(unsigned gpio)
>  {
>  	might_sleep();
> -	return gpio_get_value(gpio);
> +	return __gpio_get_value(gpio);
>  }
> 
>  static inline void gpio_set_value_cansleep(unsigned gpio, int value)
>  {
>  	might_sleep();
> -	gpio_set_value(gpio, value);
> +	__gpio_set_value(gpio, value);
>  }
> 
>  #endif /* !CONFIG_GPIOLIB */
> -- 
> 1.7.1
> 
