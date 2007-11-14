Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate6.de.ibm.com ([195.212.29.155]:7761 "EHLO
	mtagate6.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265AbXKNJ0g (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 Nov 2007 04:26:36 -0500
Subject: Re: [patch 3/3] arch_rebalance_pgtables call
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <200711132333.38086.nickpiggin@yahoo.com.au>
References: <20071112143009.425807965@de.ibm.com>
	 <20071112144010.052155135@de.ibm.com>
	 <200711132333.38086.nickpiggin@yahoo.com.au>
Content-Type: text/plain
Date: Wed, 14 Nov 2007 10:26:34 +0100
Message-Id: <1195032394.9446.6.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-ID: <linux-arch.vger.kernel.org>


On Tue, 2007-11-13 at 23:33 +1100, Nick Piggin wrote:
> On Tuesday 13 November 2007 01:30, schwidefsky@de.ibm.com wrote:
> > From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> >
> > In order to change the layout of the page tables after an mmap has
> > crossed the adress space limit of the current page table layout a
> > architecture hook in get_unmapped_area is needed. The arguments
> > are the address of the new mapping and the length of it.
> 
> Can you comment what this is supposed to be fore somewhere?

This hook is going to be used by the dynamic page table patch for s390:
http://marc.info/?l=linux-mm&m=119333667710539&w=2

That patch allows processes to have different number of page table
levels, 31 bit processes have 2 levels (2GB), normal 64 bit processes
have 3 levels (4TB) and really big 64 bit processes can have 4 levels
(8PB). The downgrade of a page table to use less levels than the parent
process is done in arch_pick_mmap_layout. The upgrade is done by using
the arch_rebalance_pgtables call. I've considered using the
arch_get_unmapped_area but got scared by the indirection in
get_unmapped_area:

        get_area = current->mm->get_unmapped_area;
        if (file && file->f_op && file->f_op->get_unmapped_area)
                get_area = file->f_op->get_unmapped_area;
        addr = get_area(file, addr, len, pgoff, flags);

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.


