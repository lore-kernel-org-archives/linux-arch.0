Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:17627 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732434AbeGKNZD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Jul 2018 09:25:03 -0400
From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH 2/3] tty/serial: atmel: add ISO7816 support
Date: Wed, 11 Jul 2018 15:16:37 +0200
Message-ID: <20180711131638.12622-3-ludovic.desroches@microchip.com>
In-Reply-To: <20180711131638.12622-1-ludovic.desroches@microchip.com>
References: <20180711131638.12622-1-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, arnd@arndb.de, richard.genoud@gmail.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@microchip.com>
Message-ID: <20180711131637.0dcCAdO15uOtSWLX_32wpb0DS0VBG85FKIg4zMeNlnQ@z>

From: Nicolas Ferre <nicolas.ferre@microchip.com>

When mode is set in atmel_config_iso7816() we backup last RS232 mode
for coming back to this mode if requested.
Also allow setup of T=0 and T=1 parameter and basic support in set_termios
function as well.
Report NACK and ITER errors in irq handler.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
[ludovic.desroches@microchip.com: rebase, add check on fidi ratio, checkpatch fixes]
Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/tty/serial/atmel_serial.c | 175 +++++++++++++++++++++++++++++++++++---
 drivers/tty/serial/atmel_serial.h |   3 +-
 2 files changed, 167 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 8e4428725848..0118b219f3a8 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -34,6 +34,7 @@
 #include <linux/suspend.h>
 #include <linux/mm.h>
 
+#include <asm/div64.h>
 #include <asm/io.h>
 #include <asm/ioctls.h>
 
@@ -147,6 +148,8 @@ struct atmel_uart_port {
 	struct circ_buf		rx_ring;
 
 	struct mctrl_gpios	*gpios;
+	u32			backup_mode;	/* MR saved during iso7816 operations */
+	u32			backup_brgr;	/* BRGR saved during iso7816 operations */
 	unsigned int		tx_done_mask;
 	u32			fifo_size;
 	u32			rts_high;
@@ -362,6 +365,136 @@ static int atmel_config_rs485(struct uart_port *port,
 	return 0;
 }
 
+static unsigned int atmel_calc_cd(struct uart_port *port,
+				  struct serial_iso7816 *iso7816conf)
+{
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	unsigned int cd;
+	u64 mck_rate;
+
+	mck_rate = (u64)clk_get_rate(atmel_port->clk);
+	dev_dbg(port->dev, "ISO7816 mck_rate = %lld\n", mck_rate);
+	do_div(mck_rate, iso7816conf->clk);
+	cd = mck_rate;
+	dev_dbg(port->dev, "ISO7816 clk = %d. CD = %d\n", iso7816conf->clk, cd);
+	return cd;
+}
+
+static unsigned int atmel_calc_fidi(struct uart_port *port,
+				    struct serial_iso7816 *iso7816conf)
+{
+	u64 fidi = 0;
+
+	dev_dbg(port->dev, "ISO7816 fi(%d) / di(%d)\n",
+		iso7816conf->sc_fi, iso7816conf->sc_di);
+	if (iso7816conf->sc_fi && iso7816conf->sc_di) {
+		fidi = (u64)iso7816conf->sc_fi;
+		do_div(fidi, iso7816conf->sc_di);
+	}
+	dev_dbg(port->dev, "ISO7816 fidi = 0x%x\n", (u32)fidi);
+	return (u32)fidi;
+}
+
+/* Enable or disable the iso7816 support */
+/* Called with interrupts disabled */
+static int atmel_config_iso7816(struct uart_port *port,
+				struct serial_iso7816 *iso7816conf)
+{
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	unsigned int mode, t;
+	unsigned int cd, fidi;
+	int ret = 0;
+
+	/* Disable RX and TX */
+	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RXDIS | ATMEL_US_TXDIS);
+	/* Disable interrupts */
+	atmel_uart_writel(port, ATMEL_US_IDR, atmel_port->tx_done_mask);
+
+	mode = atmel_uart_readl(port, ATMEL_US_MR);
+
+	if (!(port->iso7816.flags & SER_ISO7816_ENABLED)) {
+		/* port not yet in iso7816 mode: store configuration */
+		atmel_port->backup_mode = mode;
+		atmel_port->backup_brgr = atmel_uart_readl(port, ATMEL_US_BRGR);
+	}
+
+	if (iso7816conf->flags & SER_ISO7816_ENABLED) {
+		mode &= ~ATMEL_US_USMODE;
+
+		if ((iso7816conf->flags & SER_ISO7816_T_PARAM)
+					== SER_ISO7816_T(0)) {
+			mode |= ATMEL_US_USMODE_ISO7816_T0;
+			t = 0;
+		} else if ((iso7816conf->flags & SER_ISO7816_T_PARAM)
+					== SER_ISO7816_T(1)) {
+			mode |= ATMEL_US_USMODE_ISO7816_T1;
+			t = 1;
+		} else {
+			dev_warn(port->dev, "ISO7816 Type not supported. Resetting\n");
+			memset(iso7816conf, 0, sizeof(struct serial_iso7816));
+			goto err_out;
+		}
+
+		dev_dbg(port->dev, "Setting USART to ISO7816 mode T%d\n", t);
+
+		mode &= ~(ATMEL_US_USCLKS | ATMEL_US_CHRL
+			| ATMEL_US_NBSTOP | ATMEL_US_PAR);
+
+		/* NACK configuration */
+		if ((iso7816conf->flags & SER_ISO7816_T_PARAM)
+					== SER_ISO7816_T(0))
+			mode |= ATMEL_US_DSNACK;
+		else
+			mode |= ATMEL_US_INACK;
+		/* select mck clock, and output  */
+		mode |= ATMEL_US_USCLKS_MCK | ATMEL_US_CLKO;
+		/* set parity for normal/inverse mode + max iterations */
+		mode |= ATMEL_US_PAR_EVEN | ATMEL_US_NBSTOP_1 | (3 << 24);
+
+		cd = atmel_calc_cd(port, iso7816conf);
+		fidi = atmel_calc_fidi(port, iso7816conf);
+		if (fidi < 0) {
+			dev_warn(port->dev, "ISO7816 fidi = 0, Generator generates no signal\n");
+		} else if (fidi == 1 || fidi == 2) {
+			dev_err(port->dev, "ISO7816 fidi = %u, value not supported\n", fidi);
+			ret = -EINVAL;
+			goto err_out;
+		}
+		/* Actually set ISO7816 mode */
+		atmel_uart_writel(port, ATMEL_US_TTGR, iso7816conf->tg);
+		atmel_uart_writel(port, ATMEL_US_BRGR, cd);
+		atmel_uart_writel(port, ATMEL_US_FIDIR, fidi);
+
+		atmel_port->tx_done_mask = ATMEL_US_TXEMPTY | ATMEL_US_NACK | ATMEL_US_ITERATION;
+	} else {
+		dev_dbg(port->dev, "Setting UART to RS232\n");
+		/* back to last RS232 settings */
+		mode = atmel_port->backup_mode;
+		memset(iso7816conf, 0, sizeof(struct serial_iso7816));
+		atmel_uart_writel(port, ATMEL_US_TTGR, 0);
+		atmel_uart_writel(port, ATMEL_US_BRGR, atmel_port->backup_brgr);
+		atmel_uart_writel(port, ATMEL_US_FIDIR, 0x174);
+
+		if (atmel_use_pdc_tx(port))
+			atmel_port->tx_done_mask = ATMEL_US_ENDTX |
+						   ATMEL_US_TXBUFE;
+		else
+			atmel_port->tx_done_mask = ATMEL_US_TXRDY;
+	}
+
+	port->iso7816 = *iso7816conf;
+
+	atmel_uart_writel(port, ATMEL_US_MR, mode);
+
+err_out:
+	/* Enable interrupts */
+	atmel_uart_writel(port, ATMEL_US_IER, atmel_port->tx_done_mask);
+	/* Enable RX and TX */
+	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RXEN | ATMEL_US_TXEN);
+
+	return ret;
+}
+
 /*
  * Return TIOCSER_TEMT when transmitter FIFO and Shift register is empty.
  */
@@ -481,8 +614,9 @@ static void atmel_stop_tx(struct uart_port *port)
 	/* Disable interrupts */
 	atmel_uart_writel(port, ATMEL_US_IDR, atmel_port->tx_done_mask);
 
-	if ((port->rs485.flags & SER_RS485_ENABLED) &&
-	    !(port->rs485.flags & SER_RS485_RX_DURING_TX))
+	if (((port->rs485.flags & SER_RS485_ENABLED) &&
+	     !(port->rs485.flags & SER_RS485_RX_DURING_TX)) ||
+	    port->iso7816.flags & SER_ISO7816_ENABLED)
 		atmel_start_rx(port);
 }
 
@@ -500,8 +634,9 @@ static void atmel_start_tx(struct uart_port *port)
 		return;
 
 	if (atmel_use_pdc_tx(port) || atmel_use_dma_tx(port))
-		if ((port->rs485.flags & SER_RS485_ENABLED) &&
-		    !(port->rs485.flags & SER_RS485_RX_DURING_TX))
+		if (((port->rs485.flags & SER_RS485_ENABLED) &&
+		     !(port->rs485.flags & SER_RS485_RX_DURING_TX)) ||
+		    port->iso7816.flags & SER_ISO7816_ENABLED)
 			atmel_stop_rx(port);
 
 	if (atmel_use_pdc_tx(port))
@@ -799,8 +934,9 @@ static void atmel_complete_tx_dma(void *arg)
 	 */
 	if (!uart_circ_empty(xmit))
 		atmel_tasklet_schedule(atmel_port, &atmel_port->tasklet_tx);
-	else if ((port->rs485.flags & SER_RS485_ENABLED) &&
-		 !(port->rs485.flags & SER_RS485_RX_DURING_TX)) {
+	else if (((port->rs485.flags & SER_RS485_ENABLED) &&
+		  !(port->rs485.flags & SER_RS485_RX_DURING_TX)) ||
+		 port->iso7816.flags & SER_ISO7816_ENABLED) {
 		/* DMA done, stop TX, start RX for RS485 */
 		atmel_start_rx(port);
 	}
@@ -1281,6 +1417,9 @@ atmel_handle_status(struct uart_port *port, unsigned int pending,
 			wake_up_interruptible(&port->state->port.delta_msr_wait);
 		}
 	}
+
+	if (pending & (ATMEL_US_NACK | ATMEL_US_ITERATION))
+		dev_err(port->dev, "ISO7816 ERROR (0x%08x)\n", pending);
 }
 
 /*
@@ -1373,8 +1512,9 @@ static void atmel_tx_pdc(struct uart_port *port)
 		atmel_uart_writel(port, ATMEL_US_IER,
 				  atmel_port->tx_done_mask);
 	} else {
-		if ((port->rs485.flags & SER_RS485_ENABLED) &&
-		    !(port->rs485.flags & SER_RS485_RX_DURING_TX)) {
+		if (((port->rs485.flags & SER_RS485_ENABLED) &&
+		     !(port->rs485.flags & SER_RS485_RX_DURING_TX)) ||
+		    port->iso7816.flags & SER_ISO7816_ENABLED) {
 			/* DMA done, stop TX, start RX for RS485 */
 			atmel_start_rx(port);
 		}
@@ -2099,6 +2239,18 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 		atmel_uart_writel(port, ATMEL_US_TTGR,
 				  port->rs485.delay_rts_after_send);
 		mode |= ATMEL_US_USMODE_RS485;
+	} else if (port->iso7816.flags & SER_ISO7816_ENABLED) {
+		dev_dbg(port->dev, "Setting UART to ISO7816 in termios\n");
+		atmel_uart_writel(port, ATMEL_US_TTGR, port->iso7816.tg);
+		/* select mck clock, and output  */
+		mode |= ATMEL_US_USCLKS_MCK | ATMEL_US_CLKO;
+		/* set max iterations */
+		mode |= (3 << 24);
+		if ((port->iso7816.flags & SER_ISO7816_T_PARAM)
+				== SER_ISO7816_T(0))
+			mode |= ATMEL_US_USMODE_ISO7816_T0;
+		else
+			mode |= ATMEL_US_USMODE_ISO7816_T1;
 	} else if (termios->c_cflag & CRTSCTS) {
 		/* RS232 with hardware handshake (RTS/CTS) */
 		if (atmel_use_fifo(port) &&
@@ -2175,7 +2327,8 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 	}
 	quot = cd | fp << ATMEL_US_FP_OFFSET;
 
-	atmel_uart_writel(port, ATMEL_US_BRGR, quot);
+	if (!(port->iso7816.flags & SER_ISO7816_ENABLED))
+		atmel_uart_writel(port, ATMEL_US_BRGR, quot);
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA | ATMEL_US_RSTRX);
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN | ATMEL_US_RXEN);
 	atmel_port->tx_stopped = false;
@@ -2355,6 +2508,7 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
 	port->mapbase	= pdev->resource[0].start;
 	port->irq	= pdev->resource[1].start;
 	port->rs485_config	= atmel_config_rs485;
+	port->iso7816_config	= atmel_config_iso7816;
 	port->membase	= NULL;
 
 	memset(&atmel_port->rx_ring, 0, sizeof(atmel_port->rx_ring));
@@ -2379,7 +2533,8 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
 	}
 
 	/* Use TXEMPTY for interrupt when rs485 else TXRDY or ENDTX|TXBUFE */
-	if (port->rs485.flags & SER_RS485_ENABLED)
+	if (port->rs485.flags & SER_RS485_ENABLED ||
+	    port->iso7816.flags & SER_ISO7816_ENABLED)
 		atmel_port->tx_done_mask = ATMEL_US_TXEMPTY;
 	else if (atmel_use_pdc_tx(port)) {
 		port->fifosize = PDC_BUFFER_SIZE;
diff --git a/drivers/tty/serial/atmel_serial.h b/drivers/tty/serial/atmel_serial.h
index ba3a2437cde4..fff51f5fe8bc 100644
--- a/drivers/tty/serial/atmel_serial.h
+++ b/drivers/tty/serial/atmel_serial.h
@@ -124,7 +124,8 @@
 #define ATMEL_US_TTGR		0x28	/* Transmitter Timeguard Register */
 #define	ATMEL_US_TG		GENMASK(7, 0)	/* Timeguard Value */
 
-#define ATMEL_US_FIDI		0x40	/* FI DI Ratio Register */
+#define ATMEL_US_FIDIR		0x40	/* FI DI Ratio Register */
+#define ATMEL_US_FIDI		GENMASK(15, 0)	/* FIDI ratio */
 #define ATMEL_US_NER		0x44	/* Number of Errors Register */
 #define ATMEL_US_IF		0x4c	/* IrDA Filter Register */
 
-- 
2.12.2
