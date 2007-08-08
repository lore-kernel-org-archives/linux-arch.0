Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:48603
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1757818AbXHHXOg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Aug 2007 19:14:36 -0400
Date: Wed, 08 Aug 2007 16:14:36 -0700 (PDT)
Message-Id: <20070808.161436.42223098.davem@davemloft.net>
Subject: Re: Needs review from arm, sparc, pa-risc, sh, xtensa (virtual
 indexed cache issue in page migration)
From: David Miller <davem@davemloft.net>
In-Reply-To: <617E1C2C70743745A92448908E030B2A0221324E@scsmsx411.amr.corp.intel.com>
References: <617E1C2C70743745A92448908E030B2A0221324E@scsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: tony.luck@intel.com
Cc: linux-arch@vger.kernel.org, kamezawa.hiroyu@jp.fujitsu.com
List-ID: <linux-arch.vger.kernel.org>

From: "Luck, Tony" <tony.luck@intel.com>
Date: Wed, 8 Aug 2007 16:04:44 -0700

> This didn't raise any comment on LKML ... probably the
> "ia64" in the Subject: deterred you all from reading it :-)
> 
> I don't think I understand either the migration code or the
> virtual indexed cache issues well enough to figure this out.
> 
> Part 2of2 goes on to mess further with this code to cope with
> the idiosyncracies on ia64 (keeping icache and dcache coherent).

set_pte_at() on sparc64 does all of the D-cache alias handling
that would be necessary for page-cache pages.

Perhaps someone should see if IA64 can do similar instead of
sprinkling the kernel with flush_whatever() calls at seemingly
arbitrary places.

set_pte_at() is when mappings change, and you can see exactly how they
are changing and for what address space and virutal address, therefore
there is no reason that caching issues cannot be handled in it.

pte_clear() is implemented using set_pte_at() on sparc64, which allows
it to cover all PTE changes made by the kernel in any context.
