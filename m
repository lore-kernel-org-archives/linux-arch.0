Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbeIFFSI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Sep 2018 01:18:08 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A00120867
        for <linux-arch@vger.kernel.org>; Thu,  6 Sep 2018 00:45:25 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id u12-v6so9450816wrr.4
        for <linux-arch@vger.kernel.org>; Wed, 05 Sep 2018 17:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536138304.git.ren_guo@c-sky.com> <a82f72fd77a6c06d23e6d08acc9df2a816d6235d.1536138304.git.ren_guo@c-sky.com>
In-Reply-To: <a82f72fd77a6c06d23e6d08acc9df2a816d6235d.1536138304.git.ren_guo@c-sky.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 5 Sep 2018 19:45:12 -0500
Message-ID: <CABGGiszOxskc_V1E8A4i34OWSUdOSVX-QSRrgG+NjTbashND_g@mail.gmail.com>
Subject: Re: [PATCH V3 22/26] dt-bindings: interrupt-controller: C-SKY SMP intc
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: ren_guo@c-sky.com
Cc: linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Message-ID: <20180906004512.pTwCfYDyXozYBvErCvFjqzVu76b4mIK_-k1OeGCtyb0@z>

On Wed, Sep 5, 2018 at 7:09 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  .../bindings/interrupt-controller/csky,mpintc.txt  | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> new file mode 100644
> index 0000000..49d1658
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> @@ -0,0 +1,40 @@
> +===========================================
> +C-SKY Multi-processors Interrupt Controller
> +===========================================
> +
> +C-SKY Multi-processors Interrupt Controller is designed for ck807/ck810/ck860
> +SMP soc, and it also could be used in non-SMP system.

How is it accessed? No mmio registers?

> +
> +Interrupt number definition:
> +
> +  0-15  : software irq, and we use 15 as our IPI_IRQ.
> + 16-31  : private  irq, and we use 16 as the co-processor timer.
> + 31-1024: common irq for soc ip.
> +
> +=============================
> +intc node bindings definition
> +=============================
> +
> +       Description: Describes SMP interrupt controller
> +
> +       PROPERTIES
> +
> +        - compatible
> +               Usage: required
> +                Value type: <string>
> +                Definition: must be "csky,mpintc"
> +        - interrupt-cells
> +                Usage: required
> +                Value type: <u32>
> +                Definition: must be <1>
> +        - interrupt-controller:
> +                Usage: required
> +
> +Examples:
> +---------
> +
> +       intc: interrupt-controller {
> +               compatible = "csky,mpintc";
> +               #interrupt-cells = <1>;
> +               interrupt-controller;
> +       };
> --
> 2.7.4
>
