From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/3] tty/serial_core: add ISO7816 infrastructure
Date: Thu, 19 Jul 2018 12:07:05 +0100
Message-ID: <20180719120705.4a2fde04@alans-desktop>
References: <20180711131638.12622-1-ludovic.desroches@microchip.com>
 <20180711131638.12622-2-ludovic.desroches@microchip.com>
 <20180712145808.GA22502@kroah.com>
 <20180713080129.2ifw7crjksvaxxpq@M43218.corp.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180713080129.2ifw7crjksvaxxpq@M43218.corp.atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-arch@vger.kernel.org, alexandre.belloni@bootlin.com, arnd@arndb.de, richard.genoud@gmail.com, Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

> >   
> > > +	if (!port->iso7816_config)
> > > +		return -ENOIOCTLCMD;  
> > 
> > Why this error value?
> >   
> 
> It was a mimic of RS485.

Which is what you want - it means the upper tty layer knows to offer the
ioctl to other places and then return appropriately.

Alan
