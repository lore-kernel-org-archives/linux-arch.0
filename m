Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:52338 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932239Ab2LEW22 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 5 Dec 2012 17:28:28 -0500
Received: by mail-wg0-f42.google.com with SMTP id dr1so8118wgb.1
        for <linux-arch@vger.kernel.org>; Wed, 05 Dec 2012 14:28:27 -0800 (PST)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 06/44] of/vendor-prefixes: add Imagination Technologies
In-Reply-To: <1354723742-6195-7-git-send-email-james.hogan@imgtec.com>
References: <1354723742-6195-1-git-send-email-james.hogan@imgtec.com> <1354723742-6195-7-git-send-email-james.hogan@imgtec.com>
Date: Wed, 05 Dec 2012 22:28:23 +0000
Message-ID: <20121205222824.005C53E0E22@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, devicetree-discuss@lists.ozlabs.org
Message-ID: <20121205222823.38t52WiuVJdPF_zZMed2PXIag-CzL7q819uYqBux2xc@z>

On Wed, 5 Dec 2012 16:08:24 +0000, James Hogan <james.hogan@imgtec.com> wrote:
> The "powervr" prefix which is currently described as "Imagination
> Technologies" isn't really appropriate for non-PowerVR hardware, so
> deprecate it, changing the description of "powervr" to "PowerVR
> (deprecated, use img)", and add a separate "img" prefix for "Imagination
> Technologies Ltd.".
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Rob Landley <rob@landley.net>
> Cc: devicetree-discuss@lists.ozlabs.org

Applied, thanks.

g.

> ---
>  .../devicetree/bindings/vendor-prefixes.txt        |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 9de2b9f..aab2993 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -25,6 +25,7 @@ gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
>  hp	Hewlett Packard
>  ibm	International Business Machines (IBM)
>  idt	Integrated Device Technologies, Inc.
> +img	Imagination Technologies Ltd.
>  intercontrol	Inter Control Group
>  linux	Linux-specific binding
>  marvell	Marvell Technology Group Ltd.
> @@ -35,7 +36,7 @@ nintendo	Nintendo
>  nvidia	NVIDIA
>  nxp	NXP Semiconductors
>  picochip	Picochip Ltd
> -powervr	Imagination Technologies
> +powervr	PowerVR (deprecated, use img)
>  qcom	Qualcomm, Inc.
>  ramtron	Ramtron International
>  realtek Realtek Semiconductor Corp.
> -- 
> 1.7.7.6
> 
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
