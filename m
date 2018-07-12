From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/3] tty/serial: atmel: manage shutdown in case of RS485
 or ISO7816 mode
Date: Thu, 12 Jul 2018 16:59:18 +0200
Message-ID: <20180712145918.GC22502@kroah.com>
References: <20180711131638.12622-1-ludovic.desroches@microchip.com>
 <20180711131638.12622-4-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180711131638.12622-4-ludovic.desroches@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jslaby@suse.com, arnd@arndb.de, richard.genoud@gmail.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Jul 11, 2018 at 03:16:38PM +0200, Ludovic Desroches wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> In atmel_shutdown() we call atmel_stop_rx() and atmel_stop_tx() functions.
> Prevent the rx restart that is implemented in RS485 or ISO7816 modes when
> calling atmel_stop_tx() by using the atomic information tasklet_shutdown
> that is already in place for this purpose.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

No signed-off-by from you?

> ---
>  drivers/tty/serial/atmel_serial.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 0118b219f3a8..e4f877e1f3c6 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -617,7 +617,9 @@ static void atmel_stop_tx(struct uart_port *port)
>  	if (((port->rs485.flags & SER_RS485_ENABLED) &&
>  	     !(port->rs485.flags & SER_RS485_RX_DURING_TX)) ||
>  	    port->iso7816.flags & SER_ISO7816_ENABLED)
> -		atmel_start_rx(port);
> +		if (!atomic_read(&atmel_port->tasklet_shutdown))
> +			atmel_start_rx(port);

Is this really ok?  No locking needed?  What happens if that value is
set right after this?

thanks,

greg k-h
