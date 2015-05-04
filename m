From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v10 19/19] h8300: devicetree source
Date: Mon, 04 May 2015 17:09:21 +0200
Message-ID: <2656548.FgCj9p2Jp9@wuerfel>
References: <1430736122-20929-2-git-send-email-ysato@users.sourceforge.jp> <1430736122-20929-21-git-send-email-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:62418 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948AbbEDPJ2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 May 2015 11:09:28 -0400
In-Reply-To: <1430736122-20929-21-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org

On Monday 04 May 2015 19:42:02 Yoshinori Sato wrote:
> +
> +	h8intc: intc@0 {
> +		compatible = "renesas,h8s-intc", "renesas,h8300-intc";
> +		#interrupt-cells = <1>;
> +		interrupt-controller;
> +	};

The node name should be "interrupt-controller@0", not "intc@0", to follow
the common conventions.

> +	tpu: tpu@ffffe0 {
> +		compatible = "renesas,tpu";
> +		reg = <0xffffe0 16>, <0xfffff0 12>;
> +		clocks = <&pclk>;
> +		clock-names = "peripheral_clk";
> +	};
> +
> +	timer8: timer@ffffb0 {
> +		compatible = "renesas,8bit-timer";
> +		reg = <0xffff80 10>;
> +		interrupts = <72 75>;
> +		clocks = <&pclk>;
> +		clock-names = "peripheral_clk";
> +		renesas,mode = <CLOCKEVENTDEVICE>;
> +		renesas,div = <DIV_8>;
> +	};
> +

The renesas,div property seems odd here. How about defining a
"clock-frequency" property and figuring out the divider from
the parent clock in the driver?

Your new binding makes it mandatory to have a "fclk" clock, which
seems better suited than "peripheral_clk", so I'd suggest you
change the code to match the documentation (rather than the other
way round). Alternatively, you could make this an anonymous
clock and not specify the name at all.

The renesas,mode property seems odd. Why is that needed? It sounds
like you are encoding how you expect the device to be used by
Linux, rather than what it can do in hardware. If you have multiple
variants of the 8bit-timer hardware that have different features,
better use separate compatible strings for them, or a boolean
flag that announces the presence or absence of a feature.

If however, this is just a hint for Linux, maybe you can find a way
for the driver to take a guess itself, e.g. using the first
device it finds as a clockevent device, and only use a clocksource
device if there is more than one?

> +	sci0: serial@ffff78 {
> +		compatible = "renesas,sci";
> +		reg = <0xffff78 8>;
> +		interrupts = <88 89 90 91>;
> +		clocks = <&pclk>;
> +		clock-names = "peripheral_clk";
> +	};
> +	sci1: serial@ffff80 {
> +		compatible = "renesas,sci";
> +		reg = <0xffff80 8>;
> +		interrupts = <92 93 94 95>;
> +		clocks = <&pclk>;
> +		clock-names = "peripheral_clk";
> +	};
> +	sci2: serial@ffff88 {
> +		compatible = "renesas,sci";
> +		reg = <0xffff88 8>;
> +		interrupts = <96 97 98 99>;
> +		clocks = <&pclk>;
> +		clock-names = "peripheral_clk";
> +	};
> +};

The binding for sci requires the clock to be named "sci_ick",  so please
use that instead of "peripheral_clk". The driver can handle both.

	Arnd
