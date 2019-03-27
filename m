From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v13 10/11] gpio: 74x164: Utilize the for_each_set_clump8
 macro
Date: Wed, 27 Mar 2019 14:33:14 +0200
Message-ID: <20190327123314.GJ9224@smile.fi.intel.com>
References: <cover.1553661964.git.vilhelm.gray@gmail.com>
 <645f16f1d1ad3f215e34a82f457e06725fcf8f56.1553661964.git.vilhelm.gray@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <645f16f1d1ad3f215e34a82f457e06725fcf8f56.1553661964.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linus.walleij@linaro.org, bgolaszewski@baylibre.com, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, preid@electromag.com.au, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 27, 2019 at 02:02:39PM +0900, William Breathitt Gray wrote:
> Replace verbose implementation in set_multiple callback with
> for_each_set_clump8 macro to simplify code and improve clarity.

> +	for_each_set_clump8(offset, bankmask, mask, chip->registers * 8) {

> +		bank = (chip->registers - 1) - (offset / 8);

Excessive parens, but it's minor.

> +		bitmask = bitmap_get_value8(bits, offset) & bankmask;
>  
>  		chip->buffer[bank] &= ~bankmask;
> +		chip->buffer[bank] |= bitmask;
>  	}

-- 
With Best Regards,
Andy Shevchenko
