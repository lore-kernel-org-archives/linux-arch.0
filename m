Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:57192 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759710Ab2CGTPD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Mar 2012 14:15:03 -0500
Received: from mail621.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id 98F60DC6C0C
	for <linux-arch@vger.kernel.org>; Wed,  7 Mar 2012 19:23:38 +0100 (CET)
Date: Wed, 7 Mar 2012 19:08:15 +0100
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 2/3] Kbuild: Implement CONFIG_UIMAGE_KERNEL_NOLOAD
Message-ID: <20120307180815.GA27213@game.jcrosoft.org>
References: <1331080238-1524-1-git-send-email-swarren@wwwdotorg.org>
 <1331080238-1524-2-git-send-email-swarren@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1331080238-1524-2-git-send-email-swarren@wwwdotorg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Michal Marek <mmarek@suse.cz>, linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Mike Frysinger <vapier@gentoo.org>, nico@fluxnic.net, linux-sh@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, uclinux-dist-devel@blackfin.uclinux.org, sparclinux@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Haavard Skinnemoen <hskinnemoen@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, Hans-Christian Egtvedt <egtvedt@samfundet.no>
Message-ID: <20120307180815.rqUUL6T0mKpGYQl1_TMJNP-lChUQlrMEzTv0jZIL_40@z>

On 17:30 Tue 06 Mar     , Stephen Warren wrote:
> This allows the user to use U-Boot's mkimage's -T kernel_noload option
> if their arch Kconfig allows it, and they desire.
> 
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
> The next patch enables this new CONFIG_ALLOW_ option for ARM. I assume
> that some other architectures will also be able to enable it, but I'm
> not familiar enough with any to know which.
I'm going to repeat. I don't think any impromevent here.

with no specific kernel load address the uImage for is useless/

And this no the job of the kernel to build a boot loader specific boot image
format.

And the uImage format here is called the legacy format where now U-Boot
support a new format based on DT format.

Will you plan to add it too?

no sorry I don't think it's the right way to go.

On X86 we boot zImage simply. The new uImage option to do not specify the load
address add nothing more than just boot a zImage for kernel point of view.

Further more on server the vendor will use grub mostly (even on ARM) and will
expect to boot a zImage.

Best Regards,,
J.
