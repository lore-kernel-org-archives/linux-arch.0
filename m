Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268100AbUJSJWm@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23744 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268092AbUJSJWm
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Oct 2004 05:22:42 -0400
Date: Tue, 19 Oct 2004 10:22:38 +0100
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: All archs: NO_IRQ definition
Message-ID: <20041019092238.GK16153@parcelfarce.linux.theplanet.co.uk>
References: <1098169077.11400.51.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098169077.11400.51.camel@gaston>
Sender: <willy@www.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Oct 19, 2004 at 04:57:57PM +1000, Benjamin Herrenschmidt wrote:
> parisc

-1 for parisc, please.

BTW, we could just force everyone to add it themselves by merging this
patch:

Index: drivers/serial/serial_core.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/serial/serial_core.c,v
retrieving revision 1.14.2.1
retrieving revision 1.14
diff -u -p -r1.14.2.1 -r1.14
--- drivers/serial/serial_core.c        19 Oct 2004 00:01:34 -0000      1.14.2.1
+++ drivers/serial/serial_core.c        11 Oct 2004 21:41:17 -0000      1.14
@@ -230,7 +230,8 @@ static void uart_shutdown(struct uart_st
        /*
         * Ensure that the IRQ handler isn't running on another CPU.
         */
-       synchronize_irq(port->irq);
+       if (port->irq != IRQ_NONE)
+               synchronize_irq(port->irq);
 
        /*
         * Free the transmit buffer page.
@@ -1972,7 +1973,11 @@ uart_report_port(struct uart_driver *drv
                printk("MMIO 0x%lx", port->mapbase);
                break;
        }
-       printk(" (irq = %d) is a %s\n", port->irq, uart_type(port));
+       if (port->irq == IRQ_NONE) {
+               printk(" (polled) is a %s\n", uart_type(port));
+       } else {
+               printk(" (irq = %d) is a %s\n", port->irq, uart_type(port));
+       }
 }
 
 static void


-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
