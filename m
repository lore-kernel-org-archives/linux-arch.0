Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35481 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950AbbG3Umy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 30 Jul 2015 16:42:54 -0400
Date: Thu, 30 Jul 2015 22:42:49 +0200
From: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [PATCH v3 01/24] mm: enhance region_is_ram() to
 region_intersects()
Message-ID: <20150730204249.GN30479@wotan.suse.de>
References: <20150730165155.33962.64121.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150730165345.33962.80299.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150730165345.33962.80299.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com, linux-arch@vger.kernel.org, toshi.kani@hp.com, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, rmk+kernel@arm.linux.org.uk, hch@lst.de, linux-arm-kernel@lists.infradead.org
Message-ID: <20150730204249.FRdv8sVF1yPoAEBBNBpL3Gxu2VlqbXeuv7mxtmv0LRs@z>

On Thu, Jul 30, 2015 at 12:53:45PM -0400, Dan Williams wrote:
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 2e872f92dbac..84b05ebedb2d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -369,7 +369,14 @@ static inline int put_page_unless_one(struct page *page)
>  }
>  
>  extern int page_is_ram(unsigned long pfn);
> -extern int region_is_ram(resource_size_t phys_addr, unsigned long size);
> +
> +enum {
> +	REGION_INTERSECTS,
> +	REGION_DISJOINT,
> +	REGION_MIXED,
> +};
> +

Can you Kdoc'ify this? Part of the reason for the enum request was this
could be then documented really well. The helper is documented but here
you can go into more detail about each region intersection.

  Luis
