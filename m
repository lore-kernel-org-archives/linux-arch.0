From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3 7/8] ARM: dts: r8a7790: add iommus to dmac0 and dmac1
Date: Thu, 11 Feb 2016 02:41:28 +0200
Message-ID: <1704813.5Ff44u3Kaz@avalon>
References: <1455065878-11906-1-git-send-email-niklas.soderlund+renesas@ragnatech.se> <1455065878-11906-8-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:51471 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbcBKAlE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Feb 2016 19:41:04 -0500
In-Reply-To: <1455065878-11906-8-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, robin.murphy@arm.com, vinod.koul@intel.com, geert+renesas@glider.be, linus.walleij@linaro.org, dan.j.williams@intel.com, arnd@arndb.de, linux-arch@vger.kernel.org

Hi Niklas,

Thank you for the patch.

On Wednesday 10 February 2016 01:57:57 Niklas S=F6derlund wrote:

No commit message ? I'd at least mention that as a side effect of this =
patch=20
channel 0 and 15 are disabled, reducing the effective number of channel=
s to 14=20
per DMAC.

> Signed-off-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech=
=2Ese>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Same comment and ack for patch 8/8.

Note that we should still try to find a way to selectively enable the I=
OMMU in=20
a per-device fashion, as system integrators might want it to be disable=
d for=20
some devices. There's no urgency though.

> ---
>  arch/arm/boot/dts/r8a7790.dtsi | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a77=
90.dtsi
> index 7dfd393..048bbf8 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -294,6 +294,21 @@
>  		power-domains =3D <&cpg_clocks>;
>  		#dma-cells =3D <1>;
>  		dma-channels =3D <15>;
> +		iommus =3D <&ipmmu_ds 0>,
> +			 <&ipmmu_ds 1>,
> +			 <&ipmmu_ds 2>,
> +			 <&ipmmu_ds 3>,
> +			 <&ipmmu_ds 4>,
> +			 <&ipmmu_ds 5>,
> +			 <&ipmmu_ds 6>,
> +			 <&ipmmu_ds 7>,
> +			 <&ipmmu_ds 8>,
> +			 <&ipmmu_ds 9>,
> +			 <&ipmmu_ds 10>,
> +			 <&ipmmu_ds 11>,
> +			 <&ipmmu_ds 12>,
> +			 <&ipmmu_ds 13>,
> +			 <&ipmmu_ds 14>;
>  	};
>=20
>  	dmac1: dma-controller@e6720000 {
> @@ -325,6 +340,21 @@
>  		power-domains =3D <&cpg_clocks>;
>  		#dma-cells =3D <1>;
>  		dma-channels =3D <15>;
> +		iommus =3D <&ipmmu_ds 15>,
> +			 <&ipmmu_ds 16>,
> +			 <&ipmmu_ds 17>,
> +			 <&ipmmu_ds 18>,
> +			 <&ipmmu_ds 19>,
> +			 <&ipmmu_ds 20>,
> +			 <&ipmmu_ds 21>,
> +			 <&ipmmu_ds 22>,
> +			 <&ipmmu_ds 23>,
> +			 <&ipmmu_ds 24>,
> +			 <&ipmmu_ds 25>,
> +			 <&ipmmu_ds 26>,
> +			 <&ipmmu_ds 27>,
> +			 <&ipmmu_ds 28>,
> +			 <&ipmmu_ds 29>;
>  	};
>=20
>  	audma0: dma-controller@ec700000 {

--=20
Regards,

Laurent Pinchart
