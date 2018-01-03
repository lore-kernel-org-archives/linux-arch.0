Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750819AbeACTO5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Jan 2018 14:14:57 -0500
MIME-Version: 1.0
In-Reply-To: <7fe1190a9cf8e30f1b8af52dd382ba1176997786.1514874857.git.green.hu@gmail.com>
References: <cover.1514874857.git.green.hu@gmail.com> <7fe1190a9cf8e30f1b8af52dd382ba1176997786.1514874857.git.green.hu@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 3 Jan 2018 13:14:35 -0600
Message-ID: <CAL_Jsq+CC-3w8BVcUP77__ZR8aYMhxiXDYJ--HZwA=ezHG548g@mail.gmail.com>
Subject: Re: [PATCH v5 26/39] nds32: Device tree support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, netdev <netdev@vger.kernel.org>, deanbo422@gmail.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, ren_guo@c-sky.com, Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, Vincent Chen <vincentc@andestech.com>
Message-ID: <20180103191435.fVoWEBqxvrVk2Jvv2Pr2usg7q7SDdUs_4dNsBgneu6U@z>

On Tue, Jan 2, 2018 at 2:24 AM, Greentime Hu <green.hu@gmail.com> wrote:
> From: Greentime Hu <greentime@andestech.com>
>
> This patch adds support for device tree.
>
> Signed-off-by: Vincent Chen <vincentc@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>
> ---
>  arch/nds32/boot/dts/Makefile  |    8 +++++
>  arch/nds32/boot/dts/ae3xx.dts |   73 +++++++++++++++++++++++++++++++++++++++++
>  arch/nds32/kernel/devtree.c   |   19 +++++++++++
>  3 files changed, 100 insertions(+)
>  create mode 100644 arch/nds32/boot/dts/Makefile
>  create mode 100644 arch/nds32/boot/dts/ae3xx.dts
>  create mode 100644 arch/nds32/kernel/devtree.c
>
> diff --git a/arch/nds32/boot/dts/Makefile b/arch/nds32/boot/dts/Makefile
> new file mode 100644
> index 0000000..d31faa8
> --- /dev/null
> +++ b/arch/nds32/boot/dts/Makefile
> @@ -0,0 +1,8 @@
> +ifneq '$(CONFIG_NDS32_BUILTIN_DTB)' '""'
> +BUILTIN_DTB := $(patsubst "%",%,$(CONFIG_NDS32_BUILTIN_DTB)).dtb.o
> +else
> +BUILTIN_DTB :=
> +endif
> +obj-$(CONFIG_OF) += $(BUILTIN_DTB)
> +
> +clean-files := *.dtb *.dtb.S
> diff --git a/arch/nds32/boot/dts/ae3xx.dts b/arch/nds32/boot/dts/ae3xx.dts
> new file mode 100644
> index 0000000..6b23d60
> --- /dev/null
> +++ b/arch/nds32/boot/dts/ae3xx.dts
> @@ -0,0 +1,73 @@
> +/dts-v1/;
> +/ {
> +       compatible = "andestech,ae3xx";
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +       interrupt-parent = <&intc>;
> +
> +       chosen {
> +               stdout-path = &serial0;
> +       };
> +
> +       memory@0 {
> +               device_type = "memory";
> +               reg = <0x00000000 0x40000000>;
> +       };
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               cpu@0 {
> +                       device_type = "cpu";
> +                       compatible = "andestech,n13", "andestech,nds32v3";
> +                       reg = <0>;
> +                       clock-frequency = <60000000>;
> +                       next-level-cache = <&L2>;
> +               };
> +       };
> +
> +       L2: l2-cache@e0500000 {
> +               compatible = "andestech,atl2c";
> +               reg = <0xe0500000 0x1000>;
> +               cache-unified;
> +               cache-level = <2>;
> +       };
> +
> +       apb: clk@0 {

unit address without reg is not valid. Drop the "@0".

> +               #clock-cells = <0>;
> +               compatible = "fixed-clock";
> +               clock-frequency = <30000000>;
> +       };
> +
> +
> +       intc: interrupt-controller {
> +               compatible = "andestech,ativic32";
> +               #interrupt-cells = <1>;
> +               interrupt-controller;
> +       };
> +
> +       serial0: serial@f0300000 {

All the memory mapped peripherals should be under at least one simple-bus node.

> +               compatible = "andestech,uart16550", "ns16550a";
> +               reg = <0xf0300000 0x1000>;
> +               interrupts = <8>;
> +               clock-frequency = <14745600>;
> +               reg-shift = <2>;
> +               reg-offset = <32>;
> +               no-loopback-test = <1>;
> +       };
> +
> +       timer0: timer@f0400000 {
> +               compatible = "andestech,atcpit100";
> +               reg = <0xf0400000 0x1000>;
> +               interrupts = <2>;
> +               clocks = <&apb>;
> +               clock-names = "PCLK";
> +       };
> +
> +       mac0: mac@e0100000 {

ethernet@...

> +               compatible = "andestech,atmac100";
> +               reg = <0xe0100000 0x1000>;
> +               interrupts = <18>;
> +       };
> +
> +};
> diff --git a/arch/nds32/kernel/devtree.c b/arch/nds32/kernel/devtree.c
> new file mode 100644
> index 0000000..bdce0fe
> --- /dev/null
> +++ b/arch/nds32/kernel/devtree.c
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2005-2017 Andes Technology Corporation
> +
> +#include <linux/bug.h>
> +#include <linux/printk.h>
> +#include <linux/of_fdt.h>
> +
> +void __init early_init_devtree(void *params)
> +{
> +       if (!params || !early_init_dt_scan(params)) {
> +               pr_crit("\n"
> +                       "Error: invalid device tree blob at (virtual address 0x%p)\n"
> +                       "\nPlease check your bootloader.", params);
> +
> +               BUG_ON(1);
> +       }
> +
> +       dump_stack_set_arch_desc("%s (DT)", of_flat_dt_get_machine_name());
> +}
> --
> 1.7.9.5
>
