From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v16 14/14] gpio: pca953x: Utilize the for_each_set_clump8
 macro
Date: Mon, 7 Oct 2019 11:45:46 +0300
Message-ID: <20191007084546.GO32742@smile.fi.intel.com>
References: <cover.1570374078.git.vilhelm.gray@gmail.com>
 <e72393325e58778b7ba59c80c6b79c1f93b81d8d.1570374078.git.vilhelm.gray@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <e72393325e58778b7ba59c80c6b79c1f93b81d8d.1570374078.git.vilhelm.gray@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-gpio@vger.kernel.org, yamada.masahiro@socionext.com, linus.walleij@linaro.org, linux-pm@vger.kernel.org, linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org, morten.tiljeset@prevas.dk, sean.nyekjaer@prevas.dk, bgolaszewski@baylibre.com, lukas@wunner.de, geert@linux-m68k.org, akpm@linux-foundation.org, preid@electromag.com.au, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Sun, Oct 06, 2019 at 11:11:11AM -0400, William Breathitt Gray wrote:
> Replace verbose implementation in set_multiple callback with
> for_each_set_clump8 macro to simplify code and improve clarity.

I can test this along with 74x164 at the same time.

> Cc: Phil Reid <preid@electromag.com.au>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/gpio/gpio-pca953x.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index de5d1383f28d..10b669b8f27d 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -10,6 +10,7 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/bits.h>
> +#include <linux/bitops.h>
>  #include <linux/gpio/driver.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
> @@ -456,7 +457,8 @@ static void pca953x_gpio_set_multiple(struct gpio_chip *gc,
>  				      unsigned long *mask, unsigned long *bits)
>  {
>  	struct pca953x_chip *chip = gpiochip_get_data(gc);
> -	unsigned int bank_mask, bank_val;
> +	unsigned long offset;
> +	unsigned long bank_mask;
>  	int bank;
>  	u8 reg_val[MAX_BANK];
>  	int ret;
> @@ -466,15 +468,10 @@ static void pca953x_gpio_set_multiple(struct gpio_chip *gc,
>  	if (ret)
>  		goto exit;
>  
> -	for (bank = 0; bank < NBANK(chip); bank++) {
> -		bank_mask = mask[bank / sizeof(*mask)] >>
> -			   ((bank % sizeof(*mask)) * 8);
> -		if (bank_mask) {
> -			bank_val = bits[bank / sizeof(*bits)] >>
> -				  ((bank % sizeof(*bits)) * 8);
> -			bank_val &= bank_mask;
> -			reg_val[bank] = (reg_val[bank] & ~bank_mask) | bank_val;
> -		}
> +	for_each_set_clump8(offset, bank_mask, mask, gc->ngpio) {
> +		bank = offset / 8;
> +		reg_val[bank] &= ~bank_mask;
> +		reg_val[bank] |= bitmap_get_value8(bits, offset) & bank_mask;
>  	}
>  
>  	pca953x_write_regs(chip, chip->regs->output, reg_val);
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko
