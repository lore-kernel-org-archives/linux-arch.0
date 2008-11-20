From: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch] mm: vmalloc fix lazy unmapping cache aliasing
Date: Thu, 20 Nov 2008 03:17:17 +0100
Message-ID: <20081120021717.GA11774@wotan.suse.de>
References: <20081119045338.GA18697@wotan.suse.de> <20081119201715.GA9404@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36761 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549AbYKTCRT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 19 Nov 2008 21:17:19 -0500
Content-Disposition: inline
In-Reply-To: <20081119201715.GA9404@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, Andrew Morton <akpm@linux-foundation.org>

On Wed, Nov 19, 2008 at 08:17:15PM +0000, Russell King wrote:
> On Wed, Nov 19, 2008 at 05:53:38AM +0100, Nick Piggin wrote:
> > We determined that the problem was most likely due to a cache aliasing
> > issue.  flush_cache_vunmap was only being called at the moment the page
> > tables were to be taken down, however with lazy unmapping, this can
> > happen after the page has subsequently been freed and allocated for
> > something else. The dangling alias may still have dirty data attached
> > to it.
> 
> This would certainly cause problems - writes which hit the cache for the
> vmapped pages will remain in the cache, and would be evicted some time
> later.
> 
> With VIVT ARMs, that time is bounded by the context switch, which does a
> full cache flush, but between that a page may well have been reallocated
> for some other purpose.
> 
> So, ensuring that we have no dirty lines corresponding to stale mappings
> on pages before they're freed is an absolute must for VIVT caches.
> 
> > @@ -734,7 +743,7 @@ static void free_vmap_block(struct vmap_
> >  	spin_unlock(&vmap_block_tree_lock);
> >  	BUG_ON(tmp != vb);
> >  
> > -	free_unmap_vmap_area(vb->va);
> > +	free_unmap_vmap_area_noflush(vb->va);
> >  	call_rcu(&vb->rcu_head, rcu_free_vb);
> >  }
> >  
> > @@ -820,6 +829,8 @@ static void vb_free(const void *addr, un
> >  		free_vmap_block(vb);
> >  	} else
> >  		spin_unlock(&vb->lock);
> > +
> > +	flush_cache_vunmap((unsigned long)addr, (unsigned long)addr + size);
> 
> One minor nit - this looks like we're flushing the cache after the
> range has been marked as needing the mapping torn down.  Can the
> mapping be torn down before the cache is flushed?
> 
> The reason I ask is that with VIPT caches, the mapping has to be
> present so the hardware knows the physical tag to be flushed, so if
> the mapping has been torn down, we'll get an exception.  _If_ and
> only if we convert flush_cache_vunmap() to be less heavy weight
> than its current flush_cache_all().
> 
> IOW, shouldn't flush_cache_vunmap() be towards the start of vb_free() ?

You are correct. Thanks.

Andrew, can you queue this incremental fix please?

--
Russell King wrote:
> One minor nit - this looks like we're flushing the cache after the
> range has been marked as needing the mapping torn down.  Can the
> mapping be torn down before the cache is flushed?
>
> The reason I ask is that with VIPT caches, the mapping has to be
> present so the hardware knows the physical tag to be flushed, so if
> the mapping has been torn down, we'll get an exception.  _If_ and
> only if we convert flush_cache_vunmap() to be less heavy weight
> than its current flush_cache_all().
>
> IOW, shouldn't flush_cache_vunmap() be towards the start of vb_free() ?

Signed-off-by: Nick Piggin <npiggin@suse.de>
---
Index: linux-2.6/mm/vmalloc.c
===================================================================
--- linux-2.6.orig/mm/vmalloc.c
+++ linux-2.6/mm/vmalloc.c
@@ -805,6 +805,9 @@ static void vb_free(const void *addr, un
 
 	BUG_ON(size & ~PAGE_MASK);
 	BUG_ON(size > PAGE_SIZE*VMAP_MAX_ALLOC);
+
+	flush_cache_vunmap((unsigned long)addr, (unsigned long)addr + size);
+
 	order = get_order(size);
 
 	offset = (unsigned long)addr & (VMAP_BLOCK_SIZE - 1);
@@ -829,8 +832,6 @@ static void vb_free(const void *addr, un
 		free_vmap_block(vb);
 	} else
 		spin_unlock(&vb->lock);
-
-	flush_cache_vunmap((unsigned long)addr, (unsigned long)addr + size);
 }
 
 /**
