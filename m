Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:63488 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959Ab3KUMjb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 21 Nov 2013 07:39:31 -0500
Received: by mail-bk0-f54.google.com with SMTP id v16so294652bkz.27
        for <linux-arch@vger.kernel.org>; Thu, 21 Nov 2013 04:39:30 -0800 (PST)
From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH] of: unflatten_and_copy: handle NULL initial_boot_params
In-Reply-To: <1384865892-28659-1-git-send-email-james.hogan@imgtec.com>
References: <1384865892-28659-1-git-send-email-james.hogan@imgtec.com>
Date: Thu, 21 Nov 2013 12:39:27 +0000
Message-ID: <20131121123927.34EAEC40A2C@trevor.secretlab.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>, Rob Herring <rob.herring@calxeda.com>, devicetree@vger.kernel.org, linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Message-ID: <20131121123927.tnSrP3QsXexplgBRsApVTFP3HhqcoKI1U-O-0IaCiqk@z>

On Tue, 19 Nov 2013 12:58:12 +0000, James Hogan <james.hogan@imgtec.com> wrote:
> Check whether initial_boot_params is NULL before dereferencing it in
> unflatten_and_copy_device_tree() for the case where no device tree is
> available but the arch can still boot to a minimal usable system without
> it.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> ---
>  drivers/of/fdt.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 2fa024b97c43..ac4983955e6d 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -922,8 +922,14 @@ void __init unflatten_device_tree(void)
>   */
>  void __init unflatten_and_copy_device_tree(void)
>  {
> -	int size = __be32_to_cpu(initial_boot_params->totalsize);
> -	void *dt = early_init_dt_alloc_memory_arch(size,
> +	int size;
> +	void *dt;
> +
> +	if (!initial_boot_params)
> +		return;

Worth logging a message for those who can obtain the kernel log
buffer?

Otherwise:

Acked-by: Grant Likely <grant.likely@linaro.org>

But see my comments on Geert's "dt: Handle passed/built-in DT selection
in early_init_dt_scan()" patch.

g.
