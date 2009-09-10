From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 4/6] sh: add mm API for DMA to vmalloc/vmap areas
Date: Thu, 10 Sep 2009 09:27:17 +0900
Message-ID: <20090910002717.GC23674@linux-sh.org>
References: <1252511536-22066-1-git-send-email-James.Bottomley@suse.de> <1252511536-22066-2-git-send-email-James.Bottomley@suse.de> <1252511536-22066-3-git-send-email-James.Bottomley@suse.de> <1252511536-22066-4-git-send-email-James.Bottomley@suse.de> <1252511536-22066-5-git-send-email-James.Bottomley@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1252511536-22066-5-git-send-email-James.Bottomley@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-parisc@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, Christoph Hellwig <hch@lst.de>
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 09, 2009 at 10:52:14AM -0500, James Bottomley wrote:
> Signed-off-by: James Bottomley <James.Bottomley@suse.de>
> ---
>  arch/sh/include/asm/cacheflush.h |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/sh/include/asm/cacheflush.h b/arch/sh/include/asm/cacheflush.h
> index 4c5462d..db06611 100644
> --- a/arch/sh/include/asm/cacheflush.h
> +++ b/arch/sh/include/asm/cacheflush.h
> @@ -48,6 +48,14 @@ static inline void flush_kernel_dcache_page(struct page *page)
>  {
>  	flush_dcache_page(page);
>  }
> +static inline void flush_kernel_dcache_addr(void *addr)
> +{
> +	__flush_invalidate_region(addr, PAGE_SIZE);
> +}
> +static inline void invalidate_kernel_dcache_addr(void *addr)
> +{
> +	__flush_invalidate_region(addr, PAGE_SIZE);
> +}
>  
Actually, I spoke too soon. The first one should be either a
__flush_purge_region() or __flush_wback_region() I suspect. The former
does both a writeback and invalidate, while the latter only does the
writeback.
