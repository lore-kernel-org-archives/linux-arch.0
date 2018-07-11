Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:2682 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387692AbeGKNeb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Jul 2018 09:34:31 -0400
From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH 3/3] tty/serial: atmel: manage shutdown in case of RS485 or ISO7816 mode
Date: Wed, 11 Jul 2018 15:26:23 +0200
Message-ID: <20180711132623.13227-1-ludovic.desroches@microchip.com>
In-Reply-To: <20180711131638.12622-1-ludovic.desroches@microchip.com>
References: <20180711131638.12622-1-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, arnd@arndb.de, richard.genoud@gmail.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org
Message-ID: <20180711132623.5BcLG0ak_mwXzray8xg0u4-EOooUDI3hrRZmHyhA20Y@z>

From: Nicolas Ferre <nicolas.ferre@microchip.com>

In atmel_shutdown() we call atmel_stop_rx() and atmel_stop_tx() functions.
Prevent the rx restart that is implemented in RS485 or ISO7816 modes when
calling atmel_stop_tx() by using the atomic information tasklet_shutdown
that is already in place for this purpose.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/tty/serial/atmel_serial.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 0118b219f3a8..e4f877e1f3c6 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -617,7 +617,9 @@ static void atmel_stop_tx(struct uart_port *port)
 	if (((port->rs485.flags & SER_RS485_ENABLED) &&
 	     !(port->rs485.flags & SER_RS485_RX_DURING_TX)) ||
 	    port->iso7816.flags & SER_ISO7816_ENABLED)
-		atmel_start_rx(port);
+		if (!atomic_read(&atmel_port->tasklet_shutdown))
+			atmel_start_rx(port);
+
 }
 
 /*
-- 
2.12.2
