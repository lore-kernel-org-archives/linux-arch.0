Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:38375 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731109AbfHHSUM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Aug 2019 14:20:12 -0400
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH v2] div64.h: Fix description of do_div parameter
Date: Thu,  8 Aug 2019 20:19:48 +0200
Message-ID: <20190808181948.27659-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Message-ID: <20190808181948.YdHj8Odq6Pjl71sACnB986QGB7z_RwV28lXSj0-Mg9E@z>

Contrary to the description, the first parameter (n) should not be
passed as a pointer, but directly as an lvalue. This is possible because
do_div is a macro.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
=2D--

v2:
- add Geert Uytterhoeven's R-b

v1:
- https://lore.kernel.org/lkml/20190225140355.4335-1-j.neuschaefer@gmx.net=
/
=2D--
 include/asm-generic/div64.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/div64.h b/include/asm-generic/div64.h
index dc9726fdac8f..b2a9c74efa55 100644
=2D-- a/include/asm-generic/div64.h
+++ b/include/asm-generic/div64.h
@@ -28,12 +28,12 @@

 /**
  * do_div - returns 2 values: calculate remainder and update new dividend
- * @n: pointer to uint64_t dividend (will be updated)
+ * @n: uint64_t dividend (will be updated)
  * @base: uint32_t divisor
  *
  * Summary:
- * ``uint32_t remainder =3D *n % base;``
- * ``*n =3D *n / base;``
+ * ``uint32_t remainder =3D n % base;``
+ * ``n =3D n / base;``
  *
  * Return: (uint32_t)remainder
  *
=2D-
2.20.1
