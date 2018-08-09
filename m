Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.142]:40491 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbeHILLM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Aug 2018 07:11:12 -0400
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id E41C420F45
        for <linux-arch@vger.kernel.org>; Thu,  9 Aug 2018 10:47:19 +0200 (CEST)
Subject: Re: [PATCH v3 2/2] tty/serial: atmel: add ISO7816 support
References: <20180807130049.5957-1-ludovic.desroches@microchip.com>
 <20180807130049.5957-3-ludovic.desroches@microchip.com>
From: Richard Genoud <richard.genoud@gmail.com>
Message-ID: <d66c4318-1d31-5c4e-3952-6b69a010b028@sorico.fr>
Date: Thu, 9 Aug 2018 10:47:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180807130049.5957-3-ludovic.desroches@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ludovic Desroches <ludovic.desroches@microchip.com>, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, arnd@arndb.de, richard.genoud@gmail.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org
Message-ID: <20180809084717.2ctPW0hXgY-05eT6jkgGj559knCqpF8lrJaMaJrTJrg@z>

Hi !

On 07/08/2018 15:00, Ludovic Desroches wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> When mode is set in atmel_config_iso7816() we backup last RS232 mode
> for coming back to this mode if requested.
> Also allow setup of T=0 and T=1 parameter and basic support in set_termios
> function as well.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> [ludovic.desroches@microchip.com: rebase, add check on fidi ratio, checkpatch fixes]
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 211 +++++++++++++++++++++++++++++++++++---
>  drivers/tty/serial/atmel_serial.h |   6 +-
>  2 files changed, 201 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 8e4428725848..4a7ec44b0ace 100644
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
> @@ -83,6 +84,11 @@ static void atmel_stop_rx(struct uart_port *port);
>  
>  #define ATMEL_ISR_PASS_LIMIT	256
>  
> +struct atmel_uart_pdata {
> +	unsigned int	fidi_min;
> +	unsigned int	fidi_max;
> +};
> +
>  struct atmel_dma_buffer {
>  	unsigned char	*buf;
>  	dma_addr_t	dma_addr;
> @@ -114,6 +120,7 @@ struct atmel_uart_char {
>   */
>  struct atmel_uart_port {
>  	struct uart_port	uart;		/* uart */
> +	const struct atmel_uart_pdata *pdata;	/* SoC specific parameters */
>  	struct clk		*clk;		/* uart clock */
>  	int			may_wakeup;	/* cached value of device_may_wakeup for times we need to disable it */
>  	u32			backup_imr;	/* IMR saved during suspend */
> @@ -147,6 +154,8 @@ struct atmel_uart_port {
>  	struct circ_buf		rx_ring;
>  
>  	struct mctrl_gpios	*gpios;
> +	u32			backup_mode;	/* MR saved during iso7816 operations */
> +	u32			backup_brgr;	/* BRGR saved during iso7816 operations */
>  	unsigned int		tx_done_mask;
>  	u32			fifo_size;
>  	u32			rts_high;
> @@ -192,10 +201,34 @@ static struct console atmel_console;
>  #endif
>  
>  #if defined(CONFIG_OF)
> +static struct atmel_uart_pdata at91rm9200_pdata = {
> +	.fidi_min = 1,
> +	.fidi_max = 2047,
> +};
> +
> +static struct atmel_uart_pdata at91sam9260_pdata = {
> +	.fidi_min = 1,
> +	.fidi_max = 2047,
> +};
> +
> +static struct atmel_uart_pdata sama5d3_pdata = {
> +	.fidi_min = 3,
> +	.fidi_max = 65535,
Are you sure this is for sama5d3 ?
