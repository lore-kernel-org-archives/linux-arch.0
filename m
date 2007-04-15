Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.235]:36213 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980AbXDOP7j (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 15 Apr 2007 11:59:39 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1350652wxd
        for <linux-arch@vger.kernel.org>; Sun, 15 Apr 2007 08:59:38 -0700 (PDT)
Message-ID: <46224BCD.3010106@gmail.com>
Date: Sun, 15 Apr 2007 10:59:09 -0500
From: "Jory A. Pratt" <geekypenguin@gmail.com>
MIME-Version: 1.0
Subject: [PATCH] Fix Kconfig for usb/input
Content-Type: multipart/mixed;
 boundary="------------010805000205040205000505"
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

This is a multi-part message in MIME format.
--------------010805000205040205000505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

PPC32 arch specifics should not be displayed to any other arch. This is 
just a simple correction to the depends. Any questions or comments are 
welcomed as always.

--------------010805000205040205000505
Content-Type: text/plain;
 name="powerpc-usb-kconfig.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="powerpc-usb-kconfig.patch"

Subject: [patch] Fix Kconfig for usb and PPC32 arch specific options
From: Jory A. Pratt <geekypenguin@gmail.com>

This just cleans up the Kconfig so PPC32 specific options are not displayed for 
other archs

Signed-off-by: Jory A. Pratt <geekypenguin@gmail.com>
diff --git a/drivers/usb/input/Kconfig b/drivers/usb/input/Kconfig
index 69a9f3b..1b9e42e 100644
--- a/drivers/usb/input/Kconfig
+++ b/drivers/usb/input/Kconfig
@@ -30,7 +30,7 @@ comment "Input core support is needed for USB HID input layer or HIDBP support"
 config USB_HIDINPUT_POWERBOOK
 	bool "Enable support for iBook/PowerBook special keys"
 	default n
-	depends on USB_HID
+	depends on USB_HID && PPC32
 	help
 	  Say Y here if you want support for the special keys (Fn, Numlock) on
 	  Apple iBooks and PowerBooks.
@@ -339,7 +339,7 @@ config USB_KEYSPAN_REMOTE
 
 config USB_APPLETOUCH
 	tristate "Apple USB Touchpad support"
-	depends on USB && INPUT
+	depends on USB && INPUT && PPC32
 	---help---
 	  Say Y here if you want to use an Apple USB Touchpad.
 

--------------010805000205040205000505--
