Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48725 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751481AbZIIDXW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Sep 2009 23:23:22 -0400
Subject: Re: [PATCH 1/5] mm: add coherence API for DMA to vmalloc/vmap areas
From: James Bottomley <James.Bottomley@HansenPartnership.com>
In-Reply-To: <1252466226.13003.367.camel@mulgrave.site>
References: <1252434469.13003.3.camel@mulgrave.site>
	 <20090908190031.GF6538@flint.arm.linux.org.uk>
	 <1252437112.13003.39.camel@mulgrave.site>
	 <20090908201619.GG6538@flint.arm.linux.org.uk>
	 <1252442352.13003.132.camel@mulgrave.site>
	 <20090908213910.GH6538@flint.arm.linux.org.uk>
	 <1252466070.13003.365.camel@mulgrave.site>
	 <1252466226.13003.367.camel@mulgrave.site>
Content-Type: text/plain
Date: Tue, 08 Sep 2009 22:23:21 -0500
Message-ID: <1252466601.13003.374.camel@mulgrave.site>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Parisc List <linux-parisc@vger.kernel.org>, Linux Filesystem Mailing List <linux-fsdevel@vger.kernel.org>, linux-arch@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Message-ID: <20090909032321._hFHpRbzxyLQW7Em765XacbNRLII5WZD_Nt_EqHhl4A@z>

On Wed, 2009-09-09 at 03:17 +0000, James Bottomley wrote:
> On Virtually Indexed architectures (which don't do automatic alias
> resolution in their caches), we have to flush via the correct
> virtual address to prepare pages for DMA.  On some architectures
> (like arm) we cannot prevent the CPU from doing data movein along
> the alias (and thus giving stale read data), so we not only have to
> introduce a flush API to push dirty cache lines out, but also an invalidate
> API to kill inconsistent cache lines that may have moved in before
> DMA changed the data
> 
> Signed-off-by: James Bottomley <James.Bottomley@suse.de>
> ---
>  include/linux/highmem.h |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 211ff44..9719952 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -17,6 +17,12 @@ static inline void flush_anon_page(struct vm_area_struct *vma, struct page *page
>  static inline void flush_kernel_dcache_page(struct page *page)
>  {
>  }
> +static incline void flush_kernel_dcache_addr(void *vaddr)
> +{
> +}
> +static incline void invalidate_kernel_dcache_addr(void *vaddr)
> +{
> +}
>  #endif

OK, so it's been pointed out to me that I didn't compile check this ...
just testing to see everyone is awake ...

James


