Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:39735 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755165AbXHIAtR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Aug 2007 20:49:17 -0400
Date: Thu, 9 Aug 2007 09:50:42 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: Needs review from arm, sparc, pa-risc, sh, xtensa (virtual
 indexed cache issue in page migration)
Message-Id: <20070809095042.a4045780.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20070808.161436.42223098.davem@davemloft.net>
References: <617E1C2C70743745A92448908E030B2A0221324E@scsmsx411.amr.corp.intel.com>
	<20070808.161436.42223098.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: tony.luck@intel.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 08 Aug 2007 16:14:36 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: "Luck, Tony" <tony.luck@intel.com>
> Date: Wed, 8 Aug 2007 16:04:44 -0700
> 
> > This didn't raise any comment on LKML ... probably the
> > "ia64" in the Subject: deterred you all from reading it :-)
> > 
> > I don't think I understand either the migration code or the
> > virtual indexed cache issues well enough to figure this out.
> > 
> > Part 2of2 goes on to mess further with this code to cope with
> > the idiosyncracies on ia64 (keeping icache and dcache coherent).
> 
> set_pte_at() on sparc64 does all of the D-cache alias handling
> that would be necessary for page-cache pages.
> 
> Perhaps someone should see if IA64 can do similar instead of
> sprinkling the kernel with flush_whatever() calls at seemingly
> arbitrary places.
> 
> set_pte_at() is when mappings change, and you can see exactly how they
> are changing and for what address space and virutal address, therefore
> there is no reason that caching issues cannot be handled in it.
> 
> pte_clear() is implemented using set_pte_at() on sparc64, which allows
> it to cover all PTE changes made by the kernel in any context.
> 

Hmm...sprinking and messy.
Why I added sync_icache_dcache() as new macro is that the places where
sync_icache_dcache() is necessary are different from flush_(i)cache_page().
But I admit that "where sync_icache_dcache() should be inserted" is complexed.

In older version, I added flush_icache_page()/flush_cache_page() for ia64.
This can fix the problem without new macro, but nacked by Zoltan because
we have to sync icache-dcache too much.

In May,  mike@stroyan.net just moved lazy_mmu_prot_update() to proper place,
but Nacked because it just hides wrong macro definition, lazy_mmu_prot_update().
(This was 2 lines patch.)

Hmm...should I post flush_(i)cache_page() for ia64 again ?
It will be the neatest, maybe.

Thanks,
-Kame











