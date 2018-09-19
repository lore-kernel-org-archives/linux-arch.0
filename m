Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:39472 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730892AbeISRIS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Sep 2018 13:08:18 -0400
Date: Wed, 19 Sep 2018 13:30:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 07/11] arm/tlb: Convert to generic mmu_gather
Message-ID: <20180919113033.GB24124@hirez.programming.kicks-ass.net>
References: <20180913092110.817204997@infradead.org>
 <20180913092812.247989787@infradead.org>
 <20180918141034.GF16498@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918141034.GF16498@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com
Message-ID: <20180919113033.KG2NE3DCS_nFfIdsuA93xMn3Y8-BCCCZWKz7qZPR7Fg@z>

On Tue, Sep 18, 2018 at 03:10:34PM +0100, Will Deacon wrote:
> > +	addr = (addr & PMD_MASK) + SZ_1M;
> > +	__tlb_adjust_range(tlb, addr - PAGE_SIZE, addr + PAGE_SIZE);
> 
> Hmm, I don't think you've got the range correct here. Don't we want
> something like:
> 
> 	__tlb_adjust_range(tlb, addr - PAGE_SIZE, 2 * PAGE_SIZE)
> 
> to ensure that we flush on both sides of the 1M boundary?

Argh indeed. I confused {start,size} with {start,end}. Thanks!
