From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [patch] mm: vmalloc fix lazy unmapping cache aliasing
Date: Wed, 19 Nov 2008 20:17:15 +0000
Message-ID: <20081119201715.GA9404@flint.arm.linux.org.uk>
References: <20081119045338.GA18697@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33737 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbYKSUR3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 19 Nov 2008 15:17:29 -0500
Content-Disposition: inline
In-Reply-To: <20081119045338.GA18697@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, Andrew Morton <akpm@linux-foundation.org>

On Wed, Nov 19, 2008 at 05:53:38AM +0100, Nick Piggin wrote:
> We determined that the problem was most likely due to a cache aliasing
> issue.  flush_cache_vunmap was only being called at the moment the page
> tables were to be taken down, however with lazy unmapping, this can
> happen after the page has subsequently been freed and allocated for
> something else. The dangling alias may still have dirty data attached
> to it.

This would certainly cause problems - writes which hit the cache for the
vmapped pages will remain in the cache, and would be evicted some time
later.

With VIVT ARMs, that time is bounded by the context switch, which does a
full cache flush, but between that a page may well have been reallocated
for some other purpose.

So, ensuring that we have no dirty lines corresponding to stale mappings
on pages before they're freed is an absolute must for VIVT caches.

> @@ -734,7 +743,7 @@ static void free_vmap_block(struct vmap_
>  	spin_unlock(&vmap_block_tree_lock);
>  	BUG_ON(tmp != vb);
>  
> -	free_unmap_vmap_area(vb->va);
> +	free_unmap_vmap_area_noflush(vb->va);
>  	call_rcu(&vb->rcu_head, rcu_free_vb);
>  }
>  
> @@ -820,6 +829,8 @@ static void vb_free(const void *addr, un
>  		free_vmap_block(vb);
>  	} else
>  		spin_unlock(&vb->lock);
> +
> +	flush_cache_vunmap((unsigned long)addr, (unsigned long)addr + size);

One minor nit - this looks like we're flushing the cache after the
range has been marked as needing the mapping torn down.  Can the
mapping be torn down before the cache is flushed?

The reason I ask is that with VIPT caches, the mapping has to be
present so the hardware knows the physical tag to be flushed, so if
the mapping has been torn down, we'll get an exception.  _If_ and
only if we convert flush_cache_vunmap() to be less heavy weight
than its current flush_cache_all().

IOW, shouldn't flush_cache_vunmap() be towards the start of vb_free() ?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
