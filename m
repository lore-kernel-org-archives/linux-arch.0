From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH v5 2/2] tty/serial: atmel: add ISO7816 support
Date: Wed, 26 Sep 2018 14:58:48 +0200
Message-ID: <20180926125848.31032-3-ludovic.desroches@microchip.com>
References: <20180926125848.31032-1-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926125848.31032-1-ludovic.desroches@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: gregkh@linuxfoundation.org, arnd@arndb.de, richard.genoud@gmail.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@microchip.com>
List-Id: linux-arch.vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

When mode is set in atmel_config_iso7816() we backup last RS232 mode
for coming back to this mode if requested.
Also allow setup of T=0 and T=1 parameter and basic support in set_termios
function as well.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
[ludovic.desroches@microchip.com: rebase, add check on fidi ratio, checkpatch fixes]
Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Acked-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/tty/serial/atmel_serial.c | 190 +++++++++++++++++++++++++++++++++++---
 drivers/tty/serial/atmel_serial.h |   3 +-
 2 files changed, 181 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 267d4d1de3f8..05147fe24343 100644
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
@@ -163,6 +166,10 @@ struct atmel_uart_port {
 	unsigned int		pending_status;
 	spinlock_t		lock_suspended;
 
+	/* ISO7816 */
+	unsigned int		fidi_min;
+	unsigned int		fidi_max;
+
 #ifdef CONFIG_PM
 	struct {
 		u32		cr;
@@ -361,6 +368,127 @@ static int atmel_config_rs485(struct uart_port *port,
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
+	do_div(mck_rate, iso7816conf->clk);
+	cd = mck_rate;
+	return cd;
+}
+
+static unsigned int atmel_calc_fidi(struct uart_port *port,
+				    struct serial_iso7816 *iso7816conf)
+{
+	u64 fidi = 0;
+
+	if (iso7816conf->sc_fi && iso7816conf->sc_di) {
+		fidi = (u64)iso7816conf->sc_fi;
+		do_div(fidi, iso7816conf->sc_di);
+	}
+	return (u32)fidi;
+}
+
+/* Enable or disable the iso7816 support */
+/* Called with interrupts disabled */
+static int atmel_config_iso7816(struct uart_port *port,
+				struct serial_iso7816 *iso7816conf)
+{
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	unsigned int mode;
+	unsigned int cd, fidi;
+	int ret = 0;
+
+	/* Disable interrupts */
+	atmel_uart_writel(port, ATMEL_US_IDR, atmel_port->tx_done_mask);
+
+	mode = atmel_uart_readl(port, ATMEL_US_MR);
+
+	if (iso7816conf->flags & SER_ISO7816_ENABLED) {
+		mode &= ~ATMEL_US_USMODE;
+
+		if (iso7816conf->tg > 255) {
+			dev_err(port->dev, "ISO7816: Timeguard exceeding 255\n");
+			memset(iso7816conf, 0, sizeof(struct serial_iso7816));
+			ret = -EINVAL;
+			goto err_out;
+		}
+
+		if ((iso7816conf->flags & SER_ISO7816_T_PARAM)
+		    == SER_ISO7816_T(0)) {
+			mode |= ATMEL_US_USMODE_ISO7816_T0 | ATMEL_US_DSNACK;
+		} else if ((iso7816conf->flags & SER_ISO7816_T_PARAM)
+			   == SER_ISO7816_T(1)) {
+			mode |= ATMEL_US_USMODE_ISO7816_T1 | ATMEL_US_INACK;
+		} else {
+			dev_err(port->dev, "ISO7816: Type not supported\n");
+			memset(iso7816conf, 0, sizeof(struct serial_iso7816));
+			ret = -EINVAL;
+			goto err_out;
+		}
+
+		mode &= ~(ATMEL_US_USCLKS | ATMEL_US_NBSTOP | ATMEL_US_PAR);
+
+		/* select mck clock, and output  */
+		mode |= ATMEL_US_USCLKS_MCK | ATMEL_US_CLKO;
+		/* set parity for normal/inverse mode + max iterations */
+		mode |= ATMEL_US_PAR_EVEN | ATMEL_US_NBSTOP_1 | ATMEL_US_MAX_ITER(3);
+
+		cd = atmel_calc_cd(port, iso7816conf);
+		fidi = atmel_calc_fidi(port, iso7816conf);
+		if (fidi == 0) {
+			dev_warn(port->dev, "ISO7816 fidi = 0, Generator generates no signal\n");
+		} else if (fidi < atmel_port->fidi_min
+			   || fidi > atmel_port->fidi_max) {
+			dev_err(port->dev, "ISO7816 fidi = %u, value not supported\n", fidi);
+			memset(iso7816conf, 0, sizeof(struct serial_iso7816));
+			ret = -EINVAL;
+			goto err_out;
+		}
+
+		if (!(port->iso7816.flags & SER_ISO7816_ENABLED)) {
+			/* port not yet in iso7816 mode: store configuration */
+			atmel_port->backup_mode = atmel_uart_readl(port, ATMEL_US_MR);
+			atmel_port->backup_brgr = atmel_uart_readl(port, ATMEL_US_BRGR);
+		}
+
+		atmel_uart_writel(port, ATMEL_US_TTGR, iso7816conf->tg);
+		atmel_uart_writel(port, ATMEL_US_BRGR, cd);
+		atmel_uart_writel(port, ATMEL_US_FIDI, fidi);
+
+		atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXDIS | ATMEL_US_RXEN);
+		atmel_port->tx_done_mask = ATMEL_US_TXEMPTY | ATMEL_US_NACK | ATMEL_US_ITERATION;
+	} else {
+		dev_dbg(port->dev, "Setting UART back to RS232\n");
+		/* back to last RS232 settings */
+		mode = atmel_port->backup_mode;
+		memset(iso7816conf, 0, sizeof(struct serial_iso7816));
+		atmel_uart_writel(port, ATMEL_US_TTGR, 0);
+		atmel_uart_writel(port, ATMEL_US_BRGR, atmel_port->backup_brgr);
+		atmel_uart_writel(port, ATMEL_US_FIDI, 0x174);
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
+
+	return ret;
+}
+
 /*
  * Return TIOCSER_TEMT when transmitter FIFO and Shift register is empty.
  */
@@ -480,8 +608,9 @@ static void atmel_stop_tx(struct uart_port *port)
 	/* Disable interrupts */
 	atmel_uart_writel(port, ATMEL_US_IDR, atmel_port->tx_done_mask);
 
-	if ((port->rs485.flags & SER_RS485_ENABLED) &&
-	    !(port->rs485.flags & SER_RS485_RX_DURING_TX))
+	if (((port->rs485.flags & SER_RS485_ENABLED) &&
+	     !(port->rs485.flags & SER_RS485_RX_DURING_TX)) ||
+	    port->iso7816.flags & SER_ISO7816_ENABLED)
 		atmel_start_rx(port);
 }
 
@@ -499,8 +628,9 @@ static void atmel_start_tx(struct uart_port *port)
 		return;
 
 	if (atmel_use_pdc_tx(port) || atmel_use_dma_tx(port))
-		if ((port->rs485.flags & SER_RS485_ENABLED) &&
-		    !(port->rs485.flags & SER_RS485_RX_DURING_TX))
+		if (((port->rs485.flags & SER_RS485_ENABLED) &&
+		     !(port->rs485.flags & SER_RS485_RX_DURING_TX)) ||
+		    port->iso7816.flags & SER_ISO7816_ENABLED)
 			atmel_stop_rx(port);
 
 	if (atmel_use_pdc_tx(port))
@@ -798,8 +928,9 @@ static void atmel_complete_tx_dma(void *arg)
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
@@ -1282,6 +1413,9 @@ atmel_handle_status(struct uart_port *port, unsigned int pending,
 			wake_up_interruptible(&port->state->port.delta_msr_wait);
 		}
 	}
+
+	if (pending & (ATMEL_US_NACK | ATMEL_US_ITERATION))
+		dev_dbg(port->dev, "ISO7816 ERROR (0x%08x)\n", pending);
 }
 
 /*
@@ -1374,8 +1508,9 @@ static void atmel_tx_pdc(struct uart_port *port)
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
@@ -1727,6 +1862,22 @@ static void atmel_get_ip_name(struct uart_port *port)
 		atmel_port->has_frac_baudrate = true;
 		atmel_port->has_hw_timer = true;
 		atmel_port->rtor = ATMEL_US_RTOR;
+		version = atmel_uart_readl(port, ATMEL_US_VERSION);
+		switch (version) {
+		case 0x814:	/* sama5d2 */
+			/* fall through */
+		case 0x701:	/* sama5d4 */
+			atmel_port->fidi_min = 3;
+			atmel_port->fidi_max = 65535;
+			break;
+		case 0x502:	/* sam9x5, sama5d3 */
+			atmel_port->fidi_min = 3;
+			atmel_port->fidi_max = 2047;
+			break;
+		default:
+			atmel_port->fidi_min = 1;
+			atmel_port->fidi_max = 2047;
+		}
 	} else if (name == dbgu_uart) {
 		dev_dbg(port->dev, "Dbgu or uart without hw timer\n");
 	} else {
@@ -2100,6 +2251,17 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 		atmel_uart_writel(port, ATMEL_US_TTGR,
 				  port->rs485.delay_rts_after_send);
 		mode |= ATMEL_US_USMODE_RS485;
+	} else if (port->iso7816.flags & SER_ISO7816_ENABLED) {
+		atmel_uart_writel(port, ATMEL_US_TTGR, port->iso7816.tg);
+		/* select mck clock, and output  */
+		mode |= ATMEL_US_USCLKS_MCK | ATMEL_US_CLKO;
+		/* set max iterations */
+		mode |= ATMEL_US_MAX_ITER(3);
+		if ((port->iso7816.flags & SER_ISO7816_T_PARAM)
+				== SER_ISO7816_T(0))
+			mode |= ATMEL_US_USMODE_ISO7816_T0;
+		else
+			mode |= ATMEL_US_USMODE_ISO7816_T1;
 	} else if (termios->c_cflag & CRTSCTS) {
 		/* RS232 with hardware handshake (RTS/CTS) */
 		if (atmel_use_fifo(port) &&
@@ -2176,7 +2338,8 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 	}
 	quot = cd | fp << ATMEL_US_FP_OFFSET;
 
-	atmel_uart_writel(port, ATMEL_US_BRGR, quot);
+	if (!(port->iso7816.flags & SER_ISO7816_ENABLED))
+		atmel_uart_writel(port, ATMEL_US_BRGR, quot);
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA | ATMEL_US_RSTRX);
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN | ATMEL_US_RXEN);
 	atmel_port->tx_stopped = false;
@@ -2357,6 +2520,7 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
 	port->mapbase		= mpdev->resource[0].start;
 	port->irq		= mpdev->resource[1].start;
 	port->rs485_config	= atmel_config_rs485;
+	port->iso7816_config	= atmel_config_iso7816;
 	port->membase		= NULL;
 
 	memset(&atmel_port->rx_ring, 0, sizeof(atmel_port->rx_ring));
@@ -2380,8 +2544,12 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
 		/* only enable clock when USART is in use */
 	}
 
-	/* Use TXEMPTY for interrupt when rs485 else TXRDY or ENDTX|TXBUFE */
-	if (port->rs485.flags & SER_RS485_ENABLED)
+	/*
+	 * Use TXEMPTY for interrupt when rs485 or ISO7816 else TXRDY or
+	 * ENDTX|TXBUFE
+	 */
+	if (port->rs485.flags & SER_RS485_ENABLED ||
+	    port->iso7816.flags & SER_ISO7816_ENABLED)
 		atmel_port->tx_done_mask = ATMEL_US_TXEMPTY;
 	else if (atmel_use_pdc_tx(port)) {
 		port->fifosize = PDC_BUFFER_SIZE;
diff --git a/drivers/tty/serial/atmel_serial.h b/drivers/tty/serial/atmel_serial.h
index ba3a2437cde4..d811d4f2d0c0 100644
--- a/drivers/tty/serial/atmel_serial.h
+++ b/drivers/tty/serial/atmel_serial.h
@@ -78,7 +78,8 @@
 #define	ATMEL_US_OVER		BIT(19)	/* Oversampling Mode */
 #define	ATMEL_US_INACK		BIT(20)	/* Inhibit Non Acknowledge */
 #define	ATMEL_US_DSNACK		BIT(21)	/* Disable Successive NACK */
-#define	ATMEL_US_MAX_ITER	GENMASK(26, 24)	/* Max Iterations */
+#define	ATMEL_US_MAX_ITER_MASK	GENMASK(26, 24)	/* Max Iterations */
+#define	ATMEL_US_MAX_ITER(n)	(((n) << 24) & ATMEL_US_MAX_ITER_MASK)
 #define	ATMEL_US_FILTER		BIT(28)	/* Infrared Receive Line Filter */
 
 #define ATMEL_US_IER		0x08	/* Interrupt Enable Register */
-- 
2.12.2
