Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate6.de.ibm.com ([195.212.29.155]:26428 "EHLO
	mtagate6.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568AbXKORNJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 15 Nov 2007 12:13:09 -0500
Subject: Re: [patch 3/3] arch_rebalance_pgtables call
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <1195078053.28865.47.camel@pasglop>
References: <20071112143009.425807965@de.ibm.com>
	 <20071112144010.052155135@de.ibm.com>
	 <200711132333.38086.nickpiggin@yahoo.com.au>
	 <1195032394.9446.6.camel@localhost>  <1195034796.28865.36.camel@pasglop>
	 <1195040986.9446.23.camel@localhost>  <1195078053.28865.47.camel@pasglop>
Content-Type: text/plain
Date: Thu, 15 Nov 2007 18:13:06 +0100
Message-Id: <1195146786.21505.4.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: benh@kernel.crashing.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2007-11-15 at 09:07 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2007-11-14 at 12:49 +0100, Martin Schwidefsky wrote:
> > 
> > They all either have an arch override, call get_unmapped_area again or
> > are not relevant. So it should be possible to do the upgrade in
> > arch_get_unmapped_area. I still have my doubts though, all future uses
> > of the get_unmapped_area pointer have to be checked and I feel it is
> > easier to understand to do the upgrade / rebalance of the page table
> > at
> > the end of get_unmapped_area where every caller of mmap is guaranteed
> > to
> > pass through.
> 
> Well, if something does what you are worried about, then it would be
> broken on powerpc as well (among others). We have various constraints on
> the address space layout that must be handled by our arch g_u_a (or our
> hugetlb one).

Ok, I rearranged the dynamic page tables code (and fixed the bug that 31
bit processes had a 3 level page table instead of 2). It is working fine
with s390 specific versions of arch_get_unmapped_area and
arch_get_unmapped_area_topdown which do the page table upgrade. 

Which means we can drop the arch_rebalance_pgtables-call.patch from -mm
again.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.


