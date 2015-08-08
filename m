From: Michael Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v12 17/21] h8300: clock driver
Date: Fri, 07 Aug 2015 17:43:49 -0700
Message-ID: <20150808004349.2416.18161@quantum>
References: <1431325600-12333-1-git-send-email-ysato@users.sourceforge.jp>
 <1431325600-12333-18-git-send-email-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1431325600-12333-18-git-send-email-ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

Hello Sato-san,

Unfortunately this patch did not Cc myself, Stephen Boyd or the
linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org mailing list. As such Stephen and I did not
have a chance to review it. Even more unfortunate was that it was ninja
merged by maintainers without our ack. :-/

Quoting Yoshinori Sato (2015-05-10 23:26:36)
> Signed-off-by: Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>
> ---
>  .../bindings/clock/renesas,h8300-div-clock.txt     |  24 ++++
>  .../bindings/clock/renesas,h8s2678-pll-clock.txt   |  23 ++++
>  drivers/clk/Makefile                               |   1 +
>  drivers/clk/h8300/Makefile                         |   2 +
>  drivers/clk/h8300/clk-div.c                        |  53 ++++++++
>  drivers/clk/h8300/clk-h8s2678.c                    | 147 +++++++++++=
++++++++++
>  6 files changed, 250 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,h=
8300-div-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,h=
8s2678-pll-clock.txt
>  create mode 100644 drivers/clk/h8300/Makefile
>  create mode 100644 drivers/clk/h8300/clk-div.c
>  create mode 100644 drivers/clk/h8300/clk-h8s2678.c
>=20
> diff --git a/Documentation/devicetree/bindings/clock/renesas,h8300-di=
v-clock.txt b/Documentation/devicetree/bindings/clock/renesas,h8300-div=
-clock.txt
> new file mode 100644
> index 0000000..36c2b52
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/renesas,h8300-div-clock=
=2Etxt
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
> +                       compatible =3D "renesas,h8300-div-clock";
> +                       clocks =3D <&xclk>;
> +                       #clock-cells =3D <0>;
> +                       reg =3D <0xfee01b 2>;
> +                       renesas,width =3D <2>;
> +               };

I could not find any info on this clock in the H8S/2678 reference
manual[0]. Could you point me to the right documentation?

> diff --git a/Documentation/devicetree/bindings/clock/renesas,h8s2678-=
pll-clock.txt b/Documentation/devicetree/bindings/clock/renesas,h8s2678=
-pll-clock.txt
> new file mode 100644
> index 0000000..500cdadb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/renesas,h8s2678-pll-clo=
ck.txt
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
> +                       compatible =3D "renesas,h8s2678-pll-clock";
> +                       clocks =3D <&xclk>;
> +                       #clock-cells =3D <0>;
> +                       reg =3D <0xfee03b 2>, <0xfee045 2>;
> +               };

Is there really only one clock output? According to figure 21.1 there i=
s
the "System clock to =CF=86 pin" output and the "Internal clock to peri=
pheral
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

[0] http://documentation.renesas.com/doc/products/mpumcu/rej09b0283_267=
8hm.pdf

Regards,
Mike
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
