From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/3] tty/serial: atmel: add ISO7816 support
Date: Thu, 12 Jul 2018 17:01:53 +0200
Message-ID: <20180712150153.GD22502@kroah.com>
References: <20180711131638.12622-1-ludovic.desroches@microchip.com>
 <20180711131638.12622-3-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180711131638.12622-3-ludovic.desroches@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jslaby@suse.com, arnd@arndb.de, richard.genoud@gmail.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Jul 11, 2018 at 03:16:37PM +0200, Ludovic Desroches wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> When mode is set in atmel_config_iso7816() we backup last RS232 mode
> for coming back to this mode if requested.
> Also allow setup of T=0 and T=1 parameter and basic support in set_termios
> function as well.
> Report NACK and ITER errors in irq handler.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> [ludovic.desroches@microchip.com: rebase, add check on fidi ratio, checkpatch fixes]
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 175 +++++++++++++++++++++++++++++++++++---
>  drivers/tty/serial/atmel_serial.h |   3 +-
>  2 files changed, 167 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 8e4428725848..0118b219f3a8 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -34,6 +34,7 @@
>  #include <linux/suspend.h>
>  #include <linux/mm.h>
>  
> +#include <asm/div64.h>
>  #include <asm/io.h>
>  #include <asm/ioctls.h>
>  
> @@ -147,6 +148,8 @@ struct atmel_uart_port {
>  	struct circ_buf		rx_ring;
>  
>  	struct mctrl_gpios	*gpios;
> +	u32			backup_mode;	/* MR saved during iso7816 operations */
> +	u32			backup_brgr;	/* BRGR saved during iso7816 operations */
>  	unsigned int		tx_done_mask;
>  	u32			fifo_size;
>  	u32			rts_high;
> @@ -362,6 +365,136 @@ static int atmel_config_rs485(struct uart_port *port,
>  	return 0;
>  }
>  
> +static unsigned int atmel_calc_cd(struct uart_port *port,
> +				  struct serial_iso7816 *iso7816conf)
> +{
> +	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> +	unsigned int cd;
> +	u64 mck_rate;
> +
> +	mck_rate = (u64)clk_get_rate(atmel_port->clk);
> +	dev_dbg(port->dev, "ISO7816 mck_rate = %lld\n", mck_rate);
> +	do_div(mck_rate, iso7816conf->clk);
> +	cd = mck_rate;
> +	dev_dbg(port->dev, "ISO7816 clk = %d. CD = %d\n", iso7816conf->clk, cd);
> +	return cd;
> +}
> +
> +static unsigned int atmel_calc_fidi(struct uart_port *port,
> +				    struct serial_iso7816 *iso7816conf)
> +{
> +	u64 fidi = 0;
> +
> +	dev_dbg(port->dev, "ISO7816 fi(%d) / di(%d)\n",
> +		iso7816conf->sc_fi, iso7816conf->sc_di);

Do you still need all of the debugging code?  Shouldn't ftrace give you
all of this?



> +	if (iso7816conf->sc_fi && iso7816conf->sc_di) {
> +		fidi = (u64)iso7816conf->sc_fi;
> +		do_div(fidi, iso7816conf->sc_di);
> +	}
> +	dev_dbg(port->dev, "ISO7816 fidi = 0x%x\n", (u32)fidi);
> +	return (u32)fidi;
> +}
> +
> +/* Enable or disable the iso7816 support */
> +/* Called with interrupts disabled */
> +static int atmel_config_iso7816(struct uart_port *port,
> +				struct serial_iso7816 *iso7816conf)
> +{
> +	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> +	unsigned int mode, t;
> +	unsigned int cd, fidi;
> +	int ret = 0;
> +
> +	/* Disable RX and TX */
> +	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RXDIS | ATMEL_US_TXDIS);
> +	/* Disable interrupts */
> +	atmel_uart_writel(port, ATMEL_US_IDR, atmel_port->tx_done_mask);
> +
> +	mode = atmel_uart_readl(port, ATMEL_US_MR);
> +
> +	if (!(port->iso7816.flags & SER_ISO7816_ENABLED)) {
> +		/* port not yet in iso7816 mode: store configuration */
> +		atmel_port->backup_mode = mode;
> +		atmel_port->backup_brgr = atmel_uart_readl(port, ATMEL_US_BRGR);
> +	}

Are you really validating all of the fields in this structure for valid
values correctly?  It feels like you are missing some here...

> @@ -1281,6 +1417,9 @@ atmel_handle_status(struct uart_port *port, unsigned int pending,
>  			wake_up_interruptible(&port->state->port.delta_msr_wait);
>  		}
>  	}
> +
> +	if (pending & (ATMEL_US_NACK | ATMEL_US_ITERATION))
> +		dev_err(port->dev, "ISO7816 ERROR (0x%08x)\n", pending);

What can someone do with this?

If nothing, then why check or tell the user about it?  They will ignore
it :(

thanks,

greg k-h
