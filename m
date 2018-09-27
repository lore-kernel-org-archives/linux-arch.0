From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V5 23/30] dt-bindings: interrupt-controller: C-SKY SMP
 intc
Date: Thu, 27 Sep 2018 11:50:44 -0500
Message-ID: <20180927165044.GA30320@bogus>
References: <cover.1537789736.git.ren_guo@c-sky.com>
 <57888913907d6c22b23425ed9d4e5a79be5b2eff.1537789737.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57888913907d6c22b23425ed9d4e5a79be5b2eff.1537789737.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com, palmer@sifive.com
List-Id: linux-arch.vger.kernel.org

On Tue, Sep 25, 2018 at 07:39:26AM +0800, Guo Ren wrote:
>  - Dt-bindings doc about C-SKY Multi-processors interrupt controller.
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  .../bindings/interrupt-controller/csky,mpintc.txt  | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> new file mode 100644
> index 0000000..9cdad74
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> @@ -0,0 +1,40 @@
> +===========================================
> +C-SKY Multi-processors Interrupt Controller
> +===========================================
> +
> +C-SKY Multi-processors Interrupt Controller is designed for ck807/ck810/ck860
> +SMP soc, and it also could be used in non-SMP system.
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
> +	Description: Describes SMP interrupt controller
> +
> +	PROPERTIES
> +
> +	- compatible
> +		Usage: required
> +		Value type: <string>
> +		Definition: must be "csky,mpintc"

Only 1 version?

This is fine for a fallback, but you should have an SoC specific 
compatible too in case there are any SoC specific errata/quirks.

> +	- interrupt-cells

Should be: #interrupt-cells

> +		Usage: required
> +		Value type: <u32>
> +		Definition: must be <1>
> +	- interrupt-controller:
> +		Usage: required
> +
> +Examples:
> +---------
> +
> +	intc: interrupt-controller {
> +		compatible = "csky,mpintc";
> +		#interrupt-cells = <1>;
> +		interrupt-controller;
> +	};
> -- 
> 2.7.4
> 
