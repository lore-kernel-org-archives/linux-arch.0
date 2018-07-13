From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH 1/3] tty/serial_core: add ISO7816 infrastructure
Date: Fri, 13 Jul 2018 09:56:48 +0200
Message-ID: <20180713075648.ya2er5eip6uldl75@M43218.corp.atmel.com>
References: <20180711131638.12622-1-ludovic.desroches@microchip.com>
 <20180711131638.12622-2-ludovic.desroches@microchip.com>
 <20180712150229.GE22502@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180712150229.GE22502@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-arch@vger.kernel.org, alexandre.belloni@bootlin.com, arnd@arndb.de, richard.genoud@gmail.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 12, 2018 at 05:02:29PM +0200, Greg KH wrote:
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
> > +	spin_unlock_irqrestore(&port->lock, flags);
> > +
> > +	if (copy_to_user(iso7816, &aux, sizeof(aux)))
> > +		return -EFAULT;
> > +
> > +	return 0;
> > +}
> > +
> > +static int uart_set_iso7816_config(struct uart_port *port,
> > +				   struct serial_iso7816 __user *iso7816_user)
> > +{
> > +	struct serial_iso7816 iso7816;
> > +	int ret;
> > +	unsigned long flags;
> > +
> > +	if (!port->iso7816_config)
> > +		return -ENOIOCTLCMD;
> > +
> > +	if (copy_from_user(&iso7816, iso7816_user, sizeof(*iso7816_user)))
> > +		return -EFAULT;
> > +
> > +	spin_lock_irqsave(&port->lock, flags);
> > +	ret = port->iso7816_config(port, &iso7816);
> > +	spin_unlock_irqrestore(&port->lock, flags);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (copy_to_user(iso7816_user, &port->iso7816, sizeof(port->iso7816)))
> > +		return -EFAULT;
> > +
> > +	return 0;
> > +}
> > +
> >  /*
> >   * Called via sys_ioctl.  We can use spin_lock_irq() here.
> >   */
> > @@ -1385,6 +1426,14 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
> >  	case TIOCSRS485:
> >  		ret = uart_set_rs485_config(uport, uarg);
> >  		break;
> > +
> > +	case TIOCSISO7816:
> > +		ret = uart_set_iso7816_config(state->uart_port, uarg);
> > +		break;
> > +
> > +	case TIOCGISO7816:
> > +		ret = uart_get_iso7816_config(state->uart_port, uarg);
> > +		break;
> >  	default:
> >  		if (uport->ops->ioctl)
> >  			ret = uport->ops->ioctl(uport, cmd, arg);
> > diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> > index 06ea4eeb09ab..d6e7747ffd46 100644
> > --- a/include/linux/serial_core.h
> > +++ b/include/linux/serial_core.h
> > @@ -137,6 +137,8 @@ struct uart_port {
> >  	void			(*handle_break)(struct uart_port *);
> >  	int			(*rs485_config)(struct uart_port *,
> >  						struct serial_rs485 *rs485);
> > +	int			(*iso7816_config)(struct uart_port *,
> > +						  struct serial_iso7816 *iso7816);
> >  	unsigned int		irq;			/* irq number */
> >  	unsigned long		irqflags;		/* irq flags  */
> >  	unsigned int		uartclk;		/* base uart clock */
> > @@ -253,6 +255,7 @@ struct uart_port {
> >  	struct attribute_group	*attr_group;		/* port specific attributes */
> >  	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
> >  	struct serial_rs485     rs485;
> > +	struct serial_iso7816   iso7816;
> >  	void			*private_data;		/* generic platform data pointer */
> >  };
> >  
> > diff --git a/include/uapi/asm-generic/ioctls.h b/include/uapi/asm-generic/ioctls.h
> > index 040651735662..0e5c79726c2d 100644
> > --- a/include/uapi/asm-generic/ioctls.h
> > +++ b/include/uapi/asm-generic/ioctls.h
> > @@ -66,6 +66,8 @@
> >  #ifndef TIOCSRS485
> >  #define TIOCSRS485	0x542F
> >  #endif
> > +#define TIOCGISO7816	0x5430
> > +#define TIOCSISO7816	0x5431
> >  #define TIOCGPTN	_IOR('T', 0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
> >  #define TIOCSPTLCK	_IOW('T', 0x31, int)  /* Lock/unlock Pty */
> >  #define TIOCGDEV	_IOR('T', 0x32, unsigned int) /* Get primary device node of /dev/console */
> > diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
> > index 3fdd0dee8b41..93eb3c496ff1 100644
> > --- a/include/uapi/linux/serial.h
> > +++ b/include/uapi/linux/serial.h
> > @@ -132,4 +132,21 @@ struct serial_rs485 {
> >  					   are a royal PITA .. */
> >  };
> >  
> > +/*
> > + * Serial interface for controlling ISO7816 settings on chips with suitable
> > + * support. Set with TIOCSISO7816 and get with TIOCGISO7816 if supported by
> > + * your platform.
> > + */
> > +struct serial_iso7816 {
> > +	__u32	flags;			/* ISO7816 feature flags */
> > +#define SER_ISO7816_ENABLED		(1 << 0)
> > +#define SER_ISO7816_T_PARAM		(0x0f << 4)
> > +#define SER_ISO7816_T(t)		(((t) & 0x0f) << 4)
> > +	__u32	tg;
> > +	__u32	sc_fi;
> > +	__u32	sc_di;
> > +	__u32	clk;
> > +	__u32	reserved[5];
> 
> You need to verify that reserved[] is all set to 0, otherwise people
> will put crud in there and you can never use it for anything in the
> future.

Should I just verify or force it to 0?

Regards

Ludovic

> 
> thanks,
> 
> greg k-h
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
