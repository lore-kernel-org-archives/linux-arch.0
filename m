From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH 1/3] tty/serial_core: add ISO7816 infrastructure
Date: Fri, 13 Jul 2018 10:01:29 +0200
Message-ID: <20180713080129.2ifw7crjksvaxxpq@M43218.corp.atmel.com>
References: <20180711131638.12622-1-ludovic.desroches@microchip.com>
 <20180711131638.12622-2-ludovic.desroches@microchip.com>
 <20180712145808.GA22502@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180712145808.GA22502@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jslaby@suse.com, arnd@arndb.de, richard.genoud@gmail.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 12, 2018 at 04:58:08PM +0200, Greg KH wrote:
> On Wed, Jul 11, 2018 at 03:16:36PM +0200, Ludovic Desroches wrote:
> > From: Nicolas Ferre <nicolas.ferre@microchip.com>
> > 
> > Add the ISO7816 ioctl and associated accessors and data structure.
> > Drivers can then use this common implementation to handle ISO7816.
> > 
> > Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> > [ludovic.desroches@microchip.com: squash and rebase, removal of gpios, checkpatch fixes]
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> > ---
> >  drivers/tty/serial/serial_core.c  | 49 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/serial_core.h       |  3 +++
> >  include/uapi/asm-generic/ioctls.h |  2 ++
> >  include/uapi/linux/serial.h       | 17 ++++++++++++++
> >  4 files changed, 71 insertions(+)
> 
> Note, kbuild found build issues with this, please fix up.
> 
> Also, here's some comments:
> 
> > 
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> > index 9c14a453f73c..c89ac59f6f8c 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -1301,6 +1301,47 @@ static int uart_set_rs485_config(struct uart_port *port,
> >  	return 0;
> >  }
> >  
> > +static int uart_get_iso7816_config(struct uart_port *port,
> > +				   struct serial_iso7816 __user *iso7816)
> > +{
> > +	unsigned long flags;
> > +	struct serial_iso7816 aux;
> > +
> > +	spin_lock_irqsave(&port->lock, flags);
> > +	aux = port->iso7816;
> 
> Don't you want to check to see if there is a function for iso7816 before
> copying it?  Otherwise it's just empty, right?

I'll add the check.

> 
> > +	if (!port->iso7816_config)
> > +		return -ENOIOCTLCMD;
> 
> Why this error value?
> 

It was a mimic of RS485.

> > --- a/include/uapi/asm-generic/ioctls.h
> > +++ b/include/uapi/asm-generic/ioctls.h
> > @@ -66,6 +66,8 @@
> >  #ifndef TIOCSRS485
> >  #define TIOCSRS485	0x542F
> >  #endif
> > +#define TIOCGISO7816	0x5430
> > +#define TIOCSISO7816	0x5431
> 
> Where did you get these numbers from?

I will use the macros to create numbers. Any rules about nr choice?

Regards

Ludovic

> 
> thanks,
> 
> greg k-h
