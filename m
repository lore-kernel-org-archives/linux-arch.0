Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:39514 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbeISRKn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Sep 2018 13:10:43 -0400
Date: Wed, 19 Sep 2018 13:33:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 01/11] asm-generic/tlb: Provide a comment
Message-ID: <20180919113305.GC24124@hirez.programming.kicks-ass.net>
References: <20180913092110.817204997@infradead.org>
 <20180913092811.894806629@infradead.org>
 <20180914164857.GG6236@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914164857.GG6236@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com
Message-ID: <20180919113306.X7Xt-q3z-rY6rQ45a1FHcqpnsBof_cHor7_OmlkKyAE@z>

On Fri, Sep 14, 2018 at 05:48:57PM +0100, Will Deacon wrote:

> > + *  - tlb_change_page_size()
> 
> This doesn't seem to exist in my tree.
> [since realised you rename to it in the next patch]
> 

> > + * Additionally there are a few opt-in features:
> > + *
> > + *  HAVE_MMU_GATHER_PAGE_SIZE
> > + *
> > + *  This ensures we call tlb_flush() every time tlb_change_page_size() actually
> > + *  changes the size and provides mmu_gather::page_size to tlb_flush().
> 
> Ah, you add this later in the series. I think Nick reckoned we could get rid
> of this (the page_size field) eventually...

Right; let me fix that ordering..
