From: "Niklas =?iso-8859-1?Q?S=F6derlund?=" <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH v3 7/8] ARM: dts: r8a7790: add iommus to dmac0 and dmac1
Date: Thu, 11 Feb 2016 01:50:52 +0100
Message-ID: <20160211005052.GD19813@bigcity.dyn.berto.se>
References: <1455065878-11906-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1455065878-11906-8-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <20160210175559.GD17671@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34627 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbcBKAuz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Feb 2016 19:50:55 -0500
Received: by mail-lb0-f174.google.com with SMTP id cw1so19922847lbb.1
        for <linux-arch@vger.kernel.org>; Wed, 10 Feb 2016 16:50:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160210175559.GD17671@verge.net.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Simon Horman <horms@verge.net.au>
Cc: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org, arnd@arndb.de, geert+renesas@glider.be, vinod.koul@intel.com, linus.walleij@linaro.org, laurent.pinchart@ideasonboard.com, dan.j.williams@intel.com, robin.murphy@arm.com

Hi Simon,

* Simon Horman <horms@verge.net.au> [2016-02-10 18:55:59 +0100]:

> Hi Niklas,
>
> I am deferring accepting this and the similar patch for the r8a7791 pending
> acceptance of the driver changes earlier in this series. Please let me know
> if you prefer a different course of action.

That sounds good, thanks.

>
> I notice that the devel branch of there renesas tree there are
> dmac nodes for the r8a7793, r8a7794 and r8a7795. Is this change,
> also suitable for those SoCs? If so, do you plan to update them?
> If not I'll add it to my todo list.

I planed to update all effected SoCs once the dependencies for this
series where accepted. But if you want to keep track of this I'm happy.
