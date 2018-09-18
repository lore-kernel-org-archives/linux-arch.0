Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:35696 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbeIRTBi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 15:01:38 -0400
Date: Tue, 18 Sep 2018 15:28:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 2/2] tty/serial: atmel: add ISO7816 support
Message-ID: <20180918132856.GA14333@kroah.com>
References: <20180906134214.29031-1-ludovic.desroches@microchip.com>
 <20180906134214.29031-3-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906134214.29031-3-ludovic.desroches@microchip.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jslaby@suse.com, arnd@arndb.de, richard.genoud@gmail.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org
Message-ID: <20180918132856.KEhY8XySSgJUvLA3IZxA-GRgNu9dAdc-n3FSmsv-Y3c@z>

On Thu, Sep 06, 2018 at 03:42:14PM +0200, Ludovic Desroches wrote:
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
> Acked-by: Richard Genoud <richard.genoud@gmail.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 190 +++++++++++++++++++++++++++++++++++---
>  drivers/tty/serial/atmel_serial.h |   3 +-
>  2 files changed, 181 insertions(+), 12 deletions(-)

This doesn't apply to my tree :(

Also, shouldn't this new ioctl be documented somewhere?

thanks,

greg k-h
