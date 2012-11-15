From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V5 1/2] kbuild: centralize .dts->.dtb rule
Date: Thu, 15 Nov 2012 18:20:36 +0000
Message-ID: <CACxGe6tZOjMXR6CNDzDTSUkcERLiX-2+Qoad0bcPum5Z-Jxaaw@mail.gmail.com>
References: <CACxGe6vhd_4rcBbYyqtvbySVaY6XpNE+HQq42PZhKe5yt=zcaA@mail.gmail.com>
 <1352980284-2819-1-git-send-email-grant.likely@secretlab.ca> <50A52FEC.4080409@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:54078 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768572Ab2KOSU5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 15 Nov 2012 13:20:57 -0500
Received: by mail-vc0-f174.google.com with SMTP id fk26so1968632vcb.19
        for <linux-arch@vger.kernel.org>; Thu, 15 Nov 2012 10:20:56 -0800 (PST)
In-Reply-To: <50A52FEC.4080409@wwwdotorg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, Stephen Warren <swarren@nvidia.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>

On Thu, Nov 15, 2012 at 6:09 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/15/2012 04:51 AM, Grant Likely wrote:
>> Grant Likely wrote:
>>> Or how about: I could pick up the patch with only the MIPS hunk and
>>> every other user can be fixed up independently to use the new rule.
>>
>> Here's a trial patch to fix up ARM. Does this look correct? This patch
>> depends on the generic dtb build rule already being applied.
>
> I think the patch looks OK technically, except for one minor comment below.
>
> One issue with this patch is that it moves *.dts from arch/arm/boot to
> arch/arm/boot/dts, which means everyone has to adjust their scripts/...
> that package/install/... the kernel. I guess it's an easy change for
> people to make, but could easily catch people unawares if they do
> incremental builds so that arch/arm/boot/*.dtb still exists but is stale.

True. We could temporarily remove or rename if the same file exists in
the directory below to help people catch that problem. I really would
like to clean up that build rule to be consistent though.

The other option is to move all the .dts files into the boot
directory, but I don't think that is a good idea at all.

>> +targets += dtbs
>
> Doesn't that make the "dtbs" target always run by default? Perhaps
> that's reasonable though, and doesn't actually affect anything since the
> make command for this directory always specifies an explicit target?
>
> Or, was that meant to be the following that got removed from ../Makefile?
>
> targets += $(dtb-y)

Yes it is supposed to be the same thing. Doesn't it effectively do the
same since dtbs depends on $(dtb-y)?

g.
