Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:59031 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752529AbXKNKGw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 14 Nov 2007 05:06:52 -0500
Subject: Re: [patch 3/3] arch_rebalance_pgtables call
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
In-Reply-To: <1195032394.9446.6.camel@localhost>
References: <20071112143009.425807965@de.ibm.com>
	 <20071112144010.052155135@de.ibm.com>
	 <200711132333.38086.nickpiggin@yahoo.com.au>
	 <1195032394.9446.6.camel@localhost>
Content-Type: text/plain
Date: Wed, 14 Nov 2007 21:06:36 +1100
Message-Id: <1195034796.28865.36.camel@pasglop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: schwidefsky@de.ibm.com
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


On Wed, 2007-11-14 at 10:26 +0100, Martin Schwidefsky wrote:
> That patch allows processes to have different number of page table
> levels, 31 bit processes have 2 levels (2GB), normal 64 bit processes
> have 3 levels (4TB) and really big 64 bit processes can have 4 levels
> (8PB). The downgrade of a page table to use less levels than the
> parent
> process is done in arch_pick_mmap_layout. The upgrade is done by using
> the arch_rebalance_pgtables call. I've considered using the
> arch_get_unmapped_area but got scared by the indirection in
> get_unmapped_area:
> 
>         get_area = current->mm->get_unmapped_area;
>         if (file && file->f_op && file->f_op->get_unmapped_area)
>                 get_area = file->f_op->get_unmapped_area;
>         addr = get_area(file, addr, len, pgoff, flags);

Don't be, it's really only hugetlb and other arch specific stuff that
hook in here on platforms with an MMU (It's also used by /dev/mem etc...
for mmu-less platforms but you don't care).

Ben.


