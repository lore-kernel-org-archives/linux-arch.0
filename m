Return-Path: <willy@www.linux.org.uk>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24758 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262389AbUFNOCE
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 14 Jun 2004 10:02:04 -0400
Received: from willy by www.linux.org.uk with local (Exim 4.33)
	id 1BZs2G-0002mF-AB
	for linux-arch@vger.kernel.org; Mon, 14 Jun 2004 15:02:04 +0100
Date: Mon, 14 Jun 2004 15:02:04 +0100
From: Matthew Wilcox <willy@debian.org>
Subject: Re: [RFC][PATCH 3/3] Convert console list to list_head
Message-ID: <20040614140204.GC20511@parcelfarce.linux.theplanet.co.uk>
References: <20040614134502.C14403@flint.arm.linux.org.uk> <20040614134538.D14403@flint.arm.linux.org.uk> <20040614134623.E14403@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614134623.E14403@flint.arm.linux.org.uk>
Sender: <willy@www.linux.org.uk>
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Jun 14, 2004 at 01:46:23PM +0100, Russell King wrote:
> arch/parisc/kernel/pdc_cons.c:  while ((console = console_drivers) != NULL)
> arch/parisc/kernel/pdc_cons.c:          unregister_console(console_drivers);
> arch/parisc/kernel/traps.c:     if (!console_drivers)
> arch/parisc/kernel/traps.c:     if (!console_drivers)
> 
>   PARISC seems to like to unregister all consoles, and then re-
>   registers its own console driver.  IOW, it assumes it can safely
>   override the state of the console subsystem independent of whatever
>   drivers may be registered.

This gets into one of the ugliest bits of the parisc patch that I haven't
figured out how to do cleanly yet.  We have a firmware console (called
PDC console) that may be printing to screen or serial.  The device
that's being addressed might be on a PCI bus, so we can't print to it
while we're walking the PCI busses.  We also can't use it after boot, or
it'll fight with the serial driver.  So we have the following patch in our
tree:

diff -urN --exclude-from=/tmp/dont19263.10184 ../.#prev/linux-2.6/include/linux/console.h linux-2.6/include/linux/console.h
--- ../.#prev/linux-2.6/include/linux/console.h	Sun May 23 18:03:34 2004
+++ linux-2.6/include/linux/console.h	Sun May 23 18:00:46 2004
@@ -80,6 +80,7 @@
 #define CON_PRINTBUFFER	(1)
 #define CON_CONSDEV	(2) /* Last on the command line */
 #define CON_ENABLED	(4)
+#define CON_BOOT	(8)
 
 struct console
 {
diff -urN --exclude-from=/tmp/dont19263.10184 ../.#prev/linux-2.6/kernel/printk.c linux-2.6/kernel/printk.c
--- ../.#prev/linux-2.6/kernel/printk.c	Sun May 23 18:03:36 2004
+++ linux-2.6/kernel/printk.c	Mon May 10 09:40:38 2004
@@ -91,8 +91,8 @@
  * must be masked before subscripting
  */
 static unsigned long log_start;	/* Index into log_buf: next char to be read by syslog() */
-static unsigned long con_start;	/* Index into log_buf: next char to be sent to consoles */
-static unsigned long log_end;	/* Index into log_buf: most-recently-written-char + 1 */
+unsigned long con_start;	/* Index into log_buf: next char to be sent to consoles */
+unsigned long log_end;	/* Index into log_buf: most-recently-written-char + 1 */
 static unsigned long logged_chars; /* Number of chars produced since last read+clear operation */
 
 /*
@@ -716,6 +716,11 @@
 
 	if (!(console->flags & CON_ENABLED))
 		return;
+
+	if (console_drivers && (console_drivers->flags & CON_BOOT)) {
+		unregister_console(console_drivers);
+		console->flags &= ~CON_PRINTBUFFER;
+	}
 
 	/*
 	 *	Put this console in the list - keep the

ie we can add a console flagged as CON_BOOT.  When the next console is
added, it deletes the one flagged as CON_BOOT and doesn't print the buffer
(on the grounds we've already seen it).

The piece of code you've stumbled across is in pdc_console_restart().
This is only called in an emergency -- the machine is going down, and
we want to try our absolute hardest to get the panic message to the
user's console.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
