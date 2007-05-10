Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:36136
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755845AbXEJWNv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 May 2007 18:13:51 -0400
Date: Thu, 10 May 2007 15:13:53 -0700 (PDT)
Message-Id: <20070510.151353.89387383.davem@davemloft.net>
Subject: Re: New slab allocator SLUB
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0705081145360.11368@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0705081145360.11368@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: clameter@sgi.com
Cc: linux-arch@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

From: Christoph Lameter <clameter@sgi.com>
Date: Tue, 8 May 2007 12:10:32 -0700 (PDT)

> The new slab allocator SLUB was merged and it seems that we are heading 
> towards replacing SLAB completely by SLUB. This means that we would like 
> to be sure that SLUB runs reliably on all platforms. SLUB is first
> available upstream with 2.6.21-git9.

I found a new difference in SLUB and it prevents sparc64 from
booting currently :-)

What SLAB allows you to do is define LARGE_ALLOCS but not necessarily
set MAX_ORDER large enough for the largest kmalloc SLAB.  SLAB would
ignore the kmalloc cache creation failures for these largest ones that
are over MAX_ORDER.

SLUB instead panic()'s which isn't so nice that early in the boot.

There are a few platforms that will trigger this problem, in
fact pretty much every one that specifies LARGE_ALLOCS currently
based upon a casual scan of platform Kconfig files.

To be honest I don't think I even need LARGE_ALLOCS on sparc64 so I
think I'll just see if I can delete that, but I would suggest one of
two courses of action:

1) Make SLUB ignore kmalloc cache creation failures at least for
   the higher order ones

or

2) Detect the (PAGE_SIZE << MAX_ORDER) < LARGEST_KMALLOC_SIZE
   at compile time so that nobody gets such an early panic.

Take care.
