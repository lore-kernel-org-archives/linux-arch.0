From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 17/25] intel-iommu: switch from ioremap_cache to
 memremap
Date: Mon, 3 Aug 2015 16:27:16 +0200
Message-ID: <20150803142716.GC20968@8bytes.org>
References: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150725023933.8664.85856.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:53776 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752711AbbHCO1T (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 3 Aug 2015 10:27:19 -0400
Content-Disposition: inline
In-Reply-To: <20150725023933.8664.85856.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com, linux-arch@vger.kernel.org, toshi.kani@hp.com, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, rmk+kernel@arm.linux.org.uk, David Woodhouse <dwmw2@infradead.org>, hch@lst.de, linux-arm-kernel@lists.infradead.org

On Fri, Jul 24, 2015 at 10:39:33PM -0400, Dan Williams wrote:
> In preparation for deprecating ioremap_cache() convert its usage in
> intel-iommu to memremap.  This also eliminates the mishandling of the
> __iomem annotation in the implementation.
> 
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/iommu/intel-iommu.c         |   10 ++++++----
>  drivers/iommu/intel_irq_remapping.c |    4 ++--
>  2 files changed, 8 insertions(+), 6 deletions(-)

Acked-by: Joerg Roedel <jroedel@suse.de>
