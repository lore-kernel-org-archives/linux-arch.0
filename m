Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:42908 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731620AbeISSuy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Sep 2018 14:50:54 -0400
Date: Wed, 19 Sep 2018 15:12:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 01/11] asm-generic/tlb: Provide a comment
Message-ID: <20180919131254.GI24124@hirez.programming.kicks-ass.net>
References: <20180913092110.817204997@infradead.org>
 <20180913092811.894806629@infradead.org>
 <20180914164857.GG6236@arm.com>
 <20180919115158.GD24124@hirez.programming.kicks-ass.net>
 <20180919122328.GB22723@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919122328.GB22723@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com
Message-ID: <20180919131254.KAA4gJKM9UfLd8wfZ0_gXd_zu-tk8Zq6qfmQYj6NX4A@z>

On Wed, Sep 19, 2018 at 01:23:29PM +0100, Will Deacon wrote:

> > > > + *    which (when !need_flush_all; fullmm will have start = end = ~0UL) provides
> > > > + *    the range that needs to be flushed to cover the pages to be freed.
> > > 
> > > I don't understand the mention of need_flush_all here -- I didn't think it
> > > was used by the core code at all.
> > 
> > The core does indeed not use that flag; but if the architecture set
> > that, the range is still ignored.
> > 
> > Can you suggest clearer wording?
> 
> The range is only ignored if the default tlb_flush() implementation is used
> though, right? Since this text is about the fields that tlb_flush() can use,
> I think we can just delete the part in brackets.

Well, any architecture that actually uses need_flush_all will obviously
require a tlb_flush implementation that looks at it.

But OK, I'll remove the note.
