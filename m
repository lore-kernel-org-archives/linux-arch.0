From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 21/24] C6X: specific SoC support
Date: Tue, 23 Aug 2011 00:21:54 +0200
Message-ID: <2642192.V7A2ih9bgf@wuerfel>
References: <1314043785-2880-1-git-send-email-msalter@redhat.com> <1314043785-2880-22-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:58863 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898Ab1HVWWb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Aug 2011 18:22:31 -0400
In-Reply-To: <1314043785-2880-22-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>

On Monday 22 August 2011 16:09:42 Mark Salter wrote:
> This patch provides the code for the four currently supported SoCs. Each SoC
> provides a struct soc_ops which contains hooks for miscellaneous functionality
> which does not fit well in any drivers. At setup_arch time, the device tree is
> probed to find the correct soc_ops struct to use.
> 
> Most SoCs provide one or more sets of MMIO registers for various SoC-specific
> low-level device setup and control. the device tree is parsed at setup_arch
> time to find the base address of these registers.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>

This patch (together with "C6X: general SoC support") is now the only remaining
issue that I'm a bit worried about. You made great progress on removing the
board specific files, but I think that a lot of the SoC specific code should
also be done differently. Reading through it in detail, my impression was that
it would be helpful to separate the 'dscr' driver from overall SoC code,
splitting the current soc_ops into a smaller soc_ops and a separate dscr_ops
structure. The reason for this is both because they are logically separate
things to abstract, and to allow having multiple soc designs share a common
dscr driver accounting for minor differences based on the compatible
property of the dscr node.

> +static struct clk_lookup c6455_clks[] = {
> +	CLK(NULL, "pll1", &c6x_soc_pll1.sysclks[0]),
> +	CLK(NULL, "pll1_sysclk2", &c6x_soc_pll1.sysclks[2]),
> +	CLK(NULL, "pll1_sysclk3", &c6x_soc_pll1.sysclks[3]),
> +	CLK(NULL, "pll1_sysclk4", &c6x_soc_pll1.sysclks[4]),
> +	CLK(NULL, "pll1_sysclk5", &c6x_soc_pll1.sysclks[5]),
> +	CLK(NULL, "core", &c6x_core_clk),
> +	CLK("i2c_davinci.1", NULL, &c6x_i2c_clk),
> +	CLK("watchdog", NULL, &c6x_watchdog_clk),
> +	CLK("2c81800.mdio", NULL, &c6x_mdio_clk),
> +	CLK("", NULL, NULL)
> +};

I haven't paid much attention to the clock rework in the ARM architecture,
but the impression that I got was these tables are only needed for
legacy drivers and that you shouldn't require them with device-tree
aware drivers and platforms. Maybe Grant can provide more insight.

> +/* device IDs passed to dscr_enable() and dscr_disable() */
> +#define DSCR_TCP	0
> +#define DSCR_VCP	1
> +#define DSCR_EMAC	2
> +#define DSCR_TIMER0	3
> +#define DSCR_TIMER1	4
> +#define DSCR_GPIO	5
> +#define DSCR_I2C	6
> +#define DSCR_BSP0	7
> +#define DSCR_BSP1	8
> +#define DSCR_HPI	9
> +#define DSCR_PCI	10
> +#define DSCR_UTOPIA	11
> +#define DSCR_SRIO	15
> +#define DSCR_EMIFA	16
> +#define DSCR_DDR2	17

Where do these numbers come from? I can't see if they are hardware
properties or completely arbitrary. If they are part of the hardware
design, it's probably a good idea to put them into some property
of the device tree, e.g. 'ti-c6x,dscr-id', and change the driver
interface to pass the 'struct device' directly, with the core code
looking at the contents of the property.

You could either have a table in the dscr node pointing to the
phandles of all devices controlled like this with the number used
as an index, or have one number in a property per device.

> +static void __init __setup_dscr(void)
> +{
> +	struct device_node *node;
> +
> +	node = of_find_compatible_node(NULL, NULL, "ti,tms320c6455-dscr");
> +	if (!node)
> +		return;
> +
> +	dscr_base = of_iomap(node, 0);
> +	of_node_put(node);
> +	if (!dscr_base)
> +		return;
> +
> +	node = of_find_node_by_type(NULL, "soc");
> +	if (node) {
> +		chip_base = of_iomap(node, 0);
> +		of_node_put(node);
> +
> +		pr_info("DEVSTAT=%08x  PERCFG0=%08x PERCFG1=%08x\n",
> +			 chip_read(CHIP_DEVSTAT), dscr_read(DSCR_PERCFG0),
> +			 dscr_read(DSCR_PERCFG1));
> +	}
> +
> +	SOC_DEVCONFIG_SUPPORT(TCP, DSCR_TCP);
> +	SOC_DEVCONFIG_SUPPORT(VCP, DSCR_VCP);
> +	SOC_DEVCONFIG_SUPPORT(EMAC, DSCR_EMAC);
> +	SOC_DEVCONFIG_SUPPORT(TIMER, DSCR_TIMER0);
> +	SOC_DEVCONFIG_SUPPORT(GPIO, DSCR_GPIO);
> +	SOC_DEVCONFIG_SUPPORT(I2C, DSCR_I2C);
> +	SOC_DEVCONFIG_SUPPORT(MCBSP, DSCR_BSP0);
> +	SOC_DEVCONFIG_SUPPORT(HPI, DSCR_HPI);
> +	SOC_DEVCONFIG_SUPPORT(PCI, DSCR_PCI);
> +	SOC_DEVCONFIG_SUPPORT(UTOPIA, DSCR_UTOPIA);
> +	SOC_DEVCONFIG_SUPPORT(SRIO, DSCR_SRIO);
> +	SOC_DEVCONFIG_SUPPORT(EMIF, DSCR_EMIFA);
> +	SOC_DEVCONFIG_SUPPORT(DDR2, DSCR_DDR2);
> +
> +	c6455_dev_enable(SOC_DEV_TIMER, 0);
> +	c6455_dev_enable(SOC_DEV_TIMER, 1);
> +
> +#ifdef CONFIG_I2C
> +	c6455_dev_enable(SOC_DEV_I2C, 0);
> +#endif
> +#ifdef CONFIG_GENERIC_GPIO
> +	c6455_dev_enable(SOC_DEV_GPIO, 0);
> +#endif
> +#ifdef CONFIG_TMS320C64X_GEMAC
> +	c6455_dev_enable(SOC_DEV_EMAC, 0);
> +#endif
> +}

I believe you can even make this a generic dscr driver. For the most part,
the setup seems to be very similar across the four socs. The main difference
that I see is in the devices that you enable, and that can come from the
device tree, or be controlled by the device drivers calling a common function.

The #ifdef here seems completely misplaced however. Whether a device is
enabled or not should not depend on whether a driver is enabled or not.
There is also a small bug, since you do not check whether the drivers are
built as modules.

The 'node = of_find_node_by_type(NULL, "soc");' is bad style because you are
looking for a device_type, which you shouldn't do outside of the actual
Open Firmware client interface (that you don't have) and you match to a
very generic identifier ("soc"). It would be much better to match the
"compatible" value of the soc node, or perhaps to move the registers
into the dscr node and iomap both register sets from the same node
(slightly inaccurate though more readable).

> +static unsigned int c6455_silicon_rev(char **strp)
> +{
> +	u32 jtagid = chip_read(CHIP_JTAGID);
> +	u32 silicon_rev = (jtagid >> 28) & 0xf;
> +
> +	if (strp) {
> +		switch (silicon_rev) {
> +		case 0:
> +			*strp = "1.1";
> +			break;
> +		case 1:
> +			*strp = "2.0";
> +			break;
> +		case 2:
> +			*strp = "2.1";
> +			break;
> +		case 4:
> +			*strp = "3.1";
> +			break;
> +		default:
> +			*strp = "unknown";
> +			break;
> +		}
> +	}
> +	return silicon_rev;
> +}

Is this only informational? Is it actually worth having?

Maybe you can simply return the number instead of an ascii interpretation,
or you move this to the __setup_dscr function, which is an initcall, and
just remember the string.

> +static void __init c6455_setup_arch(void)
> +{
> +	/* so we won't get called twice */
> +	soc_ops.setup_arch = NULL;
> +
> +	c6x_num_cores = 1;
> +	__setup_dscr();
> +	__setup_clocks();
> +}
> +
> +define_soc(tms320c6455) {
> +	.compat		= "ti,tms320c6455",
> +	.name		= "TMS320C6455",

The "name" field seems unnecessary here, when you can simply print
the actual "compatible" string of the present device.

> +	.setup_arch	= c6455_setup_arch,
> +	.silicon_rev	= c6455_silicon_rev,
> +	.init_IRQ	= megamod_pic_init,
> +	.time_init	= timer64_init,

The time_init and init_IRQ callbacks are the same for all socs,
so I suppose they could be hardcoded for now, instead of having
indirect calls. 

	Arnd
