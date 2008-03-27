From: Lennert Buytenhek <buytenh-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>
Subject: virtual alias problem with vmap and I/O (xfs)
Date: Thu, 27 Mar 2008 13:14:58 +0100
Message-ID: <20080327121458.GA21613@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sandeen-+82itfer+wXR7s880joybQ@public.gmane.org, rabeeh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, saeed-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, dchinner-sJ/iWh9BUns@public.gmane.org

Hi all,

In some cases, xfs can end up doing I/O on a set of physical pages
that have been written to via a virtual alias set up by vmap().  (And
possibly in the other direction as well.)

Currently, xfs doesn't do anything special to handle this,
which means we can and do end up with on-disk fs corruption on
architectures with virtual caches.

I can't find any primitive that xfs should use to handle this.  Just
calling flush_dcache_page() obviously won't work since it cleans the
kernel direct mapping of the page, which isn't the one being used to
access the page.  flush_cache_range() would be suitable if it weren't
restricted to work on user addresses only, and as to
flush_cache_{vmap,vunmap}, I can't figure out what the semantics of
these are supposed to be.[*]

I guess that what xfs wants to do just isn't currently supported.

The DMA API doesn't seem right the right place to handle this, since
that deals with coherence between page_address(page) and external DMA
agents.

xfs doesn't need to guarantee coherence with DMA agents, it just needs
to make sure that the virtual aliases it uses are coherent with the
kernel direct mappings of the underlying physical pages, but such
semantics are problematic as well, since just cache cleaning the
virtual address region corresponding to a vmap() alias doesn't
guarantee that there isn't still (dirty) data in the kernel direct
mapped area.

Ideas?


thanks,
Lennert



[*] From cachetlb.txt:

	6) void flush_cache_vmap(unsigned long start, unsigned long end)
	   void flush_cache_vunmap(unsigned long start, unsigned long end)

		Here in these two interfaces we are flushing a specific range
		of (kernel) virtual addresses from the cache.  After running,
		there will be no entries in the cache for the kernel address
		space for virtual addresses in the range 'start' to 'end-1'.

		The first of these two routines is invoked after map_vm_area()
		has installed the page table entries.  The second is invoked
		before unmap_kernel_range() deletes the page table entries.

    For one, all architectures either define both flush_cache_vmap()
    and flush_cache_vunmap() to NOPs, or define both of them to
    flush_cache_all(), which I don't understand.

    Surely, in flush_cache_vunmap(), just flushing the given range
    should be sufficient for machines with virtual caches?  (Hmmm,
    e.g. ARM always does a flush_cache_all() even though ARMs with
    physical caches exist.)

    And I'm not sure why flush_cache_vmap() needs to do anything at
    all.  If we're worried about there still being (possibly dirty)
    data in the cache from a previous mapping at this virtual address,
    shouldn't we be flushing the virtual address range _first_,
    before setting up new mappings in this address range (for those
    virtual cache setups that don't store physical tags and can end
    up doing TLB lookups when evicting data?)
