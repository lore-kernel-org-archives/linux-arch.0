From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH 16/19] csky: Device tree
Date: Tue, 20 Mar 2018 21:55:25 +0800
Message-ID: <20180320135524.GA12296@guoren>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <b86f173b8333cb6cc1c7e32ec2ab1e38fae4ecf8.1521399976.git.ren_guo@c-sky.com>
 <CAK8P3a3uoiXRk0azD=LU033M3-FGr8e=HgUErDXuVMwvLWa6Gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a3uoiXRk0azD=LU033M3-FGr8e=HgUErDXuVMwvLWa6Gw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

Hi Arnd,

On Mon, Mar 19, 2018 at 11:28:03PM +0800, Arnd Bergmann wrote:
> Please add a changelog text to each patch, and send patches that add
> .dts files or
> binding documents to the devicetree mailing list.
Ok

> It is usually better for an SoC based board to split the SoC specific into a
> separate .dtsi file that gets included by the board .dts file.
Ok

> > +/ {
> > +       model = "Nationalchip gx6605s ck610";
> > +       compatible = "nationalchip,gx6605s,ck610";
> 
> Is ck610 the name of the CPU core? The general convention is to have the
> top-level "compatible" property list first the name of the board, then the
> name of the soc, but not the name of the CPU core.
Yes, ck610 is a cpu core of abiv1. and I will change it like this:
	model = "Zhuxian-sword gx6605s Development Board";
	compatible = "zhuxian-sword,gx6605s";
ref: https://c-sky.github.io/docs/gx6605s.html

> Here you should list the specific type of CPU in the compatible property and
> document the binding for that string in the Documentations/devicetree/bindings
> hierarchy. Without a binding, the 'ccr' and 'hint' properties make no sense.
Sorry, I forget remove the cpu region. It's no use now.

> If there is any chance that you could have SMP systems in the future, it
> would be better to start with #address-cells=<1>, with appropriate reg
> properties.
Ok

> Each node with a register property also needs the address in the
> node name, e.g. "interrupt-controller@500000"
Ok

> Try building the dtb file with 'make W=1' to get warnings about
> when you got that wrong.
Thx

> > +               timer0 {
> > +                       compatible = "nationalchip,timer-v1";
> 
> This should be "timer@400"
Ok

> Also, each device node should have a binding documentation
> to explain the binding associated with that "compatible"
> string.
Ok, I will add them.

> > +               ohci0: ohci-hcd0 {
> The names here should be "usb@...", not "ehci-hcd"
Ok

> > +       chosen {
> > +               bootargs = "console=ttyS0,115200 rdinit=/sbin/init root=/dev/ram0";
> > +       };
> 
> The bootargs should not be in the dts file normally, they should come from the
> boot loader.
I want to keep bootargs in dts, because the bootloader only pass the dtb to kernel. 

> For the console, use the "stdout-path" property.
Ok

Best Regards
  Guo Ren
