From: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch] mm: rewrite vmap layer
Date: Wed, 20 Aug 2008 18:22:35 +0200
Message-ID: <20080820162235.GA26894@wotan.suse.de>
References: <20080818133224.GA5258@wotan.suse.de> <48AADBDC.2000608@linux-foundation.org> <20080820090234.GA7018@wotan.suse.de> <48AC244F.1030104@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:51783 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753019AbYHTQWh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Aug 2008 12:22:37 -0400
Content-Disposition: inline
In-Reply-To: <48AC244F.1030104@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <cl@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch@vger.kernel.org

On Wed, Aug 20, 2008 at 09:03:59AM -0500, Christoph Lameter wrote:
> Nick Piggin wrote:
> 
> >> Or run purge_vma_area_lazy from keventd?
> >  
> > Right. But that's only needed if we want to vmap from irq context too
> > (otherwise we can just do the purge check at vmap time).
> > 
> > Is there any good reason to be able to vmap or vunmap from interrupt
> > time, though?
> 
> It would be good to have vunmap work in an interrupt context like other free
> operations. One may hold spinlocks while freeing structure.

I don't know if just-in-case is a strong argument to make the locks
interrupt safe and logic to handle deferred flushing. I'd be happy
to add it if there are some specific cases though.
 

> vmap from interrupt context would be useful f.e. for general fallback in the
> page allocator to virtually mapped memory if no linear physical memory is
> available (virtualizable compound pages). Without a vmap that can be run in an
> interrupt context we cannot support GFP_ATOMIC allocs there.

Indeed that would be a good use for it if this general fallback mechanism
were to be merged.
