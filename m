Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:39298 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932101AbWINW4N (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 14 Sep 2006 18:56:13 -0400
Date: Thu, 14 Sep 2006 15:56:08 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: [Fwd: [PATCH] Proposed update to the kernel kmap/kunmap API]
Message-Id: <20060914155608.e749000b.akpm@osdl.org>
In-Reply-To: <1158082434.3461.29.camel@mulgrave.il.steeleye.com>
References: <1158082434.3461.29.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


(cc linux-arch for general-arch-maintainer-headsup)

On Tue, 12 Sep 2006 12:33:54 -0500
James Bottomley <James.Bottomley@SteelEye.com> wrote:

> The simple part of the proposal is to give non-highmem architectures
> access to the kmap API for the purposes of overriding (this is what the
> attached patch does).
> 
> The more controversial part of the proposal is that we should now
> require all architectures with coherence issues to manage data coherence
> via the kmap/kunmap API.  Thus driver writers never have to write code
> like
> 
> kmap(page)
> modify data in page
> flush_kernel_dcache_page(page)
> kunmap(page)
> 
> instead, kmap/kunmap will manage the coherence and driver (and
> filesystem) writers don't need to worry about how to flush between kmap
> and kunmap.   For most architectures, the page only needs to be flushed
> if it was actually written to *and* there are user mappings of it, so
> the best implementation looks to be:  clear the page dirty pte bit in
> the kernel page tables on kmap and on kunmap, check page->mappings for
> user maps, and then the dirty bit, and only flush if it both has user
> mappings and is dirty.
> 
> James
> 
> Index: linux-2.6/include/linux/highmem.h
> ===================================================================
> --- linux-2.6.orig/include/linux/highmem.h      2006-07-26 17:51:09.000000000 -0700
> +++ linux-2.6/include/linux/highmem.h   2006-07-26 17:51:18.000000000 -0700
> @@ -29,6 +29,7 @@
>  
>  static inline unsigned int nr_free_highpages(void) { return 0; }
>  
> +#ifndef ARCH_HAS_KMAP
>  static inline void *kmap(struct page *page)
>  {
>         might_sleep();
> @@ -41,6 +42,7 @@
>  #define kunmap_atomic(addr, idx)       do { } while (0)
>  #define kmap_atomic_pfn(pfn, idx)      page_address(pfn_to_page(pfn))
>  #define kmap_atomic_to_page(ptr)       virt_to_page(ptr)
> +#endif
>  
>  #endif /* CONFIG_HIGHMEM */

I really really really would prefer to do this only for atomic kmaps. 
Normal sleeping kmap() is lame and slow and deadlocky and deprecated, so we
want to discourage its use.  Possible?
