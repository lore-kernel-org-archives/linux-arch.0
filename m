Return-Path: <rmk+linux-arch=vger.kernel.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:774 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262837AbUFNMpG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 14 Jun 2004 08:45:06 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.33)
	id 1BZqpk-0001UF-CF
	for linux-arch@vger.kernel.org; Mon, 14 Jun 2004 13:45:04 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.33)
	id 1BZqpj-0005jl-0k
	for linux-arch@vger.kernel.org; Mon, 14 Jun 2004 13:45:03 +0100
Date: Mon, 14 Jun 2004 13:45:02 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH 1/3] Provide console_device()
Message-ID: <20040614134502.C14403@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King <rmk@arm.linux.org.uk>
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

[This patch series will also appear on lkml shortly]

Add console_device() to return the console tty driver structure and the
index.  Acquire the console lock while scanning the list of console
drivers to protect us against console driver list manipulations.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/drivers/char/tty_io.c linux/drivers/char/tty_io.c
--- orig/drivers/char/tty_io.c	Wed Jun  9 00:51:02 2004
+++ linux/drivers/char/tty_io.c	Mon Jun 14 10:55:28 2004
@@ -1344,13 +1344,8 @@ retry_open:
 	}
 #endif
 	if (device == MKDEV(TTYAUX_MAJOR,1)) {
-		struct console *c = console_drivers;
-		for (c = console_drivers; c; c = c->next) {
-			if (!c->device)
-				continue;
-			driver = c->device(c, &index);
-			if (!driver)
-				continue;
+		driver = console_device(&index);
+		if (driver) {
 			/* Don't let /dev/console block */
 			filp->f_flags |= O_NONBLOCK;
 			noctty = 1;
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/kernel/printk.c linux/kernel/printk.c
--- orig/kernel/printk.c	Sun May 30 10:33:00 2004
+++ linux/kernel/printk.c	Mon Jun 14 10:56:18 2004
@@ -683,6 +683,23 @@ void console_unblank(void)
 }
 EXPORT_SYMBOL(console_unblank);
 
+struct tty_driver *console_device(int *index)
+{
+	struct console *c;
+	struct tty_driver *driver = NULL;
+
+	acquire_console_sem();
+	for (c = console_drivers; c != NULL; c = c->next) {
+		if (!c->device)
+			continue;
+		driver = c->device(c, index);
+		if (driver)
+			break;
+	}
+	release_console_sem();
+	return driver;
+}
+
 /*
  * The console driver calls this routine during kernel initialization
  * to register the console printing procedure with printk() and to
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/include/linux/console.h linux/include/linux/console.h
--- orig/include/linux/console.h	Mon May 24 11:26:21 2004
+++ linux/include/linux/console.h	Mon Jun 14 10:55:28 2004
@@ -104,6 +104,7 @@ extern void acquire_console_sem(void);
 extern void release_console_sem(void);
 extern void console_conditional_schedule(void);
 extern void console_unblank(void);
+extern struct tty_driver *console_device(int *);
 extern int is_console_locked(void);
 
 /* Some debug stub to catch some of the obvious races in the VT code */

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
