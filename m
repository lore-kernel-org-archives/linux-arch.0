Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:20495 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756944Ab3BJDLp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 9 Feb 2013 22:11:45 -0500
Date: Sat, 9 Feb 2013 19:11:39 -0800
From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: Include soc.h to fix compiling
Message-ID: <20130210031139.GD4801@atomide.com>
References: <5112DC75.8070806@dawncrow.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5112DC75.8070806@dawncrow.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?utf-8?B?QW5kcsOp?= Hentschel <nerv@dawncrow.de>
Cc: linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20130210031139.U-J7WTWPD1kSFYe0rkzzCEEODc2yMr0oatpD3z7W_IE@z>

* André Hentschel <nerv@dawncrow.de> [130206 14:46]:
> I needed this when compiling for pandaboard at commit: 0944c0a03465718909ba8e800a5230528aeabafb
> 
> Signed-off-by: André Hentschel <nerv@dawncrow.de>From: =?UTF-8?q?Andr=C3=A9=20Hentschel?= <nerv@dawncrow.de>
> From: =?UTF-8?q?Andr=C3=A9=20Hentschel?= <nerv@dawncrow.de>
> Date: Wed, 6 Feb 2013 23:16:20 +0100
> Subject: [PATCH] arm: Include soc.h to fix compiling

Thanks, applying into omap-for-v3.9/multiplatform-fixes
with the comments fixed up a bit.

Tony
 
> ---
>  arch/arm/mach-omap2/drm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-omap2/drm.c b/arch/arm/mach-omap2/drm.c
> index 4c7566c..b4faf96 100644
> --- a/arch/arm/mach-omap2/drm.c
> +++ b/arch/arm/mach-omap2/drm.c
> @@ -27,6 +27,7 @@
>  
>  #include "omap_device.h"
>  #include "omap_hwmod.h"
> +#include "soc.h"
>  
>  #if defined(CONFIG_DRM_OMAP) || (CONFIG_DRM_OMAP_MODULE)
>  
> -- 
> 1.8.0
> 
> Best Regards, André Hentschel
