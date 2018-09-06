Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbeIFFQF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Sep 2018 01:16:05 -0400
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E3A420867
        for <linux-arch@vger.kernel.org>; Thu,  6 Sep 2018 00:43:22 +0000 (UTC)
Received: by mail-wm0-f45.google.com with SMTP id s12-v6so9711603wmc.0
        for <linux-arch@vger.kernel.org>; Wed, 05 Sep 2018 17:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536138304.git.ren_guo@c-sky.com> <62dae1828ade759584bbf1507fe4a9e69d247a50.1536138304.git.ren_guo@c-sky.com>
In-Reply-To: <62dae1828ade759584bbf1507fe4a9e69d247a50.1536138304.git.ren_guo@c-sky.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 5 Sep 2018 19:43:10 -0500
Message-ID: <CABGGiswB5OUU7JDP+-s3s8ONkXZY2AAvSijQedsNtZ6p8LqZeA@mail.gmail.com>
Subject: Re: [PATCH V3 21/26] dt-bindings: interrupt-controller: C-SKY APB intc
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: ren_guo@c-sky.com
Cc: linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Message-ID: <20180906004310.dIZsafKU62U5xtT-3YY0sVRYbsgSM-Y1CbgUBSkb6-Y@z>

On Wed, Sep 5, 2018 at 7:10 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  .../interrupt-controller/csky,apb-intc.txt         | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
> new file mode 100644
> index 0000000..faa482c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
> @@ -0,0 +1,45 @@
> +==============================
> +C-SKY APB Interrupt Controller
> +==============================
> +
> +C-SKY APB Interrupt Controller is a simple soc interrupt controller
> +on the apb bus and we only use it as root irq controller.
> +
> + - csky,apb-intc is used in a lot of csky fpgas and socs, it support 64 irq nums.
> + - csky,dual-apb-intc consists of 2 apb-intc and 128 irq nums supported.

Can't this be described in DT as 2 csky,apb-intc nodes?

> + - csky,gx6605s-intc is gx6605s soc internal irq interrupt controller, 64 irq nums.
> +
> +=============================
> +intc node bindings definition
> +=============================
> +
> +        Description: Describes APB interrupt controller
> +
> +        PROPERTIES
> +
> +        - compatible
> +                Usage: required
> +                Value type: <string>
> +                Definition: must be "csky,apb-intc"
> +                                   "csky,dual-apb-intc"
> +                                   "csky,gx6605s-intc"
> +        - interrupt-cells

#interrupt-cells

> +                Usage: required
> +                Value type: <u32>
> +                Definition: must be <1>

No edge or level configuration?

> +       - reg
> +               Usage: required
> +               Value type: <u32 u32>
> +                Definition: <phyaddr size> in soc from cpu view
> +        - interrupt-controller:
> +                Usage: required
> +
> +Examples:
> +---------
> +
> +       intc: interrupt-controller {

Needs a unit-address.

> +               compatible = "csky,apb-intc";
> +               #interrupt-cells = <1>;
> +               reg = <0x00500000 0x400>;
> +               interrupt-controller;
> +       };
> --
> 2.7.4
>
