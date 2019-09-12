Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtpcmd0871.aruba.it ([62.149.156.71]:46879 "EHLO
        smtpcmd0871.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfILIsB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Sep 2019 04:48:01 -0400
From: Rodolfo Giometti <giometti@enneenne.com>
Subject: [PATCH 2/2] tty serial: add multidrop support for atmel serial controllers
Date: Thu, 12 Sep 2019 10:40:32 +0200
Message-Id: <20190912084032.16927-3-giometti@enneenne.com>
In-Reply-To: <20190912084032.16927-1-giometti@enneenne.com>
References: <20190912084032.16927-1-giometti@enneenne.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, Richard Genoud <richard.genoud@gmail.com>, Rodolfo Giometti <giometti@linux.it>, Joshua Henderson <joshua.henderson@microchip.com>

From: Rodolfo Giometti <giometti@linux.it>

This patch adds multidrop support for atmel serial controllers and it
has been tested by using a SAMA5D3 CPU.

Signed-off-by: Rodolfo Giometti <giometti@linux.it>
Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
---
 drivers/tty/serial/atmel_serial.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 0b4f36905321..b30b4a336907 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2178,7 +2178,7 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 	unsigned long flags;
-	unsigned int old_mode, mode, imr, quot, baud, div, cd, fp = 0;
+	unsigned int old_mode, mode, mdrop, imr, quot, baud, div, cd, fp = 0;
 
 	/* save the current mode register */
 	mode = old_mode = atmel_uart_readl(port, ATMEL_US_MR);
@@ -2211,9 +2211,11 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	/* parity */
 	if (termios->c_cflag & PARENB) {
-		/* Mark or Space parity */
+		/* Mark, Space or Multidrop parity */
 		if (termios->c_cflag & CMSPAR) {
-			if (termios->c_cflag & PARODD)
+			if (termios->c_cflag & PARMD)
+				mode |= ATMEL_US_PAR_MULTI_DROP;
+			else if (termios->c_cflag & PARODD)
 				mode |= ATMEL_US_PAR_MARK;
 			else
 				mode |= ATMEL_US_PAR_SPACE;
@@ -2221,8 +2223,11 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 			mode |= ATMEL_US_PAR_ODD;
 		else
 			mode |= ATMEL_US_PAR_EVEN;
+
 	} else
 		mode |= ATMEL_US_PAR_NONE;
+	mdrop = termios->c_cflag & SENDA ? ATMEL_US_SENDA : 0;
+	termios->c_cflag &= ~SENDA; /* SENDA bit must be cleared once used */
 
 	spin_lock_irqsave(&port->lock, flags);
 
@@ -2363,7 +2368,8 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (!(port->iso7816.flags & SER_ISO7816_ENABLED))
 		atmel_uart_writel(port, ATMEL_US_BRGR, quot);
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA | ATMEL_US_RSTRX);
-	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN | ATMEL_US_RXEN);
+	atmel_uart_writel(port, ATMEL_US_CR,
+			  mdrop | ATMEL_US_TXEN | ATMEL_US_RXEN);
 	atmel_port->tx_stopped = false;
 
 	/* restore interrupts */
-- 
2.17.1
