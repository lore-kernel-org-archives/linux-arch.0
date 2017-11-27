Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38030 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751467AbdK0Nmj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Nov 2017 08:42:39 -0500
Date: Mon, 27 Nov 2017 13:42:32 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 29/35] dt-bindings: nds32 CPU Bindings
Message-ID: <20171127134232.q343uymer47zt74m@lakrids.cambridge.arm.com>
References: <cover.1511785528.git.green.hu@gmail.com>
 <20a04f4a5b08dcec221e0c511e42ff3df711ae66.1511785528.git.green.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20a04f4a5b08dcec221e0c511e42ff3df711ae66.1511785528.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, Vincent Chen <vincentc@andestech.com>, Rick Chen <rick@andestech.com>, Zong Li <zong@andestech.com>
Message-ID: <20171127134232.rpzLettee9cpTBzyBT8kO-1xLIBu4gr0Vy9wQv6kZ6E@z>

Him

On Mon, Nov 27, 2017 at 08:28:16PM +0800, Greentime Hu wrote:
> From: Greentime Hu <greentime@andestech.com>
> 
> This patch adds nds32 CPU binding documents.
> 
> Signed-off-by: Vincent Chen <vincentc@andestech.com>
> Signed-off-by: Rick Chen <rick@andestech.com>
> Signed-off-by: Zong Li <zong@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>
> ---
>  Documentation/devicetree/bindings/nds32/cpus.txt |   32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nds32/cpus.txt
> 
> diff --git a/Documentation/devicetree/bindings/nds32/cpus.txt b/Documentation/devicetree/bindings/nds32/cpus.txt
> new file mode 100644
> index 0000000..c302c89
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nds32/cpus.txt
> @@ -0,0 +1,32 @@
> +* Andestech Processor Binding
> +
> +This binding specifies what properties must be available in the device tree
> +representation of a Andestech Processor Core, which is the root node in the
> +tree.
> +
> +Required properties:
> +
> +	- compatible:
> +		Usage: required
> +		Value type: <string>
> +		Definition: should be one of:
> +			"andestech,n13"
> +			"andestech,n15"
> +			"andestech,d15"
> +			"andestech,n10"
> +			"andestech,d10"
> +			"andestech,nds32v3"

Are these specific parts, or architecture versions?

I guess "andestech,nds32v3" is an architecture version, and the rest are
specific parts?

> +	- device_type
> +		Usage: required
> +		Value type: <string>
> +		Definition: must be "cpu"
> +	- clock-frequency: Contains the clock frequency for CPU, in Hz.
> +
> +* Examples
> +
> +/ {
> +	cpu {
> +		device_type = "cpu";
> +		compatible = "andestech,n13", "andestech,nds32v3";
> +	};

This is missing the required clock-frequency property.

There should be a /cpus node, with each CPU listed under that, to align
with the devicetree spec. Even if you never support SMP, there's no
reason to be different from other architectures.

You should have something like:

/ {
	cpus {
		cpu {
			device_type = "cpu";
			compatible = "andestech,n13";
			clock-frequency = <...>;
		};
	};
};

Thanks,
Mark.
