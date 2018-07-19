Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225]:57498 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbeGSLuM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Jul 2018 07:50:12 -0400
Date: Thu, 19 Jul 2018 12:07:05 +0100
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/3] tty/serial_core: add ISO7816 infrastructure
Message-ID: <20180719120705.4a2fde04@alans-desktop>
In-Reply-To: <20180713080129.2ifw7crjksvaxxpq@M43218.corp.atmel.com>
References: <20180711131638.12622-1-ludovic.desroches@microchip.com>
        <20180711131638.12622-2-ludovic.desroches@microchip.com>
        <20180712145808.GA22502@kroah.com>
        <20180713080129.2ifw7crjksvaxxpq@M43218.corp.atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jslaby@suse.com, arnd@arndb.de, richard.genoud@gmail.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org
Message-ID: <20180719110705.5X8kYrDK5QuLMqvnWItN_784sH0GxnrUvXh35YhkpbI@z>

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
