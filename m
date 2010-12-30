Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:33904 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755174Ab0L3TRj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 30 Dec 2010 14:17:39 -0500
Received: from hpaq11.eem.corp.google.com (hpaq11.eem.corp.google.com [172.25.149.11])
	by smtp-out.google.com with ESMTP id oBUJHcfx010161
	for <linux-arch@vger.kernel.org>; Thu, 30 Dec 2010 11:17:39 -0800
Received: from pxi12 (pxi12.prod.google.com [10.243.27.12])
	by hpaq11.eem.corp.google.com with ESMTP id oBUJHaTo003187
	for <linux-arch@vger.kernel.org>; Thu, 30 Dec 2010 11:17:37 -0800
Received: by pxi12 with SMTP id 12so3207408pxi.14
        for <linux-arch@vger.kernel.org>; Thu, 30 Dec 2010 11:17:35 -0800 (PST)
Date: Thu, 30 Dec 2010 11:17:32 -0800 (PST)
From: David Rientjes <rientjes@google.com>
Subject: Re: [patch 1/8] init: rename CONFIG_EMBEDDED to CONFIG_EXPERT
In-Reply-To: <201012301350.28862.arnd@arndb.de>
Message-ID: <alpine.DEB.2.00.1012301055340.12995@chino.kir.corp.google.com>
References: <alpine.DEB.2.00.1012291959200.27241@chino.kir.corp.google.com> <20101230124535.GA3306@sgi.com> <201012301350.28862.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Robin Holt <holt@sgi.com>, Ingo Molnar <mingo@elte.hu>, Greg KH <gregkh@suse.de>, "David S. Miller" <davem@davemloft.net>, Jens Axboe <axboe@kernel.dk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20101230191732.kXqEwtpAcvdXBggiSU2JOvEmeGztt7VT7nPOXsnFdtY@z>

On Thu, 30 Dec 2010, Arnd Bergmann wrote:

> > Doesn't this patch series break the 'bisectable' rule for patches?
> > I think you can get by with adding a CONFIG_EXPERT selects CONFIG_EMBEDDED
> > in the first patch and the last patch removing that same selects.
> 
> How about leaving it that way during the merge window even? That would
> help people sending git pull requests that add new dependencies on
> CONFIG_EMBEDDED. David can submit another patch that removes the
> temporary CONFIG_EMBEDDED option along with any new users in -rc2
> or for 2.6.39 then.
> 

Ok, so there are a few pending EMBEDDED dependency additions in linux-next 
as of next-20101230, which should be a pretty good indicator of what type 
of conflict we might risk during the merge window.

 - three new defconfig files:

	89ba4d12: arch/arm/configs/ag5evm_defconfig
	6cfce27c: arch/arm/configs/omap1_defconfig 
	d58f0967: arch/blackfin/configs/BF561-EZKIT-SMP_defconfig 

 - 3ce05168 (drm/kms: load fbcon from drm_kms_helper)

 - b595076a (tree-wide: fix comment/printk typos)

Instead of CONFIG_EXPERT select CONFIG_EMBEDDED, we could add a ninth 
patch which does CONFIG_EMBEDDED select CONFIG_EXPERT and tag it in some 
way so we know it's only temporary for the merge window to find new 
CONFIG_EMBEDDED entries.

Andrew, this would be going through your -mm tree anyway, so how would you 
prefer to merge it?
