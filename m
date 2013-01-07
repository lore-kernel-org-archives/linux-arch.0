From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 25/31] ARC: [plat-arcfpga] Hooking up platform to ARC UART
Date: Mon, 07 Jan 2013 14:36:47 +0000
Message-ID: <2626403.I2tzc2MAVY@wuerfel>
References: <1352281674-2186-1-git-send-email-vgupta@synopsys.com> <201301071346.01620.arnd@arndb.de> <50EAD5F3.7030204@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:55072 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab3AGOhK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jan 2013 09:37:10 -0500
In-Reply-To: <50EAD5F3.7030204@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-serial@vger.kernel.org
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 07 January 2013 19:34:35 Vineet Gupta wrote:
> On Monday 07 January 2013 07:16 PM, Arnd Bergmann wrote:

> >> static struct of_dev_auxdata arcuart_auxdata_lookup[] __initdata = {
> >> 	OF_DEV_AUXDATA("snps,arc-uart", UART0_BASE, "arc-uart", arc_uart_info),
> >> 	{}
> >> };
> > It should be enough to fill the drv->of_match_table member of the
> > platform_driver with the match table.
> 
> Not sure if I understand. My concern is the #define UART0_BASE (=0xc0fc1000) which
> needs to be defined in code despite that value being present in the device tree.
> And this is needed so that framework could match the device against the driver. I
> would have thought that some device property (in device tree) could enable the
> matching with Linux name (actually DRIVER_NAME defined in the uart driver).  Am I
> missing something ?

I mean you should not need the auxdata entry if the driver does everything
right, and you get rid of the platform_data.

> >> (3) After above, driver's probe routine is getting called with platform_device->id
> >> = -1 and it seems of_device_add() is doing that purposely. How do I handle that.
> > What do you need the id for?
> 
> In case of multiple instances of UART, driver uses this value to index into struct
> arc_uart_port [ ]
> 
> struct arc_uart_port {
>     struct uart_port port;
>     unsigned long baud;
>     int is_emulated;
> };
> 
> static struct arc_uart_port arc_uart_ports[CONFIG_SERIAL_ARC_NR_PORTS];
> 
> arc_serial_probe(struct platform_device *pdev)
>     uart = &arc_uart_ports[pdev->id];
>     arc_uart_init_one(pdev, ..)
>           if (pdev->id < 0 ...)
>                   return -ENOENT;
>  
> Although the current driver is flawed in that it checks for -ve value after
> already indexing into the array :-(
> I'll send a patch to serial list to fix that.

(adding linux-serial to Cc)

Generally speaking, drivers should not have static or fixed-size arrays of
devices in them. What you should do instead is to allocate the arc_uart_port
at from arc_serial_probe() and remove all the references to the global
array. I'm not completely sure if that's possible with the uart_port yet,
maybe someone else can comment on that.

For the id value, have a look at the drivers/tty/serial/mxs-auart.c and how
it gets the id from the /aliases node in the device tree using
of_alias_get_id().

	Arnd
