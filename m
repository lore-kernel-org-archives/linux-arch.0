Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:35211 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfBYOEe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Feb 2019 09:04:34 -0500
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH] div64.h: Fix description of do_div parameter
Date: Mon, 25 Feb 2019 15:03:54 +0100
Message-ID: <20190225140355.4335-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Message-ID: <20190225140354.kHCJ_649Oy90QPEEteuu7l84hQ74DsjY894UhfRzrkE@z>

Contrary to the description, the first parameter (n) should not be
passed as a pointer, but directly as an lvalue. This is possible because
do_div is a macro.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 include/asm-generic/div64.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/div64.h b/include/asm-generic/div64.h
index dc9726fdac8f..b2a9c74efa55 100644
--- a/include/asm-generic/div64.h
+++ b/include/asm-generic/div64.h
@@ -28,12 +28,12 @@
 
 /**
  * do_div - returns 2 values: calculate remainder and update new dividend
- * @n: pointer to uint64_t dividend (will be updated)
+ * @n: uint64_t dividend (will be updated)
  * @base: uint32_t divisor
  *
  * Summary:
- * ``uint32_t remainder = *n % base;``
- * ``*n = *n / base;``
+ * ``uint32_t remainder = n % base;``
+ * ``n = n / base;``
  *
  * Return: (uint32_t)remainder
  *
-- 
2.20.1
