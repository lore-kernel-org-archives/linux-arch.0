Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from kiruna.synopsys.com ([198.182.44.80]:42802 "EHLO
	kiruna.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab3DON7Y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Apr 2013 09:59:24 -0400
Message-ID: <516C07AC.6070608@synopsys.com>
Date: Mon, 15 Apr 2013 19:29:08 +0530
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
MIME-Version: 1.0
Subject: Re: [PATCH] Kbuild: Avoid DTB rebuilds if source files are untouched
References: <1364973141-16354-1-git-send-email-vgupta@synopsys.com> <515BD6B8.1020607@synopsys.com> <515C5652.8070705@wwwdotorg.org> <515D0FFB.4030803@synopsys.com> <515DBA0E.6000604@wwwdotorg.org> <51642158.3070205@synopsys.com> <5167BA67.5080403@synopsys.com> <5168822C.6040303@wwwdotorg.org>
In-Reply-To: <5168822C.6040303@wwwdotorg.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.cz>, Stephen Warren <swarren@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, linux-kbuild@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Message-ID: <20130415135908.yA6KVIYU-4-3Ixmq28nfED0JE1bBgd_duwOucdzh5P4@z>

On 04/13/2013 03:22 AM, Stephen Warren wrote:
>
> After installing the ARC toolchain (which was a bit painful to track
> down and install...) 

Sorry about that - we have a buildroot based distro about to be pushed upstream -
that would make it easier.

> I reproduced your exact problem. I believe the
> patch below fixes it:
>
> diff --git a/arch/arc/boot/dts/Makefile b/arch/arc/boot/dts/Makefile
> index 5776835..2f2cf23 100644
> --- a/arch/arc/boot/dts/Makefile
> +++ b/arch/arc/boot/dts/Makefile
> @@ -8,6 +8,8 @@ endif
>  obj-y   += $(builtindtb-y).dtb.o
>  targets += $(builtindtb-y).dtb
>
> +.SECONDARY: $(obj)/$(builtindtb-y).dtb.S
> +
>  dtbs:  $(addprefix  $(obj)/, $(builtindtb-y).dtb)
>
>  clean-files := *.dtb

Indeed it does - I fell stupid why this didn't occur to me. But given that you
have dealt with the dtb Makefile stuff alot more than I have :-) do you know why
it was not working when put in Makefile.lib because I feel a few other arches also
suffer from the same issue and would need similar fixes.

Anyhow, for the patch, I can manually add --author="you" but it'll still lack your
SOB - you OK with that or do you want to send a formal patch.

Thx,
-Vineet


