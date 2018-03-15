Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-dm3nam03on0049.outbound.protection.outlook.com ([104.47.41.49]:36693
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751944AbeCOLBz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Mar 2018 07:01:55 -0400
From: Aaron Wu <aaron.wu@analog.com>
Subject: [Blackfin removal] [PATCH 23/28] char: Remove Blackfin OTP support
Date: Thu, 15 Mar 2018 18:50:23 +0800
Message-ID: <1521111028-19856-23-git-send-email-aaron.wu@analog.com>
In-Reply-To: <1521111028-19856-1-git-send-email-aaron.wu@analog.com>
References: <1521111028-19856-1-git-send-email-aaron.wu@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, f.fainelli@gmail.com, linux-arch@vger.kernel.org, kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, liqin.linux@gmail.com, lennox.wu@gmail.com, gxt@mprc.pku.edu.cn, linux@roeck-us.net
Cc: viro@zeniv.linux.org.uk, jhogan@kernel.org, linux-metag@vger.kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, openrisc@lists.librecores.org, dhowells@redhat.com, peterz@infradead.org, aaron.wu@analog.com

Signed-off-by: Aaron Wu <aaron.wu@analog.com>

Remove Blackfin OTP support
---
 drivers/char/Kconfig    |  28 ------
 drivers/char/Makefile   |   1 -
 drivers/char/bfin-otp.c | 237 ------------------------------------------------
 3 files changed, 266 deletions(-)
 delete mode 100644 drivers/char/bfin-otp.c

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index c28dca0..8f64ce8 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -66,34 +66,6 @@ config TTY_PRINTK
 
 	  If unsure, say N.
 
-config BFIN_OTP
-	tristate "Blackfin On-Chip OTP Memory Support"
-	depends on BLACKFIN && (BF51x || BF52x || BF54x)
-	default y
-	help
-	  If you say Y here, you will get support for a character device
-	  interface into the One Time Programmable memory pages that are
-	  stored on the Blackfin processor.  This will not get you access
-	  to the secure memory pages however.  You will need to write your
-	  own secure code and reader for that.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called bfin-otp.
-
-	  If unsure, it is safe to say Y.
-
-config BFIN_OTP_WRITE_ENABLE
-	bool "Enable writing support of OTP pages"
-	depends on BFIN_OTP
-	default n
-	help
-	  If you say Y here, you will enable support for writing of the
-	  OTP pages.  This is dangerous by nature as you can only program
-	  the pages once, so only enable this option when you actually
-	  need it so as to not inadvertently clobber data.
-
-	  If unsure, say N.
-
 config PRINTER
 	tristate "Parallel printer support"
 	depends on PARPORT
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index 7dc3abe..f28d07b 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -14,7 +14,6 @@ obj-$(CONFIG_MSPEC)		+= mspec.o
 obj-$(CONFIG_UV_MMTIMER)	+= uv_mmtimer.o
 obj-$(CONFIG_IBM_BSR)		+= bsr.o
 obj-$(CONFIG_SGI_MBCS)		+= mbcs.o
-obj-$(CONFIG_BFIN_OTP)		+= bfin-otp.o
 
 obj-$(CONFIG_PRINTER)		+= lp.o
 
diff --git a/drivers/char/bfin-otp.c b/drivers/char/bfin-otp.c
deleted file mode 100644
index 0584025..0000000
--- a/drivers/char/bfin-otp.c
+++ /dev/null
@@ -1,237 +0,0 @@
-/*
- * Blackfin On-Chip OTP Memory Interface
- *
- * Copyright 2007-2009 Analog Devices Inc.
- *
- * Enter bugs at http://blackfin.uclinux.org/
- *
- * Licensed under the GPL-2 or later.
- */
-
-#include <linux/device.h>
-#include <linux/errno.h>
-#include <linux/fs.h>
-#include <linux/init.h>
-#include <linux/miscdevice.h>
-#include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/types.h>
-#include <mtd/mtd-abi.h>
-
-#include <asm/blackfin.h>
-#include <asm/bfrom.h>
-#include <linux/uaccess.h>
-
-#define stamp(fmt, args...) pr_debug("%s:%i: " fmt "\n", __func__, __LINE__, ## args)
-#define stampit() stamp("here i am")
-#define pr_init(fmt, args...) ({ static const __initconst char __fmt[] = fmt; printk(__fmt, ## args); })
-
-#define DRIVER_NAME "bfin-otp"
-#define PFX DRIVER_NAME ": "
-
-static DEFINE_MUTEX(bfin_otp_lock);
-
-/**
- *	bfin_otp_read - Read OTP pages
- *
- *	All reads must be in half page chunks (half page == 64 bits).
- */
-static ssize_t bfin_otp_read(struct file *file, char __user *buff, size_t count, loff_t *pos)
-{
-	ssize_t bytes_done;
-	u32 page, flags, ret;
-	u64 content;
-
-	stampit();
-
-	if (count % sizeof(u64))
-		return -EMSGSIZE;
-
-	if (mutex_lock_interruptible(&bfin_otp_lock))
-		return -ERESTARTSYS;
-
-	bytes_done = 0;
-	page = *pos / (sizeof(u64) * 2);
-	while (bytes_done < count) {
-		flags = (*pos % (sizeof(u64) * 2) ? OTP_UPPER_HALF : OTP_LOWER_HALF);
-		stamp("processing page %i (0x%x:%s)", page, flags,
-			(flags & OTP_UPPER_HALF ? "upper" : "lower"));
-		ret = bfrom_OtpRead(page, flags, &content);
-		if (ret & OTP_MASTER_ERROR) {
-			stamp("error from otp: 0x%x", ret);
-			bytes_done = -EIO;
-			break;
-		}
-		if (copy_to_user(buff + bytes_done, &content, sizeof(content))) {
-			bytes_done = -EFAULT;
-			break;
-		}
-		if (flags & OTP_UPPER_HALF)
-			++page;
-		bytes_done += sizeof(content);
-		*pos += sizeof(content);
-	}
-
-	mutex_unlock(&bfin_otp_lock);
-
-	return bytes_done;
-}
-
-#ifdef CONFIG_BFIN_OTP_WRITE_ENABLE
-static bool allow_writes;
-
-/**
- *	bfin_otp_init_timing - setup OTP timing parameters
- *
- *	Required before doing any write operation.  Algorithms from HRM.
- */
-static u32 bfin_otp_init_timing(void)
-{
-	u32 tp1, tp2, tp3, timing;
-
-	tp1 = get_sclk() / 1000000;
-	tp2 = (2 * get_sclk() / 10000000) << 8;
-	tp3 = (0x1401) << 15;
-	timing = tp1 | tp2 | tp3;
-	if (bfrom_OtpCommand(OTP_INIT, timing))
-		return 0;
-
-	return timing;
-}
-
-/**
- *	bfin_otp_deinit_timing - set timings to only allow reads
- *
- *	Should be called after all writes are done.
- */
-static void bfin_otp_deinit_timing(u32 timing)
-{
-	/* mask bits [31:15] so that any attempts to write fail */
-	bfrom_OtpCommand(OTP_CLOSE, 0);
-	bfrom_OtpCommand(OTP_INIT, timing & ~(-1 << 15));
-	bfrom_OtpCommand(OTP_CLOSE, 0);
-}
-
-/**
- *	bfin_otp_write - write OTP pages
- *
- *	All writes must be in half page chunks (half page == 64 bits).
- */
-static ssize_t bfin_otp_write(struct file *filp, const char __user *buff, size_t count, loff_t *pos)
-{
-	ssize_t bytes_done;
-	u32 timing, page, base_flags, flags, ret;
-	u64 content;
-
-	if (!allow_writes)
-		return -EACCES;
-
-	if (count % sizeof(u64))
-		return -EMSGSIZE;
-
-	if (mutex_lock_interruptible(&bfin_otp_lock))
-		return -ERESTARTSYS;
-
-	stampit();
-
-	timing = bfin_otp_init_timing();
-	if (timing == 0) {
-		mutex_unlock(&bfin_otp_lock);
-		return -EIO;
-	}
-
-	base_flags = OTP_CHECK_FOR_PREV_WRITE;
-
-	bytes_done = 0;
-	page = *pos / (sizeof(u64) * 2);
-	while (bytes_done < count) {
-		flags = base_flags | (*pos % (sizeof(u64) * 2) ? OTP_UPPER_HALF : OTP_LOWER_HALF);
-		stamp("processing page %i (0x%x:%s) from %p", page, flags,
-			(flags & OTP_UPPER_HALF ? "upper" : "lower"), buff + bytes_done);
-		if (copy_from_user(&content, buff + bytes_done, sizeof(content))) {
-			bytes_done = -EFAULT;
-			break;
-		}
-		ret = bfrom_OtpWrite(page, flags, &content);
-		if (ret & OTP_MASTER_ERROR) {
-			stamp("error from otp: 0x%x", ret);
-			bytes_done = -EIO;
-			break;
-		}
-		if (flags & OTP_UPPER_HALF)
-			++page;
-		bytes_done += sizeof(content);
-		*pos += sizeof(content);
-	}
-
-	bfin_otp_deinit_timing(timing);
-
-	mutex_unlock(&bfin_otp_lock);
-
-	return bytes_done;
-}
-
-static long bfin_otp_ioctl(struct file *filp, unsigned cmd, unsigned long arg)
-{
-	stampit();
-
-	switch (cmd) {
-	case OTPLOCK: {
-		u32 timing;
-		int ret = -EIO;
-
-		if (!allow_writes)
-			return -EACCES;
-
-		if (mutex_lock_interruptible(&bfin_otp_lock))
-			return -ERESTARTSYS;
-
-		timing = bfin_otp_init_timing();
-		if (timing) {
-			u32 otp_result = bfrom_OtpWrite(arg, OTP_LOCK, NULL);
-			stamp("locking page %lu resulted in 0x%x", arg, otp_result);
-			if (!(otp_result & OTP_MASTER_ERROR))
-				ret = 0;
-
-			bfin_otp_deinit_timing(timing);
-		}
-
-		mutex_unlock(&bfin_otp_lock);
-
-		return ret;
-	}
-
-	case MEMLOCK:
-		allow_writes = false;
-		return 0;
-
-	case MEMUNLOCK:
-		allow_writes = true;
-		return 0;
-	}
-
-	return -EINVAL;
-}
-#else
-# define bfin_otp_write NULL
-# define bfin_otp_ioctl NULL
-#endif
-
-static const struct file_operations bfin_otp_fops = {
-	.owner          = THIS_MODULE,
-	.unlocked_ioctl = bfin_otp_ioctl,
-	.read           = bfin_otp_read,
-	.write          = bfin_otp_write,
-	.llseek		= default_llseek,
-};
-
-static struct miscdevice bfin_otp_misc_device = {
-	.minor    = MISC_DYNAMIC_MINOR,
-	.name     = DRIVER_NAME,
-	.fops     = &bfin_otp_fops,
-};
-module_misc_device(bfin_otp_misc_device);
-
-MODULE_AUTHOR("Mike Frysinger <vapier@gentoo.org>");
-MODULE_DESCRIPTION("Blackfin OTP Memory Interface");
-MODULE_LICENSE("GPL");
-- 
2.7.4
