From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v11 19/19] h8300: devicetree source
Date: Fri, 8 May 2015 17:50:00 +0100
Message-ID: <20150508165000.GB11680@leverpostej>
References: <1431097479-21101-1-git-send-email-ysato@users.sourceforge.jp>
 <1431097479-21101-20-git-send-email-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431097479-21101-20-git-send-email-ysato@users.sourceforge.jp>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi,

> +++ b/Documentation/devicetree/bindings/h8300/cpu.txt
> @@ -0,0 +1,17 @@
> +* H8/300 CPU bindings
> +
> +Required properties:
> +
> +- compatible: Compatible property value should be "renesas,h8300".
> +- reg: Contains CPU index.

What does the "CPU index" correspond to physically on the CPU?

Can h8300 support SMP?

> +- clock-frequency: Contains the clock frequency for CPU, in Hz.

Is this strictly necessary?

> +- renesas,bus-width: Contain the memory bus width.

What's this needed for?

[...]

> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,h8300h-intc.txt
> @@ -0,0 +1,20 @@
> +* H8/300H Interrupt controller
> +
> +Required properties:
> +
> +- compatible: has to be "renesas,h8300h-intc", "renesas,h8300-intc" as fallback.
> +- #interrupt-cells: has to be <1>: an interrupt index and flags, as defined in
> +  interrupts.txt in this directory

Surely you need two cells to encode index and flags?

> +
> +Optional properties:
> +
> +- any properties, listed in interrupts.txt, and any standard resource allocation
> +  properties
> +
> +Example:
> +
> +	h8intc: intc@0 {

Nit: call this "interrupt-controller" rather than "ntc".

Without a reg you shouldn't have a unit-address (the '@0' part).

How does the CPU communicate with this controller? I assume it's not
MMIO.

These comments also apply to "renesas,h8s-intc".

> diff --git a/arch/h8300/boot/dts/edosk2674.dts b/arch/h8300/boot/dts/edosk2674.dts
> new file mode 100644
> index 0000000..60e73b9
> --- /dev/null
> +++ b/arch/h8300/boot/dts/edosk2674.dts
> @@ -0,0 +1,109 @@
> +#include <dt-bindings/clock/renesas,8bit-timer.h>
> +
> +/dts-v1/;
> +/ {
> +	compatible = "renesas,edosk2674";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	interrupt-parent = <&h8intc>;
> +
> +	chosen {
> +		bootargs = "console=ttySC2,38400";
> +	};

It would be great if you could use stdout-path from the start rather
than passing console= in bootargs. That makes things far less fragile
w.r.t. physical vs logical naming, and keeps console and earlycon in
sync.

It also means that a user can replace bootargs and still expect the
console to work by default (unless overridden explicitly).

> +	aliases {
> +		serial0 = &sci0;
> +		serial1 = &sci1;
> +		serial2 = &sci2;
> +	};
> +
> +	clocks {
> +		ranges;
> +		#address-cells = <1>;
> +		#size-cells = <1>;

Please get rid of the clocks container node and place the clocks
directly under the root node. There's nothing magic about a /clocks
node, and it's not been listed as a bus of any sort.

> +		pllclk: pllclk {
> +			compatible = "renesas,h8s2678-pll-clock";
> +			clocks = <&xclk>;
> +			#clock-cells = <0>;
> +			reg = <0xfee03b 2>, <0xfee045 2>;
> +		};
> +		cclk: cclk {
> +			compatible = "renesas,h8300-div-clock";
> +			clocks = <&pllclk>;
> +			#clock-cells = <0>;
> +			reg = <0xfee03b 2>;
> +			renesas,width = <3>;
> +		};

Are there existing bindings for these? I didn't see any as part of the
portion of the series I was Cc'd for.

> +	memory@0 {

Nit: the unit-address should math the address in the reg entry (here it
should be 400000 rather than 0).

[...]

> +	chosen {
> +		bootargs = "earlyprintk=h8300-sim console=ttySC0";
> +	};

If you implement earlycon you'd only need a single stdout-path entry
here, which would make this much nicer.

Thanks,
Mark.
