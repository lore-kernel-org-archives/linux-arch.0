Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33471 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946516AbbHHAoD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Aug 2015 20:44:03 -0400
Received: by pabyb7 with SMTP id yb7so65975777pab.0
        for <linux-arch@vger.kernel.org>; Fri, 07 Aug 2015 17:44:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
From: Michael Turquette <mturquette@linaro.org>
In-Reply-To: <1431325600-12333-18-git-send-email-ysato@users.sourceforge.jp>
References: <1431325600-12333-1-git-send-email-ysato@users.sourceforge.jp>
 <1431325600-12333-18-git-send-email-ysato@users.sourceforge.jp>
Message-ID: <20150808004349.2416.18161@quantum>
Subject: Re: [PATCH v12 17/21] h8300: clock driver
Date: Fri, 07 Aug 2015 17:43:49 -0700
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org
Message-ID: <20150808004349.WBzReMMLhSbNuFEe95VsptRI2MKvU3kb_sOcA2l4yAo@z>

Hello Sato-san,

Unfortunately this patch did not Cc myself, Stephen Boyd or the
linux-clk@vger.kernel.org mailing list. As such Stephen and I did not
have a chance to review it. Even more unfortunate was that it was ninja
merged by maintainers without our ack. :-/

Quoting Yoshinori Sato (2015-05-10 23:26:36)
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  .../bindings/clock/renesas,h8300-div-clock.txt     |  24 ++++
>  .../bindings/clock/renesas,h8s2678-pll-clock.txt   |  23 ++++
>  drivers/clk/Makefile                               |   1 +
>  drivers/clk/h8300/Makefile                         |   2 +
>  drivers/clk/h8300/clk-div.c                        |  53 ++++++++
>  drivers/clk/h8300/clk-h8s2678.c                    | 147 +++++++++++++++++++++
>  6 files changed, 250 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,h8300-div-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,h8s2678-pll-clock.txt
>  create mode 100644 drivers/clk/h8300/Makefile
>  create mode 100644 drivers/clk/h8300/clk-div.c
>  create mode 100644 drivers/clk/h8300/clk-h8s2678.c
> 
> diff --git a/Documentation/devicetree/bindings/clock/renesas,h8300-div-clock.txt b/Documentation/devicetree/bindings/clock/renesas,h8300-div-clock.txt
> new file mode 100644
> index 0000000..36c2b52
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/renesas,h8300-div-clock.txt
> @@ -0,0 +1,24 @@
> +* Renesas H8/300 divider clock
> +
> +Required Properties:
> +
> +  - compatible: Must be "renesas,sh73a0-h8300-div-clock"
> +
> +  - clocks: Reference to the parent clocks ("extal1" and "extal2")
> +
> +  - #clock-cells: Must be 1
> +
> +  - reg: Base address and length of the divide rate selector
> +
> +  - renesas,width: bit width of selector
> +
> +Example
> +-------
> +
> +               cclk: cclk {
> +                       compatible = "renesas,h8300-div-clock";
> +                       clocks = <&xclk>;
> +                       #clock-cells = <0>;
> +                       reg = <0xfee01b 2>;
> +                       renesas,width = <2>;
> +               };

I could not find any info on this clock in the H8S/2678 reference
manual[0]. Could you point me to the right documentation?

> diff --git a/Documentation/devicetree/bindings/clock/renesas,h8s2678-pll-clock.txt b/Documentation/devicetree/bindings/clock/renesas,h8s2678-pll-clock.txt
> new file mode 100644
> index 0000000..500cdadb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/renesas,h8s2678-pll-clock.txt
> @@ -0,0 +1,23 @@
> +Renesas H8S2678 PLL clock
> +
> +This device is Clock multiplyer
> +
> +Required Properties:
> +
> +  - compatible: Must be "renesas,h8s2678-pll-clock"
> +
> +  - clocks: Reference to the parent clocks
> +
> +  - #clock-cells: Must be 0
> +
> +  - reg: Two rate selector (Multiply / Divide) register address
> +
> +Example
> +-------
> +
> +               pllclk: pllclk {
> +                       compatible = "renesas,h8s2678-pll-clock";
> +                       clocks = <&xclk>;
> +                       #clock-cells = <0>;
> +                       reg = <0xfee03b 2>, <0xfee045 2>;
> +               };

Is there really only one clock output? According to figure 21.1 there is
the "System clock to φ pin" output and the "Internal clock to peripheral
modules" output.

I am wondering if clock-cells should be 1 instead of zero and support
both of these output signals?

As a nitpick, I think it would have been better to name the node "cpg"
as it is listed in Section 21. pllclk is only one of the two registers
that make up the cpg. Something like:

	cpg: clock-controller@fee03b

If you do decide to have clock-cells greater than zero, you might find
the following threads helpful. They describe how to craft a
clock-controller style binding:

http://lkml.kernel.org/r/<20150411001231.18916.93186@quantum>

http://lkml.kernel.org/r/<20150724034229.642.88156@quantum>

As an additional thought, it looks like the module stop registers are
mixed in with the clock registers. When you decide to write a reset
driver for these platforms you might want to re-use this existing dt
binding description and put the reset code into your clock provider
driver. Grep for reset.h in the drivers/clk/ directory for some
examples.

[0] http://documentation.renesas.com/doc/products/mpumcu/rej09b0283_2678hm.pdf

Regards,
Mike
