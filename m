From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 26/39] nds32: Device tree support
Date: Wed, 3 Jan 2018 13:14:35 -0600
Message-ID: <CAL_Jsq+CC-3w8BVcUP77__ZR8aYMhxiXDYJ--HZwA=ezHG548g@mail.gmail.com>
References: <cover.1514874857.git.green.hu@gmail.com> <7fe1190a9cf8e30f1b8af52dd382ba1176997786.1514874857.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7fe1190a9cf8e30f1b8af52dd382ba1176997786.1514874857.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, netdev <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, ren_guo-Y+KPrCd2zL4AvxtiuMwx3w@public.gmane.org, Randy
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 2, 2018 at 2:24 AM, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
>
> This patch adds support for device tree.
>
> Signed-off-by: Vincent Chen <vincentc-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
> Signed-off-by: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
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
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
