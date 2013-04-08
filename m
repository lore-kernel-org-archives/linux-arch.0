From: Chen Baozi <baozich@gmail.com>
Subject: [PATCH] gpio: update gpio Chinese documentation
Date: Mon, 8 Apr 2013 09:22:53 +0800
Message-ID: <20130408012253.GA2545@cbz-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-da0-f48.google.com ([209.85.210.48]:37296 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934511Ab3DHBZm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Apr 2013 21:25:42 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Courbot <gnurou@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Since the GENERIC_GPIO has been removed and the documentation of it
has been modified, this patch updates the corresponding documentation o=
f
gpio in Chinese.

Signed-off-by: Chen Baozi <baozich@gmail.com>
---
 Documentation/zh_CN/gpio.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/zh_CN/gpio.txt b/Documentation/zh_CN/gpio.tx=
t
index 4fa7b4e..d5b8f01 100644
--- a/Documentation/zh_CN/gpio.txt
+++ b/Documentation/zh_CN/gpio.txt
@@ -84,10 +84,10 @@ GPIO =E5=85=AC=E7=BA=A6
 =E6=8E=A7=E5=88=B6=E5=99=A8=E7=9A=84=E6=8A=BD=E8=B1=A1=E5=87=BD=E6=95=B0=
=E6=9D=A5=E5=AE=9E=E7=8E=B0=E5=AE=83=E3=80=82(=E6=9C=89=E4=B8=80=E4=BA=9B=
=E5=8F=AF=E9=80=89=E7=9A=84=E4=BB=A3=E7=A0=81=E8=83=BD=E6=94=AF=E6=8C=81=
=E8=BF=99=E7=A7=8D=E7=AD=96=E7=95=A5=E7=9A=84=E5=AE=9E=E7=8E=B0,=E6=9C=AC=
=E6=96=87=E6=A1=A3
 =E5=90=8E=E9=9D=A2=E4=BC=9A=E4=BB=8B=E7=BB=8D=EF=BC=8C=E4=BD=86=E4=BD=9C=
=E4=B8=BA GPIO =E6=8E=A5=E5=8F=A3=E7=9A=84=E5=AE=A2=E6=88=B7=E7=AB=AF=E9=
=A9=B1=E5=8A=A8=E7=A8=8B=E5=BA=8F=E5=BF=85=E9=A1=BB=E4=B8=8E=E5=AE=83=E7=
=9A=84=E5=AE=9E=E7=8E=B0=E6=97=A0=E5=85=B3=E3=80=82)
=20
-=E4=B9=9F=E5=B0=B1=E6=98=AF=E8=AF=B4,=E5=A6=82=E6=9E=9C=E5=9C=A8=E4=BB=
=96=E4=BB=AC=E7=9A=84=E5=B9=B3=E5=8F=B0=E4=B8=8A=E6=94=AF=E6=8C=81=E8=BF=
=99=E4=B8=AA=E5=85=AC=E7=BA=A6=EF=BC=8C=E9=A9=B1=E5=8A=A8=E5=BA=94=E5=B0=
=BD=E5=8F=AF=E8=83=BD=E7=9A=84=E4=BD=BF=E7=94=A8=E5=AE=83=E3=80=82=E5=B9=
=B3=E5=8F=B0
-=E5=BF=85=E9=A1=BB=E5=9C=A8 Kconfig =E4=B8=AD=E5=A3=B0=E6=98=8E=E5=AF=B9=
 GENERIC_GPIO=E7=9A=84=E6=94=AF=E6=8C=81 (=E5=B8=83=E5=B0=94=E5=9E=8B t=
rue)=EF=BC=8C=E5=B9=B6=E6=8F=90=E4=BE=9B
-=E4=B8=80=E4=B8=AA <asm/gpio.h> =E6=96=87=E4=BB=B6=E3=80=82=E9=82=A3=E4=
=BA=9B=E8=B0=83=E7=94=A8=E6=A0=87=E5=87=86 GPIO =E5=87=BD=E6=95=B0=E7=9A=
=84=E9=A9=B1=E5=8A=A8=E5=BA=94=E8=AF=A5=E5=9C=A8 Kconfig
-=E5=85=A5=E5=8F=A3=E4=B8=AD=E5=A3=B0=E6=98=8E=E4=BE=9D=E8=B5=96GENERIC=
_GPIO=E3=80=82=E5=BD=93=E9=A9=B1=E5=8A=A8=E5=8C=85=E5=90=AB=E6=96=87=E4=
=BB=B6:
+=E4=B9=9F=E5=B0=B1=E6=98=AF=E8=AF=B4,=E5=A6=82=E6=9E=9C=E5=9C=A8=E4=BB=
=96=E4=BB=AC=E7=9A=84=E5=B9=B3=E5=8F=B0=E4=B8=8A=E6=94=AF=E6=8C=81=E8=BF=
=99=E4=B8=AA=E5=85=AC=E7=BA=A6=EF=BC=8C=E9=A9=B1=E5=8A=A8=E5=BA=94=E5=B0=
=BD=E5=8F=AF=E8=83=BD=E7=9A=84=E4=BD=BF=E7=94=A8=E5=AE=83=E3=80=82=E5=90=
=8C=E6=97=B6=EF=BC=8C=E5=B9=B3=E5=8F=B0
+=E5=BF=85=E9=A1=BB=E5=9C=A8 Kconfig =E4=B8=AD=E9=80=89=E6=8B=A9 ARCH_R=
EQUIRE_GPIOLIB =E6=88=96=E8=80=85 ARCH_WANT_OPTIONAL_GPIOLIB
+=E9=80=89=E9=A1=B9=E3=80=82=E9=82=A3=E4=BA=9B=E8=B0=83=E7=94=A8=E6=A0=87=
=E5=87=86 GPIO =E5=87=BD=E6=95=B0=E7=9A=84=E9=A9=B1=E5=8A=A8=E5=BA=94=E8=
=AF=A5=E5=9C=A8 Kconfig =E5=85=A5=E5=8F=A3=E4=B8=AD=E5=A3=B0=E6=98=8E=E4=
=BE=9D=E8=B5=96GENERIC_GPIO=E3=80=82
+=E5=BD=93=E9=A9=B1=E5=8A=A8=E5=8C=85=E5=90=AB=E6=96=87=E4=BB=B6:
=20
 	#include <linux/gpio.h>
=20
--=20
1.8.1.4
