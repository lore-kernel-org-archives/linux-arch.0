From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2 43/44] tty/metag_da: Add metag DA TTY driver
Date: Mon, 7 Jan 2013 11:54:25 +0000
Message-ID: <20130107115425.7a1c9176@pyramind.ukuu.org.uk>
References: <1354723742-6195-1-git-send-email-james.hogan@imgtec.com>
	<1354723742-6195-44-git-send-email-james.hogan@imgtec.com>
	<20121205172446.41aa464e@pyramind.ukuu.org.uk>
	<50E6E322.8070108@imgtec.com>
	<20130104170013.74b6dbe2@pyramind.ukuu.org.uk>
	<50EAB1C1.9050808@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:40205 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753744Ab3AGLrl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jan 2013 06:47:41 -0500
In-Reply-To: <50EAB1C1.9050808@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

> Yes. The case I tried was a large write (strace cat /etc/somefile >
> /dev/ttyDA2) and strace showed a single large write, but it got to the
> driver in chunks of a dozen or so characters. Is that expected to happen?

Yes it is - the tty mid layer code could do better on this but it's never
been much of a priority.

> @@ -613,8 +613,7 @@ static int __init dashtty_init(void)
>  	channel_driver->type = TTY_DRIVER_TYPE_SERIAL;
>  	channel_driver->subtype = SERIAL_TYPE_NORMAL;
>  	channel_driver->init_termios = tty_std_termios;
> -	channel_driver->init_termios.c_cflag =
> -	    B38400 | CS8 | CREAD | HUPCL | CLOCAL;
> +	channel_driver->init_termios.c_cflag |= CLOCAL;
>  	channel_driver->flags = TTY_DRIVER_REAL_RAW;
> 
>  	tty_set_operations(channel_driver, &dashtty_ops);


Ok
