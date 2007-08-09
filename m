Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:41888 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761387AbXHIBO3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Aug 2007 21:14:29 -0400
Date: Thu, 9 Aug 2007 10:16:15 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: Needs review from arm, sparc, pa-risc, sh, xtensa (virtual
 indexed cache issue in page migration)
Message-Id: <20070809101615.b25c456a.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20070808.180136.67882110.davem@davemloft.net>
References: <617E1C2C70743745A92448908E030B2A0221324E@scsmsx411.amr.corp.intel.com>
	<20070808.161436.42223098.davem@davemloft.net>
	<20070809095042.a4045780.kamezawa.hiroyu@jp.fujitsu.com>
	<20070808.180136.67882110.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: tony.luck@intel.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 08 Aug 2007 18:01:36 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> Date: Thu, 9 Aug 2007 09:50:42 +0900
> 
> > Hmm...should I post flush_(i)cache_page() for ia64 again ?
> > It will be the neatest, maybe.
> 
> The problem with the flush_*() interfaces is that it tells the
> platform "what to do" instead of giving it information like "this just
> happened".
> 
> That's why I encourage approaches that use set_pte_at() because it's
> an event that gives information.

Hmm, I see. Trying to write a patch will not be much work.
Sigh, I didn't think this bugfix took one month...

> 
> Different platforms need to flush when certain circumstances are
> true.  Therefore, the better we annotate the events in the memory
> management, the easier it will be to write correct optimized flushing
> code for a platform.
> 
> But I cannot state enough that set_pte_at() and pte_clear() very
> likely serves your needs completely if you try to use it.  Every place
> I've seen IA64 add a hook has been right before or right after a
> set_pte_at() call, and this is no coincidence!
> 
All lazy_mmu_prot_update() which were used after set_pte() have to be removed.
It's buggy (my patch removes them)
All cache flusing hook should be inserted before set_pte().

Thanks,
-Kame


