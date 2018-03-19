From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 16/19] csky: Device tree
Date: Mon, 19 Mar 2018 23:28:03 +0800
Message-ID: <CAK8P3a3uoiXRk0azD=LU033M3-FGr8e=HgUErDXuVMwvLWa6Gw@mail.gmail.com>
References: <cover.1521399976.git.ren_guo@c-sky.com> <b86f173b8333cb6cc1c7e32ec2ab1e38fae4ecf8.1521399976.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b86f173b8333cb6cc1c7e32ec2ab1e38fae4ecf8.1521399976.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

On Mon, Mar 19, 2018 at 3:51 AM, Guo Ren <ren_guo@c-sky.com> wrote:
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>

Please add a changelog text to each patch, and send patches that add
.dts files or
binding documents to the devicetree mailing list.

> ---
>  arch/csky/boot/dts/gx6605s.dts         | 159 +++++++++++++++++++++++++++++++++
>  arch/csky/boot/dts/include/dt-bindings |   1 +
>  arch/csky/boot/dts/qemu.dts            |  87 ++++++++++++++++++
>  3 files changed, 247 insertions(+)
>  create mode 100644 arch/csky/boot/dts/gx6605s.dts
>  create mode 120000 arch/csky/boot/dts/include/dt-bindings
>  create mode 100644 arch/csky/boot/dts/qemu.dts
>
> diff --git a/arch/csky/boot/dts/gx6605s.dts b/arch/csky/boot/dts/gx6605s.dts
> new file mode 100644
> index 0000000..0d34d22
> --- /dev/null
> +++ b/arch/csky/boot/dts/gx6605s.dts
> @@ -0,0 +1,159 @@
> +/dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>

It is usually better for an SoC based board to split the SoC specific into a
separate .dtsi file that gets included by the board .dts file.

> +/ {
> +       model = "Nationalchip gx6605s ck610";
> +       compatible = "nationalchip,gx6605s,ck610";

Is ck610 the name of the CPU core? The general convention is to have the
top-level "compatible" property list first the name of the board, then the
name of the soc, but not the name of the CPU core.

> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +
> +       memory {
> +               device_type = "memory";
> +               reg = <0x10000000 0x04000000>;
> +       };
> +
> +       cpus {
> +               #address-cells = <0>;
> +               #size-cells = <0>;
> +
> +               cpu {
> +                       device_type = "cpu";
> +                       ccr     = <0x7d>;
> +                       hint    = <0x1c>;

Here you should list the specific type of CPU in the compatible property and
document the binding for that string in the Documentations/devicetree/bindings
hierarchy. Without a binding, the 'ccr' and 'hint' properties make no sense.

If there is any chance that you could have SMP systems in the future, it
would be better to start with #address-cells=<1>, with appropriate reg
properties.

> +       soc {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "simple-bus";
> +               ranges;
> +
> +               intc: interrupt-controller {
> +                       compatible = "nationalchip,intc-v1,ave";
> +                       reg = <0x00500000 0x400>;

Each node with a register property also needs the address in the
node name, e.g. "interrupt-controller@500000"

Try building the dtb file with 'make W=1' to get warnings about
when you got that wrong.

> +                       interrupt-controller;
> +                       #interrupt-cells = <1>;
> +               };
> +
> +               timer0 {
> +                       compatible = "nationalchip,timer-v1";

This should be "timer@400"

Also, each device node should have a binding documentation
to explain the binding associated with that "compatible"
string.

> +                       reg = <0x0020a000 0x400>;
> +                       clock-frequency = <1000000>;
> +                       interrupts = <10>;
> +                       interrupt-parent = <&intc>;
> +               };
> +
> +               ehci: ehci-hcd {
> +                       compatible = "generic-ehci";
> +                       reg = <0x00900000 0x400>;
> +                       interrupt-parent = <&intc>;
> +                       interrupts = <59>;
> +               };
> +
> +               ohci0: ohci-hcd0 {


The names here should be "usb@...", not "ehci-hcd"

> +       chosen {
> +               bootargs = "console=ttyS0,115200 rdinit=/sbin/init root=/dev/ram0";
> +       };

The bootargs should not be in the dts file normally, they should come from the
boot loader. For the console, use the "stdout-path" property.

         Arnd
