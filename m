From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 08/23] gpio: remove gpiod_sysfs_set_active_low
Date: Tue, 21 Apr 2015 17:42:16 +0200
Message-ID: <1429630951-27082-9-git-send-email-johan@kernel.org>
References: <1429630951-27082-1-git-send-email-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:33502 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755757AbbDUPnR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Apr 2015 11:43:17 -0400
In-Reply-To: <1429630951-27082-1-git-send-email-johan@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Harry Wei <harryxiyou@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org, linux-kernel@zh-kernel.org, linux-arch@vger.kernel.org

Remove gpiod_sysfs_set_active_low (and gpio_sysfs_set_active_low) which
allowed code to change the polarity of a gpio line even after it had
been exported through sysfs.

Drivers should not care, and generally does not know, about gpio-line
polarity which is a hardware feature that needs to be described by
firmware.

It is currently possible to define gpio-line polarity in device-tree an=
d
acpi firmware or using platform data. Userspace can also change the
polarity through sysfs.

Note that drivers using the legacy gpio interface could still use
GPIOF_ACTIVE_LOW to change the polarity before exporting the gpio.

There are no in-kernel users of this interface.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@zh-kernel.org
Cc: linux-arch@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 Documentation/gpio/gpio-legacy.txt |  9 -------
 Documentation/gpio/sysfs.txt       |  8 -------
 Documentation/zh_CN/gpio.txt       |  8 -------
 drivers/gpio/gpiolib-sysfs.c       | 48 ++----------------------------=
--------
 include/asm-generic/gpio.h         |  5 ----
 include/linux/gpio.h               |  7 ------
 include/linux/gpio/consumer.h      |  6 -----
 7 files changed, 2 insertions(+), 89 deletions(-)

diff --git a/Documentation/gpio/gpio-legacy.txt b/Documentation/gpio/gp=
io-legacy.txt
index 6f83fa965b4b..79ab5648d69b 100644
--- a/Documentation/gpio/gpio-legacy.txt
+++ b/Documentation/gpio/gpio-legacy.txt
@@ -751,9 +751,6 @@ requested using gpio_request():
 	int gpio_export_link(struct device *dev, const char *name,
 		unsigned gpio)
=20
-	/* change the polarity of a GPIO node in sysfs */
-	int gpio_sysfs_set_active_low(unsigned gpio, int value);
-
 After a kernel driver requests a GPIO, it may only be made available i=
n
 the sysfs interface by gpio_export().  The driver can control whether =
the
 signal direction may change.  This helps drivers prevent userspace cod=
e
@@ -767,9 +764,3 @@ After the GPIO has been exported, gpio_export_link(=
) allows creating
 symlinks from elsewhere in sysfs to the GPIO sysfs node.  Drivers can
 use this to provide the interface under their own device in sysfs with
 a descriptive name.
-
-Drivers can use gpio_sysfs_set_active_low() to hide GPIO line polarity
-differences between boards from user space.  This only affects the
-sysfs interface.  Polarity change can be done both before and after
-gpio_export(), and previously enabled poll(2) support for either
-rising or falling edge will be reconfigured to follow this setting.
diff --git a/Documentation/gpio/sysfs.txt b/Documentation/gpio/sysfs.tx=
t
index c2c3a97f8ff7..535b6a8a7a7c 100644
--- a/Documentation/gpio/sysfs.txt
+++ b/Documentation/gpio/sysfs.txt
@@ -132,9 +132,6 @@ requested using gpio_request():
 	int gpiod_export_link(struct device *dev, const char *name,
 		      struct gpio_desc *desc);
=20
-	/* change the polarity of a GPIO node in sysfs */
-	int gpiod_sysfs_set_active_low(struct gpio_desc *desc, int value);
-
 After a kernel driver requests a GPIO, it may only be made available i=
n
 the sysfs interface by gpiod_export(). The driver can control whether =
the
 signal direction may change. This helps drivers prevent userspace code
@@ -148,8 +145,3 @@ After the GPIO has been exported, gpiod_export_link=
() allows creating
 symlinks from elsewhere in sysfs to the GPIO sysfs node. Drivers can
 use this to provide the interface under their own device in sysfs with
 a descriptive name.
-
-Drivers can use gpiod_sysfs_set_active_low() to hide GPIO line polarit=
y
-differences between boards from user space. Polarity change can be don=
e both
-before and after gpiod_export(), and previously enabled poll(2) suppor=
t for
-either rising or falling edge will be reconfigured to follow this sett=
ing.
diff --git a/Documentation/zh_CN/gpio.txt b/Documentation/zh_CN/gpio.tx=
t
index d5b8f01833f4..bce972521065 100644
--- a/Documentation/zh_CN/gpio.txt
+++ b/Documentation/zh_CN/gpio.txt
@@ -638,9 +638,6 @@ GPIO =E6=8E=A7=E5=88=B6=E5=99=A8=E7=9A=84=E8=B7=AF=E5=
=BE=84=E7=B1=BB=E4=BC=BC /sys/class/gpio/gpiochip42/ (=E5=AF=B9=E4=BA=8E=
=E4=BB=8E#42 GPIO
 	int gpio_export_link(struct device *dev, const char *name,
 		unsigned gpio)
=20
-	/* =E6=94=B9=E5=8F=98 sysfs =E4=B8=AD=E7=9A=84=E4=B8=80=E4=B8=AA GPIO=
 =E8=8A=82=E7=82=B9=E7=9A=84=E6=9E=81=E6=80=A7 */
-	int gpio_sysfs_set_active_low(unsigned gpio, int value);
-
 =E5=9C=A8=E4=B8=80=E4=B8=AA=E5=86=85=E6=A0=B8=E9=A9=B1=E5=8A=A8=E7=94=B3=
=E8=AF=B7=E4=B8=80=E4=B8=AA GPIO =E4=B9=8B=E5=90=8E=EF=BC=8C=E5=AE=83=E5=
=8F=AF=E4=BB=A5=E9=80=9A=E8=BF=87 gpio_export()=E4=BD=BF=E5=85=B6=E5=9C=
=A8 sysfs
 =E6=8E=A5=E5=8F=A3=E4=B8=AD=E5=8F=AF=E8=A7=81=E3=80=82=E8=AF=A5=E9=A9=B1=
=E5=8A=A8=E5=8F=AF=E4=BB=A5=E6=8E=A7=E5=88=B6=E4=BF=A1=E5=8F=B7=E6=96=B9=
=E5=90=91=E6=98=AF=E5=90=A6=E5=8F=AF=E4=BF=AE=E6=94=B9=E3=80=82=E8=BF=99=
=E6=9C=89=E5=8A=A9=E4=BA=8E=E9=98=B2=E6=AD=A2=E7=94=A8=E6=88=B7=E7=A9=BA=
=E9=97=B4=E4=BB=A3=E7=A0=81=E6=97=A0=E6=84=8F=E9=97=B4
 =E7=A0=B4=E5=9D=8F=E9=87=8D=E8=A6=81=E7=9A=84=E7=B3=BB=E7=BB=9F=E7=8A=B6=
=E6=80=81=E3=80=82
@@ -651,8 +648,3 @@ GPIO =E6=8E=A7=E5=88=B6=E5=99=A8=E7=9A=84=E8=B7=AF=E5=
=BE=84=E7=B1=BB=E4=BC=BC /sys/class/gpio/gpiochip42/ (=E5=AF=B9=E4=BA=8E=
=E4=BB=8E#42 GPIO
 =E5=9C=A8 GPIO =E8=A2=AB=E5=AF=BC=E5=87=BA=E4=B9=8B=E5=90=8E=EF=BC=8Cg=
pio_export_link()=E5=85=81=E8=AE=B8=E5=9C=A8 sysfs =E6=96=87=E4=BB=B6=E7=
=B3=BB=E7=BB=9F=E7=9A=84=E4=BB=BB=E4=BD=95=E5=9C=B0=E6=96=B9
 =E5=88=9B=E5=BB=BA=E4=B8=80=E4=B8=AA=E5=88=B0=E8=BF=99=E4=B8=AA GPIO s=
ysfs =E8=8A=82=E7=82=B9=E7=9A=84=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=A5=E3=
=80=82=E8=BF=99=E6=A0=B7=E9=A9=B1=E5=8A=A8=E5=B0=B1=E5=8F=AF=E4=BB=A5=E9=
=80=9A=E8=BF=87=E4=B8=80=E4=B8=AA=E6=8F=8F=E8=BF=B0=E6=80=A7=E7=9A=84
 =E5=90=8D=E5=AD=97=EF=BC=8C=E5=9C=A8 sysfs =E4=B8=AD=E4=BB=96=E4=BB=AC=
=E6=89=80=E6=8B=A5=E6=9C=89=E7=9A=84=E8=AE=BE=E5=A4=87=E4=B8=8B=E6=8F=90=
=E4=BE=9B=E4=B8=80=E4=B8=AA(=E5=88=B0=E8=BF=99=E4=B8=AA GPIO sysfs =E8=8A=
=82=E7=82=B9=E7=9A=84)=E6=8E=A5=E5=8F=A3=E3=80=82
-
-=E9=A9=B1=E5=8A=A8=E5=8F=AF=E4=BB=A5=E4=BD=BF=E7=94=A8 gpio_sysfs_set_=
active_low() =E6=9D=A5=E5=9C=A8=E7=94=A8=E6=88=B7=E7=A9=BA=E9=97=B4=E9=9A=
=90=E8=97=8F=E7=94=B5=E8=B7=AF=E6=9D=BF=E4=B9=8B=E9=97=B4
-GPIO =E7=BA=BF=E7=9A=84=E6=9E=81=E6=80=A7=E5=B7=AE=E5=BC=82=E3=80=82=E8=
=BF=99=E4=B8=AA=E4=BB=85=E5=AF=B9 sysfs =E6=8E=A5=E5=8F=A3=E8=B5=B7=E4=BD=
=9C=E7=94=A8=E3=80=82=E6=9E=81=E6=80=A7=E7=9A=84=E6=94=B9=E5=8F=98=E5=8F=
=AF=E4=BB=A5=E5=9C=A8 gpio_export()
-=E5=89=8D=E5=90=8E=E8=BF=9B=E8=A1=8C,=E4=B8=94=E4=B9=8B=E5=89=8D=E4=BD=
=BF=E8=83=BD=E7=9A=84=E8=BD=AE=E8=AF=A2=E6=93=8D=E4=BD=9C(poll(2))=E6=94=
=AF=E6=8C=81(=E4=B8=8A=E5=8D=87=E6=88=96=E4=B8=8B=E9=99=8D=E6=B2=BF)=E5=
=B0=86=E4=BC=9A=E8=A2=AB=E9=87=8D=E6=96=B0=E9=85=8D=E7=BD=AE=E6=9D=A5=E9=
=81=B5=E5=BE=AA
-=E8=BF=99=E4=B8=AA=E8=AE=BE=E7=BD=AE=E3=80=82
diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.=
c
index 31434c5a90ef..8a95a954f514 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -293,8 +293,8 @@ static int sysfs_set_active_low(struct gpio_desc *d=
esc, struct device *dev,
 		clear_bit(FLAG_ACTIVE_LOW, &desc->flags);
=20
 	/* reconfigure poll(2) support if enabled on one edge only */
-	if (dev !=3D NULL && (!!test_bit(FLAG_TRIG_RISE, &desc->flags) ^
-				!!test_bit(FLAG_TRIG_FALL, &desc->flags))) {
+	if (!!test_bit(FLAG_TRIG_RISE, &desc->flags) ^
+				!!test_bit(FLAG_TRIG_FALL, &desc->flags)) {
 		unsigned long trigger_flags =3D desc->flags & GPIO_TRIGGER_MASK;
=20
 		gpio_setup_irq(desc, dev, 0);
@@ -666,50 +666,6 @@ int gpiod_export_link(struct device *dev, const ch=
ar *name,
 EXPORT_SYMBOL_GPL(gpiod_export_link);
=20
 /**
- * gpiod_sysfs_set_active_low - set the polarity of gpio sysfs value
- * @gpio: gpio to change
- * @value: non-zero to use active low, i.e. inverted values
- *
- * Set the polarity of /sys/class/gpio/gpioN/value sysfs attribute.
- * The GPIO does not have to be exported yet.  If poll(2) support has
- * been enabled for either rising or falling edge, it will be
- * reconfigured to follow the new polarity.
- *
- * Returns zero on success, else an error.
- */
-int gpiod_sysfs_set_active_low(struct gpio_desc *desc, int value)
-{
-	struct device		*dev =3D NULL;
-	int			status =3D -EINVAL;
-
-	if (!desc) {
-		pr_warn("%s: invalid GPIO\n", __func__);
-		return -EINVAL;
-	}
-
-	mutex_lock(&sysfs_lock);
-
-	if (test_bit(FLAG_EXPORT, &desc->flags)) {
-		dev =3D class_find_device(&gpio_class, NULL, desc, match_export);
-		if (dev =3D=3D NULL) {
-			status =3D -ENODEV;
-			goto unlock;
-		}
-	}
-
-	status =3D sysfs_set_active_low(desc, dev, value);
-	put_device(dev);
-unlock:
-	mutex_unlock(&sysfs_lock);
-
-	if (status)
-		gpiod_dbg(desc, "%s: status %d\n", __func__, status);
-
-	return status;
-}
-EXPORT_SYMBOL_GPL(gpiod_sysfs_set_active_low);
-
-/**
  * gpiod_unexport - reverse effect of gpio_export()
  * @gpio: gpio to make unavailable
  *
diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index 9bb0d11729c9..40ec1433f05d 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -128,11 +128,6 @@ static inline int gpio_export_link(struct device *=
dev, const char *name,
 	return gpiod_export_link(dev, name, gpio_to_desc(gpio));
 }
=20
-static inline int gpio_sysfs_set_active_low(unsigned gpio, int value)
-{
-	return gpiod_sysfs_set_active_low(gpio_to_desc(gpio), value);
-}
-
 static inline void gpio_unexport(unsigned gpio)
 {
 	gpiod_unexport(gpio_to_desc(gpio));
diff --git a/include/linux/gpio.h b/include/linux/gpio.h
index ab81339a8590..d12b5d566e4b 100644
--- a/include/linux/gpio.h
+++ b/include/linux/gpio.h
@@ -196,13 +196,6 @@ static inline int gpio_export_link(struct device *=
dev, const char *name,
 	return -EINVAL;
 }
=20
-static inline int gpio_sysfs_set_active_low(unsigned gpio, int value)
-{
-	/* GPIO can never have been requested */
-	WARN_ON(1);
-	return -EINVAL;
-}
-
 static inline void gpio_unexport(unsigned gpio)
 {
 	/* GPIO can never have been exported */
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consume=
r.h
index 3a7c9ffd5ab9..09a7fb0062a6 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -449,7 +449,6 @@ static inline int desc_to_gpio(const struct gpio_de=
sc *desc)
 int gpiod_export(struct gpio_desc *desc, bool direction_may_change);
 int gpiod_export_link(struct device *dev, const char *name,
 		      struct gpio_desc *desc);
-int gpiod_sysfs_set_active_low(struct gpio_desc *desc, int value);
 void gpiod_unexport(struct gpio_desc *desc);
=20
 #else  /* CONFIG_GPIOLIB && CONFIG_GPIO_SYSFS */
@@ -466,11 +465,6 @@ static inline int gpiod_export_link(struct device =
*dev, const char *name,
 	return -ENOSYS;
 }
=20
-static inline int gpiod_sysfs_set_active_low(struct gpio_desc *desc, i=
nt value)
-{
-	return -ENOSYS;
-}
-
 static inline void gpiod_unexport(struct gpio_desc *desc)
 {
 }
--=20
2.0.5
