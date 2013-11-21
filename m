Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:44630 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754342Ab3KUMVx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 21 Nov 2013 07:21:53 -0500
Received: by mail-bk0-f42.google.com with SMTP id w11so283913bkz.29
        for <linux-arch@vger.kernel.org>; Thu, 21 Nov 2013 04:21:52 -0800 (PST)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/9] dt: Handle passed/built-in DT selection in early_init_dt_scan()
In-Reply-To: <1384859554-27268-1-git-send-email-geert@linux-m68k.org>
References: <5283A000.8090007@gmail.com> < 1384859554-27268-1-git-send-email-geert@linux-m68k.org>
Date: Thu, 21 Nov 2013 12:21:48 +0000
Message-ID: <20131121122148.1B43DC40A2C@trevor.secretlab.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <rob.herring@calxeda.com>
Cc: devicetree@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20131121122148.mgVlAjF6Q4bMYwqksF_XUhiVejAIh9l6sEIwo_1xlYc@z>

On Tue, 19 Nov 2013 12:12:26 +0100, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Let early_init_dt_scan() fall-back to the built-in DT if no DT was passed,
> or if it's invalid, so architectures don't have to duplicate this logic.
> 
> Suggested-by: Rob Herring <rob.herring@calxeda.com>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/of/fdt.c       |   24 +++++++++++++++++-------
>  include/linux/of_fdt.h |    1 +
>  2 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 2fa024b97c43..a797cd43bc8b 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -868,18 +868,28 @@ void * __init __weak early_init_dt_alloc_memory_arch(u64 size, u64 align)
>  
>  bool __init early_init_dt_scan(void *params)
>  {
> -	if (!params)
> -		return false;
> -
>  	/* Setup flat device-tree pointer */
>  	initial_boot_params = params;
>  
> -	/* check device tree validity */
> -	if (be32_to_cpu(initial_boot_params->magic) != OF_DT_HEADER) {
> -		initial_boot_params = NULL;
> -		return false;
> +	/* check passed device tree validity */
> +	if (initial_boot_params &&
> +	    be32_to_cpu(initial_boot_params->magic) == OF_DT_HEADER) {
> +		pr_info("FDT at %p\n", initial_boot_params);
> +		goto found;
> +	}
> +
> +	/* check built-in device tree validity */
> +	initial_boot_params = &__dtb_start;
> +	if (__dtb_end != (void *)&__dtb_start &&
> +	    be32_to_cpu(initial_boot_params->magic) == OF_DT_HEADER) {
> +		pr_info("Compiled-in FDT at %p\n", initial_boot_params);
> +		goto found;

__dtb_start is in an init section which is discarded after initcalls.
For this to work, the dtb needs to be copied into a region of allocated
memory. The dtb section can also potentially contain multiple .dtb
blobs. In the use case that you care about you are probably only
thinking about one, but it is entirely possible for device drivers to
have a dtb linked in which may break this if it gets linked in a
different order. The specific example I'm thinking about is I want to
have the DT selftest code load an overlay to get testcase data from a
dtb blob.

The other concern I have here is that I don't really want this to be the
default on a lot of platforms. ARM and PowerPC for instance should only
get the default dtb from the boot wrapper. It needs to be configurable
in some way.

Instead of using __dtb_start, it would probably solve both of the above
problems if the build-in DTB has a specific label identifying it as the
default DT.

g.

