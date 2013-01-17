From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC PATCH v1 25/31] ARC: [plat-arcfpga] Hooking up platform
 to ARC UART
Date: Thu, 17 Jan 2013 12:59:38 +0530
Message-ID: <50F7A862.4050006@synopsys.com>
References: <1352281674-2186-1-git-send-email-vgupta@synopsys.com> <1352281674-2186-26-git-send-email-vgupta@synopsys.com> <201211071416.08012.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us02smtp2.synopsys.com ([198.182.60.77]:42453 "EHLO
	alvesta.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466Ab3AQH3z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Jan 2013 02:29:55 -0500
In-Reply-To: <201211071416.08012.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 07 November 2012 07:46 PM, Arnd Bergmann wrote:
> On Wednesday 07 November 2012, Vineet Gupta wrote:
>> +static struct platform_device arc_uart##n##_dev = {    \
>> +       .name = "arc-uart",                             \
>> +       .id = n,                                        \
>> +       .num_resources = ARRAY_SIZE(arc_uart##n##_res), \
>> +       .resource = arc_uart##n##_res,                  \
>> +       .dev = {                                        \
>> +               .platform_data = &arc_uart_info,        \
>> +       },                                              \
>> +}
>> +
>> +ARC_UART_DEV(0);
>> +#if CONFIG_SERIAL_ARC_NR_PORTS > 1
>> +ARC_UART_DEV(1);
>> +#endif
>> +
>> +static struct platform_device *fpga_early_devs[] __initdata = {
>> +#if defined(CONFIG_SERIAL_ARC_CONSOLE)
>> +       &arc_uart0_dev,
>> +#endif
>> +};
> 
> statically defining platform devices like this is considered very
> bad style, especially since it prevents you from doing proper
> boot-time configuration. Please get the available devices from
> the boot loader. Normally this is done using a flattened device
> tree blob that gets passed, unless you can probe the hardware
> directly.
> 
> 	Arnd
> 

So my strategy for v2 series (based off 3.8-rcx) is to introduce devicetree,
multi-platform-image support (and other key fixes such as syscall restart issues)
as slap-on patches on top of old code. This is not to avoid any chop-n-dice of
fixing patches (I've done that in plenty between v1 and v2). Its just that, in
absence of revision history for ARC port (in upstream later on) - it helps capture
the evolution of some key features and also for the community it serves as a live
documentation of bad designs and how they can be fixed.

Is that a reasonable approach for new port which is non-bisectable anyways ?

Thx,
-Vineet
