From: Christoph Lameter <cl@linux-foundation.org>
Subject: Re: [patch] mm: rewrite vmap layer
Date: Wed, 20 Aug 2008 09:03:59 -0500
Message-ID: <48AC244F.1030104@linux-foundation.org>
References: <20080818133224.GA5258@wotan.suse.de> <48AADBDC.2000608@linux-foundation.org> <20080820090234.GA7018@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37943 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753304AbYHTOEq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Aug 2008 10:04:46 -0400
In-Reply-To: <20080820090234.GA7018@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch@vger.kernel.org

Nick Piggin wrote:

>> Or run purge_vma_area_lazy from keventd?
>  
> Right. But that's only needed if we want to vmap from irq context too
> (otherwise we can just do the purge check at vmap time).
> 
> Is there any good reason to be able to vmap or vunmap from interrupt
> time, though?

It would be good to have vunmap work in an interrupt context like other free
operations. One may hold spinlocks while freeing structure.

vmap from interrupt context would be useful f.e. for general fallback in the
page allocator to virtually mapped memory if no linear physical memory is
available (virtualizable compound pages). Without a vmap that can be run in an
interrupt context we cannot support GFP_ATOMIC allocs there.
