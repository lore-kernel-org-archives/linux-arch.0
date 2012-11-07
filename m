Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:63194 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab2KGOQK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Nov 2012 09:16:10 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 25/31] ARC: [plat-arcfpga] Hooking up platform to ARC UART
Date: Wed, 7 Nov 2012 14:16:07 +0000
References: <1352281674-2186-1-git-send-email-vgupta@synopsys.com> <1352281674-2186-26-git-send-email-vgupta@synopsys.com>
In-Reply-To: <1352281674-2186-26-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-ID: <201211071416.08012.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
Message-ID: <20121107141607.RlE0-V_ere82NFiJO4EAaJoJ8NzRyJ0cdC3LbIBkdns@z>

On Wednesday 07 November 2012, Vineet Gupta wrote:
> +static struct platform_device arc_uart##n##_dev = {    \
> +       .name = "arc-uart",                             \
> +       .id = n,                                        \
> +       .num_resources = ARRAY_SIZE(arc_uart##n##_res), \
> +       .resource = arc_uart##n##_res,                  \
> +       .dev = {                                        \
> +               .platform_data = &arc_uart_info,        \
> +       },                                              \
> +}
> +
> +ARC_UART_DEV(0);
> +#if CONFIG_SERIAL_ARC_NR_PORTS > 1
> +ARC_UART_DEV(1);
> +#endif
> +
> +static struct platform_device *fpga_early_devs[] __initdata = {
> +#if defined(CONFIG_SERIAL_ARC_CONSOLE)
> +       &arc_uart0_dev,
> +#endif
> +};

statically defining platform devices like this is considered very
bad style, especially since it prevents you from doing proper
boot-time configuration. Please get the available devices from
the boot loader. Normally this is done using a flattened device
tree blob that gets passed, unless you can probe the hardware
directly.

	Arnd
