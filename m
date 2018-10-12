From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V8 18/21] dt-bindings: csky CPU Bindings
Date: Fri, 12 Oct 2018 06:35:51 -0500
Message-ID: <20181012113551.GA17917@bogus>
References: <cover.1539315390.git.ren_guo@c-sky.com>
 <1c77e479a1dc0119912ac146b1038963b3653381.1539315391.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1c77e479a1dc0119912ac146b1038963b3653381.1539315391.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, hch@infradead.org, marc.zyngier@arm.com, mark.rutland@arm.com, peterz@infradead.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, c-sky_gcc_upstream@c-sky.com
List-Id: linux-arch.vger.kernel.org

On Fri, Oct 12, 2018 at 12:42:53PM +0800, Guo Ren wrote:
> This patch adds the documentation to describe that how to add cpu nodes in
> dts for SMP.
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/csky/cpus.txt | 70 +++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/csky/cpus.txt
> 
> diff --git a/Documentation/devicetree/bindings/csky/cpus.txt b/Documentation/devicetree/bindings/csky/cpus.txt
> new file mode 100644
> index 0000000..ee3901d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/csky/cpus.txt
> @@ -0,0 +1,70 @@
> +==================
> +C-SKY CPU Bindings
> +==================
> +
> +The device tree allows to describe the layout of CPUs in a system through
> +the "cpus" node, which in turn contains a number of subnodes (ie "cpu")
> +defining properties for every cpu.
> +
> +Only SMP system need to care about the cpus node and single processor
> +needn't define cpus node at all.
> +
> +=====================================
> +cpus and cpu node bindings definition
> +=====================================
> +
> +- cpus node
> +
> +        Description: Container of cpu nodes
> +
> +        The node name must be "cpus".
> +
> +        A cpus node must define the following properties:
> +
> +        - #address-cells
> +                Usage: required
> +                Value type: <u32>
> +                Definition: must be set to 1
> +        - #size-cells
> +                Usage: required
> +                Value type: <u32>
> +                Definition: must be set to 0
> +
> +- cpu node
> +
> +        Description: Describes one of SMP cores
> +
> +        PROPERTIES
> +

What happened to compatible?

> +        - device_type
> +                Usage: required
> +                Value type: <string>
> +                Definition: must be "cpu"
> +        - reg
> +                Usage: required
> +                Value type: <u32>
> +                Definition: CPU index
> +        - status:

Drop this. It is implied.

> +                Usage: required
> +                Value type: <string>
> +                Definition: "ok"       means enable  the cpu-core
> +                            "disabled" means disable the cpu-core
> +
> +Example:
> +--------
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		cpu@0 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			status = "ok";
> +		};
> +
> +		cpu@1 {
> +			device_type = "cpu";
> +			reg = <1>;
> +			status = "ok";
> +		};
> +	};
> -- 
> 2.7.4
> 
