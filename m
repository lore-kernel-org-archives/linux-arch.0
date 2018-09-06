From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V3 22/26] dt-bindings: interrupt-controller: C-SKY SMP intc
Date: Wed, 5 Sep 2018 19:45:12 -0500
Message-ID: <CABGGiszOxskc_V1E8A4i34OWSUdOSVX-QSRrgG+NjTbashND_g@mail.gmail.com>
References: <cover.1536138304.git.ren_guo@c-sky.com> <a82f72fd77a6c06d23e6d08acc9df2a816d6235d.1536138304.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a82f72fd77a6c06d23e6d08acc9df2a816d6235d.1536138304.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ren_guo@c-sky.com
Cc: linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

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
