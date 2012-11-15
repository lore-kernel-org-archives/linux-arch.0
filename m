From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V5 1/2] kbuild: centralize .dts->.dtb rule
Date: Thu, 15 Nov 2012 11:09:48 -0700
Message-ID: <50A52FEC.4080409@wwwdotorg.org>
References: <CACxGe6vhd_4rcBbYyqtvbySVaY6XpNE+HQq42PZhKe5yt=zcaA@mail.gmail.com> <1352980284-2819-1-git-send-email-grant.likely@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:48792 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768597Ab2KOSJw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 15 Nov 2012 13:09:52 -0500
In-Reply-To: <1352980284-2819-1-git-send-email-grant.likely@secretlab.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, Stephen Warren <swarren@nvidia.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>

On 11/15/2012 04:51 AM, Grant Likely wrote:
> Grant Likely wrote:
>> Or how about: I could pick up the patch with only the MIPS hunk and
>> every other user can be fixed up independently to use the new rule.
> 
> Here's a trial patch to fix up ARM. Does this look correct? This patch
> depends on the generic dtb build rule already being applied.

I think the patch looks OK technically, except for one minor comment below.

One issue with this patch is that it moves *.dts from arch/arm/boot to
arch/arm/boot/dts, which means everyone has to adjust their scripts/...
that package/install/... the kernel. I guess it's an easy change for
people to make, but could easily catch people unawares if they do
incremental builds so that arch/arm/boot/*.dtb still exists but is stale.

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index f37cf9f..2aef042 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -104,4 +104,8 @@ dtb-$(CONFIG_ARCH_VT8500) += vt8500-bv07.dtb \
>  	wm8505-ref.dtb \
>  	wm8650-mid.dtb
>  
> +targets += dtbs

Doesn't that make the "dtbs" target always run by default? Perhaps
that's reasonable though, and doesn't actually affect anything since the
make command for this directory always specifies an explicit target?

Or, was that meant to be the following that got removed from ../Makefile?

targets += $(dtb-y)

>  endif
> +
> +dtbs: $(addprefix $(obj)/, $(dtb-y))
> +clean-files := *.dtb
