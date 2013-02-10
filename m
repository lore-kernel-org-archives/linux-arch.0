From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: Include soc.h to fix compiling
Date: Sat, 9 Feb 2013 19:11:39 -0800
Message-ID: <20130210031139.GD4801@atomide.com>
References: <5112DC75.8070806@dawncrow.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5112DC75.8070806@dawncrow.de>
Sender: linux-omap-owner@vger.kernel.org
To: =?utf-8?B?QW5kcsOp?= Hentschel <nerv@dawncrow.de>
Cc: linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

* Andr=C3=A9 Hentschel <nerv@dawncrow.de> [130206 14:46]:
> I needed this when compiling for pandaboard at commit: 0944c0a0346571=
8909ba8e800a5230528aeabafb
>=20
> Signed-off-by: Andr=C3=A9 Hentschel <nerv@dawncrow.de>From: =3D?UTF-8=
?q?Andr=3DC3=3DA9=3D20Hentschel?=3D <nerv@dawncrow.de>
> From: =3D?UTF-8?q?Andr=3DC3=3DA9=3D20Hentschel?=3D <nerv@dawncrow.de>
> Date: Wed, 6 Feb 2013 23:16:20 +0100
> Subject: [PATCH] arm: Include soc.h to fix compiling

Thanks, applying into omap-for-v3.9/multiplatform-fixes
with the comments fixed up a bit.

Tony
=20
> ---
>  arch/arm/mach-omap2/drm.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/mach-omap2/drm.c b/arch/arm/mach-omap2/drm.c
> index 4c7566c..b4faf96 100644
> --- a/arch/arm/mach-omap2/drm.c
> +++ b/arch/arm/mach-omap2/drm.c
> @@ -27,6 +27,7 @@
> =20
>  #include "omap_device.h"
>  #include "omap_hwmod.h"
> +#include "soc.h"
> =20
>  #if defined(CONFIG_DRM_OMAP) || (CONFIG_DRM_OMAP_MODULE)
> =20
> --=20
> 1.8.0
>=20
> Best Regards, Andr=C3=A9 Hentschel
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
