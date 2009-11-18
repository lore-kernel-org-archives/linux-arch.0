From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 1/6] mm: add coherence API for DMA to vmalloc/vmap areas
Date: Wed, 18 Nov 2009 10:13:37 -0500
Message-ID: <1258557217.2540.12.camel@mulgrave.site>
References: <1258477432-2513-1-git-send-email-James.Bottomley@suse.de>
	 <1258477432-2513-2-git-send-email-James.Bottomley@suse.de>
	 <20091118143815.GA17146@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:44949 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757060AbZKRPNf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Nov 2009 10:13:35 -0500
In-Reply-To: <20091118143815.GA17146@linux-mips.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org

On Wed, 2009-11-18 at 15:38 +0100, Ralf Baechle wrote:
> On Tue, Nov 17, 2009 at 11:03:47AM -0600, James Bottomley wrote:
> 
> > On Virtually Indexed architectures (which don't do automatic alias
> > resolution in their caches), we have to flush via the correct
> > virtual address to prepare pages for DMA.  On some architectures
> > (like arm) we cannot prevent the CPU from doing data movein along
> > the alias (and thus giving stale read data), so we not only have to
> > introduce a flush API to push dirty cache lines out, but also an invalidate
> > API to kill inconsistent cache lines that may have moved in before
> > DMA changed the data
> 
> The API looks right for MIPS and trivial to implement based on existing
> code, so feel free to throw in my Ack on the generic parts.
> 
> The new APIs deserve documentation in Documentation/cachetlb.txt.

True (mutter, hate doing docs, mutter).

How about this?

James

---

diff --git a/Documentation/cachetlb.txt b/Documentation/cachetlb.txt
index da42ab4..7d1055c 100644
--- a/Documentation/cachetlb.txt
+++ b/Documentation/cachetlb.txt
@@ -377,3 +377,27 @@ maps this page at its virtual address.
 	All the functionality of flush_icache_page can be implemented in
 	flush_dcache_page and update_mmu_cache. In 2.7 the hope is to
 	remove this interface completely.
+
+For machines where aliasing can be a problem, there exist two
+additional APIs to handle I/O to vmap/vmalloc areas within the
+kernel. These are areas that have two kernel mappings, one the regular
+page offset map through which the page has likely been previously
+accessed and the other, the new contiguous map in the kernel virtual
+map area.  This dual mapping sets up aliasing within the kernel and,
+in particular since all kernel flushing goes through the offset map,
+must be handled separately for I/O.  to declare your architecture as
+needing to use these functions, you must define
+ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE in asm/cacheflush.h and add two API
+helpers (usually as static inlines in cacheflush.h).  The two new APIs
+are:
+
+  void flush_kernel_dcache_addr(void *addr)
+       Flush a single page through the vmap alias for addr.  This is
+       usually executed prior to performing I/O on the page to make
+       sure the underlying physical page is up to date.
+
+  void invalidate_kernel_dcache_addr(void *addr)
+       Invalidate the page after I/O has completed.  This is necessary
+       on machines whose cache mechanisms might trigger cache movein
+       during I/O.  If you can ensure architecturally that this movein
+       never occurs, this function can be empty on your architecture.
