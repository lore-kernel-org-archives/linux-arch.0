Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:43346 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932450Ab3DPJeQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Apr 2013 05:34:16 -0400
Received: by mail-wg0-f45.google.com with SMTP id l18so254487wgh.12
        for <linux-arch@vger.kernel.org>; Tue, 16 Apr 2013 02:34:14 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 1/4] gpio: convert selectors of GENERIC_GPIO to GPIOLIB
In-Reply-To: <1365445950-5736-2-git-send-email-gnurou@gmail.com>
References: <1365445950-5736-1-git-send-email-gnurou@gmail.com> <1365445950-5736-2-git-send-email-gnurou@gmail.com>
Date: Tue, 16 Apr 2013 10:34:11 +0100
Message-ID: <20130416093411.4A61D3E14C0@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Courbot <gnurou@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
Message-ID: <20130416093411.H5pEFd5O41eI-7tpzZEKXJHNxuA2wsDlQHLP4AIe1go@z>

On Mon,  8 Apr 2013 11:32:27 -0700, Alexandre Courbot <gnurou@gmail.com> wrote:
> From: Alexandre Courbot <acourbot@nvidia.com>
> 
> GENERIC_GPIO is now equivalent to GPIOLIB and features that depended on
> GENERIC_GPIO can now depend on GPIOLIB to allow removal of this option.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>  arch/unicore32/Kconfig               |  2 +-
>  drivers/extcon/Kconfig               |  2 +-
>  drivers/i2c/busses/Kconfig           |  4 ++--
>  drivers/i2c/muxes/Kconfig            |  2 +-
>  drivers/input/keyboard/Kconfig       |  6 +++---
>  drivers/input/misc/Kconfig           |  8 ++++----
>  drivers/input/mouse/Kconfig          |  2 +-
>  drivers/leds/Kconfig                 |  6 +++---
>  drivers/mtd/maps/Kconfig             |  2 +-
>  drivers/mtd/nand/Kconfig             |  2 +-
>  drivers/net/phy/Kconfig              |  2 +-
>  drivers/pinctrl/sh-pfc/Kconfig       | 26 +++++++++++++-------------
>  drivers/regulator/Kconfig            |  2 +-
>  drivers/reset/Kconfig                |  2 +-
>  drivers/spi/Kconfig                  |  8 ++++----
>  drivers/staging/android/Kconfig      |  2 +-
>  drivers/staging/iio/accel/Kconfig    |  2 +-
>  drivers/staging/iio/adc/Kconfig      |  2 +-
>  drivers/staging/iio/addac/Kconfig    |  2 +-
>  drivers/staging/iio/resolver/Kconfig |  4 ++--
>  drivers/staging/iio/trigger/Kconfig  |  2 +-
>  drivers/usb/phy/Kconfig              |  2 +-
>  drivers/video/Kconfig                |  2 +-
>  drivers/video/backlight/Kconfig      |  4 ++--
>  drivers/w1/masters/Kconfig           |  2 +-
>  include/linux/gpio.h                 |  6 +++---
>  26 files changed, 53 insertions(+), 53 deletions(-)
> 
> diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
> index 63521dc..468cd70 100644
> --- a/arch/unicore32/Kconfig
> +++ b/arch/unicore32/Kconfig
> @@ -156,7 +156,7 @@ source "mm/Kconfig"
>  
>  config LEDS
>  	def_bool y
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  
>  config ALIGNMENT_TRAP
>  	def_bool y
> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> index 5168a13..3297301 100644
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -16,7 +16,7 @@ comment "Extcon Device Drivers"
>  
>  config EXTCON_GPIO
>  	tristate "GPIO extcon support"
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	help
>  	  Say Y here to enable GPIO based extcon support. Note that GPIO
>  	  extcon supports single state per extcon instance.
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index adfee98..631736e 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -363,7 +363,7 @@ config I2C_BLACKFIN_TWI_CLK_KHZ
>  
>  config I2C_CBUS_GPIO
>  	tristate "CBUS I2C driver"
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	help
>  	  Support for CBUS access using I2C API. Mostly relevant for Nokia
>  	  Internet Tablets (770, N800 and N810).
> @@ -436,7 +436,7 @@ config I2C_EG20T
>  
>  config I2C_GPIO
>  	tristate "GPIO-based bitbanging I2C"
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	select I2C_ALGOBIT
>  	help
>  	  This is a very simple bitbanging I2C driver utilizing the
> diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
> index 0be5b83..40062ed 100644
> --- a/drivers/i2c/muxes/Kconfig
> +++ b/drivers/i2c/muxes/Kconfig
> @@ -7,7 +7,7 @@ menu "Multiplexer I2C Chip support"
>  
>  config I2C_MUX_GPIO
>  	tristate "GPIO-based I2C multiplexer"
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	help
>  	  If you say yes to this option, support will be included for a
>  	  GPIO based I2C multiplexer. This driver provides access to
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 6a195d5..62a2c0e 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -175,7 +175,7 @@ config KEYBOARD_EP93XX
>  
>  config KEYBOARD_GPIO
>  	tristate "GPIO Buttons"
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	help
>  	  This driver implements support for buttons connected
>  	  to GPIO pins of various CPUs (and some other chips).
> @@ -190,7 +190,7 @@ config KEYBOARD_GPIO
>  
>  config KEYBOARD_GPIO_POLLED
>  	tristate "Polled GPIO buttons"
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	select INPUT_POLLDEV
>  	help
>  	  This driver implements support for buttons connected
> @@ -241,7 +241,7 @@ config KEYBOARD_TCA8418
>  
>  config KEYBOARD_MATRIX
>  	tristate "GPIO driven matrix keypad support"
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	select INPUT_MATRIXKMAP
>  	help
>  	  Enable support for GPIO driven matrix keypad.
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index af80928..bb698e1 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -214,7 +214,7 @@ config INPUT_APANEL
>  config INPUT_GP2A
>  	tristate "Sharp GP2AP002A00F I2C Proximity/Opto sensor driver"
>  	depends on I2C
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	help
>  	  Say Y here if you have a Sharp GP2AP002A00F proximity/als combo-chip
>  	  hooked to an I2C bus.
> @@ -224,7 +224,7 @@ config INPUT_GP2A
>  
>  config INPUT_GPIO_TILT_POLLED
>  	tristate "Polled GPIO tilt switch"
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	select INPUT_POLLDEV
>  	help
>  	  This driver implements support for tilt switches connected
> @@ -472,7 +472,7 @@ config INPUT_PWM_BEEPER
>  
>  config INPUT_GPIO_ROTARY_ENCODER
>  	tristate "Rotary encoders connected to GPIO pins"
> -	depends on GPIOLIB && GENERIC_GPIO
> +	depends on GPIOLIB
>  	help
>  	  Say Y here to add support for rotary encoders connected to GPIO lines.
>  	  Check file:Documentation/input/rotary-encoder.txt for more
> @@ -484,7 +484,7 @@ config INPUT_GPIO_ROTARY_ENCODER
>  config INPUT_RB532_BUTTON
>  	tristate "Mikrotik Routerboard 532 button interface"
>  	depends on MIKROTIK_RB532
> -	depends on GPIOLIB && GENERIC_GPIO
> +	depends on GPIOLIB
>  	select INPUT_POLLDEV
>  	help
>  	  Say Y here if you want support for the S1 button built into
> diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
> index 802bd6a..effa9c5 100644
> --- a/drivers/input/mouse/Kconfig
> +++ b/drivers/input/mouse/Kconfig
> @@ -295,7 +295,7 @@ config MOUSE_VSXXXAA
>  
>  config MOUSE_GPIO
>  	tristate "GPIO mouse"
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	select INPUT_POLLDEV
>  	help
>  	  This driver simulates a mouse on GPIO lines of various CPUs (and some
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index d44806d..ef99229 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -173,7 +173,7 @@ config LEDS_PCA9532_GPIO
>  config LEDS_GPIO
>  	tristate "LED Support for GPIO connected LEDs"
>  	depends on LEDS_CLASS
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	help
>  	  This option enables support for the LEDs connected to GPIO
>  	  outputs. To be useful the particular board must have LEDs
> @@ -362,7 +362,7 @@ config LEDS_INTEL_SS4200
>  config LEDS_LT3593
>  	tristate "LED driver for LT3593 controllers"
>  	depends on LEDS_CLASS
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	help
>  	  This option enables support for LEDs driven by a Linear Technology
>  	  LT3593 controller. This controller uses a special one-wire pulse
> @@ -431,7 +431,7 @@ config LEDS_ASIC3
>  
>  config LEDS_RENESAS_TPU
>  	bool "LED support for Renesas TPU"
> -	depends on LEDS_CLASS=y && HAVE_CLK && GENERIC_GPIO
> +	depends on LEDS_CLASS=y && HAVE_CLK && GPIOLIB
>  	help
>  	  This option enables build of the LED TPU platform driver,
>  	  suitable to drive any TPU channel on newer Renesas SoCs.
> diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
> index bed9634..bed9d58 100644
> --- a/drivers/mtd/maps/Kconfig
> +++ b/drivers/mtd/maps/Kconfig
> @@ -351,7 +351,7 @@ config MTD_BFIN_ASYNC
>  
>  config MTD_GPIO_ADDR
>  	tristate "GPIO-assisted Flash Chip Support"
> -	depends on GENERIC_GPIO || GPIOLIB
> +	depends on GPIOLIB
>  	depends on MTD_COMPLEX_MAPPINGS
>  	help
>  	  Map driver which allows flashes to be partially physically addressed
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 1cca712..a60f6c1 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -75,7 +75,7 @@ config MTD_NAND_DENALI_SCRATCH_REG_ADDR
>  
>  config MTD_NAND_GPIO
>  	tristate "GPIO NAND Flash driver"
> -	depends on GENERIC_GPIO && ARM
> +	depends on GPIOLIB && ARM
>  	help
>  	  This enables a GPIO based NAND flash driver.
>  
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 4503452..1e11f2b 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -126,7 +126,7 @@ config MDIO_BITBANG
>  
>  config MDIO_GPIO
>  	tristate "Support for GPIO lib-based bitbanged MDIO buses"
> -	depends on MDIO_BITBANG && GENERIC_GPIO
> +	depends on MDIO_BITBANG && GPIOLIB
>  	---help---
>  	  Supports GPIO lib-based MDIO busses.
>  
> diff --git a/drivers/pinctrl/sh-pfc/Kconfig b/drivers/pinctrl/sh-pfc/Kconfig
> index 0e1f99c..f8a2ae4 100644
> --- a/drivers/pinctrl/sh-pfc/Kconfig
> +++ b/drivers/pinctrl/sh-pfc/Kconfig
> @@ -6,7 +6,7 @@ if ARCH_SHMOBILE || SUPERH
>  
>  config PINCTRL_SH_PFC
>  	# XXX move off the gpio dependency
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	select GPIO_SH_PFC if ARCH_REQUIRE_GPIOLIB
>  	select PINMUX
>  	select PINCONF
> @@ -40,19 +40,19 @@ config PINCTRL_PFC_R8A7779
>  config PINCTRL_PFC_SH7203
>  	def_bool y
>  	depends on CPU_SUBTYPE_SH7203
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	select PINCTRL_SH_PFC
>  
>  config PINCTRL_PFC_SH7264
>  	def_bool y
>  	depends on CPU_SUBTYPE_SH7264
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	select PINCTRL_SH_PFC
>  
>  config PINCTRL_PFC_SH7269
>  	def_bool y
>  	depends on CPU_SUBTYPE_SH7269
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	select PINCTRL_SH_PFC
>  
>  config PINCTRL_PFC_SH7372
> @@ -68,55 +68,55 @@ config PINCTRL_PFC_SH73A0
>  config PINCTRL_PFC_SH7720
>  	def_bool y
>  	depends on CPU_SUBTYPE_SH7720
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	select PINCTRL_SH_PFC
>  
>  config PINCTRL_PFC_SH7722
>  	def_bool y
>  	depends on CPU_SUBTYPE_SH7722
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	select PINCTRL_SH_PFC
>  
>  config PINCTRL_PFC_SH7723
>  	def_bool y
>  	depends on CPU_SUBTYPE_SH7723
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	select PINCTRL_SH_PFC
>  
>  config PINCTRL_PFC_SH7724
>  	def_bool y
>  	depends on CPU_SUBTYPE_SH7724
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	select PINCTRL_SH_PFC
>  
>  config PINCTRL_PFC_SH7734
>  	def_bool y
>  	depends on CPU_SUBTYPE_SH7734
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	select PINCTRL_SH_PFC
>  
>  config PINCTRL_PFC_SH7757
>  	def_bool y
>  	depends on CPU_SUBTYPE_SH7757
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	select PINCTRL_SH_PFC
>  
>  config PINCTRL_PFC_SH7785
>  	def_bool y
>  	depends on CPU_SUBTYPE_SH7785
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	select PINCTRL_SH_PFC
>  
>  config PINCTRL_PFC_SH7786
>  	def_bool y
>  	depends on CPU_SUBTYPE_SH7786
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	select PINCTRL_SH_PFC
>  
>  config PINCTRL_PFC_SHX3
>  	def_bool y
>  	depends on CPU_SUBTYPE_SHX3
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	select PINCTRL_SH_PFC
>  
>  endif
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index a5d97ea..8bb2644 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -66,7 +66,7 @@ config REGULATOR_USERSPACE_CONSUMER
>  
>  config REGULATOR_GPIO
>  	tristate "GPIO regulator support"
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	help
>  	  This driver provides support for regulators that can be
>  	  controlled via gpios.
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index e728d36..c7dcf44 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -16,7 +16,7 @@ if RESET_CONTROLLER
>  
>  config RESET_GPIO
>  	tristate "GPIO reset controller support"
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	help
>  	  This driver provides support for reset lines that are controlled
>  	  directly by GPIOs.
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 141d8c1..92a9345 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -62,7 +62,7 @@ config SPI_ALTERA
>  
>  config SPI_ATH79
>  	tristate "Atheros AR71XX/AR724X/AR913X SPI controller driver"
> -	depends on ATH79 && GENERIC_GPIO
> +	depends on ATH79 && GPIOLIB
>  	select SPI_BITBANG
>  	help
>  	  This enables support for the SPI controller present on the
> @@ -175,7 +175,7 @@ config SPI_FALCON
>  
>  config SPI_GPIO
>  	tristate "GPIO-based bitbanging SPI Master"
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	select SPI_BITBANG
>  	help
>  	  This simple GPIO bitbanging SPI master uses the arch-neutral GPIO
> @@ -259,7 +259,7 @@ config SPI_FSL_ESPI
>  
>  config SPI_OC_TINY
>  	tristate "OpenCores tiny SPI"
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	select SPI_BITBANG
>  	help
>  	  This is the driver for OpenCores tiny SPI master controller.
> @@ -457,7 +457,7 @@ config SPI_TOPCLIFF_PCH
>  
>  config SPI_TXX9
>  	tristate "Toshiba TXx9 SPI controller"
> -	depends on GENERIC_GPIO && CPU_TX49XX
> +	depends on GPIOLIB && CPU_TX49XX
>  	help
>  	  SPI driver for Toshiba TXx9 MIPS SoCs
>  
> diff --git a/drivers/staging/android/Kconfig b/drivers/staging/android/Kconfig
> index 9f61d46..c0c95be 100644
> --- a/drivers/staging/android/Kconfig
> +++ b/drivers/staging/android/Kconfig
> @@ -54,7 +54,7 @@ config ANDROID_TIMED_OUTPUT
>  
>  config ANDROID_TIMED_GPIO
>  	tristate "Android timed gpio driver"
> -	depends on GENERIC_GPIO && ANDROID_TIMED_OUTPUT
> +	depends on GPIOLIB && ANDROID_TIMED_OUTPUT
>  	default n
>  
>  config ANDROID_LOW_MEMORY_KILLER
> diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
> index e2e786d..ad45dfb 100644
> --- a/drivers/staging/iio/accel/Kconfig
> +++ b/drivers/staging/iio/accel/Kconfig
> @@ -61,7 +61,7 @@ config LIS3L02DQ
>  	depends on SPI
>  	select IIO_TRIGGER if IIO_BUFFER
>  	depends on !IIO_BUFFER || IIO_KFIFO_BUF
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	help
>  	  Say yes here to build SPI support for the ST microelectronics
>  	  accelerometer. The driver supplies direct access via sysfs files
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> index d990829..cabc7a3 100644
> --- a/drivers/staging/iio/adc/Kconfig
> +++ b/drivers/staging/iio/adc/Kconfig
> @@ -73,7 +73,7 @@ config AD7780
>  config AD7816
>  	tristate "Analog Devices AD7816/7/8 temperature sensor and ADC driver"
>  	depends on SPI
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	help
>  	  Say yes here to build support for Analog Devices AD7816/7/8
>  	  temperature sensors and ADC.
> diff --git a/drivers/staging/iio/addac/Kconfig b/drivers/staging/iio/addac/Kconfig
> index 698a897..e6795e0 100644
> --- a/drivers/staging/iio/addac/Kconfig
> +++ b/drivers/staging/iio/addac/Kconfig
> @@ -5,7 +5,7 @@ menu "Analog digital bi-direction converters"
>  
>  config ADT7316
>  	tristate "Analog Devices ADT7316/7/8 ADT7516/7/9 temperature sensor, ADC and DAC driver"
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	help
>  	  Say yes here to build support for Analog Devices ADT7316, ADT7317, ADT7318
>  	  and ADT7516, ADT7517, ADT7519 temperature sensors, ADC and DAC.
> diff --git a/drivers/staging/iio/resolver/Kconfig b/drivers/staging/iio/resolver/Kconfig
> index 49f69ef..ce360f1 100644
> --- a/drivers/staging/iio/resolver/Kconfig
> +++ b/drivers/staging/iio/resolver/Kconfig
> @@ -13,7 +13,7 @@ config AD2S90
>  config AD2S1200
>  	tristate "Analog Devices ad2s1200/ad2s1205 driver"
>  	depends on SPI
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	help
>  	  Say yes here to build support for Analog Devices spi resolver
>  	  to digital converters, ad2s1200 and ad2s1205, provides direct access
> @@ -22,7 +22,7 @@ config AD2S1200
>  config AD2S1210
>  	tristate "Analog Devices ad2s1210 driver"
>  	depends on SPI
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	help
>  	  Say yes here to build support for Analog Devices spi resolver
>  	  to digital converters, ad2s1210, provides direct access via sysfs.
> diff --git a/drivers/staging/iio/trigger/Kconfig b/drivers/staging/iio/trigger/Kconfig
> index d44d3ad..1a051da 100644
> --- a/drivers/staging/iio/trigger/Kconfig
> +++ b/drivers/staging/iio/trigger/Kconfig
> @@ -14,7 +14,7 @@ config IIO_PERIODIC_RTC_TRIGGER
>  
>  config IIO_GPIO_TRIGGER
>  	tristate "GPIO trigger"
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	help
>  	  Provides support for using GPIO pins as IIO triggers.
>  
> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
> index 3a7fec9..21153d1 100644
> --- a/drivers/usb/phy/Kconfig
> +++ b/drivers/usb/phy/Kconfig
> @@ -128,7 +128,7 @@ config TWL6030_USB
>  
>  config USB_GPIO_VBUS
>  	tristate "GPIO based peripheral-only VBUS sensing 'transceiver'"
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	help
>  	  Provides simple GPIO VBUS sensing for controllers with an
>  	  internal transceiver via the usb_phy interface, and
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index d90e3f5..6170a87 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -2481,7 +2481,7 @@ config FB_SSD1307
>  	tristate "Solomon SSD1307 framebuffer support"
>  	depends on FB && I2C
>  	depends on OF
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	select FB_SYS_FOPS
>  	select FB_SYS_FILLRECT
>  	select FB_SYS_COPYAREA
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 2e166c3..d5ab658 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -36,14 +36,14 @@ config LCD_CORGI
>  
>  config LCD_L4F00242T03
>  	tristate "Epson L4F00242T03 LCD"
> -	depends on SPI_MASTER && GENERIC_GPIO
> +	depends on SPI_MASTER && GPIOLIB
>  	help
>  	  SPI driver for Epson L4F00242T03. This provides basic support
>  	  for init and powering the LCD up/down through a sysfs interface.
>  
>  config LCD_LMS283GF05
>  	tristate "Samsung LMS283GF05 LCD"
> -	depends on SPI_MASTER && GENERIC_GPIO
> +	depends on SPI_MASTER && GPIOLIB
>  	help
>  	  SPI driver for Samsung LMS283GF05. This provides basic support
>  	  for powering the LCD up/down through a sysfs interface.
> diff --git a/drivers/w1/masters/Kconfig b/drivers/w1/masters/Kconfig
> index e8ca63a..2bd1257 100644
> --- a/drivers/w1/masters/Kconfig
> +++ b/drivers/w1/masters/Kconfig
> @@ -50,7 +50,7 @@ config W1_MASTER_DS1WM
>  
>  config W1_MASTER_GPIO
>  	tristate "GPIO 1-wire busmaster"
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	help
>  	  Say Y here if you want to communicate with your 1-wire devices using
>  	  GPIO pins. This driver uses the GPIO API to control the wire.
> diff --git a/include/linux/gpio.h b/include/linux/gpio.h
> index f6c7ae3..552e3f4 100644
> --- a/include/linux/gpio.h
> +++ b/include/linux/gpio.h
> @@ -39,7 +39,7 @@ struct gpio {
>  	const char	*label;
>  };
>  
> -#ifdef CONFIG_GENERIC_GPIO
> +#ifdef CONFIG_GPIOLIB
>  
>  #ifdef CONFIG_ARCH_HAVE_CUSTOM_GPIO_H
>  #include <asm/gpio.h>
> @@ -74,7 +74,7 @@ static inline int irq_to_gpio(unsigned int irq)
>  
>  #endif /* ! CONFIG_ARCH_HAVE_CUSTOM_GPIO_H */
>  
> -#else /* ! CONFIG_GENERIC_GPIO */
> +#else /* ! CONFIG_GPIOLIB */
>  
>  #include <linux/kernel.h>
>  #include <linux/types.h>
> @@ -226,7 +226,7 @@ gpiochip_remove_pin_ranges(struct gpio_chip *chip)
>  	WARN_ON(1);
>  }
>  
> -#endif /* ! CONFIG_GENERIC_GPIO */
> +#endif /* ! CONFIG_GPIOLIB */
>  
>  struct device;
>  
> -- 
> 1.8.2
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
