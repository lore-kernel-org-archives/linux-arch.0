From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 2/5] ARM: dts: use #include "..." to include DT in the
 same directory
Date: Mon, 15 May 2017 21:10:49 +0800
Message-ID: <20170515131048.GW8471@dragon>
References: <1494846888-18966-1-git-send-email-yamada.masahiro@socionext.com>
 <1494846888-18966-3-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756265AbdEONLO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 15 May 2017 09:11:14 -0400
Content-Disposition: inline
In-Reply-To: <1494846888-18966-3-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: devicetree@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Gaurav Minocha <gaurav.minocha.os@gmail.com>, Olof Johansson <olof@lixom.net>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Grant Likely <grant.likely@linaro.org>, Omar Sandoval <osandov@osandov.com>, Frank Rowand <frowand.list@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org

Hi Masahiro,

On Mon, May 15, 2017 at 08:14:45PM +0900, Masahiro Yamada wrote:
> Most of DT files in ARM use #include "..." to make pre-processor
> include DT in the same directory, but we have 3 exceptional files
> that use #include <...> for that.
> 
> They must be fixed to remove -I$(srctree)/arch/$(SRCARCH)/boot/dts
> path from dtc_cpp_flags.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/arm/boot/dts/imx6q-zii-rdu2.dts  | 4 ++--
>  arch/arm/boot/dts/imx6qp-zii-rdu2.dts | 4 ++--

I see this patch depends on nothing and can be applied immediately.  But
versatile-pb.dts is not really in my charge.  In case you want to get
this series merged by arm-soc folks, here is my ACK:

Acked-by: Shawn Guo <shawnguo@kernel.org>

Or you need to split versatile-pb.dts out, and then I can take it.

Shawn

>  arch/arm/boot/dts/versatile-pb.dts    | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-zii-rdu2.dts b/arch/arm/boot/dts/imx6q-zii-rdu2.dts
> index b2d3466..6be8a1e 100644
> --- a/arch/arm/boot/dts/imx6q-zii-rdu2.dts
> +++ b/arch/arm/boot/dts/imx6q-zii-rdu2.dts
> @@ -41,8 +41,8 @@
>  
>  /dts-v1/;
>  
> -#include <imx6q.dtsi>
> -#include <imx6qdl-zii-rdu2.dtsi>
> +#include "imx6q.dtsi"
> +#include "imx6qdl-zii-rdu2.dtsi"
>  
>  / {
>  	model = "ZII RDU2 Board";
> diff --git a/arch/arm/boot/dts/imx6qp-zii-rdu2.dts b/arch/arm/boot/dts/imx6qp-zii-rdu2.dts
> index 882b3bd..547a766 100644
> --- a/arch/arm/boot/dts/imx6qp-zii-rdu2.dts
> +++ b/arch/arm/boot/dts/imx6qp-zii-rdu2.dts
> @@ -41,8 +41,8 @@
>  
>  /dts-v1/;
>  
> -#include <imx6qp.dtsi>
> -#include <imx6qdl-zii-rdu2.dtsi>
> +#include "imx6qp.dtsi"
> +#include "imx6qdl-zii-rdu2.dtsi"
>  
>  / {
>  	model = "ZII RDU2+ Board";
> diff --git a/arch/arm/boot/dts/versatile-pb.dts b/arch/arm/boot/dts/versatile-pb.dts
> index 33a8eb2..06e2331 100644
> --- a/arch/arm/boot/dts/versatile-pb.dts
> +++ b/arch/arm/boot/dts/versatile-pb.dts
> @@ -1,4 +1,4 @@
> -#include <versatile-ab.dts>
> +#include "versatile-ab.dts"
>  
>  / {
>  	model = "ARM Versatile PB";
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
