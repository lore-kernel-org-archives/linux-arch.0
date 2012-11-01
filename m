From: Rob Herring <robherring2@gmail.com>
Subject: Re: [RFC PATCH v1 06/40] of/vendor-prefixes: add Imagination Technologies
Date: Wed, 31 Oct 2012 20:38:39 -0500
Message-ID: <5091D29F.1050100@gmail.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <1351700061-7203-7-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:57296 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051Ab2KABil (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 31 Oct 2012 21:38:41 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so906228bkc.19
        for <linux-arch@vger.kernel.org>; Wed, 31 Oct 2012 18:38:40 -0700 (PDT)
In-Reply-To: <1351700061-7203-7-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, devicetree-discuss@lists.ozlabs.org

On 10/31/2012 11:13 AM, James Hogan wrote:
> The "powervr" prefix which is currently described as "Imagination
> Technologies" isn't really appropriate for non-PowerVR hardware, so
> change the description of "powervr" to "PowerVR (Imagination
> Technologies Ltd.)", and add a separate "img" prefix for "Imagination
> Technologies Ltd.".
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Rob Landley <rob@landley.net>
> Cc: devicetree-discuss@lists.ozlabs.org
> ---
>  .../devicetree/bindings/vendor-prefixes.txt        |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index db4d3af..5a94721b 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -24,6 +24,7 @@ gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
>  hp	Hewlett Packard
>  ibm	International Business Machines (IBM)
>  idt	Integrated Device Technologies, Inc.
> +img	Imagination Technologies Ltd.
>  intercontrol	Inter Control Group
>  linux	Linux-specific binding
>  marvell	Marvell Technology Group Ltd.
> @@ -34,7 +35,7 @@ nintendo	Nintendo
>  nvidia	NVIDIA
>  nxp	NXP Semiconductors
>  picochip	Picochip Ltd
> -powervr	Imagination Technologies
> +powervr	PowerVR (Imagination Technologies Ltd.)

Perhaps you should add "deprecated, use img"

Otherwise, looks fine and I assume you are going to merge with the rest
of the series:

Acked-by: Rob Herring <rob.herring@calxeda.com>

Rob
