From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 32/39] dt-bindings: nds32 L2 cache controller Bindings
Date: Wed, 3 Jan 2018 15:10:13 -0600
Message-ID: <20180103211013.daryfidm7hdbrsjc@rob-hp-laptop>
References: <cover.1514874857.git.green.hu@gmail.com>
 <fc1f58a97003b4bedfbb8b6e3d29b1628ff61f9a.1514874858.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <fc1f58a97003b4bedfbb8b6e3d29b1628ff61f9a.1514874858.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, ren_guo-Y+KPrCd2zL4AvxtiuMwx3w@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org, stefan.kristiansson-MbMCFXIvDHJFcC0YU169RA@public.gmane.org, shorne-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 02, 2018 at 04:25:04PM +0800, Greentime Hu wrote:
> From: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
> 
> This patch adds nds32 L2 cache controller binding documents.
> 
> Signed-off-by: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
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

Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> +		compatible = "andestech,atl2c";
> +		reg = <0xe0500000 0x1000>;
> +		cache-unified;
> +		cache-level = <2>;
> +	};
> +
> -- 
> 1.7.9.5
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
