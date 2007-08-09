Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:47900
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1759669AbXHIBBg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Aug 2007 21:01:36 -0400
Date: Wed, 08 Aug 2007 18:01:36 -0700 (PDT)
Message-Id: <20070808.180136.67882110.davem@davemloft.net>
Subject: Re: Needs review from arm, sparc, pa-risc, sh, xtensa (virtual
 indexed cache issue in page migration)
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070809095042.a4045780.kamezawa.hiroyu@jp.fujitsu.com>
References: <617E1C2C70743745A92448908E030B2A0221324E@scsmsx411.amr.corp.intel.com>
	<20070808.161436.42223098.davem@davemloft.net>
	<20070809095042.a4045780.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: kamezawa.hiroyu@jp.fujitsu.com
Cc: tony.luck@intel.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Date: Thu, 9 Aug 2007 09:50:42 +0900

> Hmm...should I post flush_(i)cache_page() for ia64 again ?
> It will be the neatest, maybe.

The problem with the flush_*() interfaces is that it tells the
platform "what to do" instead of giving it information like "this just
happened".

That's why I encourage approaches that use set_pte_at() because it's
an event that gives information.

Different platforms need to flush when certain circumstances are
true.  Therefore, the better we annotate the events in the memory
management, the easier it will be to write correct optimized flushing
code for a platform.

But I cannot state enough that set_pte_at() and pte_clear() very
likely serves your needs completely if you try to use it.  Every place
I've seen IA64 add a hook has been right before or right after a
set_pte_at() call, and this is no coincidence!
