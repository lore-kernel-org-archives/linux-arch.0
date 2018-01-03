Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:39096 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750873AbeACVKP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jan 2018 16:10:15 -0500
Date: Wed, 3 Jan 2018 15:10:13 -0600
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 32/39] dt-bindings: nds32 L2 cache controller Bindings
Message-ID: <20180103211013.daryfidm7hdbrsjc@rob-hp-laptop>
References: <cover.1514874857.git.green.hu@gmail.com>
 <fc1f58a97003b4bedfbb8b6e3d29b1628ff61f9a.1514874858.git.green.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc1f58a97003b4bedfbb8b6e3d29b1628ff61f9a.1514874858.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Message-ID: <20180103211013.B8LJGAkntCgAdIucJookRosnRnw8X8CyXpeURg2aIwI@z>

On Tue, Jan 02, 2018 at 04:25:04PM +0800, Greentime Hu wrote:
> From: Greentime Hu <greentime@andestech.com>
> 
> This patch adds nds32 L2 cache controller binding documents.
> 
> Signed-off-by: Greentime Hu <greentime@andestech.com>
> ---
>  Documentation/devicetree/bindings/nds32/atl2c.txt |   29 +++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nds32/atl2c.txt
> 
> diff --git a/Documentation/devicetree/bindings/nds32/atl2c.txt b/Documentation/devicetree/bindings/nds32/atl2c.txt
> new file mode 100644
> index 0000000..db9f7ec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nds32/atl2c.txt
> @@ -0,0 +1,29 @@
> +* Andestech L2 cache Controller
> +
> +The level-2 cache controller plays an important role in reducing memory latency
> +for high performance systems, such as thoese designs with AndesCore processors.
> +Level-2 cache controller in general enhances overall system performance
> +signigicantly and the system power consumption might be reduced as well by
> +reducing DRAM accesses.
> +
> +This binding specifies what properties must be available in the device tree
> +representation of an Andestech L2 cache controller.
> +
> +Required properties:
> +	- compatible:
> +		Usage: required
> +		Value type: <string>
> +		Definition: "andestech,atl2c"
> +	- reg : Physical base address and size of cache controller's memory mapped
> +	- cache-unified : Specifies the cache is a unified cache.
> +	- cache-level : Should be set to 2 for a level 2 cache.
> +
> +* Example
> +
> +	L2: l2-cache@e0500000 {

cache-controller@...

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +		compatible = "andestech,atl2c";
> +		reg = <0xe0500000 0x1000>;
> +		cache-unified;
> +		cache-level = <2>;
> +	};
> +
> -- 
> 1.7.9.5
> 
