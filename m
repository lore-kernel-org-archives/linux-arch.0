From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V5 25/30] dt-bindings: timer: C-SKY Multi-processor timer
Date: Thu, 27 Sep 2018 12:35:26 -0500
Message-ID: <20180927173526.GA26777@bogus>
References: <cover.1537789736.git.ren_guo@c-sky.com>
 <d8f95c8a3be94d29611eccbeac51a3b74e5f570e.1537789737.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d8f95c8a3be94d29611eccbeac51a3b74e5f570e.1537789737.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com, palmer@sifive.com
List-Id: linux-arch.vger.kernel.org

On Tue, Sep 25, 2018 at 07:39:28AM +0800, Guo Ren wrote:
>  - Dt-bingdings doc for C-SKY SMP system setting.
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  .../devicetree/bindings/timer/csky,mptimer.txt     | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/csky,mptimer.txt
> 
> diff --git a/Documentation/devicetree/bindings/timer/csky,mptimer.txt b/Documentation/devicetree/bindings/timer/csky,mptimer.txt
> new file mode 100644
> index 0000000..1e7e31d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/csky,mptimer.txt
> @@ -0,0 +1,46 @@
> +============================
> +C-SKY Multi-processors Timer
> +============================
> +
> +C-SKY multi-processors timer is designed for C-SKY SMP system and the
> +regs is accessed by cpu co-processor 4 registers with mtcr/mfcr.
> +
> + - PTIM_CTLR "cr<0, 14>" Control reg to start reset timer.
> + - PTIM_TSR  "cr<1, 14>" Interrupt cleanup status reg.
> + - PTIM_CCVR "cr<3, 14>" Current counter value reg.
> + - PTIM_LVR  "cr<6, 14>" Window value reg to triger next event.
> +
> +==============================
> +timer node bindings definition
> +==============================
> +
> +	Description: Describes SMP timer
> +
> +	PROPERTIES
> +
> +	- compatible
> +		Usage: required
> +		Value type: <string>
> +		Definition: must be "csky,mptimer"
> +	- clocks
> +		Usage: required
> +		Value type: <node>
> +		Definition: must be input clk node
> +	- interrupts
> +		Usage: required
> +		Value type: <u32>
> +		Definition: must be timer irq num defined by soc
> +	- interrupt-parent:

Drop this. It is implied and could be in the parent node.

> +		Usage: required
> +		Value type: <node>
> +		Definition: must be interrupt controller node
> +
> +Examples:
> +---------
> +
> +	timer: timer {
> +		compatible = "csky,mptimer";
> +		clocks = <&dummy_apb_clk>;
> +		interrupts = <16>;
> +		interrupt-parent = <&intc>;
> +	};
> -- 
> 2.7.4
> 
