From: David Rientjes <rientjes@google.com>
Subject: Re: [patch 1/8] init: rename CONFIG_EMBEDDED to CONFIG_EXPERT
Date: Mon, 3 Jan 2011 13:56:19 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1101031353260.10636@chino.kir.corp.google.com>
References: <alpine.DEB.2.00.1012291959200.27241@chino.kir.corp.google.com> <20101230124535.GA3306@sgi.com> <201012301350.28862.arnd@arndb.de> <alpine.DEB.2.00.1012301055340.12995@chino.kir.corp.google.com>
 <20110103121030.921f6ff2.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:15008 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754011Ab1ACV42 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2011 16:56:28 -0500
Received: from wpaz33.hot.corp.google.com (wpaz33.hot.corp.google.com [172.24.198.97])
	by smtp-out.google.com with ESMTP id p03LuQjh005173
	for <linux-arch@vger.kernel.org>; Mon, 3 Jan 2011 13:56:27 -0800
Received: from pzk12 (pzk12.prod.google.com [10.243.19.140])
	by wpaz33.hot.corp.google.com with ESMTP id p03LuOLA028670
	for <linux-arch@vger.kernel.org>; Mon, 3 Jan 2011 13:56:25 -0800
Received: by pzk12 with SMTP id 12so2806710pzk.34
        for <linux-arch@vger.kernel.org>; Mon, 03 Jan 2011 13:56:24 -0800 (PST)
In-Reply-To: <20110103121030.921f6ff2.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Robin Holt <holt@sgi.com>, Ingo Molnar <mingo@elte.hu>, Greg KH <gregkh@suse.de>, "David S. Miller" <davem@davemloft.net>, Jens Axboe <axboe@kernel.dk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 3 Jan 2011, Andrew Morton wrote:

> > Ok, so there are a few pending EMBEDDED dependency additions in linux-next 
> > as of next-20101230, which should be a pretty good indicator of what type 
> > of conflict we might risk during the merge window.
> > 
> >  - three new defconfig files:
> > 
> > 	89ba4d12: arch/arm/configs/ag5evm_defconfig
> > 	6cfce27c: arch/arm/configs/omap1_defconfig 
> > 	d58f0967: arch/blackfin/configs/BF561-EZKIT-SMP_defconfig 
> > 
> >  - 3ce05168 (drm/kms: load fbcon from drm_kms_helper)
> > 
> >  - b595076a (tree-wide: fix comment/printk typos)
> > 
> > Instead of CONFIG_EXPERT select CONFIG_EMBEDDED, we could add a ninth 
> > patch which does CONFIG_EMBEDDED select CONFIG_EXPERT and tag it in some 
> > way so we know it's only temporary for the merge window to find new 
> > CONFIG_EMBEDDED entries.
> > 
> > Andrew, this would be going through your -mm tree anyway, so how would you 
> > prefer to merge it?
> 
> um, one big patch shortly after -rc1 is released?
> 

Sounds good, I'll send you a big patch immediately following 2.6.38-rc1 
and add a "config EMBEDDED" that will simply do a "select EXPERT" so it's 
easy to use oldconfig.

It's debatable whether CONFIG_EMBEDDED would actually make sense, and I 
think it does: for example, I think it would be helpful to identify kernel 
options that really only make sense on embedded devices such as device 
drivers, CONFIG_PRINTK, CONFIG_SLOB, etc.
