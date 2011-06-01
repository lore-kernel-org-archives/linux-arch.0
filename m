From: ralf@linux-mips.org
Subject: [patch 06/14] i8253: Make pcspkr input driver use the shared i8253_lock.
Date: Wed, 01 Jun 2011 19:05:02 +0100
Message-ID: <20110601180610.453577265@duck.linux-mips.net>
References: <20110601180456.801265664@duck.linux-mips.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=i8253-move-pcspkr.c-to-shared-lock.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

 drivers/input/misc/pcspkr.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

Index: linux-mips/drivers/input/misc/pcspkr.c
===================================================================
--- linux-mips.orig/drivers/input/misc/pcspkr.c
+++ linux-mips/drivers/input/misc/pcspkr.c
@@ -14,6 +14,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/i8253.h>
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/platform_device.h>
@@ -25,14 +26,6 @@ MODULE_DESCRIPTION("PC Speaker beeper dr
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:pcspkr");
 
-#if defined(CONFIG_MIPS) || defined(CONFIG_X86)
-/* Use the global PIT lock ! */
-#include <linux/i8253.h>
-#else
-#include <asm/8253pit.h>
-static DEFINE_RAW_SPINLOCK(i8253_lock);
-#endif
-
 static int pcspkr_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
 {
 	unsigned int count = 0;
