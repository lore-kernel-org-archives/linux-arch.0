Return-Path: <rmk+linux-arch=vger.kernel.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2566 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262882AbUFNMpl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 14 Jun 2004 08:45:41 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.33)
	id 1BZqqJ-0001UO-Ei
	for linux-arch@vger.kernel.org; Mon, 14 Jun 2004 13:45:39 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.33)
	id 1BZqqI-0005mE-Mt
	for linux-arch@vger.kernel.org; Mon, 14 Jun 2004 13:45:38 +0100
Date: Mon, 14 Jun 2004 13:45:38 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] Provide console_suspend() and console_resume()
Message-ID: <20040614134538.D14403@flint.arm.linux.org.uk>
References: <20040614134502.C14403@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614134502.C14403@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Mon, Jun 14, 2004 at 01:45:02PM +0100
Sender: Russell King <rmk@arm.linux.org.uk>
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Add console_suspend() and console_resume() methods so the serial drivers
can disable console output before suspending a port, and re-enable output
afterwards.

We also add locking to ensure that we synchronise with any in-progress
printk.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/drivers/serial/serial_core.c linux/drivers/serial/serial_core.c
--- orig/drivers/serial/serial_core.c	Sun May 30 10:32:45 2004
+++ linux/drivers/serial/serial_core.c	Mon Jun 14 10:59:49 2004
@@ -1923,7 +1923,7 @@ int uart_suspend_port(struct uart_driver
 	 * Disable the console device before suspending.
 	 */
 	if (uart_console(port))
-		port->cons->flags &= ~CON_ENABLED;
+		console_suspend(port->cons);
 
 	uart_change_pm(state, 3);
 
@@ -1945,7 +1945,7 @@ int uart_resume_port(struct uart_driver 
 	 */
 	if (uart_console(port)) {
 		uart_change_speed(state, NULL);
-		port->cons->flags |= CON_ENABLED;
+		console_resume(port->cons);
 	}
 
 	if (state->info && state->info->flags & UIF_INITIALIZED) {
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/kernel/printk.c linux/kernel/printk.c
--- orig/kernel/printk.c	Mon Jun 14 11:01:49 2004
+++ linux/kernel/printk.c	Mon Jun 14 11:01:37 2004
@@ -700,6 +700,22 @@ struct tty_driver *console_device(int *i
 	return driver;
 }
 
+void console_suspend(struct console *console)
+{
+	acquire_console_sem();
+	console->flags &= ~CON_ENABLED;
+	release_console_sem();
+}
+EXPORT_SYMBOL(console_suspend);
+
+void console_resume(struct console *console)
+{
+	acquire_console_sem();
+	console->flags |= CON_ENABLED;
+	release_console_sem();
+}
+EXPORT_SYMBOL(console_resume);
+
 /*
  * The console driver calls this routine during kernel initialization
  * to register the console printing procedure with printk() and to
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/include/linux/console.h linux/include/linux/console.h
--- orig/include/linux/console.h	Mon Jun 14 11:01:49 2004
+++ linux/include/linux/console.h	Mon Jun 14 11:00:21 2004
@@ -105,6 +105,8 @@ extern void release_console_sem(void);
 extern void console_conditional_schedule(void);
 extern void console_unblank(void);
 extern struct tty_driver *console_device(int *);
+extern void console_suspend(struct console *);
+extern void console_resume(struct console *);
 extern int is_console_locked(void);
 
 /* Some debug stub to catch some of the obvious races in the VT code */

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
