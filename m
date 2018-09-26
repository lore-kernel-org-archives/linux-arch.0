Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:16840 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeIZTIY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Sep 2018 15:08:24 -0400
Date: Wed, 26 Sep 2018 14:55:28 +0200
From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH v4 2/2] tty/serial: atmel: add ISO7816 support
Message-ID: <20180926125528.fmfti62ymod2derb@M43218.corp.atmel.com>
References: <20180906134214.29031-1-ludovic.desroches@microchip.com>
 <20180906134214.29031-3-ludovic.desroches@microchip.com>
 <20180918132856.GA14333@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180918132856.GA14333@kroah.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jslaby@suse.com, arnd@arndb.de, richard.genoud@gmail.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org
Message-ID: <20180926125528.69ZkZwmkH9jtatT3qukM8AXYUWALIuJjADm5ozJfCTY@z>

On Tue, Sep 18, 2018 at 03:28:56PM +0200, Greg KH wrote:
> On Thu, Sep 06, 2018 at 03:42:14PM +0200, Ludovic Desroches wrote:
> > From: Nicolas Ferre <nicolas.ferre@microchip.com>
> > 
> > When mode is set in atmel_config_iso7816() we backup last RS232 mode
> > for coming back to this mode if requested.
> > Also allow setup of T=0 and T=1 parameter and basic support in set_termios
> > function as well.
> > 
> > Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> > [ludovic.desroches@microchip.com: rebase, add check on fidi ratio, checkpatch fixes]
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> > Acked-by: Richard Genoud <richard.genoud@gmail.com>
> > ---
> >  drivers/tty/serial/atmel_serial.c | 190 +++++++++++++++++++++++++++++++++++---
> >  drivers/tty/serial/atmel_serial.h |   3 +-
> >  2 files changed, 181 insertions(+), 12 deletions(-)
> 
> This doesn't apply to my tree :(
> 

I am rebasing it on tty-next.

> Also, shouldn't this new ioctl be documented somewhere?
> 

v5 is coming.

Regards

Ludovic
