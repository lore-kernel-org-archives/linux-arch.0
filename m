Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54910 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeIFFUZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Sep 2018 01:20:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id c14-v6so9685304wmb.4
        for <linux-arch@vger.kernel.org>; Wed, 05 Sep 2018 17:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536138304.git.ren_guo@c-sky.com> <768ac390f9eee8acb4dc9ca85a489a1d2fd00628.1536138304.git.ren_guo@c-sky.com>
In-Reply-To: <768ac390f9eee8acb4dc9ca85a489a1d2fd00628.1536138304.git.ren_guo@c-sky.com>
From: Rob Herring <rob.herring@linaro.org>
Date: Wed, 5 Sep 2018 19:47:29 -0500
Message-ID: <CABGGiszuo3gpjmutYzOpQUmGaNjq88_5pDj2TjXveX9x2+Rsig@mail.gmail.com>
Subject: Re: [PATCH V3 19/26] dt-bindings: timer: gx6605s SOC timer
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: ren_guo@c-sky.com
Cc: linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Message-ID: <20180906004729.5LRiGbCFEfhlxOMHDg6h4Ti9iMos4S9KTr_2f8HHfdQ@z>

On Wed, Sep 5, 2018 at 7:09 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  .../bindings/timer/csky,gx6605s-timer.txt          | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
>
> diff --git a/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt b/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
> new file mode 100644
> index 0000000..1136d9e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
> @@ -0,0 +1,46 @@
> +=================
> +gx6605s SOC Timer
> +=================
> +
> +The timer is used in gx6605s soc as system timer and the driver
> +contain clk event and clk source.
> +
> +==============================
> +timer node bindings definition
> +==============================
> +
> +        Description: Describes gx6605s SOC timer
> +
> +        PROPERTIES
> +
> +        - compatible
> +                Usage: required
> +                Value type: <string>
> +                Definition: must be "csky,gx6605s"

-timer?

> +       - reg
> +               Usage: required
> +               Value type: <u32 u32>
> +               Definition: <phyaddr size> in soc from cpu view
> +       - clocks
> +               Usage: required
> +               Value type: <node>

phandle + clock specifier cells

> +               Definition: must be input clk node
> +        - interrupt
> +                Usage: required
> +                Value type: <u32>
> +                Definition: must be timer irq num defined by soc
> +        - interrupt-parent:

This is implied. Don't need to document it here.

> +                Usage: required
> +               Value type: <node>
> +                Definition: must be interrupt controller node
> +
> +Examples:
> +---------
> +
> +       timer:timer {

Needs a unit-address.

> +               compatible = "csky,gx6605s-timer";
> +               reg = <0x0020a000 0x400>;
> +               clocks = <&dummy_apb_clk>;
> +               interrupts = <10>;
> +               interrupt-parent = <&intc>;
> +       };
> --
> 2.7.4
>
