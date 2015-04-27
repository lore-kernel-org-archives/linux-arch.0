From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH 08/23] gpio: remove gpiod_sysfs_set_active_low
Date: Mon, 27 Apr 2015 12:54:15 +0900
Message-ID: <CAAVeFuLc8U_fhmb=oyr+hTsH8XgkQU0Z-oSS4K3CRObqv_P_AQ@mail.gmail.com>
References: <1429630951-27082-1-git-send-email-johan@kernel.org> <1429630951-27082-9-git-send-email-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:36806 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbbD0Dyh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 26 Apr 2015 23:54:37 -0400
In-Reply-To: <1429630951-27082-9-git-send-email-johan@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Harry Wei <harryxiyou@gmail.com>, Arnd Bergmann <arnd@arndb.de>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, linux-kernel@zh-kernel.org, linux-arch <linux-arch@vger.kernel.org>

On Wed, Apr 22, 2015 at 12:42 AM, Johan Hovold <johan@kernel.org> wrote=
:
> Remove gpiod_sysfs_set_active_low (and gpio_sysfs_set_active_low) whi=
ch
> allowed code to change the polarity of a gpio line even after it had
> been exported through sysfs.
>
> Drivers should not care, and generally does not know, about gpio-line
> polarity which is a hardware feature that needs to be described by
> firmware.
>
> It is currently possible to define gpio-line polarity in device-tree =
and
> acpi firmware or using platform data. Userspace can also change the
> polarity through sysfs.
>
> Note that drivers using the legacy gpio interface could still use
> GPIOF_ACTIVE_LOW to change the polarity before exporting the gpio.
>
> There are no in-kernel users of this interface.
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Harry Wei <harryxiyou@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@zh-kernel.org
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  Documentation/gpio/gpio-legacy.txt |  9 -------
>  Documentation/gpio/sysfs.txt       |  8 -------
>  Documentation/zh_CN/gpio.txt       |  8 -------
>  drivers/gpio/gpiolib-sysfs.c       | 48 ++--------------------------=
----------
>  include/asm-generic/gpio.h         |  5 ----
>  include/linux/gpio.h               |  7 ------
>  include/linux/gpio/consumer.h      |  6 -----
>  7 files changed, 2 insertions(+), 89 deletions(-)
>
> diff --git a/Documentation/gpio/gpio-legacy.txt b/Documentation/gpio/=
gpio-legacy.txt
> index 6f83fa965b4b..79ab5648d69b 100644
> --- a/Documentation/gpio/gpio-legacy.txt
> +++ b/Documentation/gpio/gpio-legacy.txt
> @@ -751,9 +751,6 @@ requested using gpio_request():
>         int gpio_export_link(struct device *dev, const char *name,
>                 unsigned gpio)
>
> -       /* change the polarity of a GPIO node in sysfs */
> -       int gpio_sysfs_set_active_low(unsigned gpio, int value);
> -
>  After a kernel driver requests a GPIO, it may only be made available=
 in
>  the sysfs interface by gpio_export().  The driver can control whethe=
r the
>  signal direction may change.  This helps drivers prevent userspace c=
ode
> @@ -767,9 +764,3 @@ After the GPIO has been exported, gpio_export_lin=
k() allows creating
>  symlinks from elsewhere in sysfs to the GPIO sysfs node.  Drivers ca=
n
>  use this to provide the interface under their own device in sysfs wi=
th
>  a descriptive name.
> -
> -Drivers can use gpio_sysfs_set_active_low() to hide GPIO line polari=
ty
> -differences between boards from user space.  This only affects the
> -sysfs interface.  Polarity change can be done both before and after
> -gpio_export(), and previously enabled poll(2) support for either
> -rising or falling edge will be reconfigured to follow this setting.
> diff --git a/Documentation/gpio/sysfs.txt b/Documentation/gpio/sysfs.=
txt
> index c2c3a97f8ff7..535b6a8a7a7c 100644
> --- a/Documentation/gpio/sysfs.txt
> +++ b/Documentation/gpio/sysfs.txt
> @@ -132,9 +132,6 @@ requested using gpio_request():
>         int gpiod_export_link(struct device *dev, const char *name,
>                       struct gpio_desc *desc);
>
> -       /* change the polarity of a GPIO node in sysfs */
> -       int gpiod_sysfs_set_active_low(struct gpio_desc *desc, int va=
lue);
> -
>  After a kernel driver requests a GPIO, it may only be made available=
 in
>  the sysfs interface by gpiod_export(). The driver can control whethe=
r the
>  signal direction may change. This helps drivers prevent userspace co=
de
> @@ -148,8 +145,3 @@ After the GPIO has been exported, gpiod_export_li=
nk() allows creating
>  symlinks from elsewhere in sysfs to the GPIO sysfs node. Drivers can
>  use this to provide the interface under their own device in sysfs wi=
th
>  a descriptive name.
> -
> -Drivers can use gpiod_sysfs_set_active_low() to hide GPIO line polar=
ity
> -differences between boards from user space. Polarity change can be d=
one both
> -before and after gpiod_export(), and previously enabled poll(2) supp=
ort for
> -either rising or falling edge will be reconfigured to follow this se=
tting.
> diff --git a/Documentation/zh_CN/gpio.txt b/Documentation/zh_CN/gpio.=
txt
> index d5b8f01833f4..bce972521065 100644
> --- a/Documentation/zh_CN/gpio.txt
> +++ b/Documentation/zh_CN/gpio.txt
> @@ -638,9 +638,6 @@ GPIO =E6=8E=A7=E5=88=B6=E5=99=A8=E7=9A=84=E8=B7=AF=
=E5=BE=84=E7=B1=BB=E4=BC=BC /sys/class/gpio/gpiochip42/ (=E5=AF=B9=E4=BA=
=8E=E4=BB=8E#42 GPIO
>         int gpio_export_link(struct device *dev, const char *name,
>                 unsigned gpio)
>
> -       /* =E6=94=B9=E5=8F=98 sysfs =E4=B8=AD=E7=9A=84=E4=B8=80=E4=B8=
=AA GPIO =E8=8A=82=E7=82=B9=E7=9A=84=E6=9E=81=E6=80=A7 */
> -       int gpio_sysfs_set_active_low(unsigned gpio, int value);
> -
>  =E5=9C=A8=E4=B8=80=E4=B8=AA=E5=86=85=E6=A0=B8=E9=A9=B1=E5=8A=A8=E7=94=
=B3=E8=AF=B7=E4=B8=80=E4=B8=AA GPIO =E4=B9=8B=E5=90=8E=EF=BC=8C=E5=AE=83=
=E5=8F=AF=E4=BB=A5=E9=80=9A=E8=BF=87 gpio_export()=E4=BD=BF=E5=85=B6=E5=
=9C=A8 sysfs
>  =E6=8E=A5=E5=8F=A3=E4=B8=AD=E5=8F=AF=E8=A7=81=E3=80=82=E8=AF=A5=E9=A9=
=B1=E5=8A=A8=E5=8F=AF=E4=BB=A5=E6=8E=A7=E5=88=B6=E4=BF=A1=E5=8F=B7=E6=96=
=B9=E5=90=91=E6=98=AF=E5=90=A6=E5=8F=AF=E4=BF=AE=E6=94=B9=E3=80=82=E8=BF=
=99=E6=9C=89=E5=8A=A9=E4=BA=8E=E9=98=B2=E6=AD=A2=E7=94=A8=E6=88=B7=E7=A9=
=BA=E9=97=B4=E4=BB=A3=E7=A0=81=E6=97=A0=E6=84=8F=E9=97=B4
>  =E7=A0=B4=E5=9D=8F=E9=87=8D=E8=A6=81=E7=9A=84=E7=B3=BB=E7=BB=9F=E7=8A=
=B6=E6=80=81=E3=80=82
> @@ -651,8 +648,3 @@ GPIO =E6=8E=A7=E5=88=B6=E5=99=A8=E7=9A=84=E8=B7=AF=
=E5=BE=84=E7=B1=BB=E4=BC=BC /sys/class/gpio/gpiochip42/ (=E5=AF=B9=E4=BA=
=8E=E4=BB=8E#42 GPIO
>  =E5=9C=A8 GPIO =E8=A2=AB=E5=AF=BC=E5=87=BA=E4=B9=8B=E5=90=8E=EF=BC=8C=
gpio_export_link()=E5=85=81=E8=AE=B8=E5=9C=A8 sysfs =E6=96=87=E4=BB=B6=E7=
=B3=BB=E7=BB=9F=E7=9A=84=E4=BB=BB=E4=BD=95=E5=9C=B0=E6=96=B9
>  =E5=88=9B=E5=BB=BA=E4=B8=80=E4=B8=AA=E5=88=B0=E8=BF=99=E4=B8=AA GPIO=
 sysfs =E8=8A=82=E7=82=B9=E7=9A=84=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=A5=E3=
=80=82=E8=BF=99=E6=A0=B7=E9=A9=B1=E5=8A=A8=E5=B0=B1=E5=8F=AF=E4=BB=A5=E9=
=80=9A=E8=BF=87=E4=B8=80=E4=B8=AA=E6=8F=8F=E8=BF=B0=E6=80=A7=E7=9A=84
>  =E5=90=8D=E5=AD=97=EF=BC=8C=E5=9C=A8 sysfs =E4=B8=AD=E4=BB=96=E4=BB=AC=
=E6=89=80=E6=8B=A5=E6=9C=89=E7=9A=84=E8=AE=BE=E5=A4=87=E4=B8=8B=E6=8F=90=
=E4=BE=9B=E4=B8=80=E4=B8=AA(=E5=88=B0=E8=BF=99=E4=B8=AA GPIO sysfs =E8=8A=
=82=E7=82=B9=E7=9A=84)=E6=8E=A5=E5=8F=A3=E3=80=82
> -
> -=E9=A9=B1=E5=8A=A8=E5=8F=AF=E4=BB=A5=E4=BD=BF=E7=94=A8 gpio_sysfs_se=
t_active_low() =E6=9D=A5=E5=9C=A8=E7=94=A8=E6=88=B7=E7=A9=BA=E9=97=B4=E9=
=9A=90=E8=97=8F=E7=94=B5=E8=B7=AF=E6=9D=BF=E4=B9=8B=E9=97=B4
> -GPIO =E7=BA=BF=E7=9A=84=E6=9E=81=E6=80=A7=E5=B7=AE=E5=BC=82=E3=80=82=
=E8=BF=99=E4=B8=AA=E4=BB=85=E5=AF=B9 sysfs =E6=8E=A5=E5=8F=A3=E8=B5=B7=E4=
=BD=9C=E7=94=A8=E3=80=82=E6=9E=81=E6=80=A7=E7=9A=84=E6=94=B9=E5=8F=98=E5=
=8F=AF=E4=BB=A5=E5=9C=A8 gpio_export()
> -=E5=89=8D=E5=90=8E=E8=BF=9B=E8=A1=8C,=E4=B8=94=E4=B9=8B=E5=89=8D=E4=BD=
=BF=E8=83=BD=E7=9A=84=E8=BD=AE=E8=AF=A2=E6=93=8D=E4=BD=9C(poll(2))=E6=94=
=AF=E6=8C=81(=E4=B8=8A=E5=8D=87=E6=88=96=E4=B8=8B=E9=99=8D=E6=B2=BF)=E5=
=B0=86=E4=BC=9A=E8=A2=AB=E9=87=8D=E6=96=B0=E9=85=8D=E7=BD=AE=E6=9D=A5=E9=
=81=B5=E5=BE=AA
> -=E8=BF=99=E4=B8=AA=E8=AE=BE=E7=BD=AE=E3=80=82
> diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysf=
s.c
> index 31434c5a90ef..8a95a954f514 100644
> --- a/drivers/gpio/gpiolib-sysfs.c
> +++ b/drivers/gpio/gpiolib-sysfs.c
> @@ -293,8 +293,8 @@ static int sysfs_set_active_low(struct gpio_desc =
*desc, struct device *dev,
>                 clear_bit(FLAG_ACTIVE_LOW, &desc->flags);
>
>         /* reconfigure poll(2) support if enabled on one edge only */
> -       if (dev !=3D NULL && (!!test_bit(FLAG_TRIG_RISE, &desc->flags=
) ^
> -                               !!test_bit(FLAG_TRIG_FALL, &desc->fla=
gs))) {
> +       if (!!test_bit(FLAG_TRIG_RISE, &desc->flags) ^
> +                               !!test_bit(FLAG_TRIG_FALL, &desc->fla=
gs)) {

This change seems to be unrelated to this patch...

Otherwise, I agree and good riddance!
